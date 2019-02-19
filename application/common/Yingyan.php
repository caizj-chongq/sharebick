<?php

namespace app\common;

use think\Db;

class Yingyan
{
    /**
     * @var string
     */
    protected $requestBaseUsl = "http://yingyan.baidu.com/v3";

    /**
     * @var array
     */
    protected $requestUrl = [
        "createEntity" => "/entity/add",    //创建监控对象实体
        "updateEntity" => "/entity/update",    //更新监控对象实体
        "deleteEntity" => "/entity/delete",    //删除监控对象实体
        "listEntity" => "/entity/list",    //监控对象实体列表
        "createPolygonFence" => "/fence/createpolygonfence",  //创建电子围栏
        "deletePolygonFence" => "/fence/delete",  //删除电子围栏
        "listPolygonFence" => "/fence/list",  //电子围栏列表
        "queryStatusByLocation" => "/fence/querystatusbylocation"   //传入坐标查看是否在围栏内外，前提是监控对象与围栏绑定
    ];

    /**
     * @var mixed
     */
    private $ak;

    /**
     * @var mixed
     */
    private $serviceId;

    /**
     * Yingyan constructor.
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function __construct()
    {
        $systemInfo = Db::table('system_info')->find();
        if ($systemInfo) {
            $this->ak = $systemInfo->yingyanAk;
            $this->serviceId = $systemInfo->service_id;
        } else {
            return false;
        }
    }

    /**
     * 创建监控对象实体
     * @param $entityName
     * @param null $entityDesc
     * @param array $columnKey
     * @return false|string
     */
    public function createEntity($entityName, $entityDesc = null, array $columnKey = array())
    {
        $requestUrl = $this->requestBaseUsl . $this->requestUrl['createEntity'];
        $requestData = [
            'ak' => $this->ak,
            'service_id' => $this->serviceId,
            'entity_name' => $entityName,
            'entity_desc' => $entityDesc
        ];
        $requestData = array_merge($requestData, $columnKey);

        $requestMethod = 'POST';

        return $this->send($requestUrl, $requestData, $requestMethod);
    }

    /**
     * 更新监控对象实体 名称不可修改
     * @param $entityName 不可更新 entityName
     * @param null $entityDesc
     * @param array $columnKey
     * @return false|string
     */
    public function updateEntity($entityName, $entityDesc = null, array $columnKey = array())
    {
        $requestUrl = $this->requestBaseUsl . $this->requestUrl['updateEntity'];
        $requestData = [
            'ak' => $this->ak,
            'service_id' => $this->serviceId,
            'entity_name' => $entityName,
            'entity_desc' => $entityDesc
        ];
        $requestData = array_merge($requestData, $columnKey);
        $requestMethod = 'POST';

        return $this->send($requestUrl, $requestData, $requestMethod);
    }

    /**
     * 删除监控对象实体
     * @param $entityName
     * @return false|string
     */
    public function deleteEntity($entityName)
    {
        $requestUrl = $this->requestBaseUsl . $this->requestUrl['deleteEntity'];
        $requestData = [
            'ak' => $this->ak,
            'service_id' => $this->serviceId,
            'entity_name' => $entityName
        ];
        $requestMethod = 'POST';

        return $this->send($requestUrl, $requestData, $requestMethod);
    }

    /**
     * 创建电子围栏
     * @param $fenceName
     * @param array $vertexes
     * @param $person
     * @return false|string
     */
    public function createPolygonFence($fenceName, array $vertexes, $person)
    {
        $requestUrl = $this->requestBaseUsl . $this->requestUrl['createPolygonFence'];
        $requestData = [
            'ak' => $this->ak,
            'service_id' => $this->serviceId,
            'dece_name' => $fenceName,
            'coord_type' => 'bd09ll',
            'decoise' => 100,
            'vertexes' => implode(';', $vertexes),
            'monitored_person' => $person
        ];
        $requestMethod = 'POST';

        return $this->send($requestUrl, $requestData, $requestMethod);
    }

    /**
     * 删除电子围栏
     * @param null $monitoredPerson
     * @param array $fenceIds
     * @return array|false|string
     */
    public function deletePolygonFence($monitoredPerson = null, array $fenceIds = array())
    {
        $requestUrl = $this->requestBaseUsl . $this->requestUrl['deletePolygonFence'];
        if (is_null($monitoredPerson) && count($fenceIds) == 0) {
            return [
                'code' => 2,
                'msg' => 'params error'
            ];
        }

        if (!is_null($monitoredPerson)) {
            $requestData = [
                'ak' => $this->ak,
                'service_id' => $this->serviceId,
                'monitored_person' => $monitoredPerson
            ];
        }

        if (count($fenceIds) > 0) {
            $requestData = [
                'ak' => $this->ak,
                'service_id' => $this->serviceId,
                'fence_ids' => $fenceIds
            ];
        }

        if (!is_null($monitoredPerson) && count($fenceIds) > 0) {
            $requestData = [
                'ak' => $this->ak,
                'service_id' => $this->serviceId,
                'monitored_person' => $monitoredPerson,
                'fence_ids' => $fenceIds
            ];
        }

        $requestMethod = 'POST';

        return $this->send($requestUrl, $requestData, $requestMethod);
    }

    /**
     * 电子围栏列表
     * @param null $monitoredPerson
     * @param array $fenceIds
     * @return array|false|string
     */
    public function listPolygonFence($monitoredPerson = null, array $fenceIds = array())
    {
        $requestUrl = $this->requestBaseUsl . $this->requestUrl['listPolygonFence'];
        if (is_null($monitoredPerson) && count($fenceIds) == 0) {
            return [
                'code' => 2,
                'msg' => 'params error'
            ];
        }

        if (!is_null($monitoredPerson)) {
            $requestData = [
                'ak' => $this->ak,
                'service_id' => $this->serviceId,
                'monitored_person' => $monitoredPerson
            ];
        }

        if (count($fenceIds) > 0) {
            $requestData = [
                'ak' => $this->ak,
                'service_id' => $this->serviceId,
                'fence_ids' => $fenceIds
            ];
        }

        if (!is_null($monitoredPerson) && count($fenceIds) > 0) {
            $requestData = [
                'ak' => $this->ak,
                'service_id' => $this->serviceId,
                'monitored_person' => $monitoredPerson,
                'fence_ids' => $fenceIds
            ];
        }

        $requestMethod = 'GET';

        return $this->send($requestUrl, $requestData, $requestMethod);
    }


    /**
     * 传入监控对象和监控对象坐标，查看坐标是否在当前监控对象绑定的电子围栏范围内
     * @param $longitude
     * @param $latitude
     * @param $person
     * @return false|string
     */
    public function queryStatusByLocation($longitude, $latitude, $person)
    {
        $requestUrl = $this->requestBaseUsl . $this->requestUrl['queryStatusByLocation'];
        $requestData = [
            'ak' => $this->ak,
            'service_id' => $this->serviceId,
            'coord_type' => 'bd09ll',
            'longitude' => $longitude,
            'latitude' => $latitude,
            'monitored_person' => $person
        ];
        $requestMethod = 'GET';

        return $this->send($requestUrl, $requestData, $requestMethod);
    }

    /**
     * 发送请求
     * @param $url
     * @param $data
     * @param string $method
     * @return false|string
     */
    private function send($url, $data, $method = 'GET')
    {
        switch ($method) {
            case 'GET':
                $context = stream_context_create(array(
                    'http' => array(
                        'method' => 'GET',
                        'content' => http_build_query($data),
                        'timeout' => 20
                    )
                ));
                break;
            case 'POST':
                $context = stream_context_create(array(
                    'http' => array(
                        'method' => 'POST',
                        'content' => http_build_query($data),
                        'timeout' => 20
                    )
                ));
                break;
            default :
                $context = stream_context_create();
        }

        $response = file_get_contents($url, false, $context);
        return $response;
    }
}