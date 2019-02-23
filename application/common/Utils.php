<?php

namespace app\common;

class Utils
{
    //  返回响应相关函数

    /**
     * @param array $data
     * @param int $status
     * @param string $msg
     * @return \think\response\Json
     */
    public static function ajaxReturn($data = [], $status = 0, $msg = '')
    {
        return json(self::base($data, $status, $msg));
    }

    /**
     * @param array $data
     * @param int $status
     * @param string $msg
     * @return array
     */
    public static function base($data = [], $status = 0, $msg = '')
    {
        if ($data && !is_array($data)) {
            $data = [$data];
        }
        return compact('data', 'status', 'msg');
    }

    /**
     * @return \think\response\Json
     */
    public static function throw405()
    {
        return Utils::ajaxReturn(null, 405, 'Method Error.');
    }

    /**
     * @return \think\response\Json
     */
    public static function throw401()
    {
        return Utils::ajaxReturn(null, 401, 'Unauthorized.');
    }

    /**
     * @param string $msg
     * @return \think\response\Json
     */
    public static function throw400($msg = '')
    {
        return Utils::ajaxReturn(null, 400, $msg);
    }

    //公用函数

    /**
     * @param $str
     * @return string
     */
    public static function encodeSha1($str)
    {
        return sha1($str);
    }

    /**
     * @param $data
     * @param int $parent_id
     * @return array
     */
    public static function tree($data, $parent_id = 0)
    {
        $tree = [];
        foreach ($data as $item) {
            if ($item->parent_id ?? $item['parent_id'] == $parent_id) {
                $item['children'] = self::tree($data, $item->id ?? $item['id']);
                $tree[] = $item;
            }
        }
        return $tree;
    }

    /**
     * 获取ip
     * @return array|false|mixed|string
     */
    public static function getRealIp()
    {
        static $realIp = '';

        if (!$realIp) {
            $cip = getenv('HTTP_CLIENT_IP');
            $xip = getenv('HTTP_X_FORWARDED_FOR');
            $rip = getenv('REMOTE_ADDR');
            $srip = $_SERVER['REMOTE_ADDR'];
            if ($cip && strcasecmp($cip, 'unknown')) {
                $realIp = $cip;
            } elseif ($xip && strcasecmp($xip, 'unknown')) {
                $realIp = $xip;
            } elseif ($rip && strcasecmp($rip, 'unknown')) {
                $realIp = $rip;
            } elseif ($srip && strcasecmp($srip, 'unknown')) {
                $realIp = $srip;
            }
            $match = array();
            preg_match('/[\d\.]{7,15}/', $realIp, $match);
            $realIp = $match[0] ? $match[0] : '0.0.0.0';
        }
        return $realIp;
    }

    /**
     * 创建多层目录
     * @param $path
     * @return bool
     */
    public static function mkdirs($path)
    {
        return is_dir($path) or (self::mkdirs(dirname($path))) and self::mkdirs($path);
    }

    /**
     * 产生随机字符串
     * @param int $length
     * @return string
     */
    public static function str_random($length = 128)
    {
        $key = "";
        $pattern = '1234567890ABCDEFGHIJKLOMNOPQRSTUVWXYZ';
        for ($i = 0; $i < $length; $i++) {
            $key .= $pattern{mt_rand(0, 35)};    //生成php随机数
        }
        return $key;
    }


}