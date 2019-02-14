<?php

namespace app\index\model;

use think\exception\ValidateException;
use think\Model;
use think\Validate;

class User extends Model
{
    /**
     * @var string
     */
    protected $table = "admin_users";

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
        'group_id',
        'username',
        'secret',
        'nick',
        'real_name',
        'created',
        'updated',
        'deleted'
    ];

    /**
     * @var string
     */
    public static $userOperation = "userOperation";

    /**
     * @param array $data
     * @param array $where
     * @param null $sequence
     * @return false|int
     */
    public function save($data = [], $where = [], $sequence = null)
    {
        $rules = [
            'group_id' => [
                'require'
            ],
            'username' => [
                'require',
                'max' => 30
            ],
            'secret' => [
                'require'
            ],
            'nick' => [
                'max' => 30
            ],
            'real_name' => [
                'max' => 30
            ]
        ];
        $message = [
            'group_id.require' => '所属用户组不能为空！',
            'username.require' => '用户名不能为空！',
            'username.max' => '用户名最多30个字符！',
            'secret.require' => '密码不能为空！',
            'nick.max' => '昵称最多30个字符！',
            'real_name.max' => '真实姓名最多30个字符！'
        ];
        $validate = Validate::make($rules, $message);

        if (!$validate->check($this->getData())) {
            throw new ValidateException($validate->getError());
        }

        return parent::save($data, $where, $sequence);
    }

    /**
     * @return $this|int
     */
    public function delete()
    {
        return self::where('deleted', '=', 0)->where('id', '=', $this->id)->setField('deleted', time());
    }
}