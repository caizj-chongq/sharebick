<?php
namespace app\index\model;

use think\Model;
use traits\model\SoftDelete;

class Bicycle extends Model
{
    use SoftDelete;

    /**
     * @var string
     */
    protected $table = "bicycles";

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
    protected static $deleteTime = 'deleted';

    /**
     * @var bool
     */
    protected $autoWriteTimestamp = true;

    /**
     * @var string
     */
    protected $pk = 'id';

    /***
     * @var array
     */
    protected $field = [
        'created',
        'updated',
        'deleted'
    ];
}