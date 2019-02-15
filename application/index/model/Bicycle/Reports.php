<?php
namespace app\index\model\Bicycle;

use app\index\model\BaseModel;

class Reports extends BaseModel
{
    /**
     * @var string
     */
    protected $table = "bicycle_reports";

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
     * @var array
     */
    protected $field = [
        'bicycle_id',
        'type',
        'nick',
        'remark',
        'images',
        'status',
        'created',
        'updated',
        'deleted'
    ];

    /**
     * @var string
     */
    public static $bicycleReportType = "bicycleReportType";

    /**
     * @var string
     */
    public static $bicycleReportStatus = "bicycleReportStatus";
}