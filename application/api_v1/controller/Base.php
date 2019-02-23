<?php
namespace app\api_v1\controller;

use app\index\model\Client;
use think\Controller;
use think\exception\HttpResponseException;
use think\Request;
use think\Response;

class Base extends Controller
{
    protected $user;

    /**
     * Base constructor.
     * @param Request|null $request
     * @throws \HttpException
     */
    public function __construct(Request $request = null)
    {
        parent::__construct($request);
        $this->user = $this->checkLogin($request->param('token', ''));
    }


    private function checkLogin($token = null)
    {
        $user = Client::where('token', '=', $token)->find();
        if (!($token && $user)) {
            $data = json_encode([
                'data' => null,
                'code' => 401,
                'msg' => 'Unauthorized.'
            ]);
            $type = $this->getResponseType();
            $response = Response::create($data, $type);
            throw new HttpResponseException($response);
        }

        return $user;
    }
}