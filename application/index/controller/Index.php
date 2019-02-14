<?php
namespace app\index\controller;

use think\Request;
use app\index\model\User as UserModel;
use app\index\model\Client\Operation as ClientOperationModel;
use app\index\model\Client as ClientModel;

class Index extends Base
{
    /**
     * Index constructor.
     * @param Request|null $request
     */
    public function __construct(Request $request = null)
    {
        parent::__construct($request);
    }

    /**
     * @return mixed
     * @throws \think\Exception
     */
    public function index()
    {
        $userCount = UserModel::where('deleted', '=', 0)->count();   //总用户

        $monthActiveUser = ClientOperationModel::whereTime('time', 'month')
            ->count();   //当前月活跃用户

        $weekActiveUser = ClientOperationModel::whereTime('time', 'week')
            ->count();   //当前周活跃用户

        $dayActiveUser = ClientOperationModel::whereTime('time', 'today')
            ->count();   //当前周活跃用户

        $monthAddUser = ClientModel::whereTime('created', 'month')
            ->where('deleted', '=', 0)
            ->count();   //当前月新增用户

        $weekAddUser = ClientModel::whereTime('created', 'week')
            ->where('deleted', '=', 0)
            ->count();   //当前周新增用户

        $dayAddUser = ClientModel::whereTime('created', 'today')
            ->where('deleted', '=', 0)
            ->count();   //当前周新增用户

        $this->assign(compact('userCount', 'monthActiveUser', 'weekActiveUser', 'dayActiveUser', 'weekAddUser', 'monthAddUser', 'dayAddUser'));
        return $this->fetch();
    }

    /**
     *
     */
    public function _empty()    //空操作
    {
        return $this->redirect('index/Error/index');
    }
}
