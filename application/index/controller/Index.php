<?php
namespace app\index\controller;

use think\Request;
use app\index\model\User as UserModel;

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
     */
    public function index()
    {
        $userCount = UserModel::where('deleted', '=', 0)->count();   //总用户

        $monthActiveUser = UserModel::where('deleted', '=', 0)
            ->whereTime('updated', 'month')
            ->count();   //当前月活跃用户

        $weekActiveUser = UserModel::where('deleted', '=', 0)
            ->whereTime('updated', 'week')
            ->count();   //当前周活跃用户

        $dayActiveUser = UserModel::where('deleted', '=', 0)
            ->whereTime('updated', 'today')
            ->count();   //当前周活跃用户

        $this->assign(compact('userCount', 'monthActiveUser', 'weekActiveUser', 'dayActiveUser'));
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
