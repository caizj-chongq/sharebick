<?php
namespace app\index\model;

use think\Model;

class UserGroup extends Model
{
    /**
     * @var string
     */
    protected $table = "admin_groups";

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
     * @return $this|int
     */
    public function delete()
    {
        return self::where('deleted', '=', 0)->where('id', '=', $this->id)->setField('deleted', time());
    }
}