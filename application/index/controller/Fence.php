<?php

namespace app\index\controller;

use app\common\Utils;
use app\common\Yingyan;
use think\Db;
use think\Request;
use app\index\model\Fence as FenceModel;
use app\index\model\Fence\Bicycles as FenceBicyclesModel;
use app\index\model\Bicycle as BicycleModel;

class Fence extends Base
{
    /**
     * @var Yingyan
     */
    protected $yingyan;

    /**
     * Fence constructor.
     * @param Request|null $request
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function __construct(Request $request = null)
    {
        parent::__construct($request);
        $this->yingyan = new Yingyan();
    }

    public function homeIndex(Request $request) {
        $fenceNames = FenceModel::where('deleted', '=', 0)->select();
        $fenceBicycles = FenceModel\Bicycles::where('fence_bicycles.deleted', '=', 0)
            ->join('bicycles', 'bicycles.id = fence_bicycles.bicycle_id')
            ->field('bicycles.*, fence_bicycles.fence_id')
            ->select();
        $fenceBicyclesArr = [];
        foreach ($fenceBicycles as $fenceBicycle) {
            $fenceBicyclesArr[$fenceBicycle->fence_id][] = [
                'bicycle_number' => $fenceBicycle->bicycle_number,
                'lock_number' => $fenceBicycle->lock_number,
                'bicycle_name' => $fenceBicycle->bicycle_name,
                'hourlyPrice' => $fenceBicycle->hourlyPrice,
                'dailyPrice' => $fenceBicycle->dailyPrice,
                'gps' => json_decode($fenceBicycle->gps)

            ];
        }

        if ($request->isAjax()) {
            $nowFence = current(array_filter(json_decode(json_encode($fenceNames), true), function ($item) use ($request) {
                return $item['id'] == $request->param('fence_id', 0);
            }));
            $bicycles = $fenceBicyclesArr[$request->param('fence_id')] ?? 0;
            return Utils::ajaxReturn(compact('nowFence', 'bicycles'));
        }

        $nowFence = $fenceNames[0];
        $nowFenceBiycles = json_encode($fenceBicyclesArr[$nowFence->id] ?? []);
        $this->assign(compact('fenceNames', 'nowFence', 'nowFenceBiycles'));
        $this->assign(['ak' => $this->yingyan->getBrowerAk()]);
        return $this->fetch();
    }

    /**
     * @param Request $request
     * @return mixed
     * @throws \think\exception\DbException
     */
    public function index(Request $request)
    {
        $fences = FenceModel::where('deleted', '=', 0);

        if (strlen($request->param('keywords'))) {
            $keywords = $request->param('keywords');
            $fences->where('name', 'like', "%$keywords%");
            $this->assign(compact('keywords'));
        }

        $fences = $fences->paginate(10);

        $page = $fences->render();
        $this->assign([
            'fences' => $fences,
            'page' => $page
        ]);
        return $this->fetch();
    }

    /**
     * @param Request $request
     * @param $id
     * @return mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function show(Request $request, $id)
    {
        $fenceInfo = FenceModel::where('deleted', '=', 0)
            ->where('id', '=', $id)
            ->find();
        if ($fenceInfo) {
            $this->assign(['ak' => $this->yingyan->getBrowerAk()]);
            $this->assign(compact('fenceInfo'));
            return $this->fetch();
        }
        $this->error('电子围栏不存在！');
    }

    /**
     * @param Request $request
     * @return mixed|\think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function store(Request $request)
    {
        if ($request->isPost()) {
            //保存
            $names = json_decode($request->param('names'), true);
            $points = json_decode($request->param('data'), true);
            foreach ($names as $name) {
                $fenceExists = FenceModel::where('name', '=', $name)->where('deleted', '=', 0)->find();
                if ($fenceExists) {
                    return Utils::throw400('该电子围栏名称已存在！');
                }
            }

            try {
                Db::startTrans();
                $fences = [];
                foreach ($points as $key => $point) {
                    $fences[$key]['name'] = $names[$key];
                    $fences[$key]['points'] = json_encode($point);
                }
                $bicycleName = \app\index\model\Bicycle::where('id', '=', $request->param('person'))->find()->bicycle_name ?? '';

                foreach ($fences as $key => $fence) {
                    $points = json_decode($fence['points'], true);
                    $pointsStr = "";
                    foreach ($points as $point) {
                        $pointsStr .= $point['lat'] . ',' . $point['lng'] . ';';
                    }
                    $pointsStr = trim($pointsStr, ';');
                    $response = json_decode($this->yingyan->createPolygonFence($fence['name'], $pointsStr, $bicycleName), true);
                    if (!$response['status']) {
                        $fences[$key]['fence_id'] = $response['fence_id'];
                    } else {
                        throw new \Exception($response['message']);
                    }
                }

                $fence = new FenceModel();
                $result = $fence->saveAll($fences);
                $fenceBicycleData = [];
                foreach ($result as $item) {
                    $fenceBicycleData[] = [
                        'fence_id' => $item->id,
                        'bicycle_id' => $request->param('person')
                    ];
                }
                $fenceBicycle = new FenceBicyclesModel();
                $fenceBicycle->saveAll($fenceBicycleData);

                Db::commit();
            } catch (\Exception $exception) {
                Db::rollback();
                return Utils::throw400($exception->getMessage());
            }
            return Utils::ajaxReturn();
        }
        $this->assign(['ak' => $this->yingyan->getBrowerAk(), 'persons' => BicycleModel::where('deleted', '=', 0)->select()]);
        return $this->fetch();
    }

    /**
     * @param Request $request
     * @return mixed|\think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function destroy(Request $request, $id)
    {
        if ($request->isAjax() && $request->isDelete()) {
            Utils::throw405();
        }
        //删除电子围栏
        $fence = FenceModel::where('deleted', '=', 0)
            ->where('id', '=', $id)
            ->find();
        if ($fence) {
            try {
                Db::startTrans();
                $response = json_decode($this->yingyan->deletePolygonFence(null, [$fence->fence_id]), true);

                $fence->delete();
                if ($response['status']) {
                    throw new \Exception($response['message']);
                }
                Db::rollback();
            } catch (\Exception $exception) {
                Db::rollback();
                return Utils::throw400($exception->getMessage());
            }
        }

        return Utils::ajaxReturn();
    }


}