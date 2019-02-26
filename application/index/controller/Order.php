<?php

namespace app\index\controller;

use app\common\TencentMap;
use app\common\Utils;
use app\common\Yingyan;
use think\Db;
use think\Request;
use app\index\model\Order as OrderModel;
use app\index\model\Fence as FenceModel;

class Order extends Base
{
    protected $yingyan;

    public function __construct(Request $request = null)
    {
        parent::__construct($request);

        $this->yingyan = new Yingyan();
        $this->assign(['ak' => $this->yingyan->getBrowerAk()]);
    }

    /**
     * @param Request $request
     * @return mixed
     * @throws \think\exception\DbException
     */
    public function index(Request $request)
    {
        $orders = OrderModel::where('deleted', '=', 0);

        if (strlen($request->param('keywords'))) {
            $keywords = $request->param('keywords');
            $orders->where('order_number', 'like', "%$keywords%");
            $this->assign(compact('keywords'));
        }

        $orders = $orders->paginate(10);

        $page = $orders->render();
        $this->assign([
            'orders' => $orders,
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
        $orderInfo = OrderModel::where('deleted', '=', 0)
            ->where('id', '=', $id)
            ->find();
        if ($orderInfo) {
            $locationFile = ORDER_LOCATION_PATH . 'location_' . $orderInfo->order_number . '.log';

            $locations = [];
            if (is_file($locationFile)) {
                $locations = json_decode(file_get_contents($locationFile), true);
            }
            $orderInfo->location = json_encode($locations);

            //查询电子围栏信息
            $bicycle_id = json_decode($orderInfo->bicycle_opretion, true)['id'];
            $fence = FenceModel\Bicycles::join('fences', 'fences.id = fence_bicycles.fence_id')
                    ->where('bicycle_id', '=', $bicycle_id)
                    ->find();
            if ($fence) {
                $this->assign(['fencePoints' => $fence->points]);
            }
            $this->assign(compact('orderInfo'));

            //查看电子围栏报警记录
            $fenceAlarms = FenceModel\Alarm::where('order_id', '=', $orderInfo->id)
                ->where('deleted', '=', 0)
                ->select();
            $this->assign(compact('fenceAlarms'));
            return $this->fetch();
        }

        $this->error('订单不存在！');
    }

}