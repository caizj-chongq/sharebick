<?php
namespace app;

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
    public static function base($data = [], $status = 0, $msg = '') {
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

}