<?php
namespace app\index\model\Fence;

use app\index\model\BaseModel;

class Alarm extends BaseModel
{
    /**
     * @var string
     */
    protected $table = "fence_alarm";

    /**
     * @var string
     */
    protected $updateTime = 'updated';

    /**
     * @var string
     */
    protected $createTime = 'created';


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
        'order_id',
        'out_time',
        'in_time',
        'out_gps',
        'in_gps',
        'created',
        'updated',
        'deleted',
    ];
}