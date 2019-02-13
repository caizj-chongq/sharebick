<?php
namespace app\index\controller;

use app\index\model\UserGroup;
use app\Utils;
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
            $clients->where('username', 'like', "%$keywords%")
                ->where('nick', 'like', "%$keywords%");
            $this->assign(compact('keywords'));
        }

        $users = $clients->paginate(10);

        $page = $users->render();
        $this->assign([
            'users' => $users,
            'page' => $page
        ]);

        return $this->fetch();
    }

    /**
     * @param Request $request
     * @return mixed|\think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function store(Request $request)
    {
        if ($request->isAjax() && $request->isPost()) {
            //保存
            $clientExists = ClientModel::where('username', '=', $request->param('username'))->find();
            if ($clientExists) {
                return Utils::ajaxReturn(null, 400, '该用户名已经被别的用户使用了！');
            } else {
                $client = new ClientModel();
                $client->data(array_merge($request->param(), [
                    'secret' => Utils::encodeSha1($request->param('secret'))
                ]));
                $client->save();
                return Utils::ajaxReturn();
            }
        }

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
        $userInfo = ClientModel::where('deleted', '=', 0)
            ->where('id', '=', $id)
            ->find();
        if ($userInfo) {
            $this->assign(compact('userInfo'));
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
        $userInfo = ClientModel::where('deleted', '=', 0)
            ->where('id', '=', $id)
            ->find();
        if ($request->isAjax() && $request->isPatch()) {
            //保存
            if ($userInfo) {
                $userInfo->data([
                    'group_id' => $request->param('group_id'),
                    'username' => $userInfo->username,
                    'secret' => Utils::encodeSha1($request->param('secret')),
                    'nick' => $request->param('nick'),
                    'real_name' => $request->param('real_name')
                ]);
                $userInfo->save();
                return Utils::ajaxReturn();
            } else {
                return Utils::ajaxReturn(null, 400, '用户不存在！');
            }
        }

        if ($userInfo) {
            $userGroups = UserGroup::where('deleted', '=', 0)->select();
            $this->assign(compact('userInfo', 'userGroups', 'id'));
            return $this->fetch('');
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
        $user = ClientModel::where('deleted', '=', 0)
            ->where('id', '=', $id)
            ->find();
        if ($user) {
            $user->delete();
        }

        return Utils::ajaxReturn();
    }

}