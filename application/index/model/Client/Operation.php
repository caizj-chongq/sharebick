<?php
namespace app\index\model\Client;

use think\Model;

class Operation extends Model
{
    /**
     * @var string
     */
    protected $table = "clients_operations";

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
        'client_id',
        'time',
        'type',
        'ip',
        'created'
    ];
}