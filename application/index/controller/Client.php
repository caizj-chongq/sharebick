<?php

namespace app\index\controller;

use app\common\Utils;
use think\Request;
use app\index\model\Client as ClientModel;

class Client extends Base
{
    /**
     * @param Request $request
     * @return mixed
     * @throws \think\exception\DbException
     */
    public function index(Request $request)
    {
        $clients = ClientModel::where('deleted', '=', 0);

        if (strlen($request->param('keywords'))) {
            $keywords = $request->param('keywords');
            $clients->where('nick', 'like', "%$keywords%");
            $this->assign(compact('keywords'));
        }

        $clients = $clients->paginate(10);

        $page = $clients->render();
        $this->assign([
            'clients' => $clients,
            'page' => $page
        ]);

        return $this->fetch();
    }

    /**
     * @param Request $request
     * @param $id
     * @return mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function show(Request $request, $id)
    {
        $clientInfo = ClientModel::where('deleted', '=', 0)
            ->where('id', '=', $id)
            ->find();
        if ($clientInfo) {
            $this->assign(compact('clientInfo'));
            return $this->fetch();
        }
        $this->error('用户不存在！');
    }

    /**
     * @param Request $request
     * @param $id
     * @return mixed|\think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function update(Request $request, $id)
    {
        $clientInfo = ClientModel::where('deleted', '=', 0)
            ->where('id', '=', $id)
            ->find();
        if ($request->isAjax() && $request->isPatch()) {
            //保存
            if ($clientInfo) {
                try {
                    $clientInfo->data([
                        'nick' => $clientInfo->nick,
                        'mobile' => $request->param('mobile'),
                        'money' => $request->param('money')
                    ]);
                    $clientInfo->save();
                } catch (\Exception $exception) {
                    return Utils::throw400($exception->getMessage());
                }

                return Utils::ajaxReturn();
            } else {
                return Utils::throw400('用户不存在！');
            }
        }

        if ($clientInfo) {
            $this->assign(compact('clientInfo', 'id'));
            return $this->fetch();
        }

        $this->error('用户不存在！');
    }

    /**
     * @param Request $request
     * @param $id
     * @return \think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function destroy(Request $request, $id)
    {
        if ($request->isAjax() && $request->isPost()) {
            Utils::throw405();
        }
        //删除用户
        $client = ClientModel::where('deleted', '=', 0)
            ->where('id', '=', $id)
            ->find();
        if ($client) {
            $client->delete();
        }

        return Utils::ajaxReturn();
    }

}