<?php

namespace app\index\controller;

use app\common\Utils;
use think\Request;
use app\index\model\User as UserModel;
use app\index\model\Client\Operation as ClientOperationModel;
use app\index\model\Client as ClientModel;
use app\index\model\Order as OrderModel;

class Index extends Base
{
    /**
     * Index constructor.
     * @param Request|null $request
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function __construct(Request $request = null)
    {
        parent::__construct($request);
    }

    /**
     * @return mixed
     * @throws \think\Exception
     */
    public function index(Request $request)
    {
        //订单
        $startTime = strtotime($request->param('start', date('Y-m-1 00:00:00')));   //开始时间
        $endTime = strtotime($request->param('end', date('Y-m-t 23:59:59')));   //结束时间
        $orders = OrderModel::where('deleted', '=', 0)
            ->where('end', '>=', $startTime)
            ->where('end', '<=', $endTime)
            ->select();
        $ordersGroupByDay = [];
        foreach ($orders as $order) {
            $orderTime = date('Y-m-d', strtotime($order->end));
            $ordersGroupByDay[$orderTime]['count'] = ($ordersGroupByDay[$orderTime]['count'] ?? 0) + 1;
            $ordersGroupByDay[$orderTime]['sumPrice'] = ($ordersGroupByDay[$orderTime]['sumPrice'] ?? 0) + $order->price;
        }
        if ($request->isAjax()) {
            return Utils::ajaxReturn($ordersGroupByDay);
        } else {
            $userCount = UserModel::where('deleted', '=', 0)->count();   //总用户
            $dayAddUser = ClientModel::whereTime('created', 'today')->where('deleted', '=', 0)->count();   //当前周新增用户

            //当月骑行单数
            $monthCyclingOrderNumber = OrderModel::whereTime('created', 'month')->where('deleted', '=', 0)->count();
            //当月应收金额
            $monthReceivableMoney = OrderModel::whereTime('end', 'month')->where(function ($query) {
                $query->where('status', '=', 3)
                    ->whereOr('status', '=', 4);
            })->where('deleted', '=', 0)->sum('price');
            //当月实收金额
            $monthPaidAmount = OrderModel::whereTime('end', 'month')->where('status', '=', 3)->where('deleted', '=', 0)->sum('price');
            //当月待收金额
            $monthAmountToBeReceived = OrderModel::whereTime('end', 'month')->where('status', '=', 4)->where('deleted', '=', 0)->sum('price');


            $this->assign(['ordersGroupByDay' => json_encode($ordersGroupByDay)]);
            $this->assign(compact('userCount', 'dayAddUser', 'monthAmountToBeReceived', 'monthCyclingOrderNumber', 'monthPaidAmount', 'monthReceivableMoney'));
            return $this->fetch();
        }
    }

    /**
     *
     */
    public function _empty()    //空操作
    {
        return $this->redirect('index/Error/index');
    }
}
