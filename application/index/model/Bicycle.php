<?php

namespace app\index\model;


use app\common\CodeMap;
use think\exception\ValidateException;
use think\Validate;

class Bicycle extends BaseModel
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
        'deleted',
        'bicycle_number',
        'lock_number',
        'status',
        'bicycle_name'
    ];

    /**
     * @var array
     */
    protected static $statusInfoMap = array();

    /**
     * @var string
     */
    public static $bicycleStatus = "bicycleStatus";

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

    /**
     * @param array $data
     * @param array $where
     * @param null $sequence
     * @return false|int
     */
    public function save($data = [], $where = [], $sequence = null)
    {
        $rules = [
            'bicycle_number' => [
                'require',
                'max' => 20
            ],
            'bicycle_name' => [
                'require',
                'max' => 10,
                'min' => 5
            ],
            'lock_number' => [
                'require',
                'max' => 20
            ]
        ];
        $message = [
            'bicycle_number.require' => '车号不能为空！',
            'bicycle_number.max' => '车号最多20个字符！',
            'bicycle_name.require' => '车名不能为空！',
            'bicycle_name.max' => '车名最多10个字符！',
            'bicycle_name.min' => '车号最少5个字符！',
            'lock_number.require' => '锁号不能为空！',
            'lock_number.max' => '锁号最多15个字符！'
        ];
        $validate = Validate::make($rules, $message);

        if (!$validate->check($this->getData())) {
            throw new ValidateException($validate->getError());
        }

        return parent::save($data, $where, $sequence);
    }

}