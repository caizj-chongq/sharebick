<?php

namespace app\index\controller;

use think\Request;
use app\index\model\Order as OrderModel;

class Order extends Base
{
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
            $this->assign(compact('orderInfo'));
            return $this->fetch();
        }
        $this->error('订单不存在！');
    }

}