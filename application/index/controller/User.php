<?php
namespace app\index\controller;

use app\index\model\UserGroup;
use app\common\Utils;
use think\Request;
use app\index\model\User as UserModel;

class User extends Base
{
    /**
     * @return mixed
     * @throws \think\exception\DbException
     */
    public function index(Request $request)
    {
        $users = UserModel::where('deleted', '=', 0);

        if (strlen($request->param('keywords'))) {
            $keywords = $request->param('keywords');
            $users->where('username', 'like', "%$keywords%")
                ->where('nick', 'like', "%$keywords%")
                ->where('real_name', 'like', "%$keywords%");
            $this->assign(compact('keywords'));
        }

        $users = $users->paginate(10);

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
            $userExists = UserModel::where('username', '=', $request->param('username'))->find();
            if ($userExists) {
                return Utils::throw400('该用户名已经被别的用户使用了！');
            } else {
                try {
                    $user = new UserModel();
                    $user->data(array_merge($request->param(), [
                        'secret' => Utils::encodeSha1($request->param('secret'))
                    ]));
                    $user->save();
                } catch (\Exception $exception) {
                    return Utils::throw400($exception->getMessage());
                }

                return Utils::ajaxReturn();
            }
        }
        $userGroups = UserGroup::where('deleted', '=', 0)->select();
        $this->assign(compact('userGroups'));
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
        $userInfo = UserModel::where('deleted', '=', 0)
            ->where('id', '=', $id)
            ->find();
        if ($userInfo) {
            $userGroups = UserGroup::where('deleted', '=', 0)->select();
            $this->assign(compact('userInfo', 'userGroups'));
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
        $userInfo = UserModel::where('deleted', '=', 0)
            ->where('id', '=', $id)
            ->find();
        if ($request->isAjax() && $request->isPatch()) {
            //保存
            if ($userInfo) {
                try {
                    $userInfo->data([
                        'group_id' => $request->param('group_id'),
                        'username' => $userInfo->username,
                        'secret' => Utils::encodeSha1($request->param('secret')),
                        'nick' => $request->param('nick'),
                        'real_name' => $request->param('real_name')
                    ]);
                    $userInfo->save();
                } catch (\Exception $exception) {
                    return Utils::throw400($exception->getMessage());
                }
                return Utils::ajaxReturn();
            } else {
                return Utils::throw400('用户不存在！');
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
        if ($request->isAjax() && $request->isDelete()) {
            Utils::throw405();
        }
        //删除用户
        $user = UserModel::where('deleted', '=', 0)
            ->where('id', '=', $id)
            ->find();
        if ($user) {
            $user->delete();
        }

        return Utils::ajaxReturn();
    }

}