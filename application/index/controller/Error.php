<?php
namespace app\index\controller;
use think\Controller;

class Error extends Controller
{
    public function index() //空控制器
    {
        return $this->fetch('error/page_404');
    }

    public function _empty()    //空操作
    {
        return $this->redirect('index/Error/index');
    }

}
