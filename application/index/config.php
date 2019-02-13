<?php
$rootPath = '/';

return [
    'template'  =>  [
        'layout_on'     =>  true,
        'layout_name'   =>  'layout',
    ],
    'view_replace_str'  =>  [
        '__PUBLIC__'=> $rootPath,
        '__STATIC__'=> $rootPath . 'static'
    ]
];