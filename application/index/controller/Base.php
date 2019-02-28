<?php

namespace app\index\controller;

use app\common\CodeMap;
use app\common\Utils;
use think\Controller;
use think\Db;
use think\exception\HttpResponseException;
use think\Request;
use think\Response;
use think\Validate;

class Base extends Controller
{
    protected $codeMap;

    protected $user;

    /**
     * Base constructor.
     * @param Request|null $request
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function __construct(Request $request = null)
    {
        Validate::extend('mobile', function ($value) {      //定义一个电话号码的验证条件
            $mobileReg = '/^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\d{8}$/';
            return (boolean)preg_match($mobileReg, $value);
        });


        $this->validateAjaxToken($request);
        $this->checkLogin($request);       //检测是否登录，如果没有登录就跳转到登录页面
        $this->checkPermission($request);

        $this->codeMap = new CodeMap();

        parent::__construct($request);
    }

    /**
     * 验证ajax的token，防止csrf攻击
     * @param Request $request
     */
    private function validateAjaxToken(Request $request)
    {
        if ($request->isAjax() && !$request->isGet()) {
            $err = '';
            if (!strlen($request->param('token'))) {
                $err = 'token不能为空！';
            }

            if (!strlen($err) && session('token') !== $request->param('token')) {
                $err = 'token错误！';
            }
            if ($err) {
                $data = Utils::throw400($err);
                $type = $this->getResponseType();
                $response = Response::create($data, $type);
                throw new HttpResponseException($response);
            }
        }
    }

    /**
     * 检测是否登录，如果没有登录就跳转到登录页面
     * @param Request $request
     * @return bool
     */
    private function checkLogin(Request $request)
    {
        $exceptActions = [
            'login' => [
                'index',
                'login'
            ]
        ];
        $requestController = strtolower($request->controller());
        $requestAction = strtolower($request->action());

        if (!isset($exceptActions[$requestController]) || (isset($exceptActions[$requestController]) && !in_array($requestAction, $exceptActions[$requestController]))) {
            //用户登录后把用户登录信息放入session中，并且以_token_作为键
            $this->user = json_decode($request->session(SESSION_TOKEN_KEY), true);
            if (!count($this->user)) {
                $this->redirect('index/login/index');
            }
        }
    }

    /**
     * 检测权限
     * @param Request $request
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    private function checkPermission(Request $request)
    {
        $except = [ //不需要验证权限的路由
            'index/login/index',
            'index/login/login',
            'index/error/index',
            'index/error/empty',
        ];
        $requestRoute = strtolower($request->module() . '/' . $request->controller() . '/' . $request->action());

        if (in_array($requestRoute, $except)) {
            return ;
        }

        if ($this->user['id'] == 1) { //系统预制超级管理员
            return ;
        }

        $hasPermission = Db::table('admin_group_navigate')
            ->join('admin_navigates', 'admin_navigates.id = admin_group_navigate.navigate_id')
            ->where('admin_group_navigate.group_id', '=', $this->user['group_id'])
            ->where('admin_navigates.route', '=', $requestRoute)
            ->find();
        if (!$hasPermission) {
            $this->redirect('index/Error/index');
        }

    }

    public function _empty()    //空操作
    {
        return $this->redirect('index/Error/index');
    }
}