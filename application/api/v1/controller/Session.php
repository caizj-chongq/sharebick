<?php

namespace app\api\controller;

use app\common\Utils;
use app\index\model\Client as ClientModel;
use think\Controller;
use think\Request;

class Session extends Controller
{
    /**
     * 登录
     * @param Request $request
     * @return \think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function login(Request $request)
    {
        if ($request->isPost()) {
            $userName = $request->param('username', '');
            $secret = $request->param('password', '');
            $user = ClientModel::where('username', '=', $userName)->find();
            if ($user) {
                if ($user->secret === Utils::encodeSha1($secret)) {
                    //login success
                    $user->token = uniqid();
                    $user->save();
                    return Utils::ajaxReturn($user);
                }
            }

            return Utils::throw400('账号或密码错误！');
        }

        return Utils::throw405();
    }
}