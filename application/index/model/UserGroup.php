<?php
namespace app\index\model;

use think\Model;
use traits\model\SoftDelete;

class UserGroup extends Model
{
    use SoftDelete;
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
    protected static $deleteTime = 'deleted';

    /**
     * @var bool
     */
    protected $autoWriteTimestamp = true;

    /**
     * @var string
     */
    protected $pk = 'id';

}