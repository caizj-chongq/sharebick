<?php

namespace app\index\controller;

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
    public function index()
    {
        $userCount = UserModel::where('deleted', '=', 0)->count();   //总用户

        $monthActiveUser = ClientOperationModel::whereTime('time', 'month')->count();   //当前月活跃用户

        $weekActiveUser = ClientOperationModel::whereTime('time', 'week')->count();   //当前周活跃用户

        $dayActiveUser = ClientOperationModel::whereTime('time', 'today')->count();   //当前周活跃用户

        $monthAddUser = ClientModel::whereTime('created', 'month')->where('deleted', '=', 0)->count();   //当前月新增用户

        $weekAddUser = ClientModel::whereTime('created', 'week')->where('deleted', '=', 0)->count();   //当前周新增用户

        $dayAddUser = ClientModel::whereTime('created', 'today')->where('deleted', '=', 0)->count();   //当前周新增用户

        //当月骑行单数
        $monthCyclingOrderNumber = OrderModel::whereTime('created', 'month')->where('deleted', '=', 0)->count();
        //当周骑行单数
        $weekCyclingOrderNumber = OrderModel::whereTime('created', 'week')->where('deleted', '=', 0)->count();
        //当日骑行单数
        $dayCyclingOrderNumber = OrderModel::whereTime('created', 'today')->where('deleted', '=', 0)->count();

        //当月应收金额
        $monthReceivableMoney = OrderModel::whereTime('created', 'month')->where('status', '=', 3)->whereOr('status', '=', 4)->where('deleted', '=', 0)->sum('price');
        //当周应收金额
        $weekReceivableMoney = OrderModel::whereTime('created', 'week')->where('status', '=', 3)->whereOr('status', '=', 4)->where('deleted', '=', 0)->sum('price');
        //当天应收金额
        $dayReceivableMoney = OrderModel::whereTime('created', 'today')->where('status', '=', 3)->whereOr('status', '=', 4)->where('deleted', '=', 0)->sum('price');

        //当月已支付单数
        $monthPayOrderNumber = OrderModel::whereTime('created', 'month')->where('status', '=', 3)->where('deleted', '=', 0)->count();
        //当周已支付单数
        $weekPayOrderNumber = OrderModel::whereTime('created', 'week')->where('status', '=', 3)->where('deleted', '=', 0)->count();
        //当天已支付单数
        $dayPayOrderNumber = OrderModel::whereTime('created', 'today')->where('status', '=', 3)->where('deleted', '=', 0)->count();

        //当月实收金额
        $monthPaidAmount = OrderModel::whereTime('created', 'month')->where('status', '=', 3)->where('deleted', '=', 0)->sum('price');
        //当周实收金额
        $weekPaidAmount = OrderModel::whereTime('created', 'week')->where('status', '=', 3)->where('deleted', '=', 0)->sum('price');
        //当天实收金额
        $dayPaidAmount = OrderModel::whereTime('created', 'today')->where('status', '=', 3)->where('deleted', '=', 0)->sum('price');

        //当月未支付单数
        $monthNoPayOrderNumber = OrderModel::whereTime('created', 'month')->where('status', '=', 4)->where('deleted', '=', 0)->count();
        //当周未支付单数
        $weekNoPayOrderNumber = OrderModel::whereTime('created', 'week')->where('status', '=', 4)->where('deleted', '=', 0)->count();
        //当天未支付单数
        $dayNoPayOrderNumber = OrderModel::whereTime('created', 'today')->where('status', '=', 4)->where('deleted', '=', 0)->count();

        //当月待收金额
        $monthAmountToBeReceived = OrderModel::whereTime('created', 'month')->where('status', '=', 4)->where('deleted', '=', 0)->sum('price');
        //当周待收金额
        $weekAmountToBeReceived = OrderModel::whereTime('created', 'week')->where('status', '=', 4)->where('deleted', '=', 0)->sum('price');
        //当天待收金额
        $dayAmountToBeReceived = OrderModel::whereTime('created', 'today')->where('status', '=', 4)->where('deleted', '=', 0)->sum('price');



        $this->assign(compact('userCount', 'monthActiveUser', 'weekActiveUser', 'dayActiveUser', 'weekAddUser', 'monthAddUser', 'dayAddUser', 'monthAmountToBeReceived', 'monthCyclingOrderNumber', 'monthNoPayOrderNumber', 'monthPaidAmount', 'monthPayOrderNumber', 'monthReceivableMoney', 'weekAmountToBeReceived', 'weekCyclingOrderNumber', 'weekNoPayOrderNumber', 'weekPaidAmount', 'weekPayOrderNumber', 'weekReceivableMoney', 'dayAmountToBeReceived', 'dayCyclingOrderNumber', 'dayNoPayOrderNumber', 'dayPaidAmount', 'dayPayOrderNumber', 'dayReceivableMoney'));
        return $this->fetch();
    }

    /**
     *
     */
    public function _empty()    //空操作
    {
        return $this->redirect('index/Error/index');
    }
}
