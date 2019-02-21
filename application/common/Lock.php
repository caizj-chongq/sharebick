<?php
namespace app\common;

class Lock
{
    /**
     * @var
     */
    protected $imei;

    protected $token = "48A91502513526909A5D91A10BB1E39D";

    protected $requestUrl = "http://lock.eachbike.com:8088/BikeServer/bike";

    /**
     * Lock constructor.
     * @param $imei
     */
    public function __construct($imei)
    {
        $this->imei = $imei;
    }

    /**
     * 开锁
     * @return bool|string
     */
    public function unLock()
    {
        $requestData = [
            'type' => 1001,
            'imei' => $this->imei,
            'token' => $this->token,
            'timestamp' => time()
        ];
        return $this->send($this->requestUrl, $requestData);
    }

    /**
     * 定位
     * @return bool|string
     */
    public function getLocation()
    {
        $requestData = [
            'type' => 1002,
            'imei' => $this->imei,
            'token' => $this->token,
            'timestamp' => time()
        ];
        return $this->send($this->requestUrl, $requestData);
    }

    /**
     * 电量获取
     * @return bool|string
     */
    public function getElectricQuantity()
    {
        $requestData = [
            'type' => 1003,
            'imei' => $this->imei,
            'token' => $this->token,
            'timestamp' => time()
        ];
        return $this->send($this->requestUrl, $requestData);
    }

    /**
     * 找车
     * @return bool|string
     */
    public function findCar()
    {
        $requestData = [
            'type' => 1005,
            'imei' => $this->imei,
            'token' => $this->token,
            'timestamp' => time()
        ];
        return $this->send($this->requestUrl, $requestData);
    }

    /**
     * 关机
     * @return bool|string
     */
    public function off()
    {
        $requestData = [
            'type' => 1006,
            'imei' => $this->imei,
            'token' => $this->token,
            'timestamp' => time()
        ];
        return $this->send($this->requestUrl, $requestData);
    }

    /**
     * @param $url
     * @param $data
     * @param string $method
     * @return bool|string
     */
    private function send($url, $data, $method = 'GET')
    {
        switch ($method) {
            case 'GET':
                $context = stream_context_create(array(
                    'http' => array(
                        'method' => 'GET',
                        'content' => http_build_query($data),
                        'timeout' => 500
                    )
                ));
                break;
            case 'POST':
                $context = stream_context_create(array(
                    'http' => array(
                        'method' => 'POST',
                        'header' => 'Content-type: application/x-www-form-urlencoded',
                        'content' => http_build_query($data),
                        'timeout' => 500
                    )
                ));
                break;
            default :
                $context = stream_context_create();
        }
        $response = file_get_contents($url, false, $context);
        $this->saveLog($url, $data, $method, $response);
        return $response;
    }

    /**
     * @param $requestUrl
     * @param $requestData
     * @param $method
     * @param $response
     */
    private function saveLog($requestUrl, $requestData, $method, $response)
    {
        $logFilePath = LOG_PATH . 'lock/' . date('Ymd') . '.log';

        if (!is_dir(dirname($logFilePath))) {
            Utils::mkdirs($logFilePath);
        }

        file_put_contents($logFilePath, sprintf("[%s]\tmethod: %s\nrequestUrl:%s\nrequestData:%s\nresponse:%s\n", date('Y-m-d H:i:s'), $method, $requestUrl, json_encode($requestData), $response), FILE_APPEND);
    }
}