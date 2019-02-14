<?php
namespace app\index\model\User;

use think\Model;

class Operation extends Model
{
    /**
     * @var string
     */
    protected $table = "admin_users_operations";

    /**
     * @var string
     */
    protected $createTime = 'created';

    /**
     * @var string
     */
    protected $updateTime = '';

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
        'user_id',
        'time',
        'type',
        'ip',
        'created'
    ];
}