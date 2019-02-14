<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件

/**
 * @param $array
 * @param $keys
 * @return array
 */
function array_except($array, $keys) {
    if (!is_array($keys)) {
        $keys = array($keys);
    }

    $except = array();
    foreach ($array as $key => $value) {
        if (!in_array($key, $keys)) {
            array_push($except, $key);
        }
    }

    return $except;
}

/**
 * @param $array
 * @param $keys
 * @return array
 */
function array_only($array, $keys) {
    if (!is_array($keys)) {
        $keys = array($keys);
    }

    $only = array();
    foreach ($array as $key => $value) {
        if (in_array($key, $keys)) {
            array_push($only, $key);
        }
    }

    return $only;
}

/**
 * @param $params
 */
function dd($params) {
    $params = array($params);

    echo "<pre>";
    foreach ($params as $param) {
        var_dump($param);
    }
    die();
}