<?php
namespace app\common;

class CodeMap
{
    protected $mapArray = [
        'clientOperation' => [      //code
            'login' => 1     // tag => value
        ],
        'userOperation' => [
            'login' => 1
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
        $desc = null;
        if (array_key_exists($code, $this->mapArray) && array_key_exists($tag, $this->mapArray[$code])) {
            $desc = $this->mapArray[$code][$tag];
        }

        return $desc;
    }

}