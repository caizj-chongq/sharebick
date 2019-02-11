<?php

namespace app\index\controller;

use app\Utils;
use think\Request;
use app\index\model\User;

class Login extends Base
{
    /**
     * 登录页面
     * @return mixed
     */
    public function index()
    {
        return $this->fetch();
    }

    /**
     * 登录ajax请求处理方法
     * @param Request $request
     * @return \think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function login(Request $request)
    {
        if (!$request->isPost()) {
            return Utils::throw405();
        }

        $data = $request->post();
        if (count($data)) {
            $user = User::where('username', '=', $data['name'] ?? 1)->where('deleted', '=', 0)->find();
            if ($user) {
                if ($user->secret == Utils::encodeSha1($data['secret']) ?? '') {
                    session(SESSION_TOKEN_KEY, $user->hidden(['secret', 'real_name', 'updated', 'deleted'])->toJson());
                    return Utils::ajaxReturn('', 0, "Login Success！");

                }
            }
        }

        return Utils::ajaxReturn('', 2, 'Error: Login Failed！');
    }

    /**
     * 登出ajax处理方法
     * @param Request $request
     * @return \think\response\Json
     */
    public function logout(Request $request)
    {
        if (!$request->isPost()) {
            return Utils::throw405();
        }

        session(SESSION_TOKEN_KEY, null);
        return Utils::ajaxReturn('', 0, "Logout Success！");

    }

    /**
     * 空方法
     */
    public function _empty()    //空操作
    {
        return $this->redirect('index/Error/index');
    }
}