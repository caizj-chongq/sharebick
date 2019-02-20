<?php

namespace app\index\model;


use app\common\CodeMap;
use think\exception\ValidateException;
use think\Validate;

class Fence extends BaseModel
{
    /**
     * @var string
     */
    protected $table = "fences";

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
        'name',
        'points',
        'fence_id'
    ];

    /**
     * @param array $data
     * @param array $where
     * @param null $sequence
     * @return false|int
     */
    public function save($data = [], $where = [], $sequence = null)
    {
        $rules = [
            'name' => [
                'require',
                'max' => 20
            ],
            'points' => [
                'require'
            ]
        ];
        $message = [
            'name.require' => '电子围栏名称不能为空！',
            'name.max' => '电子围栏名称最多20个字符！',
            'points.require' => '电子围栏顶点不能为空！'
        ];
        $validate = Validate::make($rules, $message);

//        if (!$validate->check($this->getData())) {
//            throw new ValidateException($validate->getError());
//        }

        return parent::save($data, $where, $sequence);
    }

}