<?php

namespace app\api_v1\controller;

use app\common\Utils;
use app\common\wx\Wx;
use app\index\model\Client as ClientModel;
use think\Controller;
use think\Db;
use think\Request;

class Session extends Controller
{
    protected $wx;

    public function __construct(Request $request = null)
    {
        parent::__construct($request);
        $this->wx = new Wx();
    }

    /**
     * 登录
     * @param Request $request
     * @return false|string|\think\response\Json
     */
    public function login(Request $request)
    {
        if ($request->isPost()) {
           return Utils::ajaxReturn(json_decode($this->wx->code2Session($request->param('code')), true));
        }
        return Utils::throw405();
    }

    /**
     * 保存用户信息
     * @param Request $request
     * @return \think\response\Json
     * @throws \think\Exception
     */
    public function storeUser(Request $request)
    {
        if ($request->isPost()) {
            $client = ClientModel::where('openid','=', $request->param('openId'))->find();
            if (!$client) {
                $client = new ClientModel();
                $client->data([
                    'nick' => $request->param('nick'),
                    'openid' => $request->param('openId'),
                    'token' => Utils::str_random()
                ]);
                $client->save();
            }
            return Utils::ajaxReturn($client->toArray());
        }
        return Utils::throw405();
    }

}