<?php
namespace app\index\model;

use think\exception\ValidateException;
use think\Validate;

class Client extends BaseModel
{
    /**
     * @var string
     */
    protected $table = "clients";

    /**
     * @var string
     */
    protected $updateTime = 'updated';

    /**
     * @var string
     */
    protected $createTime = 'created';

    /**
     * @var string
     */
    protected $deleteTime = 'deleted';

    /**
     * @var bool
     */
    protected $autoWriteTimestamp = true;

    /**
     * @var string
     */
    protected $pk = 'id';

    /**
     * @var array
     */
    protected $field = [
        'username',
        'secret',
        'nick',
        'mobile',
        'money',
        'token',
        'created',
        'updated',
        'deleted'
    ];

    /**
     * @var string
     */
    public static $clientrOperation = "clientOperation";

    /**
     * @param array $data
     * @param array $where
     * @param null $sequence
     * @return false|int
     */
    public function save($data = [], $where = [], $sequence = null)
    {
        $rules = [
            'username' => [
                'require',
                'max' => 30
            ],
            'secret' => [
                'require'
            ],
            'nick' => [
                'max' => 15
            ],
            'mobile' => [
                'mobile'
            ],
            'money' => [
                'number'
            ]
        ];
        $message = [
            'username.require' => '用户名不能为空！',
            'username.max' => '用户名最多30个字符！',
            'secret.require' => '密码不能为空！',
            'nick.max' => '昵称最多15个字符！',
            'mobile.mobile' => '手机号码不正确！',
            'money.number' => '拥有钱必须是数字！',
        ];
        $validate = Validate::make($rules, $message);

        if (!$validate->check($this->getData())) {
            throw new ValidateException($validate->getError());
        }

        return parent::save($data, $where, $sequence);
    }
}