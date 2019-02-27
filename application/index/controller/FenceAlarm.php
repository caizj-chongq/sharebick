<?php
namespace app\index\controller;

use app\index\model\Fence\Alarm;
use think\Request;

class FenceAlarm extends Base
{
    public function index(Request $request)
    {

        $fenceAlarms = Alarm::join('orders', 'orders.id = fence_alarm.order_id')
            ->field('orders.order_number,fence_alarm.*');


        $fenceAlarms = $fenceAlarms->paginate(10);

        $page = $fenceAlarms->render();
        $this->assign([
            'fenceAlarms' => $fenceAlarms,
            'page' => $page
        ]);


        $this->assign(compact('fenceAlarms'));
        return $this->fetch();
    }
}