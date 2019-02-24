<?php

namespace app\common;

class CodeMap
{
    protected $mapArray = [
        'clientOperation' => [      //code
            'login' => [
                'value' => 1,
                'zhDesc' => '登入'
            ]     // tag => value
        ],
        'userOperation' => [
            'login' => [
                'value' => 1,
                'zhDesc' => '登入'
            ]
        ],
        'bicycleStatus' => [
            'notPutIn' => [
                'value' => 1,
                'zhDesc' => '未投放'
            ],
            'inUse' => [
                'value' => 2,
                'zhDesc' => '使用中'
            ],
            'stopUse' => [
                'value' => 3,
                'zhDesc' => '暂停使用'
            ]
        ],
        'orderStatus' => [
            'ing' => [
                'value' => 1,
                'zhDesc' => '进行中'
            ],
            'cancle' => [
                'value' => 2,
                'zhDesc' => '已取消'
            ],
            'success' => [
                'value' => 3,
                'zhDesc' => '已完成'
            ],
            'noPay' =>[
                'value' => 4,
                'zhDesc' => '未支付'
            ]
        ]
    ];

    /**
     * 根据code和tag来获取value
     * @param $code
     * @param $tag
     * @return null
     */
    public function getCodeValueByCodeAndTag($code, $tag)
    {
        $value = null;
        if (array_key_exists($code, $this->mapArray) && array_key_exists($tag, $this->mapArray[$code])) {
            $value = $this->mapArray[$code][$tag]['value'];
        }

        return $value;
    }

    /**
     * 根据code和tag来获取values
     * @param $code
     * @return null
     */
    public function getCodeValueArrByCode($code, $tag)
    {
        $value = null;
        if (array_key_exists($code, $this->mapArray) && array_key_exists($tag, $this->mapArray[$code])) {
            $value = $this->mapArray[$code][$tag];
        }

        return $value;
    }

    /**
     * 根据code来获取values
     * @param $code
     * @return null
     */
    public function getCodeValuesByCode($code)
    {
        $value = null;
        if (array_key_exists($code, $this->mapArray)) {
            $value = $this->mapArray[$code];
        }

        return $value;
    }


}