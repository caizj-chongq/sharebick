<?php
namespace app\common;

use think\Env;

class TencentMap
{
    protected $key;

    public function __construct()
    {
        $this->key = Env::get('TencentMap.key', '');
    }

    /**
     * doc url: https://lbs.qq.com/webservice_v1/guide-convert.html
     * @param $locationStr
     * @param int $type
     * @return bool|string
     */
    public function translateCoord($locationStr, $type = 1)
    {
        $requestUrl = "https://apis.map.qq.com/ws/coord/v1/translate";
        $requestData = [
            'locations' => $locationStr,
            'type' => $type,
            'key' => $this->key,
            'output' => 'json'
        ];
        return $this->send($requestUrl, $requestData);
    }

    /**
     * doc url: https://lbs.qq.com/webservice_v1/guide-distancematrix.html
     * @param $mode
     * @param $from
     * @param $to
     * @return bool|string
     */
    public function parametersDistance($mode, $from, $to)
    {
        $requestUrl = "http://apis.map.qq.com/ws/distance/v1/matrix?parameters";
        $requestData = [
            'mode' => $mode,
            'from' => $from,
            'to' => $to,
            'key' => $this->key,
            'output' => 'json'
        ];
        return $this->send($requestUrl, $requestData);
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
                $response = file_get_contents($url . '?' . http_build_query($data));
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
                $response = file_get_contents($url, false, $context);
                break;
            default :
                $response = [];
        }
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
        $logFilePath = LOG_PATH . 'tencent/' . date('Ymd') . '.log';

        if (!is_dir(dirname($logFilePath))) {
            Utils::mkdirs($logFilePath);
        }

        file_put_contents($logFilePath, sprintf("[%s]\tmethod: %s\nrequestUrl:%s\nrequestData:%s\nresponse:%s\n", date('Y-m-d H:i:s'), $method, $requestUrl, json_encode($requestData), $response), FILE_APPEND);
    }
}