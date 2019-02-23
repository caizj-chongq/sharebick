<?php
namespace app\api_v1\controller;

use app\common\Utils;
use think\Request;

class Client extends Base
{
    /**
     * 更新
     * @param Request $request
     * @return false|string|\think\response\Json
     */
    public function update(Request $request)
    {
        if ($request->isPost()) {
            $client = $this->user;
            $client->data($request->param());
            $client->save();
            return Utils::ajaxReturn($client);
        }
        return Utils::throw405();
    }
}