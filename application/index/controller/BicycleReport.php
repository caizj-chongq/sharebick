<?php

namespace app\index\controller;

use app\common\Utils;
use app\index\model\Bicycle\Reports as ReportsModel;
use think\Request;
use app\index\model\Client as ClientModel;

class BicycleReport extends Base
{
    /**
     * @param Request $request
     * @return mixed
     */
    public function index(Request $request)
    {
        $reports = ReportsModel::join("bicycles", "bicycles.id = bicycle_reports.bicycle_id")
            ->field("bicycles.bicycle_number,bicycle_reports.*");

        if (strlen($request->param('keywords'))) {
            $keywords = $request->param('keywords');
            $reports->where('remark', 'like', "%$keywords%");
            $this->assign(compact('keywords'));
        }

        $reports = $reports->paginate(10);

        $page = $reports->render();
        $this->assign([
            'reports' => $reports,
            'page' => $page
        ]);

        return $this->fetch();
    }

    /**
     * @param Request $request
     * @param $id
     * @return mixed
     */
    public function show(Request $request, $id)
    {
        $reportInfo = ReportsModel::join("bicycles", "bicycles.id = bicycle_reports.bicycle_id")
            ->where('deleted', '=', 0)
            ->where('id', '=', $id)
            ->field("bicycles.bicycle_number,bicycle_reports.*")
            ->find();
        if ($reportInfo) {
            $this->assign(compact('reportInfo'));
            return $this->fetch();
        }
        $this->error('反馈不存在！');
    }

    /**
     * @param Request $request
     * @param $id
     * @return mixed|\think\response\Json
     */
    public function update(Request $request, $id)
    {
        $ids = explode(',', $id);
        $reportsInfo = ReportsModel::where('deleted', '=', 0)
            ->whereIn('id', $ids)
            ->where('is_ok', '=', 0)
            ->select();
        //保存
        if ($reportsInfo) {
            try {
                ReportsModel::where('deleted', '=', 0)
                    ->whereIn('id', $ids)
                    ->where('is_ok', '=', 0)
                    ->update([
                        'is_ok' => 1,
                        'operator' => $request->session(SESSION_TOKEN_KEY)
                    ]);
            } catch (\Exception $exception) {
                return Utils::throw400($exception->getMessage());
            }

            return Utils::ajaxReturn();
        } else {
            return Utils::throw400('报修信息不存在！');
        }

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