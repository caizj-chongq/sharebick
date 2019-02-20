<?php
namespace app\index\model\LockStatus;

use think\Model;

class Lock extends Model
{
    protected $connection = 'db_connect_lock_status';

    protected $table = 'zmr_user';
}