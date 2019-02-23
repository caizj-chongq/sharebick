<?php

namespace app\common\wx;

use app\common\Utils;
use think\Env;

class Wx
{
    protected $url = "https://api.weixin.qq.com/sns/jscode2session";

    protected $appId;

    protected $secret;

    /**
     * Wx constructor.
     */
    public function __construct()
    {
        $this->appId = Env::get('wx.appId');
        $this->secret = Env::get('wx.secret');
    }

    /**
     * @param $jsCode
     * @return false|string
     */
    public function code2Session($jsCode)
    {
        $requestData = [
            'grant_type' => 'authorization_code',
            'appid' => $this->appId,
            'secret' => $this->secret,
            'js_code' => $jsCode
        ];

        return $this->send($this->url, $requestData);
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
                $context = stream_context_create();
                $response = json_encode([]);
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
        $logFilePath = LOG_PATH . 'weixin/' . date('Ymd') . '.log';
        if (!is_dir(dirname($logFilePath))) {
            Utils::mkdirs($logFilePath);
        }

        file_put_contents($logFilePath, sprintf("[%s]\tmethod: %s\nrequestUrl:%s\nrequestData:%s\nresponse:%s\n", date('Y-m-d H:i:s'), $method, $requestUrl, json_encode($requestData), $response), FILE_APPEND);
    }
}