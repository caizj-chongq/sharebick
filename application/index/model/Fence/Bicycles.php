<?php
namespace app\index\model\Fence;

use app\index\model\BaseModel;

class Bicycles extends BaseModel
{
    /**
     * @var string
     */
    protected $table = "fence_bicycles";

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
        'fence_id',
        'bicycle_id',
        'created',
        'updated',
        'deleted'
    ];
}