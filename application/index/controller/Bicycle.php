<?php

namespace app\index\controller;

use app\common\Utils;
use app\common\Yingyan;
use think\Db;
use think\Request;
use app\index\model\Bicycle as BicycleModel;

class Bicycle extends Base
{
    protected $yingyan;

    /**
     * Bicycle constructor.
     * @param Request|null $request
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function __construct(Request $request = null)
    {
        parent::__construct($request);
        $bicycleStatus = $this->codeMap->getCodeValuesByCode(BicycleModel::$bicycleStatus);
        $this->yingyan = new Yingyan();
        $this->assign(compact('bicycleStatus'));
    }

    /**
     * @param Request $request
     * @return mixed
     * @throws \think\exception\DbException
     */
    public function index(Request $request)
    {
        $bicycles = BicycleModel::where('deleted', '=', 0);

        if (strlen($request->param('keywords'))) {
            $keywords = $request->param('keywords');
            $bicycles->where('lock_number', 'like', "%$keywords%")
                ->where('bicycle_number', 'like', "%$keywords%");
            $this->assign(compact('keywords'));
        }

        $bicycles = $bicycles->paginate(10);

        $page = $bicycles->render();
        $this->assign([
            'bicycles' => $bicycles,
            'page' => $page
        ]);

        return $this->fetch();
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
        if ($request->isAjax() && $request->isPost()) {
            //保存
            $bicycleExists = BicycleModel::where('bicycle_number', '=', $request->param('bicycle_number'))
                ->whereOr('lock_number', '=', $request->param('lock_number'))
                ->where('deleted', '=', 0)
                ->find();
            if ($bicycleExists) {
                $errMsg = '';
                if ($bicycleExists->bicycle_number === $request->param('bicycle_number')) {
                    $errMsg = '车号已经存在！';
                }
                if (!strlen($errMsg) && $bicycleExists->lock_number === $request->param('lock_number')) {
                    $errMsg = '该锁已被绑定到车号【' . $bicycleExists->bicycle_number . '】！';
                }
                return Utils::throw400($errMsg);
            } else {
                try {
                    Db::startTrans();
                    $client = new BicycleModel();
                    $client->data($request->param());
                    $client->save();
                    $response = json_decode($this->yingyan->createEntity($request->param('bicycle_name')), true);
                    if ($response['status']) {
                        throw new \Exception($response['message']);
                    }
                    Db::commit();
                } catch (\Exception $exception) {
                    Db::rollback();
                    return Utils::throw400($exception->getMessage());
                }
                return Utils::ajaxReturn();
            }
        }

        $bicycleStatus = $this->codeMap->getCodeValuesByCode(BicycleModel::$bicycleStatus);
        $this->assign(compact('bicycleStatus'));
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
        $bicycleInfo = BicycleModel::where('deleted', '=', 0)
            ->where('id', '=', $id)
            ->find();
        if ($bicycleInfo) {
            $this->assign(compact('bicycleInfo'));
            return $this->fetch();
        }
        $this->error('车辆不存在！');
    }

    /**
     * @param Request $request
     * @param $id
     * @return mixed|\think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function update(Request $request, $id)
    {
        $bicycleInfo = BicycleModel::where('deleted', '=', 0)
            ->where('id', '=', $id)
            ->find();
        if ($request->isAjax() && $request->isPatch()) {
            //保存
            if ($bicycleInfo) {
                //查看锁号是否是被使用
                $lockExists = BicycleModel::where('deleted', '=', 0)
                    ->where('lock_number', '=', $request->param('lock_number'))
                    ->where('id', '<>', $id)
                    ->find();
                if ($lockExists) {
                    return Utils::throw400('该锁已被绑定到车号【' . $lockExists->bicycle_number . '】！');
                }

                try {
                    $bicycleInfo->data([
                        'bicycle_number' => $bicycleInfo->bicycle_number,
                        'lock_number' => $request->param('lock_number'),
                        'status' => $request->param('status'),
                        'bicycle_name' => $bicycleInfo->bicycle_name
                    ]);
                    $bicycleInfo->save();
                } catch (\Exception $exception) {
                    return Utils::throw400($exception->getMessage());
                }

                return Utils::ajaxReturn();
            } else {
                return Utils::throw400('车辆不存在！');
            }
        }

        if ($bicycleInfo) {
            $this->assign(compact('bicycleInfo', 'id'));
            return $this->fetch();
        }

        $this->error('车辆不存在！');
    }

    /**
     * @param Request $request
     * @param $id
     * @return \think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function destroy(Request $request, $id)
    {
        if ($request->isAjax() && $request->isPost()) {
            Utils::throw405();
        }
        //删除车辆
        $bicycle = BicycleModel::where('deleted', '=', 0)
            ->where('id', '=', $id)
            ->find();
        if ($bicycle) {
            try {
                Db::startTrans();
                $bicycle->delete();
                $response = json_decode($this->yingyan->deleteEntity($bicycle->bicycle_name), true);
                if ($response['status']) {
                    throw new \Exception($response['message']);
                }
                Db::commit();
            } catch (\Exception $exception) {
                Db::rollback();
                return Utils::throw400($exception->getMessage());
            }
            return Utils::ajaxReturn();
        }

        return Utils::ajaxReturn();
    }

}