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
        'nick',
        'mobile',
        'money',
        'openid',
        'token',
        'created',
        'updated',
        'deleted'
    ];

    protected $hidden = [
        'secret'
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
        return parent::save($data, $where, $sequence);
    }
}