<?php
namespace app\index\model;

use think\Model;

class Bicycle extends Model
{
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
    protected $deleteTime = 'deleted';

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

    /**
     * @return $this|int
     */
    public function delete()
    {
        return self::where('deleted', '=', 0)->where('id', '=', $this->id)->setField('deleted', time());
    }
}