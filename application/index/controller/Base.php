<?php

namespace app\index\controller;

use app\Utils;
use think\Controller;
use think\exception\HttpResponseException;
use think\Request;
use think\Response;
use think\Validate;

class Base extends Controller
{
    /**
     * Base constructor.
     * @param Request|null $request
     */
    public function __construct(Request $request = null)
    {
        $this->validateAjaxToken($request);
        $this->checkLogin($request);

        parent::__construct($request);
    }

    /**
     * 验证ajax的token，防止csrf攻击
     * @param Request $request
     */
    private function validateAjaxToken(Request $request)
    {
        if ($request->isAjax() && $request->isPost()) {
            $rules = [
                'token' => [
                    'require',
                    'token:token'
                ]
            ];
            $messages = [
                'token.require' => 'token不能为空！',
                'token.token' => 'token不正确！'
            ];
            $validate = Validate::make($rules, $messages);

            if (!$validate->check($request->param())) {
                $data = Utils::base(null, 400, $validate->getError());
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