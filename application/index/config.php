<?php
return [
    'template'  =>  [
        'layout_on'     =>  true,
        'layout_name'   =>  'layout',
    ],
    'view_replace_str'  =>  [
        '__PUBLIC__'=> 'http://' . $_SERVER['SERVER_NAME'] . rtrim(dirname(rtrim($_SERVER['SCRIPT_NAME'], '/'))),
        '__STATIC__'=> 'http://' . $_SERVER['SERVER_NAME'] . rtrim(dirname(rtrim($_SERVER['SCRIPT_NAME'], '/'))) . '/static'
    ]
];