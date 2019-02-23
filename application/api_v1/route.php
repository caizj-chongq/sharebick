<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

use think\Route;

Route::any('/api_v1/session','api_v1/Session/login');
Route::post('/api_v1/client','api_v1/Session/storeUser');
Route::patch('/api_v1/client','api_v1/Client/update');

Route::post('/api_v1/bicycle','api_v1/Bicycle/store');
