<?php

namespace app\index\model;


use app\common\CodeMap;
use think\exception\ValidateException;
use think\Validate;

class Order extends BaseModel
{
    /**
     * @var string
     */
    protected $table = "orders";

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
        'deleted',
        'order_number',
        'bicycle_id',
        'begin',
        'end',
        'price',
        'status',
        'client_opretion',
        'bicycle_opretion',
        'remark',
        'client_id',
        'meter'
    ];

    /**
     * @var array
     */
    protected static $statusInfoMap = array();

    /**
     * @var string
     */
    public static $bicycleStatus = "orderStatus";

    /**
     * @param $value
     * @param $data
     * @return array
     */
    public function getStatusAttr($value, $data)
    {
        $statusInfos = (new CodeMap())->getCodeValuesByCode(self::$bicycleStatus);

        if (!count(self::$statusInfoMap) || !array_key_exists($value, self::$statusInfoMap)) {
            foreach ($statusInfos as $statusInfo) {
                if ($statusInfo['value'] == $value) {
                    self::$statusInfoMap[$value] = $statusInfo['zhDesc'];
                }
            }
        }

        return [
            'status' => $value,
            'status_info' => self::$statusInfoMap[$value] ?? ''
        ];
    }

    public function getBeginAttr($value)
    {
        if ($value) {
            return date('Y-m-d H:i:s', $value);
        }
        return $value;
    }


    public function getEndAttr($value)
    {
        if ($value) {
            return date('Y-m-d H:i:s', $value);
        }
        return $value;
    }


    public function getMeterAttr($value)
    {
        if ($value) {
            return number_format($value, 0, '.', ',');
        }
        return $value;
    }

    /**
     * @param array $data
     * @param array $where
     * @param null $sequence
     * @return false|int
     */
    public function save($data = [], $where = [], $sequence = null)
    {
        return parent::save($data, $where, $sequence);
    }

}