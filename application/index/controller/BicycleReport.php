<?php
namespace app\index\controller;

class BicycleReport extends Base
{
    public function index()
    {

    }
//server{
//listen     80;
//server_name  sharebick.local.com;
//client_max_body_size 32M;
//access_log /var/log/nginx/sharebick.access.log;
//error_log /var/log/nginx/sharebick.error.log;
//
//gzip on;
//gzip_min_length 10k;
//gzip_buffers 16 64k;
//gzip_http_version 1.1;
//gzip_comp_level 6;
//gzip_types text/plain application/x-javascript text/css application/xml application/javascript;
//gzip_vary on;
//
//root   /home/vagrant/Code/sharebick/public;
//
//location / {
//root   /home/vagrant/Code/sharebick/public;
//index  index.html index.htm index.php;
//try_files $uri $uri/ /index.php/$uri?$query_string;
//}
//
//location ~ \.php(.*)$ {
//fastcgi_buffer_size 128k;
//       fastcgi_buffers 32 32k;
//       client_max_body_size 32M;
//       root           /home/vagrant/Code/sharebick/public;
//       fastcgi_pass   127.0.0.1:9000;
//
//       fastcgi_index  index.php;
//       fastcgi_split_path_info ^(.+\.php)(.*)$;
//       fastcgi_param PATH_INFO $fastcgi_path_info;
//       fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;
//       fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
//       include        fastcgi_params;
//       fastcgi_read_timeout 600;
//       fastcgi_send_timeout 600;
//    }
//}

}