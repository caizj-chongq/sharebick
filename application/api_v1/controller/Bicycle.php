<?php
namespace app\api_v1\controller;

use app\common\Lock;
use app\common\Utils;
use app\index\model\Bicycle as BicycleModel;
use app\index\model\LockStatus\Lock as LockModel;
use think\Request;

class Bicycle extends Base
{
    /**
     * 开锁，创建订单信息
     * @param Request $request
     * @return \think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function store(Request $request)
    {
        if ($request->isPost()) {
            $carNumber = $request->param('carNumber', '');
            $car = BicycleModel::where('bicycle_number', '=', $carNumber)->where('deleted', '=', 0)->find();
            if (!$car) {
                return Utils::throw400('不存在该车辆！');
            }

            if (in_array($car->status['status'], [1, 3])) {   //1: 未投放, 3:暂停使用
                return Utils::throw400('车辆当前不可用，请更换车辆进行使用');
            }

            $lock = new Lock();
            $unLockTime = time();
            $response = json_decode($lock->unLock($car->lock_number, $unLockTime), true);
            if ($response['code'] != 1) {
                return Utils::throw400('车辆当前不可用，请更换车辆进行使用');
            }

            $lockInfo = null;
            for ($i = 0; $i < 10 ; $i++) {    //轮询查看开锁没有
                $lockInfo = LockModel::where('imei', '=', $car->lock_number)
                    ->where('lock_status', '=', 1)
                    ->where('lock_time', '>=', date('Y-m-d H:i:s', $unLockTime))
                    ->find();
                if ($lockInfo) {
                    break;
                }
                sleep(1);
            }
            if ($i >= 10) {
                return Utils::throw400('开锁失败，请更换车辆再试！');
            }

            //开锁后生产订单信息

        }

        return Utils::throw405();
    }


}