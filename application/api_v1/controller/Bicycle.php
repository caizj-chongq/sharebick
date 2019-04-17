<?php

namespace app\api_v1\controller;

use app\common\Lock;
use app\common\TencentMap;
use app\common\Utils;
use app\common\Yingyan;
use app\index\model\Bicycle as BicycleModel;
use app\index\model\Fence\Alarm;
use app\index\model\LockStatus\Lock as LockModel;
use app\index\model\Order as OrderModel;
use think\Db;
use think\Paginator;
use think\Request;

/**
 * @apiDefine Page
 * @apiParam    {Integer}    [page=1]    页码
 */

/**
 * @apiDefine Token
 * @apiParam    {String}    token    接口调用凭证
 */

/**
 * @api {get} /bicycle 订单列表
 * @apiVersion 0.0.1
 * @apiName bicycle.index
 * @apiGroup bicycle
 *
 * @apiUse  Page
 * @apiUse  Token
 *
 * @apiSuccess        {Number}    status    状态码
 * @apiSuccess        {String}    message    状态提示
 * @apiSuccess        {Object}    data    数据
 *
 * @apiSuccessExample Success:
 *     {
 *          "data": {
 *              "total": 1,
 *              "per_page": 5,
 *              "current_page": 1,
 *              "last_page": 1,
 *              "data": [
 *                  {
 *                      "id": 7,
 *                      "order_number": "OR201902245c7188c421b58",
 *                      "bicycle_id": 6,
 *                      "begin": "2019-02-24 01:54:12",
 *                      "end": "2019-02-24 12:04:47",
 *                      "price": "611.00",
 *                      "status": {
 *                          "status": 4,
 *                          "status_info": "未支付"
 *                      },
 *                      "client_opretion": "{\"id\": 1, \"nick\": \"123\", \"money\": \"0.00\", \"mobile\": null, \"openid\": \"openid\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}",
 *                      "bicycle_opretion": "{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}",
 *                      "created": "2019-02-24 01:54:12",
 *                      "updated": "2019-02-24 01:54:12",
 *                      "deleted": 0,
 *                      "remark": null,
 *                      "client_id": 1,
 *                      "meter": 0
 *                  }
 *              ]
 *          },
 *          "status": 0,
 *          "msg": ""
 *     }
 *
 * @apiUse Error
 *
 */

/**
 * @api {get} /bicycle_show 订单详情
 * @apiVersion 0.0.1
 * @apiName bicycle.show
 * @apiGroup bicycle
 *
 * @apiUse  Token
 * @apiParam    {Integer}    id      订单id
 *
 * @apiSuccess        {Number}    status    状态码
 * @apiSuccess        {String}    message    状态提示
 * @apiSuccess        {Object}    data    数据
 *
 * @apiSuccessExample Success:
 *     {
 *          "data": {
 *              "id": 7,
 *              "order_number": "OR201902245c7188c421b58",
 *              "bicycle_id": 6,
 *              "begin": "2019-02-24 01:54:12",
 *              "end": "2019-02-24 12:04:47",
 *              "price": "611.00",
 *              "status": {
 *                  "status": 4,
 *                  "status_info": "未支付"
 *              },
 *              "client_opretion": "{\"id\": 1, \"nick\": \"123\", \"money\": \"0.00\", \"mobile\": null, \"openid\": \"openid\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}",
 *              "bicycle_opretion": "{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}",
 *              "created": "2019-02-24 01:54:12",
 *              "updated": "2019-02-24 01:54:12",
 *              "deleted": 0,
 *              "remark": null,
 *              "client_id": 1,
 *              "meter": 0,
 *              "location": []  //订单定位信息，用来做车辆轨迹
 *          },
 *          "status": 0,
 *          "msg": ""
 *     }
 *
 * @apiUse Error
 *
 */

/**
 * @api {post} /bicycle 创建订单
 * @apiVersion 0.0.1
 * @apiName bicycle.store
 * @apiGroup bicycle
 *
 * @apiUse  Token
 * @apiParam    {String}    carNumber      车号
 *
 * @apiSuccess        {Number}    status    状态码
 * @apiSuccess        {String}    message    状态提示
 * @apiSuccess        {Object}    data    数据
 *
 * @apiSuccessExample Success:
 *     {
 *          "data": {
 *              "order_number": "OR201903045c7ce5a08f543",
 *              "bicycle_id": 6,
 *              "begin": "2019-03-04 16:45:20",
 *              "status": {
 *                  "status": 1,
 *                  "status_info": "进行中"
 *              },
 *              "client_opretion": {
 *                  "id": 1,
 *                  "nick": "123",
 *                  "money": "498547.00",
 *                  "created": "2019-02-23 19:12:41",
 *                  "updated": "2019-02-23 19:12:41",
 *                  "deleted": 0,
 *                  "mobile": null,
 *                  "openid": "openid"
 *              },
 *              "bicycle_opretion": {
 *                  "id": 6,
 *                  "created": "2019-02-23 20:58:39",
 *                  "updated": "2019-02-23 21:04:56",
 *                  "deleted": 0,
 *                  "lock_number": "866160033560827",
 *                  "bicycle_number": "001",
 *                  "status": {
 *                      "status": 2,
 *                      "status_info": "使用中"
 *                  },
 *                  "bicycle_name": "可以随意调用接口的车",
 *                  "hourlyPrice": "60.00",
 *                  "dailyPrice": "1440.00"
 *              },
 *              "client_id": 1,
 *              "created": "2019-03-04 16:45:20",
 *              "updated": "2019-03-04 16:45:20",
 *              "id": "21"
 *          },
 *          "status": 0,
 *          "msg": ""
 *     }
 *
 * @apiUse Error
 *
 */

/**
 * @api {put} /bicycle 更新订单
 * @apiVersion 0.0.1
 * @apiName bicycle.update
 * @apiGroup bicycle
 *
 * @apiUse  Token
 * @apiParam    {Integer}    id      订单id
 * @apiParam    {Integer}    [status]      想要更新为的状态  1 使用中; 2 取消订单(3分钟以内); 3 完成订单(付钱); 4 结束用车
 * @apiParam    {Integer}     [location]   车辆定位，传入就定位，不传就不定位
 * @apiParam    {String}     [remark]      车辆反馈信息
 *
 * @apiSuccess        {Number}    status    状态码
 * @apiSuccess        {String}    message    状态提示
 * @apiSuccess        {Object}    data    数据
 *
 * @apiSuccessExample Success:
 *     {
 *          "data": {
 *              "order_number": "OR201903045c7ce5a08f543",
 *              "bicycle_id": 6,
 *              "begin": "2019-03-04 16:45:20",
 *              "status": {
 *                  "status": 1,
 *                  "status_info": "进行中"
 *              },
 *              "client_opretion": {
 *                  "id": 1,
 *                  "nick": "123",
 *                  "money": "498547.00",
 *                  "created": "2019-02-23 19:12:41",
 *                  "updated": "2019-02-23 19:12:41",
 *                  "deleted": 0,
 *                  "mobile": null,
 *                  "openid": "openid"
 *              },
 *              "bicycle_opretion": {
 *                  "id": 6,
 *                  "created": "2019-02-23 20:58:39",
 *                  "updated": "2019-02-23 21:04:56",
 *                  "deleted": 0,
 *                  "lock_number": "866160033560827",
 *                  "bicycle_number": "001",
 *                  "status": {
 *                      "status": 2,
 *                      "status_info": "使用中"
 *                  },
 *                  "bicycle_name": "可以随意调用接口的车",
 *                  "hourlyPrice": "60.00",
 *                  "dailyPrice": "1440.00"
 *              },
 *              "client_id": 1,
 *              "created": "2019-03-04 16:45:20",
 *              "updated": "2019-03-04 16:45:20",
 *              "id": "21"
 *          },
 *          "status": 0,
 *          "msg": ""
 *     }
 *
 * @apiUse Error
 *
 */

class Bicycle extends Base
{
    protected $lock;

    public function __construct(Request $request = null)
    {
        parent::__construct($request);
        $this->lock = new Lock();
    }

    /**
     * @param Request $request
     * @return \think\response\Json
     * @throws \think\exception\DbException
     */
    public function index(Request $request)
    {
        $orders = OrderModel::where('deleted', '=', 0)
            ->where('client_id', '=', $this->user->id)
            ->order('created', 'desc')
            ->paginate(5);
        return Utils::ajaxReturn($orders->toArray());
    }

    /**
     * @param Request $request
     * @return \think\response\Json
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function show(Request $request)
    {
        $order = OrderModel::where('id', '=', $request->param('id', ''))->where('client_id', '=', $this->user->id)->find();
        if (!$order) {
            return Utils::throw400('订单不存在！');
        }
        $locationFile = ORDER_LOCATION_PATH . 'location_' . $order->order_number . '.log';

        $locations = [];
        if (is_file($locationFile)) {
            $locationData = json_decode(file_get_contents($locationFile), true);
            $tencentLocations = (new TencentMap())->conversionCoordinates($locationData);
            if ($tencentLocations['code']) {
                return Utils::throw400($tencentLocations['msg']);
            }
            $locations = $tencentLocations['data'];
        }

        $order->location = $locations;
        return Utils::ajaxReturn($order->toArray());
    }

    /**
     * @param Request $request
     * @return \think\response\Json
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException.
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

            if (OrderModel::where('bicycle_id', '=', $car->id)
                ->where('deleted', '=', 0)
                ->where('status', '=', 1)
                ->find()) { //如果存在正在使用的订单
                return Utils::throw400('车辆当前不可用，请更换车辆进行使用');
            }

            $lock = new Lock();
            $unLockTime = time() - 120;
            $response = json_decode($lock->unLock($car->lock_number, $unLockTime), true);
            if ($response['code'] != 1) {
                return Utils::throw400('车辆当前不可用，请更换车辆进行使用');
            }

            $lockInfo = null;
            for ($i = 0; $i < 5 ; $i++) {    //轮询查看开锁没有
                $lockInfo = LockModel::where('imei', '=', $car->lock_number)
                    ->where('lock_status', '=', 1)
                    ->where('lock_time', '>=', date('Y-m-d H:i:s', $unLockTime))
                    ->find();
                if ($lockInfo) {
                    break;
                }
                sleep(1);
            }
            if ($i >= 5) {
                return Utils::throw400('开锁失败，请更换车辆再试！');
            }

            //开锁后生产订单信息
            $order = new OrderModel();
            $order->data([
                'order_number' => 'OR' . date('Ymd') . uniqid(),
                'bicycle_id' => $car->id,
                'begin' => $unLockTime,
                'status' => 1,
                'client_opretion' => $this->user->hidden(['token']),
                'bicycle_opretion' => $car,
                'client_id' => $this->user->id
            ]);
            $order->save();
            return Utils::ajaxReturn($order->toArray());
        }

        return Utils::throw405();
    }

    /**
     * 更新订单操作
     * @param Request $request
     * @return \think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function update(Request $request)
    {
        if ($request->isPut()) {
            $order = OrderModel::where('id', '=', $request->param('id', ''))->where('client_id', '=', $this->user->id)->find();
            if (!$order) {
                return Utils::throw400('订单不存在！');
            }
            $startTime = (is_numeric($order->begin) ? $order->begin : strtotime($order->begin)) - 120;
            if (strlen($request->param('status', ''))) { //传入status
                switch ($request->param('status')) {
                    case 2: //取消订单
                        if (ceil(($startTime - time()) / 60) > 3) {    //前3分钟可以取消订单
                            return Utils::throw400('骑行时间已超过3分钟，不允许再取消订单！');
                        }
                        // 查询关锁状态
                        $lockInfo = null;
                        for ($i = 0; $i < 5; $i++) {    //轮询查看关锁没有
                            dd(date('Y-m-d H:i:s', $startTime));
                            $lockInfo = LockModel::where('imei', '=', json_decode($order->bicycle_opretion, true)['bicycle_number'])
                                ->where('lock_status', '=', 0)
                                ->where('lock_time', '>=', date('Y-m-d H:i:s', $startTime))
                                ->find();
                            if ($lockInfo) {
                                break;
                            }
                            sleep(1);
                        }
                        if ($i >= 5) {
                            return Utils::throw400('服务器繁忙，请稍后再试！');
                        }

                        //车辆位置
                        $locationTime = time();
                        $carImei = json_decode($order->bicycle_opretion, true)['lock_number'];
                        $response = json_decode($this->lock->getLocation($carImei, $locationTime), true);
                        if ($response['code'] != 1) {
                            return Utils::throw400('定位失败！');
                        }

                        $lockInfo = null;
                        for ($i = 0; $i < 5; $i++) {    //轮询获取定位
                            $lockInfo = LockModel::where('imei', '=', $carImei)
                                ->where('pos_gtime', '>=', date('Y-m-d H:i:s', $locationTime - 120))
                                ->find();
                            if ($lockInfo) {
                                break;
                            }
                            sleep(1);
                        }
                        if ($i >= 5) {
                            return Utils::throw400('定位失败！');
                        }

                        if ($lockInfo) {
                            //保存数据到车表中，更新车的位置
                            $saveBicycleData['gps'] = json_encode([
                                    'lng' => $lockInfo->pos_lng,
                                    'lat' => $lockInfo->pos_lat
                                ]);
                        }

                        $saveData['status'] = 2;
                        $saveData['end'] = time();
                        break;
                    case 3: //3完成订单 扣除用户金额
                        //判断用户金额是否充足
                        if ($this->user->money < $order->price) {
                            return Utils::throw400('对不起，您的账户余额不足，请联系管理员充值！');
                        }
                        $userSaveData = [
                            'money' => $this->user->money - $order->price
                        ];
                        $saveData['status'] = 3;
                        break;
                    case 4: //结束用车
                        // 查询关锁状态
                        $lockInfo = null;
                        for ($i = 0; $i < 5; $i++) {    //轮询查看关锁没有
                            $lockInfo = LockModel::where('imei', '=', json_decode($order->bicycle_opretion, true)['lock_number'])
                                ->where('lock_status', '=', 0)
                                ->where('lock_time', '>=', date('Y-m-d H:i:s', $startTime))
                                ->find();
                            if ($lockInfo) {
                                break;
                            }
                            sleep(1);
                        }
                        if ($i >= 5) {
                            return Utils::throw400('服务器繁忙，请稍后再试！');
                        }

                        //判断当前锁位置是否在围栏外,如果在围栏外面，就不允许停车
                        //车辆位置
                        $locationTime = time() - 120;
                        $carImei = json_decode($order->bicycle_opretion, true)['lock_number'];
                        $response = json_decode($this->lock->getLocation($carImei, $locationTime), true);
                        if ($response['code'] != 1) {
                            return Utils::throw400('定位失败！');
                        }

                        $lockInfo = null;
                        for ($i = 0; $i < 5; $i++) {    //轮询获取定位
                            $lockInfo = LockModel::where('imei', '=', $carImei)
                                ->where('pos_gtime', '>=', date('Y-m-d H:i:s', $locationTime))
                                ->find();
                            if ($lockInfo) {
                                break;
                            }
                            sleep(1);
                        }
                        if ($i >= 5) {
                            return Utils::throw400('定位失败！');
                        }
//
//
                        if ($lockInfo) {
                            //保存数据到车表中，更新车的位置
                            $saveBicycleData['gps'] = json_encode([
                                'lng' => $lockInfo->pos_lng,
                                'lat' => $lockInfo->pos_lat
                            ]);
//                            //判断当前锁位置是否在围栏外
//                            $yingyan = new Yingyan();
//                            $response = json_decode($yingyan->queryStatusByLocation($lockInfo->pos_lng, $lockInfo->pos_lat, json_decode($order->bicycle_opretion, true)['bicycle_name'], 'wgs84'), true);
//
//                            if (!$response['status']) {
//                                $err = '';
//                                if ($response['size']) {
//                                    foreach ($response['monitored_statuses'] as $monitored_status) {
//                                        if ($monitored_status['monitored_status'] == 'out') {
//                                            $err = '当前车辆已驶出规定范围，请回到规定范围内再试！';
//                                            break;
//                                        }
//                                    }
//                                }
//                                if (strlen($err)) {
//                                    return Utils::ajaxReturn(null, 3, $err);
//                                }
//                            }
                        }

                        //计算保存数据
                        $endTime = time();
                        $saveData['status'] = 4;
                        $saveData['end'] = $endTime;
                        //计算价格
                        $diffTime = $endTime - $startTime + 120; //相差时间戳
                        //计算有几天、几小时
                        $day = 60 * 60 * 24;
                        $days = floor($diffTime / $day);
                        $minute = 60;
                        $minutes = ceil(($diffTime - ($days * $day)) / $minute);
                        $bicycle_opretion = json_decode($order->bicycle_opretion, true);
                        $price = ($days * $bicycle_opretion['dailyPrice']) + ($minutes * $bicycle_opretion['hourlyPrice'] / 60); //除去天的剩下的按照小时计算（小时换算成分钟）
                        $saveData['price'] = $price;

                        //计算距离
                        $filename = ORDER_LOCATION_PATH . 'location_' . $order->order_number . '.log';
                        if (!is_file($filename)) {
                            $saveData['meter'] = 0;
                            break;
                        }
                        $tencnetMap = new TencentMap();
                        //转换坐标为腾讯坐标
                        $locationData = json_decode(file_get_contents($filename), true);
                        $tencentLocations = $tencnetMap->conversionCoordinates($locationData);
                        if ($tencentLocations['code']) {
                            return Utils::throw400($tencentLocations['msg']);
                        }
                        $needComputedLocationArr = $tencentLocations['data'];

                        $startArr = [];
                        $endArr = [];
                        foreach ($needComputedLocationArr as $key => $item) {
                            if ($key != count($needComputedLocationArr)) {
                                $startArr[] = $item;
                            }
                            if ($key != 0) {
                                $endArr[] = $item;
                            }

                        }
                        if (!(count($startArr) && count($endArr))) {
                            $saveData['meter'] = 0;
                            break;
                        }

                        //计算距离核心
                        $realResult = [];
                        for ($rounds = 0; $rounds < ceil(count($endArr) / 20); $rounds++) {
                            $startStr = '';
                            $endStr = '';
                            if (count($endArr) - ($rounds * 20) >= 20) {
                                $eles = 20;
                            } else {
                                $eles = count($endArr) - ($rounds * 20);
                            }

                            for ($k = 0; $k < $eles; $k++) {
                                $startStr .= $startArr[$k + $rounds * 20]['lat'] . ',' . $startArr[$k + $rounds * 20]['lng'] . ';';
                                $endStr .=  $endArr[$k + $rounds * 20]['lat'] . ',' . $endArr[$k + $rounds * 20]['lng'] . ';';
                            }
                            $response = json_decode($tencnetMap->parametersDistance('bicycling', trim($startStr, ';'), trim($endStr, ';')), true);
                            $result = [];
                            if (!$response['status']) {
                                $result = $response['result'];
                            } else {
                                return Utils::throw400($response['message']);
                            }
                            for ($i = 0; $i < count($result['rows']); $i++) {
                                for ($j = 0; $j < count($result['rows'][$i]['elements']); $j++) {
                                    if ($i == $j) {
                                        $realResult[] = $result['rows'][$i]['elements'][$j];
                                    }
                                }
                            }
                        }

                        $meter = 0;
                        foreach ($realResult as $item) {
                            $meter += $item['distance'];
                        }
                        $saveData['meter'] = $meter;
                        break;
                }
            }

            if (strlen($request->param('remark', ''))) { //传入remark,反馈车况
                $saveData['remark'] = $request->param('remark');
            }

            if (strlen($request->param('location', ''))) {
                //更新订单 车辆位置
                $locationTime = time() - 120;
                $carImei = json_decode($order->bicycle_opretion, true)['lock_number'];
                $response = json_decode($this->lock->getLocation($carImei, $locationTime), true);
                if ($response['code'] != 1) {
                    return Utils::throw400('定位失败！');
                }

                $lockInfo = null;
                for ($i = 0; $i < 10; $i++) {    //轮询查看开锁没有
                    $lockInfo = LockModel::where('imei', '=', $carImei)
                        ->where('pos_gtime', '>=', date('Y-m-d H:i:s', $locationTime))
                        ->find();
                    if ($lockInfo) {
                        break;
                    }
                    sleep(1);
                }
                if ($i >= 10) {
                    return Utils::throw400('定位失败！');
                }
                //把位置信息放入文件
                if ($lockInfo) {
                    $filename = ORDER_LOCATION_PATH . 'location_' . $order->order_number . '.log';
                    $oldData = [];
                    if (is_file($filename)) {
                        $oldData = json_decode(file_get_contents($filename), true);
                    }
                    $oldData[] = [
                        'lat' => $lockInfo->pos_lat,
                        'lng' => $lockInfo->pos_lng
                    ];
                    file_put_contents($filename, json_encode($oldData));

                    //判断位置是否在电子围栏内
                    $yingyan = new Yingyan();
                    $response = json_decode($yingyan->queryStatusByLocation($lockInfo->pos_lng, $lockInfo->pos_lat, json_decode($order->bicycle_opretion, true)['bicycle_name'], 'wgs84'), true);

                    if (!$response['status']) {
                        $err = '';
                        if ($response['size']) {
                            foreach ($response['monitored_statuses'] as $monitored_status) {
                                if ($monitored_status['monitored_status'] == 'out') {
                                    //围栏外,保存数据到围栏报警数据表
                                    $alarm = Alarm::where('order_id', '=', $order->id)
                                        ->where('out_time', '<>', 0)
                                        ->where('in_time', '=', 0)
                                        ->find();   //存在出去了还没有进来的数据
                                    if (!$alarm) {
                                        $alarm = new Alarm();
                                        $alarm->data([
                                            'out_gps' => json_encode([
                                                'lng' => $lockInfo->pos_lng,
                                                'lat' => $lockInfo->pos_lat
                                            ]),
                                            "out_time" => time(),
                                            "order_id" => $order->id
                                        ]);
                                        $alarm->save();
                                    }

//                                    $err = '当前车辆已驶出规定范围，请尽快回到规定范围内！';
                                    break;
                                }
                            }

                            //电子围栏报警更新进入电子围栏信息
                            if (!strlen($err)) {
                                $alarm = Alarm::where('order_id', '=', $order->id)
                                    ->where('out_time', '<>', 0)
                                    ->where('in_time', '=', 0)
                                    ->find();   //存在出去了还没有进来的数据
                                if ($alarm) {
                                    $alarm->data([
                                        'in_gps' => json_encode([
                                            'lng' => $lockInfo->pos_lng,
                                            'lat' => $lockInfo->pos_lat
                                        ]),
                                        "in_time" => time()
                                    ]);
                                    $alarm->save();
                                }
                            }
                        }
                        if (strlen($err)) {
                            return Utils::ajaxReturn(null, 3, $err);
                        }
                    }
                }
            }

            try {
                Db::startTrans();
                if (isset($saveData)) { //是否存在订单需要保存的数据
                    $order->where('id', '=', $request->param('id', ''))->update($saveData);
                    if (isset($saveData['remark'])) {   //是否存在车辆反馈的相关信息
                        BicycleModel\Reports::create([  //保存车辆反馈信息
                            'bicycle_id' => json_decode($order->bicycle_opretion, true)['id'],
                            'remark' => $saveData['remark'],
                            'order_id' => $order->id,
                            'client_id' => $order->client_id
                        ]);
                    }
                }

                if (isset($userSaveData)) { //是否存在需要保存在用户表中的数据
                    Db::table('clients')->where('id', '=', $this->user->id)->update($userSaveData);
                }

                if (isset($saveBicycleData)) { //是否存在需要保存在车辆表中的数据
                    Db::table('bicycles')->where('id', '=', json_decode($order->bicycle_opretion, true)['id'])->update($saveBicycleData);
                }

                Db::commit();
                return Utils::ajaxReturn(OrderModel::where('id', '=', $request->param('id', ''))->where('client_id', '=', $this->user->id)->find()->toArray());
            } catch (\Exception $exception) {
                Db::rollback();
                return Utils::throw400($exception->getMessage());
            }
        }
        return Utils::throw405();
    }


}