<?php
namespace app\index\model;

use think\exception\ValidateException;
use think\Model;
use think\Validate;
use traits\model\SoftDelete;

class Client extends Model
{
    use SoftDelete;
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
        'created',
        'updated',
        'deleted'
    ];

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
            'mobile' => function ($value, $data) {
                $mobileReg = '/^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\d{8}$/';
                return (boolean)preg_match($mobileReg, $value);
            }
        ];
        $message = [
            'username.require' => '用户名不能为空！',
            'username.max' => '用户名最多30个字符！',
            'secret.require' => '密码不能为空！',
            'nick.max' => '昵称最多15个字符！',
            'mobile' => '手机号码不正确！'
        ];
        $validate = Validate::make($rules, $message);

        if (!$validate->check($this->getData())) {
            throw new ValidateException($validate->getError());
        }

        return parent::save($data, $where, $sequence);
    }
}