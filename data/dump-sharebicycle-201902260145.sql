-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: sharebicycle
-- ------------------------------------------------------
-- Server version	5.7.25-0ubuntu0.18.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin_group_navigate`
--

DROP TABLE IF EXISTS `admin_group_navigate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_group_navigate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `navigate_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `group_navigate` (`navigate_id`,`group_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_group_navigate`
--

LOCK TABLES `admin_group_navigate` WRITE;
/*!40000 ALTER TABLE `admin_group_navigate` DISABLE KEYS */;
INSERT INTO `admin_group_navigate` VALUES (54,2,5),(5,2,6),(9,2,7),(14,2,8),(21,2,8),(64,3,5),(6,3,6),(10,3,7),(15,3,8),(57,4,5),(11,4,7),(16,4,8),(65,5,5),(66,6,5),(55,8,5),(7,8,6),(12,8,7),(17,8,8),(67,9,5),(8,9,6),(13,9,7),(18,9,8),(68,10,5),(63,12,5);
/*!40000 ALTER TABLE `admin_group_navigate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_groups`
--

DROP TABLE IF EXISTS `admin_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(30) NOT NULL COMMENT '组名称 ',
  `desc` varchar(150) DEFAULT NULL COMMENT '简介',
  `created` int(11) DEFAULT '0' COMMENT '创建时间',
  `updated` int(11) DEFAULT '0' COMMENT '更新时间',
  `deleted` int(11) DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_groups`
--

LOCK TABLES `admin_groups` WRITE;
/*!40000 ALTER TABLE `admin_groups` DISABLE KEYS */;
INSERT INTO `admin_groups` VALUES (1,'1','1',0,1546870103,1546870103),(5,'admin','admin',0,1547465792,0),(6,'qwer','qw',1546870097,1547465785,1547465785),(7,'admin','admin',1546874706,1547465782,1547465782),(8,'admin','admin',1546874721,1547465780,1547465780);
/*!40000 ALTER TABLE `admin_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_navigates`
--

DROP TABLE IF EXISTS `admin_navigates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_navigates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL COMMENT '权限名称',
  `route` varchar(150) DEFAULT NULL COMMENT '规则',
  `desc` varchar(150) DEFAULT NULL COMMENT '描述',
  `parent_id` int(11) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_navigates`
--

LOCK TABLES `admin_navigates` WRITE;
/*!40000 ALTER TABLE `admin_navigates` DISABLE KEYS */;
INSERT INTO `admin_navigates` VALUES (1,'用户管理','index/user','后台用户管理',0),(2,'列表','index/user/index','',1),(3,'详情','index/user/show','',1),(4,'新增','index/user/store','',1),(5,'更新','index/user/update','',1),(6,'删除','index/user/destroy','',1),(7,'用户组管理','index/group','后台用户组管理',0),(8,'列表','index/group/index','',7),(9,'详情','index/group/show','',7),(10,'新增','index/group/store','',7),(11,'更新','index/group/update','',7),(12,'删除','index/group/destroy','',7);
/*!40000 ALTER TABLE `admin_navigates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `secret` varchar(128) NOT NULL COMMENT '密码',
  `nick` varchar(30) DEFAULT NULL COMMENT '昵称',
  `real_name` varchar(30) DEFAULT NULL COMMENT '真实姓名',
  `group_id` int(11) DEFAULT '0' COMMENT '用户组id',
  `deleted` int(11) DEFAULT '0' COMMENT '删除时间',
  `created` int(11) DEFAULT '0' COMMENT '创建时间',
  `updated` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `group` (`group_id`) USING BTREE,
  KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
INSERT INTO `admin_users` VALUES (2,'admin1','da39a3ee5e6b4b0d3255bfef95601890afd80709','123456','123456',1,0,1546759837,1546761337),(3,'admin2','da39a3ee5e6b4b0d3255bfef95601890afd80709','123456','123456',1,0,1546759956,1546759956),(4,'admin2','da39a3ee5e6b4b0d3255bfef95601890afd80709','123456','123456',1,0,1546759980,1546759980),(5,'123','da39a3ee5e6b4b0d3255bfef95601890afd80709','123456','123456',1,1550137160,1546759991,1546759991),(6,'12','da39a3ee5e6b4b0d3255bfef95601890afd80709','123456','123456',1,1550137054,1546760012,1546760012),(7,'1','da39a3ee5e6b4b0d3255bfef95601890afd80709','1','1',1,1546765335,1546760034,1546765335),(8,'admin1','8cb2237d0679ca88db6464eac60da96345513964','123456','123456',1,1546765315,1546761117,1546765315),(9,'admin1','8cb2237d0679ca88db6464eac60da96345513964','123456','123456',1,1546765311,1546761144,1546765311),(11,'admin','d033e22ae348aeb5660fc2140aec35850c4da997','admin','admin',5,0,0,0);
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_users_operations`
--

DROP TABLE IF EXISTS `admin_users_operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_users_operations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `created` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users_operations`
--

LOCK TABLES `admin_users_operations` WRITE;
/*!40000 ALTER TABLE `admin_users_operations` DISABLE KEYS */;
INSERT INTO `admin_users_operations` VALUES (1,1,1550132838,1,'192.168.10.1',1550132838),(2,1,1550135308,1,'192.168.10.1',1550135308),(3,11,1550199537,1,'192.168.10.1',1550199537),(4,11,1550415324,1,'127.0.0.1',1550415323),(5,11,1550415334,1,'127.0.0.1',1550415334),(6,11,1550589994,1,'127.0.0.1',1550589994),(7,11,1550662336,1,'127.0.0.1',1550662336),(8,11,1550668601,1,'127.0.0.1',1550668601),(9,11,1550835410,1,'127.0.0.1',1550835409),(10,11,1550900483,1,'127.0.0.1',1550900482),(11,11,1550904744,1,'192.168.10.1',1550904744),(12,11,1550926562,1,'192.168.10.1',1550926562),(13,11,1550937159,1,'192.168.10.1',1550937159),(14,11,1550980760,1,'192.168.10.1',1550980760),(15,11,1551019865,1,'192.168.10.1',1551019865),(16,11,1551025653,1,'192.168.10.1',1551025653),(17,11,1551025770,1,'192.168.10.1',1551025770),(18,11,1551098138,1,'192.168.10.1',1551098138),(19,11,1551098599,1,'192.168.10.1',1551098599),(20,11,1551098827,1,'192.168.10.1',1551098827),(21,11,1551098934,1,'192.168.10.1',1551098934),(22,11,1551102595,1,'192.168.10.1',1551102595);
/*!40000 ALTER TABLE `admin_users_operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bicycle_reports`
--

DROP TABLE IF EXISTS `bicycle_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bicycle_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bicycle_id` int(11) DEFAULT '0',
  `remark` varchar(200) DEFAULT NULL,
  `created` int(11) DEFAULT '0',
  `updated` int(11) DEFAULT '0',
  `is_ok` tinyint(4) DEFAULT '0' COMMENT '是否查看维修',
  `operator` json DEFAULT NULL COMMENT '操作人快照',
  `deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bicycle_reports`
--

LOCK TABLES `bicycle_reports` WRITE;
/*!40000 ALTER TABLE `bicycle_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `bicycle_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bicycles`
--

DROP TABLE IF EXISTS `bicycles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bicycles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` int(11) DEFAULT '0',
  `updated` int(11) DEFAULT '0',
  `deleted` int(11) DEFAULT '0',
  `lock_number` varchar(20) DEFAULT NULL,
  `bicycle_number` varchar(20) DEFAULT NULL,
  `status` int(11) DEFAULT '0' COMMENT '车辆状态',
  `bicycle_name` varchar(10) DEFAULT NULL COMMENT '车辆名称',
  `hourlyPrice` decimal(18,2) DEFAULT '0.00',
  `dailyPrice` decimal(18,2) DEFAULT '0.00',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bicycles`
--

LOCK TABLES `bicycles` WRITE;
/*!40000 ALTER TABLE `bicycles` DISABLE KEYS */;
INSERT INTO `bicycles` VALUES (6,1550926719,1550927096,0,'866160033560827','001',2,'可以随意调用接口的车',60.00,1440.00);
/*!40000 ALTER TABLE `bicycles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nick` varchar(15) DEFAULT NULL,
  `money` decimal(18,2) DEFAULT '0.00',
  `created` int(11) DEFAULT '0',
  `updated` int(11) DEFAULT '0',
  `deleted` int(11) DEFAULT '0',
  `mobile` varchar(12) DEFAULT NULL,
  `openid` varchar(32) DEFAULT NULL,
  `token` varchar(128) NOT NULL,
  PRIMARY KEY (`id`,`token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'蔡正军',499506.00,1550920361,1550920361,0,NULL,'ovJH64q6DhFNbwGVWB2OlKgkrxW8','824DMW00LRCYAXHXNMLVW2DVK4UGSOSRHB6WQ4JFKKJG6FTEOELTU9VK7G3H40667BAULRLADOQ5OY6GS5WP5WC1U3KVIUHFL0QOX0LJNWUAF2QQOQ5F79EMB1PMQ4TB');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients_operations`
--

DROP TABLE IF EXISTS `clients_operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients_operations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT '0',
  `time` int(11) DEFAULT '0' COMMENT '操作时间',
  `type` int(11) DEFAULT NULL COMMENT '操作类型',
  `ip` varchar(15) DEFAULT NULL,
  `created` int(11) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients_operations`
--

LOCK TABLES `clients_operations` WRITE;
/*!40000 ALTER TABLE `clients_operations` DISABLE KEYS */;
/*!40000 ALTER TABLE `clients_operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fence_alarm`
--

DROP TABLE IF EXISTS `fence_alarm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fence_alarm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT '0',
  `out_time` int(11) DEFAULT '0',
  `in_time` int(11) DEFAULT '0',
  `out_gps` json DEFAULT NULL,
  `in_gps` json DEFAULT NULL,
  `created` int(11) DEFAULT '0',
  `updated` int(11) DEFAULT '0',
  `deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fence_alarm`
--

LOCK TABLES `fence_alarm` WRITE;
/*!40000 ALTER TABLE `fence_alarm` DISABLE KEYS */;
/*!40000 ALTER TABLE `fence_alarm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fence_bicycles`
--

DROP TABLE IF EXISTS `fence_bicycles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fence_bicycles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fence_id` int(11) DEFAULT NULL,
  `bicycle_id` int(11) DEFAULT NULL,
  `created` int(255) DEFAULT '0',
  `updated` int(11) DEFAULT '0',
  `deleted` int(255) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fence_bicycles`
--

LOCK TABLES `fence_bicycles` WRITE;
/*!40000 ALTER TABLE `fence_bicycles` DISABLE KEYS */;
INSERT INTO `fence_bicycles` VALUES (1,13,5,1550673476,1550673476,0),(2,14,5,1550673476,1550673476,0),(3,15,6,1551019908,1551019908,0);
/*!40000 ALTER TABLE `fence_bicycles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fences`
--

DROP TABLE IF EXISTS `fences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL COMMENT '电子围栏名称',
  `points` json DEFAULT NULL COMMENT '围栏顶点',
  `fence_id` int(11) DEFAULT NULL COMMENT '百度鹰眼服务端电子围栏id',
  `created` int(11) DEFAULT '0',
  `updated` int(11) DEFAULT '0',
  `deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fences`
--

LOCK TABLES `fences` WRITE;
/*!40000 ALTER TABLE `fences` DISABLE KEYS */;
INSERT INTO `fences` VALUES (1,'阿萨德','[{\"lat\": 29.547881, \"lng\": 106.516717}, {\"lat\": 29.536758, \"lng\": 106.52031}, {\"lat\": 29.538895, \"lng\": 106.531378}, {\"lat\": 29.546373, \"lng\": 106.52915}]',NULL,1550663686,1550663686,1550664574),(2,'1','[{\"lat\": 29.550018, \"lng\": 106.501194}, {\"lat\": 29.537638, \"lng\": 106.50335}, {\"lat\": 29.542917, \"lng\": 106.505794}, {\"lat\": 29.546247, \"lng\": 106.506584}, {\"lat\": 29.548321, \"lng\": 106.505003}, {\"lat\": 29.545933, \"lng\": 106.504213}]',NULL,1550663761,1550663761,0),(3,'2','[{\"lat\": 29.546876, \"lng\": 106.512046}, {\"lat\": 29.539272, \"lng\": 106.514418}, {\"lat\": 29.541283, \"lng\": 106.516861}, {\"lat\": 29.542602, \"lng\": 106.515567}, {\"lat\": 29.544111, \"lng\": 106.517651}, {\"lat\": 29.547001, \"lng\": 106.518729}, {\"lat\": 29.54543, \"lng\": 106.521173}, {\"lat\": 29.549578, \"lng\": 106.52067}, {\"lat\": 29.55096, \"lng\": 106.517005}, {\"lat\": 29.548635, \"lng\": 106.517508}, {\"lat\": 29.548447, \"lng\": 106.515208}, {\"lat\": 29.549955, \"lng\": 106.514202}, {\"lat\": 29.552971, \"lng\": 106.511974}, {\"lat\": 29.551212, \"lng\": 106.511399}, {\"lat\": 29.550395, \"lng\": 106.512333}, {\"lat\": 29.549955, \"lng\": 106.510896}, {\"lat\": 29.54851, \"lng\": 106.511974}, {\"lat\": 29.548321, \"lng\": 106.510752}, {\"lat\": 29.54719, \"lng\": 106.510465}]',NULL,1550663761,1550663761,0),(4,'3','[{\"lat\": 29.547881, \"lng\": 106.530156}, {\"lat\": 29.544676, \"lng\": 106.530156}, {\"lat\": 29.54122, \"lng\": 106.528359}, {\"lat\": 29.541346, \"lng\": 106.523329}, {\"lat\": 29.547818, \"lng\": 106.523688}, {\"lat\": 29.552908, \"lng\": 106.525341}, {\"lat\": 29.553977, \"lng\": 106.532527}, {\"lat\": 29.555233, \"lng\": 106.525053}, {\"lat\": 29.550583, \"lng\": 106.539498}, {\"lat\": 29.559066, \"lng\": 106.530587}, {\"lat\": 29.545619, \"lng\": 106.533246}, {\"lat\": 29.548007, \"lng\": 106.539283}]',NULL,1550663761,1550663761,0),(5,'asdf','[{\"lat\": 29.55184, \"lng\": 106.510537}, {\"lat\": 29.543105, \"lng\": 106.512262}, {\"lat\": 29.543671, \"lng\": 106.524694}, {\"lat\": 29.549452, \"lng\": 106.518298}, {\"lat\": 29.552468, \"lng\": 106.51837}, {\"lat\": 29.547693, \"lng\": 106.515783}, {\"lat\": 29.550709, \"lng\": 106.513483}, {\"lat\": 29.552343, \"lng\": 106.529222}]',NULL,1550665886,1550665886,0),(6,'xcvbb','[{\"lat\": 29.549201, \"lng\": 106.508381}, {\"lat\": 29.541534, \"lng\": 106.506728}, {\"lat\": 29.543671, \"lng\": 106.523904}, {\"lat\": 29.550709, \"lng\": 106.519592}, {\"lat\": 29.553788, \"lng\": 106.515424}, {\"lat\": 29.546562, \"lng\": 106.515496}, {\"lat\": 29.548635, \"lng\": 106.512477}, {\"lat\": 29.552908, \"lng\": 106.511902}, {\"lat\": 29.555296, \"lng\": 106.510178}, {\"lat\": 29.566983, \"lng\": 106.50759}]',NULL,1550668625,1550668625,1550668683),(13,'asdzc','[{\"lat\": 29.54719, \"lng\": 106.504824}, {\"lat\": 29.543357, \"lng\": 106.505902}, {\"lat\": 29.543734, \"lng\": 106.511507}, {\"lat\": 29.544613, \"lng\": 106.509639}]',42,1550673476,1550673476,0),(14,'wqeyh','[{\"lat\": 29.549201, \"lng\": 106.520274}, {\"lat\": 29.551652, \"lng\": 106.521927}, {\"lat\": 29.548887, \"lng\": 106.525449}, {\"lat\": 29.547316, \"lng\": 106.523077}, {\"lat\": 29.543859, \"lng\": 106.522933}, {\"lat\": 29.542351, \"lng\": 106.519125}]',43,1550673476,1550673476,0),(15,'测试电子围栏','[{\"lat\": 29.6175, \"lng\": 106.298887}, {\"lat\": 29.61706, \"lng\": 106.298734}, {\"lat\": 29.616715, \"lng\": 106.300064}, {\"lat\": 29.61706, \"lng\": 106.300297}, {\"lat\": 29.617837, \"lng\": 106.299723}]',44,1551019908,1551019908,0);
/*!40000 ALTER TABLE `fences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_number` varchar(25) NOT NULL,
  `bicycle_id` int(11) DEFAULT NULL,
  `begin` int(11) DEFAULT '0' COMMENT '开始时间',
  `end` int(11) DEFAULT '0' COMMENT '结束时间',
  `price` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `status` int(11) DEFAULT NULL COMMENT '状态',
  `client_opretion` json DEFAULT NULL COMMENT '下单人快照',
  `bicycle_opretion` json DEFAULT NULL COMMENT '车辆快照',
  `created` int(11) DEFAULT '0',
  `updated` int(11) DEFAULT '0',
  `deleted` int(11) DEFAULT '0',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `client_id` int(11) DEFAULT NULL,
  `meter` int(11) DEFAULT '0' COMMENT '骑行米数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'OR201902245c7181ce9e3b6',6,1550942670,1550942737,1.12,4,'{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"0.00\", \"token\": \"824DMW00LRCYAXHXNMLVW2DVK4UGSOSRHB6WQ4JFKKJG6FTEOELTU9VK7G3H40667BAULRLADOQ5OY6GS5WP5WC1U3KVIUHFL0QOX0LJNWUAF2QQOQ5F79EMB1PMQ4TB\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}','{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}',1550942670,1550942670,0,NULL,1,0),(2,'OR201902245c7182b2a6ffc',6,1550942898,1550943132,4.00,4,'{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"0.00\", \"token\": \"824DMW00LRCYAXHXNMLVW2DVK4UGSOSRHB6WQ4JFKKJG6FTEOELTU9VK7G3H40667BAULRLADOQ5OY6GS5WP5WC1U3KVIUHFL0QOX0LJNWUAF2QQOQ5F79EMB1PMQ4TB\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}','{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}',1550942898,1550942898,0,NULL,1,0),(7,'OR201902245c7188c421b58',6,1550944452,1550981087,611.00,4,'{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"0.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}','{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}',1550944452,1550944452,0,NULL,1,0),(8,'OR201902245c7217f938388',6,1550981113,1550990784,162.00,3,'{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"0.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}','{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}',1550981113,1550981113,0,NULL,1,641),(11,'OR201902245c723d97ef457',6,1550990743,1550990907,3.00,3,'{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"0.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}','{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}',1550990743,1550990743,0,NULL,1,0),(12,'OR201902245c723ead3d650',6,1550991021,1551010598,327.00,3,'{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"0.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}','{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}',1550991021,1550991021,0,NULL,1,0),(13,'OR201902245c728b50578ae',6,1551010640,1551010689,1.00,3,'{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"0.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}','{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}',1551010640,1551010640,0,NULL,1,0),(14,'OR201902245c729619a1934',6,1551013401,1551013417,1.00,4,'{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"499669.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}','{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}',1551013401,1551013401,0,NULL,1,0),(15,'OR201902245c72966fa0549',6,1551013487,1551013490,1.00,3,'{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"499669.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}','{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}',1551013487,1551013487,0,NULL,1,0),(16,'OR201902245c729a2f0b9c0',6,1551014447,1551017793,0.00,2,'{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"499506.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}','{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}',1551014447,1551014447,0,'123456789',1,0),(17,'OR201902245c72a7ef7b2ef',6,1551017967,0,0.00,1,'{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"499506.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}','{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}',1551017967,1551017967,0,NULL,1,0);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_info`
--

DROP TABLE IF EXISTS `system_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_info` (
  `yingyanAk` varchar(128) DEFAULT NULL COMMENT '百度鹰眼服务ak',
  `service_id` varchar(15) DEFAULT NULL COMMENT '百度鹰眼轨迹服务service_id',
  `browerAk` varchar(128) DEFAULT NULL,
  `wx_appid` varchar(50) DEFAULT NULL,
  `wx_appsecret` varchar(128) DEFAULT NULL,
  `lock_token` varchar(128) DEFAULT NULL,
  `tencent_map_key` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_info`
--

LOCK TABLES `system_info` WRITE;
/*!40000 ALTER TABLE `system_info` DISABLE KEYS */;
INSERT INTO `system_info` VALUES ('ySWPa1ipCqxDgcYphFvIbZWcN6gG1VRR','208795','XhyLag9s3zKpfr3t05TuDGVzd91Z5HjC','wxa4930391436e886d','5696395d5659d0dc23bbb450f8f6ff07','48A91502513526909A5D91A10BB1E39D','QQ5BZ-25JW3-CFH3X-37TXW-BCPN5-BLFQM');
/*!40000 ALTER TABLE `system_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'sharebicycle'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-26  1:46:00
