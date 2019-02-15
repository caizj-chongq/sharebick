<?php
namespace app\index\model;

use think\Model;

class BaseModel extends Model
{
    /**
     * @return $this|int
     */
    public function delete()
    {
        return self::where('deleted', '=', 0)->where('id', '=', $this->id)->setField('deleted', time());
    }
}