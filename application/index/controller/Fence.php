<?php
namespace app\index\controller;

use app\common\Yingyan;
use think\Request;

class Fence extends Base
{
    /**
     * @var Yingyan
     */
    protected $yingyan;

    /**
     * Fence constructor.
     * @param Request|null $request
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function __construct(Request $request = null)
    {
        parent::__construct($request);
//        $this->yingyan = new Yingyan();
    }

    /**
     * @return mixed
     */
    public function index()
    {
        $fences = [];
        $this->assign('fences');
        return $this->fetch();
    }

    /**
     * @param Request $request
     * @param $id
     * @return mixed
     */
    public function show(Request $request, $id)
    {
        return $this->fetch();
    }

    /**
     * @param Request $request
     * @return mixed
     */
    public function store(Request $request)
    {
        if ($request->isPost()) {
            $names = json_decode($request->param('names'), true);
            $points = json_decode($request->param('data'), true);
            $fences = [];
            foreach ($points as $key => $point) {
                $fences[$key]['name'] = $names[$key];
                $fences[$key]['point'] = $point;
            }

        }
//        $this->assign(['ak' => $this->yingyan->getBrowerAk()]);
        return $this->fetch();
    }


}