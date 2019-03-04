<?php

namespace app\api_v1\controller;

use app\common\Utils;
use app\common\wx\Wx;
use app\index\model\Client as ClientModel;
use think\Controller;
use think\Request;

/**
 * @apiDefine Error
 * @apiErrorExample Error:
 *     {
 *         "status": error code, //405 request method error; 0 success; other number => other error
 *         "message": "error msg",
 *         "data": null
 *     }
 */

/**
 * @api {post} /session 完成微信小程序登录流程
 * @apiVersion 0.0.1
 * @apiName session.wx_seesion
 * @apiGroup session
 *
 * @apiParam    {String}    code    微信小程序临时登录凭证code
 *
 * @apiSuccess        {Number}    status    状态码
 * @apiSuccess        {String}    message    状态提示
 * @apiSuccess        {Object}    data    数据（直接返回微信api code2session接口响应值）
 *
 * @apiSuccessExample Success:
 *     {
 *          "data": {
 *                openid:"openid"
 *                session_key:"session_key"
 *          },
 *          "message": "",
 *          "status": 0
 *      }
 *
 * @apiUse Error
 *
 */

/**
 * @api {post} /client 完成系统登录流程
 * @apiVersion 0.0.1
 * @apiName session.sys_session
 * @apiGroup session
 *
 * @apiParam    {String}    openid    微信小程序用户唯一标志
 * @apiParam    {String}    nick    用户昵称
 *
 * @apiSuccess        {Number}    status    状态码
 * @apiSuccess        {String}    message    状态提示
 * @apiSuccess        {Object}    data    数据（返回用户信息）
 *
 * @apiSuccessExample Success:
 *     {
 *          "data": {
 *              "id": 1,
 *              "nick": "nick", //昵称
 *              "money": "money",   //余额
 *              "created": "2019-02-23 19:12:41",
 *              "updated": "2019-02-23 19:12:41",
 *              "deleted": 0,
 *              "mobile": null, //电话号
 *              "openid": "openid",
 *              "token": "token" //后续请求凭证
 *          },
 *          "status": 0,
 *          "msg": ""
 *     }
 *
 *
 * @apiUse Error
 *
 */
class Session extends Controller
{
    protected $wx;

    public function __construct(Request $request = null)
    {
        parent::__construct($request);
        $this->wx = new Wx();
    }

    /**
     * 登录
     * @param Request $request
     * @return false|string|\think\response\Json
     */
    public function login(Request $request)
    {
        if ($request->isPost()) {
           return Utils::ajaxReturn(json_decode($this->wx->code2Session($request->param('code')), true));
        }
        return Utils::throw405();
    }

    /**
     * 保存用户信息
     * @param Request $request
     * @return \think\response\Json
     * @throws \think\Exception
     */
    public function storeUser(Request $request)
    {
        if ($request->isPost()) {
            $client = ClientModel::where('openid','=', $request->param('openId'))->find();
            if (!$client) {
                $client = new ClientModel();
                $client->data([
                    'nick' => $request->param('nick'),
                    'openid' => $request->param('openId'),
                    'token' => Utils::str_random()
                ]);
                $client->save();
            }
            ClientModel\Operation::create([
                'client_id' => $client->id,
                'time' => time(),
                'type' => 1,
                'ip' => Utils::getRealIp(),
            ]);
            return Utils::ajaxReturn($client->toArray());
        }
        return Utils::throw405();
    }

}