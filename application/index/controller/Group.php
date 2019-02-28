<?php

namespace app\index\controller;

use app\index\model\UserGroup;
use app\common\Utils;
use think\Db;
use think\Request;

class Group extends Base
{
    /**
     * @param Request $request
     * @return mixed
     * @throws \think\exception\DbException
     */
    public function index(Request $request)
    {
        $groups = UserGroup::where('deleted', '=', 0);

        if (strlen($request->param('keywords'))) {
            $keywords = $request->param('keywords');
            $groups->where('group_name', 'like', "%$keywords%")
                ->where('desc', 'like', "%$keywords%");
            $this->assign(compact('keywords'));
        }

        $groups = $groups->paginate(10);

        $page = $groups->render();
        $this->assign([
            'groups' => $groups,
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
    public function store(Request $request)
    {
        if ($request->isAjax() && $request->isPost()) {
            $data = $request->param();

            try {
                Db::startTrans();
                $userGroup = new UserGroup();
                $userGroup->data([
                    'group_name' => $data['group_name'],
                    'desc' => $data['desc']
                ]);
                $userGroup->save();

                foreach (explode(',', $data['navigates']) as $navigate) {
                    DB::table('admin_group_navigate')->insert([
                        'group_id' => $userGroup->id,
                        'navigate_id' => $navigate
                    ]);
                }

                Db::commit();
                return Utils::ajaxReturn();
            } catch (\Exception $exception) {
                Db::rollback();
                return Utils::throw400($exception->getMessage());
            }
        }

        $navigates =  Utils::tree(Db::table('admin_navigates')
            ->select());

        $this->assign(compact('navigates'));
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
        $groupInfo = UserGroup::where('deleted', '=', 0)
            ->where('id', '=', $id)
            ->find();

        if ($groupInfo) {
            $navigates =  Utils::tree(Db::table('admin_navigates')
                ->select());

            $this->assign(compact('groupInfo', 'navigates'));
            return $this->fetch();
        }

        $this->error('当前用户组不存在！');
    }

    /**
     * @param Request $request
     * @param $id
     * @return mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function update(Request $request, $id)
    {
        $groupInfo = UserGroup::where('deleted', '=', 0)
            ->where('id', '=', $id)
            ->find();

        if ($request->isAjax() && $request->isPatch()) {
            //更新
            $data = $request->param();
            if ($groupInfo) {
                try {
                    Db::startTrans();
                    $groupInfo->data([
                        'group_name' => $data['group_name'],
                        'desc' => $data['desc']
                    ]);
                    $groupInfo->save();

                    $groupNavigates = DB::table('admin_group_navigate')
                        ->where('group_id', '=', $id)
                        ->select();
                    $ids = [];
                    foreach ($groupNavigates as $groupNavigate) {
                        $ids[] =  $groupNavigate['navigate_id'];
                    }

                    $insertIds = [];
                    foreach (explode(',', $data['navigates']) as $navigate) {
                        if (!in_array($navigate, $ids)) {
                            $insert = DB::table('admin_group_navigate')
                                ->insert([
                                    'group_id' => $id,
                                    'navigate_id' => $navigate
                                ]);
                            $insertIds[] = DB::table('admin_group_navigate')->where('id', '=', $insert)->find()['navigate_id'];
                        } else {
                            $insertIds[] = $navigate;
                        }
                    }

                    DB::table('admin_group_navigate')
                        ->where('group_id', '=', $id)
                        ->where('navigate_id', 'not in', $insertIds)
                        ->delete();

                    Db::commit();
                    return Utils::ajaxReturn();
                } catch (\Exception $exception) {
                    Db::rollback();
                    return Utils::throw400($exception->getMessage());
                }
            } else {
                return Utils::throw400('用户组不存在！');
            }
        }

        if ($groupInfo) {
            $navigates =  Utils::tree(Db::table('admin_navigates')
                ->select());
            $userNavigates = Db::table('admin_group_navigate')
                ->where('group_id', '=', $id)
                ->select();
            foreach ($navigates as $key1 => $value1) {
                foreach ($value1['children'] as $key2 => $value2) {
                    $navigates[$key1]['children'][$key2]['has'] = false;
                    foreach ($userNavigates as $key3 => $value3) {
                        if ($value2['id'] == $value3['navigate_id']) {
                            $navigates[$key1]['children'][$key2]['has'] = true;
                        }
                    }
                }
            }

            $this->assign(compact('groupInfo', 'navigates', 'id'));
            return $this->fetch();
        }

        $this->error('当前用户组不存在！');
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
            $group = UserGroup::where('deleted', '=', 0)
                ->where('id', '=', $id)
                ->find();

            if ($group) {
                $group->delete();
                return Utils::ajaxReturn();
            } else {
                return Utils::ajaxReturn(null, 400, '用户组不存在！');
            }
        } else {
            return Utils::throw405();
        }
    }

    /**
     * 创建权限
     */
    public function seeder()
    {
        $navigates = [
            [
                'name' => '用户管理',
                'route' => 'index/user',
                'desc' => '后台用户管理',
                'children' => [
                    [
                        'name' => '列表',
                        'route' => 'index',
                        'desc' => ''
                    ],
                    [
                        'name' => '详情',
                        'route' => 'show',
                        'desc' => ''
                    ],
                    [
                        'name' => '新增',
                        'route' => 'store',
                        'desc' => ''
                    ],
                    [
                        'name' => '更新',
                        'route' => 'update',
                        'desc' => ''
                    ],
                    [
                        'name' => '删除',
                        'route' => 'destroy',
                        'desc' => ''
                    ]
                ]
            ],
            [
                'name' => '用户组管理',
                'route' => 'index/group',
                'desc' => '后台用户组管理',
                'children' => [
                    [
                        'name' => '列表',
                        'route' => 'index',
                        'desc' => ''
                    ],
                    [
                        'name' => '详情',
                        'route' => 'show',
                        'desc' => ''
                    ],
                    [
                        'name' => '新增',
                        'route' => 'store',
                        'desc' => ''
                    ],
                    [
                        'name' => '更新',
                        'route' => 'update',
                        'desc' => ''
                    ],
                    [
                        'name' => '删除',
                        'route' => 'destroy',
                        'desc' => ''
                    ]
                ]
            ],
            [
                'name' => '会员管理',
                'route' => 'index/client',
                'desc' => '小程序端会员管理',
                'children' => [
                    [
                        'name' => '列表',
                        'route' => 'index',
                        'desc' => ''
                    ],
                    [
                        'name' => '详情',
                        'route' => 'show',
                        'desc' => ''
                    ],
                    [
                        'name' => '更新',
                        'route' => 'update',
                        'desc' => ''
                    ],
                    [
                        'name' => '删除',
                        'route' => 'destroy',
                        'desc' => ''
                    ]
                ]
            ],
            [
                'name' => '车辆管理',
                'route' => 'index/bicycle',
                'desc' => '后台车辆管理',
                'children' => [
                    [
                        'name' => '列表',
                        'route' => 'index',
                        'desc' => ''
                    ],
                    [
                        'name' => '新增',
                        'route' => 'store',
                        'desc' => ''
                    ],
                    [
                        'name' => '详情',
                        'route' => 'show',
                        'desc' => ''
                    ],
                    [
                        'name' => '更新',
                        'route' => 'update',
                        'desc' => ''
                    ],
                    [
                        'name' => '删除',
                        'route' => 'destroy',
                        'desc' => ''
                    ]
                ]
            ],
            [
                'name' => '订单管理',
                'route' => 'index/order',
                'desc' => '订单管理',
                'children' => [
                    [
                        'name' => '列表',
                        'route' => 'index',
                        'desc' => ''
                    ],
                    [
                        'name' => '详情',
                        'route' => 'show',
                        'desc' => ''
                    ]
                ]
            ],
            [
            'name' => '车辆反馈管理',
            'route' => 'index/bicycle_report',
            'desc' => '车辆反馈管理',
            'children' => [
                [
                    'name' => '列表',
                    'route' => 'index',
                    'desc' => ''
                ],
                [
                    'name' => '详情',
                    'route' => 'show',
                    'desc' => ''
                ],
                [
                    'name' => '更新',
                    'route' => 'update',
                    'desc' => ''
                ],
                [
                    'name' => '删除',
                    'route' => 'destroy',
                    'desc' => ''
                ]
            ]
        ],
            [
                'name' => '电子围栏管理',
                'route' => 'index/bicycle',
                'desc' => '电子围栏管理',
                'children' => [
                    [
                        'name' => '列表',
                        'route' => 'fence',
                        'desc' => ''
                    ],
                    [
                        'name' => '新增',
                        'route' => 'store',
                        'desc' => ''
                    ],
                    [
                        'name' => '详情',
                        'route' => 'show',
                        'desc' => ''
                    ],
                    [
                        'name' => '删除',
                        'route' => 'destroy',
                        'desc' => ''
                    ]
                ]
            ],
            [
                'name' => '电子围栏报警管理',
                'route' => 'index/fence_alarm',
                'desc' => '电子围栏报警管理',
                'children' => [
                    [
                        'name' => '列表',
                        'route' => 'index',
                        'desc' => ''
                    ]
                ]
            ],
        ];

        //保存数据
        foreach ($navigates as $navigate) {
            $id = DB::table('admin_navigates')->insertGetId([
                'name' => $navigate['name'],
                'desc' => $navigate['desc'],
                'route' => $navigate['route']
            ]);
            foreach ($navigate['children'] as $child) {
                DB::table('admin_navigates')->insert([
                    'name' => $child['name'],
                    'desc' => $child['desc'],
                    'route' => $navigate['route'] . '/' . $child['route'],
                    'parent_id' => $id
                ]);
            }
        }
    }

}