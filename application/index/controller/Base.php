<?php

namespace app\index\controller;

use app\common\CodeMap;
use app\common\Utils;
use think\Controller;
use think\exception\HttpResponseException;
use think\Request;
use think\Response;
use think\Validate;

class Base extends Controller
{
    protected $codeMap;

    /**
     * Base constructor.
     * @param Request|null $request
     */
    public function __construct(Request $request = null)
    {
        Validate::extend('mobile', function ($value) {
            $mobileReg = '/^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\d{8}$/';
            return (boolean)preg_match($mobileReg, $value);
        });


        $this->validateAjaxToken($request);
        $this->checkLogin($request);       //检测权限
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
            if (!$request->session(SESSION_TOKEN_KEY)) {
                $this->redirect('index/login/index');
            }
        }
    }
}