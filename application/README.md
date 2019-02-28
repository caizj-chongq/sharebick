**后台管理配置**
1. 首先下载xampp, 然后将本项目路径放入xampp的根目录
2. 如果是从git上拉取项目，那么就需要安装composer，安装完成后，打开cmd或者shell窗口，并把当前目录切换到项目目录，之后在执行如下代码
``
    composer update
``
待执行完成，就可以尝试着访问该项目
3. 将本项目的data目录下面的.sql文件导入到数据库中，导入步骤不明白的，自行百度 _怎么导入sql文件到数据库中_
4. 设置项目配置,请按照 .env.example文件的配置项，在项目根目录创建一个.env文件，并且把这些配置项配置到.env文件中
5. 使用系统前，需要在application/common文件夹下面创建orderLocation文件夹;在根目录的runtime/log下分别创建名为lock、tencent、weixin、yingyan四个文件夹，里面分别放着对应接口调用日志。
6. 访问网页，使用admin账号进行登录,账号密码分别为admin,admin;这个时候都可以开始使用系统了。
7. 系统目录介绍:
    application --> 应用目录
        api_v1  --> 小程序端接口模块
           controller --> 控制器 
               Base.php --> 关于小程序模块的基础控制器，用来实现 继承了这个控制器的控制器，执行统一代码
               Bicycle.php --> 小程序端的 订单列表（index）、下单（store）、订单详情（show）、订单更新（取消订单、支付订单、停止用车、反馈车辆信息、车辆定位 (update)）、
               Session.php  --> 实现小程序端的 微信登录流程(login)、保存用户信息(storeUser),保存用户信息接口使用来换取后续小程序与后台进行通讯的token凭证 
           config.php --> 配置文件,里面主要配置了这个模块的路由模式为强制开启模式，必须通过本模块下面route.php所定义的路由进行访问
           route.php  --> 里面定义了关于小程序端接口的访问路由,所有接口都可以在这个页面找到对应的访问代码
        common  --> 公告模块
            orderLocation --> 保存着 关于订单的定位文件 **需要在项目使用前创建这个目录**
            wx --> 关于调用微信api的代码
            CodeMap.php  --> 系统中某些状态值描述以及获取
            Lock.php  --> 关于锁相关接口的文件
            TencentMap.php  --> 关于腾讯地图的api接口文件(腾讯地图在后台主要是用来实现车辆行驶距离的计算)
            Utils.php  --> 公共方法,里面的每一个方法都有的对应的注释
            Yingyan.php --> 百度鹰眼的相关api接口文件(主要用来实现电子围栏、电子围栏报警、添加终端) 
        index   --> 默认模块(默认访问的模块)
           controller  --> 控制器
               Base.php --> 里面实现的功能是大多数控制器都需要执行的，前提是继承该控制器
               Bicycle.php  --> 车辆管理控制器
               BicycleReport.php  --> 车辆反馈控制器
               Client.php  --> 会员管理控制器
               Error.php  --> 使用来处理当你在地址栏上出入了不存在的地址的时候那么就会直接跳转到这个控制下对应的empty方法里面执行代码
               Fence.php  --> 电子围栏管理控制器
               FenceAlarm.php  --> 电子围栏报警管理控制器
               Group.php  -->  后台用户组管理控制器。里面的seeder使用来生成已固定的权限
               Index.php  -->  后台主页控制器
               Login.php  --> 后台用户登录相关控制器
               Order.php  --> 订单管理控制器
               User.php   --> 后台用户管理控制器           
           model  --> 模型(一个模型文件对应着一张表,具体表名称在对应的模型文件中有)
               Bicycle  --> 车辆相关的其他模型
                    Reports.php  --> 车辆反馈模型                    
               Client   -->  会员相关的其他模型
                    Operation.php  --> 会员操作模型(没有记录任何东西)
               Fence    -->  电子围栏相关的其他模型
                    Alarm.php  --> 电子围栏报警模型
                    Bicycles.php  --> 电子围栏和车辆绑定模型
               LockStatus  --> 远程数据库（锁信息）相关模型
                    Lock.php  --> 远程锁模型
               User   -->  后台用户相关其他模型
                    Operation.php  --> 后台用户操作模型(仅仅记录了登录)
               BaseModel.php  --> 基础模型，主要用来定义删除操作为更新deleted字段
               Bicycle.php  --> 车辆模型
               Client.php  --> 会员模型
               Fence.php  --> 电子围栏模型
               Order.php  --> 订单模型
               User.php  --> 后台用户模型
               UserGroup.php  --> 后台用户组模型
           view  --> 视图模板 **本项目的模板文件使用了layout布局  https://www.kancloud.cn/manual/thinkphp5/125013**           
        *.php   --> 各种配置文件
        


