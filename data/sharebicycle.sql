/*
Navicat MySQL Data Transfer

Source Server         : homestead
Source Server Version : 50719
Source Host           : 192.168.10.10:3306
Source Database       : sharebicycle

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2019-03-01 09:36:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin_group_navigate
-- ----------------------------
DROP TABLE IF EXISTS `admin_group_navigate`;
CREATE TABLE `admin_group_navigate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `navigate_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `group_navigate` (`navigate_id`,`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of admin_group_navigate
-- ----------------------------

-- ----------------------------
-- Table structure for admin_groups
-- ----------------------------
DROP TABLE IF EXISTS `admin_groups`;
CREATE TABLE `admin_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(30) NOT NULL COMMENT '组名称 ',
  `desc` varchar(150) DEFAULT NULL COMMENT '简介',
  `created` int(11) DEFAULT '0' COMMENT '创建时间',
  `updated` int(11) DEFAULT '0' COMMENT '更新时间',
  `deleted` int(11) DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of admin_groups
-- ----------------------------

-- ----------------------------
-- Table structure for admin_navigates
-- ----------------------------
DROP TABLE IF EXISTS `admin_navigates`;
CREATE TABLE `admin_navigates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL COMMENT '权限名称',
  `route` varchar(150) DEFAULT NULL COMMENT '规则',
  `desc` varchar(150) DEFAULT NULL COMMENT '描述',
  `parent_id` int(11) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of admin_navigates
-- ----------------------------
INSERT INTO `admin_navigates` VALUES ('1', '用户管理', 'index/user', '后台用户管理', '0');
INSERT INTO `admin_navigates` VALUES ('2', '列表', 'index/user/index', '', '1');
INSERT INTO `admin_navigates` VALUES ('3', '详情', 'index/user/show', '', '1');
INSERT INTO `admin_navigates` VALUES ('4', '新增', 'index/user/store', '', '1');
INSERT INTO `admin_navigates` VALUES ('5', '更新', 'index/user/update', '', '1');
INSERT INTO `admin_navigates` VALUES ('6', '删除', 'index/user/destroy', '', '1');
INSERT INTO `admin_navigates` VALUES ('7', '用户组管理', 'index/group', '后台用户组管理', '0');
INSERT INTO `admin_navigates` VALUES ('8', '列表', 'index/group/index', '', '7');
INSERT INTO `admin_navigates` VALUES ('9', '详情', 'index/group/show', '', '7');
INSERT INTO `admin_navigates` VALUES ('10', '新增', 'index/group/store', '', '7');
INSERT INTO `admin_navigates` VALUES ('11', '更新', 'index/group/update', '', '7');
INSERT INTO `admin_navigates` VALUES ('12', '删除', 'index/group/destroy', '', '7');
INSERT INTO `admin_navigates` VALUES ('13', '会员管理', 'index/client', '小程序端会员管理', '0');
INSERT INTO `admin_navigates` VALUES ('14', '列表', 'index/client/index', '', '13');
INSERT INTO `admin_navigates` VALUES ('15', '详情', 'index/client/show', '', '13');
INSERT INTO `admin_navigates` VALUES ('16', '更新', 'index/client/update', '', '13');
INSERT INTO `admin_navigates` VALUES ('17', '删除', 'index/client/destroy', '', '13');
INSERT INTO `admin_navigates` VALUES ('18', '车辆管理', 'index/bicycle', '后台车辆管理', '0');
INSERT INTO `admin_navigates` VALUES ('19', '列表', 'index/bicycle/index', '', '18');
INSERT INTO `admin_navigates` VALUES ('20', '新增', 'index/bicycle/store', '', '18');
INSERT INTO `admin_navigates` VALUES ('21', '详情', 'index/bicycle/show', '', '18');
INSERT INTO `admin_navigates` VALUES ('22', '更新', 'index/bicycle/update', '', '18');
INSERT INTO `admin_navigates` VALUES ('23', '删除', 'index/bicycle/destroy', '', '18');
INSERT INTO `admin_navigates` VALUES ('24', '订单管理', 'index/order', '订单管理', '0');
INSERT INTO `admin_navigates` VALUES ('25', '列表', 'index/order/index', '', '24');
INSERT INTO `admin_navigates` VALUES ('26', '详情', 'index/order/show', '', '24');
INSERT INTO `admin_navigates` VALUES ('27', '车辆反馈管理', 'index/bicycle_report', '车辆反馈管理', '0');
INSERT INTO `admin_navigates` VALUES ('28', '列表', 'index/bicycle_report/index', '', '27');
INSERT INTO `admin_navigates` VALUES ('29', '详情', 'index/bicycle_report/show', '', '27');
INSERT INTO `admin_navigates` VALUES ('30', '更新', 'index/bicycle_report/update', '', '27');
INSERT INTO `admin_navigates` VALUES ('31', '删除', 'index/bicycle_report/destroy', '', '27');
INSERT INTO `admin_navigates` VALUES ('32', '电子围栏管理', 'index/bicycle', '电子围栏管理', '0');
INSERT INTO `admin_navigates` VALUES ('33', '列表', 'index/bicycle/fence', '', '32');
INSERT INTO `admin_navigates` VALUES ('34', '新增', 'index/bicycle/store', '', '32');
INSERT INTO `admin_navigates` VALUES ('35', '详情', 'index/bicycle/show', '', '32');
INSERT INTO `admin_navigates` VALUES ('36', '删除', 'index/bicycle/destroy', '', '32');
INSERT INTO `admin_navigates` VALUES ('37', '电子围栏报警管理', 'index/fence_alarm', '电子围栏报警管理', '0');
INSERT INTO `admin_navigates` VALUES ('38', '列表', 'index/fence_alarm/index', '', '37');

-- ----------------------------
-- Table structure for admin_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_users`;
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

-- ----------------------------
-- Records of admin_users
-- ----------------------------
INSERT INTO `admin_users` VALUES ('1', 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', '超级管理员', '超级管理员', '0', '0', '1546759837', '1546761337');

-- ----------------------------
-- Table structure for admin_users_operations
-- ----------------------------
DROP TABLE IF EXISTS `admin_users_operations`;
CREATE TABLE `admin_users_operations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `created` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of admin_users_operations
-- ----------------------------
INSERT INTO `admin_users_operations` VALUES ('1', '1', '1551353021', '1', '192.168.10.1', '1551353021');
INSERT INTO `admin_users_operations` VALUES ('2', '1', '1551366693', '1', '192.168.10.1', '1551366693');
INSERT INTO `admin_users_operations` VALUES ('3', '1', '1551369431', '1', '192.168.10.1', '1551369431');
INSERT INTO `admin_users_operations` VALUES ('4', '1', '1551404016', '1', '192.168.10.1', '1551404016');

-- ----------------------------
-- Table structure for bicycle_reports
-- ----------------------------
DROP TABLE IF EXISTS `bicycle_reports`;
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

-- ----------------------------
-- Records of bicycle_reports
-- ----------------------------

-- ----------------------------
-- Table structure for bicycles
-- ----------------------------
DROP TABLE IF EXISTS `bicycles`;
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

-- ----------------------------
-- Records of bicycles
-- ----------------------------
INSERT INTO `bicycles` VALUES ('6', '1550926719', '1550927096', '0', '866160033560827', '001', '2', '可以随意调用接口的车', '60.00', '1440.00');

-- ----------------------------
-- Table structure for clients
-- ----------------------------
DROP TABLE IF EXISTS `clients`;
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

-- ----------------------------
-- Records of clients
-- ----------------------------
INSERT INTO `clients` VALUES ('1', '蔡正军', '498547.00', '1550920361', '1550920361', '0', null, 'ovJH64q6DhFNbwGVWB2OlKgkrxW8', '824DMW00LRCYAXHXNMLVW2DVK4UGSOSRHB6WQ4JFKKJG6FTEOELTU9VK7G3H40667BAULRLADOQ5OY6GS5WP5WC1U3KVIUHFL0QOX0LJNWUAF2QQOQ5F79EMB1PMQ4TB');

-- ----------------------------
-- Table structure for clients_operations
-- ----------------------------
DROP TABLE IF EXISTS `clients_operations`;
CREATE TABLE `clients_operations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT '0',
  `time` int(11) DEFAULT '0' COMMENT '操作时间',
  `type` int(11) DEFAULT NULL COMMENT '操作类型',
  `ip` varchar(15) DEFAULT NULL,
  `created` int(11) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of clients_operations
-- ----------------------------

-- ----------------------------
-- Table structure for fence_alarm
-- ----------------------------
DROP TABLE IF EXISTS `fence_alarm`;
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
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fence_alarm
-- ----------------------------
INSERT INTO `fence_alarm` VALUES ('1', '18', '1551346651', '1551346651', '{\"lat\": \"27.737602\", \"lng\": \"100.823199\"}', '{\"lat\": \"27.737602\", \"lng\": \"100.823199\"}', '1551346651', '1551346651', '0');
INSERT INTO `fence_alarm` VALUES ('2', '18', '1551346711', '1551346711', '{\"lat\": \"27.737609\", \"lng\": \"100.823231\"}', '{\"lat\": \"27.737609\", \"lng\": \"100.823231\"}', '1551346711', '1551346711', '0');
INSERT INTO `fence_alarm` VALUES ('3', '18', '1551346771', '1551346771', '{\"lat\": \"27.737612\", \"lng\": \"100.823197\"}', '{\"lat\": \"27.737612\", \"lng\": \"100.823197\"}', '1551346771', '1551346771', '0');
INSERT INTO `fence_alarm` VALUES ('4', '18', '1551346831', '1551346831', '{\"lat\": \"27.737622\", \"lng\": \"100.823245\"}', '{\"lat\": \"27.737622\", \"lng\": \"100.823245\"}', '1551346831', '1551346831', '0');
INSERT INTO `fence_alarm` VALUES ('5', '18', '1551346894', '1551346894', '{\"lat\": \"27.737653\", \"lng\": \"100.823160\"}', '{\"lat\": \"27.737653\", \"lng\": \"100.823160\"}', '1551346894', '1551346894', '0');
INSERT INTO `fence_alarm` VALUES ('6', '18', '1551346951', '1551346951', '{\"lat\": \"27.737662\", \"lng\": \"100.823140\"}', '{\"lat\": \"27.737662\", \"lng\": \"100.823140\"}', '1551346951', '1551346951', '0');
INSERT INTO `fence_alarm` VALUES ('7', '18', '1551347014', '1551347014', '{\"lat\": \"27.737675\", \"lng\": \"100.823175\"}', '{\"lat\": \"27.737675\", \"lng\": \"100.823175\"}', '1551347014', '1551347014', '0');
INSERT INTO `fence_alarm` VALUES ('8', '18', '1551347074', '1551347074', '{\"lat\": \"27.737628\", \"lng\": \"100.823204\"}', '{\"lat\": \"27.737628\", \"lng\": \"100.823204\"}', '1551347074', '1551347074', '0');
INSERT INTO `fence_alarm` VALUES ('9', '18', '1551347131', '1551347131', '{\"lat\": \"27.737592\", \"lng\": \"100.823177\"}', '{\"lat\": \"27.737592\", \"lng\": \"100.823177\"}', '1551347131', '1551347131', '0');
INSERT INTO `fence_alarm` VALUES ('10', '18', '1551347191', '1551347191', '{\"lat\": \"27.737568\", \"lng\": \"100.823212\"}', '{\"lat\": \"27.737568\", \"lng\": \"100.823212\"}', '1551347191', '1551347191', '0');
INSERT INTO `fence_alarm` VALUES ('11', '18', '1551347251', '1551347251', '{\"lat\": \"27.737588\", \"lng\": \"100.823140\"}', '{\"lat\": \"27.737588\", \"lng\": \"100.823140\"}', '1551347251', '1551347251', '0');
INSERT INTO `fence_alarm` VALUES ('12', '18', '1551347314', '1551347314', '{\"lat\": \"27.737681\", \"lng\": \"100.823171\"}', '{\"lat\": \"27.737681\", \"lng\": \"100.823171\"}', '1551347314', '1551347314', '0');
INSERT INTO `fence_alarm` VALUES ('13', '18', '1551347374', '1551347374', '{\"lat\": \"27.737613\", \"lng\": \"100.823197\"}', '{\"lat\": \"27.737613\", \"lng\": \"100.823197\"}', '1551347374', '1551347374', '0');
INSERT INTO `fence_alarm` VALUES ('14', '18', '1551347434', '1551347434', '{\"lat\": \"27.737524\", \"lng\": \"100.823204\"}', '{\"lat\": \"27.737524\", \"lng\": \"100.823204\"}', '1551347434', '1551347434', '0');
INSERT INTO `fence_alarm` VALUES ('15', '18', '1551347494', '1551347494', '{\"lat\": \"27.737552\", \"lng\": \"100.823170\"}', '{\"lat\": \"27.737552\", \"lng\": \"100.823170\"}', '1551347494', '1551347494', '0');
INSERT INTO `fence_alarm` VALUES ('16', '18', '1551347554', '1551347554', '{\"lat\": \"27.737503\", \"lng\": \"100.823193\"}', '{\"lat\": \"27.737503\", \"lng\": \"100.823193\"}', '1551347554', '1551347554', '0');
INSERT INTO `fence_alarm` VALUES ('17', '18', '1551347614', '1551347614', '{\"lat\": \"27.737536\", \"lng\": \"100.823197\"}', '{\"lat\": \"27.737536\", \"lng\": \"100.823197\"}', '1551347614', '1551347614', '0');
INSERT INTO `fence_alarm` VALUES ('18', '18', '1551347671', '1551347671', '{\"lat\": \"27.737497\", \"lng\": \"100.823175\"}', '{\"lat\": \"27.737497\", \"lng\": \"100.823175\"}', '1551347671', '1551347671', '0');
INSERT INTO `fence_alarm` VALUES ('19', '18', '1551347731', '1551347731', '{\"lat\": \"27.737535\", \"lng\": \"100.823161\"}', '{\"lat\": \"27.737535\", \"lng\": \"100.823161\"}', '1551347731', '1551347731', '0');
INSERT INTO `fence_alarm` VALUES ('20', '18', '1551347791', '1551347791', '{\"lat\": \"27.737531\", \"lng\": \"100.823118\"}', '{\"lat\": \"27.737531\", \"lng\": \"100.823118\"}', '1551347791', '1551347791', '0');
INSERT INTO `fence_alarm` VALUES ('21', '18', '1551347851', '1551347851', '{\"lat\": \"27.737515\", \"lng\": \"100.823101\"}', '{\"lat\": \"27.737515\", \"lng\": \"100.823101\"}', '1551347851', '1551347851', '0');
INSERT INTO `fence_alarm` VALUES ('22', '18', '1551347911', '1551347911', '{\"lat\": \"27.737613\", \"lng\": \"100.823324\"}', '{\"lat\": \"27.737613\", \"lng\": \"100.823324\"}', '1551347911', '1551347911', '0');
INSERT INTO `fence_alarm` VALUES ('23', '18', '1551347971', '1551347971', '{\"lat\": \"27.737561\", \"lng\": \"100.823234\"}', '{\"lat\": \"27.737561\", \"lng\": \"100.823234\"}', '1551347971', '1551347971', '0');
INSERT INTO `fence_alarm` VALUES ('24', '18', '1551348031', '1551348031', '{\"lat\": \"27.737504\", \"lng\": \"100.823228\"}', '{\"lat\": \"27.737504\", \"lng\": \"100.823228\"}', '1551348031', '1551348031', '0');
INSERT INTO `fence_alarm` VALUES ('25', '18', '1551351001', '1551351001', '{\"lat\": \"27.737591\", \"lng\": \"100.823155\"}', '{\"lat\": \"27.737591\", \"lng\": \"100.823155\"}', '1551351001', '1551351001', '0');
INSERT INTO `fence_alarm` VALUES ('26', '18', '1551351061', '1551351061', '{\"lat\": \"27.737568\", \"lng\": \"100.823118\"}', '{\"lat\": \"27.737568\", \"lng\": \"100.823118\"}', '1551351061', '1551351061', '0');
INSERT INTO `fence_alarm` VALUES ('27', '18', '1551351121', '1551351121', '{\"lat\": \"27.737589\", \"lng\": \"100.823187\"}', '{\"lat\": \"27.737589\", \"lng\": \"100.823187\"}', '1551351121', '1551351121', '0');
INSERT INTO `fence_alarm` VALUES ('28', '18', '1551351180', '1551351180', '{\"lat\": \"27.737591\", \"lng\": \"100.823183\"}', '{\"lat\": \"27.737591\", \"lng\": \"100.823183\"}', '1551351180', '1551351180', '0');
INSERT INTO `fence_alarm` VALUES ('29', '18', '1551351241', '1551351241', '{\"lat\": \"27.737591\", \"lng\": \"100.823155\"}', '{\"lat\": \"27.737591\", \"lng\": \"100.823155\"}', '1551351241', '1551351241', '0');
INSERT INTO `fence_alarm` VALUES ('30', '18', '1551351300', '1551351300', '{\"lat\": \"27.737608\", \"lng\": \"100.823194\"}', '{\"lat\": \"27.737608\", \"lng\": \"100.823194\"}', '1551351300', '1551351300', '0');
INSERT INTO `fence_alarm` VALUES ('31', '18', '1551351361', '1551351361', '{\"lat\": \"27.737598\", \"lng\": \"100.823185\"}', '{\"lat\": \"27.737598\", \"lng\": \"100.823185\"}', '1551351361', '1551351361', '0');
INSERT INTO `fence_alarm` VALUES ('32', '18', '1551351421', '1551351421', '{\"lat\": \"27.737658\", \"lng\": \"100.823321\"}', '{\"lat\": \"27.737658\", \"lng\": \"100.823321\"}', '1551351421', '1551351421', '0');
INSERT INTO `fence_alarm` VALUES ('33', '18', '1551351482', '1551351482', '{\"lat\": \"27.737578\", \"lng\": \"100.823082\"}', '{\"lat\": \"27.737578\", \"lng\": \"100.823082\"}', '1551351482', '1551351482', '0');
INSERT INTO `fence_alarm` VALUES ('34', '18', '1551351542', '1551351542', '{\"lat\": \"27.737604\", \"lng\": \"100.823118\"}', '{\"lat\": \"27.737604\", \"lng\": \"100.823118\"}', '1551351542', '1551351542', '0');
INSERT INTO `fence_alarm` VALUES ('35', '18', '1551351602', '1551351602', '{\"lat\": \"27.737637\", \"lng\": \"100.823277\"}', '{\"lat\": \"27.737637\", \"lng\": \"100.823277\"}', '1551351602', '1551351602', '0');
INSERT INTO `fence_alarm` VALUES ('36', '18', '1551351662', '1551351662', '{\"lat\": \"27.737598\", \"lng\": \"100.823159\"}', '{\"lat\": \"27.737598\", \"lng\": \"100.823159\"}', '1551351662', '1551351662', '0');
INSERT INTO `fence_alarm` VALUES ('37', '18', '1551351722', '1551351722', '{\"lat\": \"27.737590\", \"lng\": \"100.823177\"}', '{\"lat\": \"27.737590\", \"lng\": \"100.823177\"}', '1551351722', '1551351722', '0');
INSERT INTO `fence_alarm` VALUES ('38', '18', '1551351782', '1551351782', '{\"lat\": \"27.737610\", \"lng\": \"100.823197\"}', '{\"lat\": \"27.737610\", \"lng\": \"100.823197\"}', '1551351782', '1551351782', '0');
INSERT INTO `fence_alarm` VALUES ('39', '18', '1551351842', '1551351842', '{\"lat\": \"27.737599\", \"lng\": \"100.823235\"}', '{\"lat\": \"27.737599\", \"lng\": \"100.823235\"}', '1551351842', '1551351842', '0');
INSERT INTO `fence_alarm` VALUES ('40', '18', '1551351902', '1551351902', '{\"lat\": \"27.737623\", \"lng\": \"100.823237\"}', '{\"lat\": \"27.737623\", \"lng\": \"100.823237\"}', '1551351902', '1551351902', '0');
INSERT INTO `fence_alarm` VALUES ('41', '18', '1551351962', '1551351962', '{\"lat\": \"27.737616\", \"lng\": \"100.823271\"}', '{\"lat\": \"27.737616\", \"lng\": \"100.823271\"}', '1551351962', '1551351962', '0');
INSERT INTO `fence_alarm` VALUES ('42', '18', '1551352022', '1551352022', '{\"lat\": \"27.737609\", \"lng\": \"100.823195\"}', '{\"lat\": \"27.737609\", \"lng\": \"100.823195\"}', '1551352022', '1551352022', '0');
INSERT INTO `fence_alarm` VALUES ('43', '18', '1551352082', '1551352082', '{\"lat\": \"27.737624\", \"lng\": \"100.823206\"}', '{\"lat\": \"27.737624\", \"lng\": \"100.823206\"}', '1551352082', '1551352082', '0');
INSERT INTO `fence_alarm` VALUES ('44', '18', '1551352142', '1551352142', '{\"lat\": \"27.737583\", \"lng\": \"100.823146\"}', '{\"lat\": \"27.737583\", \"lng\": \"100.823146\"}', '1551352142', '1551352142', '0');
INSERT INTO `fence_alarm` VALUES ('45', '18', '1551352202', '1551352202', '{\"lat\": \"27.737620\", \"lng\": \"100.823226\"}', '{\"lat\": \"27.737620\", \"lng\": \"100.823226\"}', '1551352202', '1551352202', '0');
INSERT INTO `fence_alarm` VALUES ('46', '18', '1551352262', '1551352262', '{\"lat\": \"27.737613\", \"lng\": \"100.823226\"}', '{\"lat\": \"27.737613\", \"lng\": \"100.823226\"}', '1551352262', '1551352262', '0');
INSERT INTO `fence_alarm` VALUES ('47', '18', '1551352322', '1551352322', '{\"lat\": \"27.737616\", \"lng\": \"100.823159\"}', '{\"lat\": \"27.737616\", \"lng\": \"100.823159\"}', '1551352322', '1551352322', '0');
INSERT INTO `fence_alarm` VALUES ('48', '18', '1551352382', '1551352382', '{\"lat\": \"27.737598\", \"lng\": \"100.823222\"}', '{\"lat\": \"27.737598\", \"lng\": \"100.823222\"}', '1551352382', '1551352382', '0');
INSERT INTO `fence_alarm` VALUES ('49', '18', '1551352442', '1551352442', '{\"lat\": \"27.737617\", \"lng\": \"100.823239\"}', '{\"lat\": \"27.737617\", \"lng\": \"100.823239\"}', '1551352442', '1551352442', '0');
INSERT INTO `fence_alarm` VALUES ('50', '18', '1551352502', '1551352502', '{\"lat\": \"27.737644\", \"lng\": \"100.823280\"}', '{\"lat\": \"27.737644\", \"lng\": \"100.823280\"}', '1551352502', '1551352502', '0');
INSERT INTO `fence_alarm` VALUES ('51', '18', '1551352562', '1551352562', '{\"lat\": \"27.737590\", \"lng\": \"100.823222\"}', '{\"lat\": \"27.737590\", \"lng\": \"100.823222\"}', '1551352562', '1551352562', '0');
INSERT INTO `fence_alarm` VALUES ('52', '18', '1551352622', '1551352622', '{\"lat\": \"27.737649\", \"lng\": \"100.823272\"}', '{\"lat\": \"27.737649\", \"lng\": \"100.823272\"}', '1551352622', '1551352622', '0');
INSERT INTO `fence_alarm` VALUES ('53', '18', '1551352682', '1551352682', '{\"lat\": \"27.737663\", \"lng\": \"100.823198\"}', '{\"lat\": \"27.737663\", \"lng\": \"100.823198\"}', '1551352682', '1551352682', '0');
INSERT INTO `fence_alarm` VALUES ('54', '18', '1551352768', '1551352768', '{\"lat\": \"27.737833\", \"lng\": \"100.823218\"}', '{\"lat\": \"27.737833\", \"lng\": \"100.823218\"}', '1551352768', '1551352768', '0');
INSERT INTO `fence_alarm` VALUES ('55', '18', '1551352802', '1551352802', '{\"lat\": \"27.737684\", \"lng\": \"100.823178\"}', '{\"lat\": \"27.737684\", \"lng\": \"100.823178\"}', '1551352802', '1551352802', '0');
INSERT INTO `fence_alarm` VALUES ('56', '18', '1551352862', '1551352862', '{\"lat\": \"27.737611\", \"lng\": \"100.823154\"}', '{\"lat\": \"27.737611\", \"lng\": \"100.823154\"}', '1551352862', '1551352862', '0');
INSERT INTO `fence_alarm` VALUES ('57', '18', '1551352922', '1551352923', '{\"lat\": \"27.737673\", \"lng\": \"100.823169\"}', '{\"lat\": \"27.737673\", \"lng\": \"100.823169\"}', '1551352922', '1551352923', '0');
INSERT INTO `fence_alarm` VALUES ('58', '18', '1551352982', '1551352982', '{\"lat\": \"27.737721\", \"lng\": \"100.823213\"}', '{\"lat\": \"27.737721\", \"lng\": \"100.823213\"}', '1551352982', '1551352982', '0');
INSERT INTO `fence_alarm` VALUES ('59', '18', '1551353042', '1551353042', '{\"lat\": \"27.737645\", \"lng\": \"100.823217\"}', '{\"lat\": \"27.737645\", \"lng\": \"100.823217\"}', '1551353042', '1551353042', '0');
INSERT INTO `fence_alarm` VALUES ('60', '18', '1551353102', '1551353102', '{\"lat\": \"27.737605\", \"lng\": \"100.823214\"}', '{\"lat\": \"27.737605\", \"lng\": \"100.823214\"}', '1551353102', '1551353102', '0');
INSERT INTO `fence_alarm` VALUES ('61', '18', '1551353163', '1551353163', '{\"lat\": \"27.737571\", \"lng\": \"100.823208\"}', '{\"lat\": \"27.737571\", \"lng\": \"100.823208\"}', '1551353163', '1551353163', '0');
INSERT INTO `fence_alarm` VALUES ('62', '18', '1551353222', '1551353223', '{\"lat\": \"27.737593\", \"lng\": \"100.823173\"}', '{\"lat\": \"27.737593\", \"lng\": \"100.823173\"}', '1551353222', '1551353223', '0');
INSERT INTO `fence_alarm` VALUES ('63', '18', '1551353283', '1551353283', '{\"lat\": \"27.737598\", \"lng\": \"100.823177\"}', '{\"lat\": \"27.737598\", \"lng\": \"100.823177\"}', '1551353283', '1551353283', '0');
INSERT INTO `fence_alarm` VALUES ('64', '18', '1551353343', '1551353343', '{\"lat\": \"27.737597\", \"lng\": \"100.823216\"}', '{\"lat\": \"27.737597\", \"lng\": \"100.823216\"}', '1551353343', '1551353343', '0');
INSERT INTO `fence_alarm` VALUES ('65', '18', '1551353403', '1551353403', '{\"lat\": \"27.737592\", \"lng\": \"100.823230\"}', '{\"lat\": \"27.737592\", \"lng\": \"100.823230\"}', '1551353403', '1551353403', '0');
INSERT INTO `fence_alarm` VALUES ('66', '18', '1551353463', '1551353463', '{\"lat\": \"27.737627\", \"lng\": \"100.823214\"}', '{\"lat\": \"27.737627\", \"lng\": \"100.823214\"}', '1551353463', '1551353463', '0');
INSERT INTO `fence_alarm` VALUES ('67', '18', '1551353523', '1551353523', '{\"lat\": \"27.737659\", \"lng\": \"100.823201\"}', '{\"lat\": \"27.737659\", \"lng\": \"100.823201\"}', '1551353523', '1551353523', '0');
INSERT INTO `fence_alarm` VALUES ('68', '18', '1551353587', '1551353587', '{\"lat\": \"27.737619\", \"lng\": \"100.823136\"}', '{\"lat\": \"27.737619\", \"lng\": \"100.823136\"}', '1551353587', '1551353587', '0');
INSERT INTO `fence_alarm` VALUES ('69', '18', '1551353647', '1551353647', '{\"lat\": \"27.737605\", \"lng\": \"100.823217\"}', '{\"lat\": \"27.737605\", \"lng\": \"100.823217\"}', '1551353647', '1551353647', '0');
INSERT INTO `fence_alarm` VALUES ('70', '18', '1551353703', '1551353703', '{\"lat\": \"27.737633\", \"lng\": \"100.823193\"}', '{\"lat\": \"27.737633\", \"lng\": \"100.823193\"}', '1551353703', '1551353703', '0');
INSERT INTO `fence_alarm` VALUES ('71', '18', '1551353763', '1551353763', '{\"lat\": \"27.737602\", \"lng\": \"100.823180\"}', '{\"lat\": \"27.737602\", \"lng\": \"100.823180\"}', '1551353763', '1551353763', '0');
INSERT INTO `fence_alarm` VALUES ('72', '18', '1551353823', '1551353823', '{\"lat\": \"27.737564\", \"lng\": \"100.823199\"}', '{\"lat\": \"27.737564\", \"lng\": \"100.823199\"}', '1551353823', '1551353823', '0');
INSERT INTO `fence_alarm` VALUES ('73', '18', '1551353883', '1551353883', '{\"lat\": \"27.737575\", \"lng\": \"100.823178\"}', '{\"lat\": \"27.737575\", \"lng\": \"100.823178\"}', '1551353883', '1551353883', '0');
INSERT INTO `fence_alarm` VALUES ('74', '18', '1551355960', '1551355960', '{\"lat\": \"27.737587\", \"lng\": \"100.823279\"}', '{\"lat\": \"27.737587\", \"lng\": \"100.823279\"}', '1551355960', '1551355960', '0');
INSERT INTO `fence_alarm` VALUES ('75', '18', '1551356020', '1551356020', '{\"lat\": \"27.737551\", \"lng\": \"100.823149\"}', '{\"lat\": \"27.737551\", \"lng\": \"100.823149\"}', '1551356020', '1551356020', '0');
INSERT INTO `fence_alarm` VALUES ('76', '18', '1551356080', '1551356080', '{\"lat\": \"27.737505\", \"lng\": \"100.823149\"}', '{\"lat\": \"27.737505\", \"lng\": \"100.823149\"}', '1551356080', '1551356080', '0');
INSERT INTO `fence_alarm` VALUES ('77', '18', '1551356140', '1551356140', '{\"lat\": \"27.737573\", \"lng\": \"100.823103\"}', '{\"lat\": \"27.737573\", \"lng\": \"100.823103\"}', '1551356140', '1551356140', '0');
INSERT INTO `fence_alarm` VALUES ('78', '18', '1551356200', '1551356200', '{\"lat\": \"27.737611\", \"lng\": \"100.823163\"}', '{\"lat\": \"27.737611\", \"lng\": \"100.823163\"}', '1551356200', '1551356200', '0');
INSERT INTO `fence_alarm` VALUES ('79', '18', '1551356261', '1551356261', '{\"lat\": \"27.737584\", \"lng\": \"100.823169\"}', '{\"lat\": \"27.737584\", \"lng\": \"100.823169\"}', '1551356261', '1551356261', '0');
INSERT INTO `fence_alarm` VALUES ('80', '18', '1551356320', '1551356320', '{\"lat\": \"27.737574\", \"lng\": \"100.823187\"}', '{\"lat\": \"27.737574\", \"lng\": \"100.823187\"}', '1551356320', '1551356320', '0');
INSERT INTO `fence_alarm` VALUES ('81', '18', '1551356380', '1551356380', '{\"lat\": \"27.737613\", \"lng\": \"100.823136\"}', '{\"lat\": \"27.737613\", \"lng\": \"100.823136\"}', '1551356380', '1551356380', '0');
INSERT INTO `fence_alarm` VALUES ('82', '18', '1551361009', '1551361009', '{\"lat\": \"27.737648\", \"lng\": \"100.823357\"}', '{\"lat\": \"27.737648\", \"lng\": \"100.823357\"}', '1551361009', '1551361009', '0');
INSERT INTO `fence_alarm` VALUES ('83', '18', '1551361075', '1551361075', '{\"lat\": \"27.737592\", \"lng\": \"100.823092\"}', '{\"lat\": \"27.737592\", \"lng\": \"100.823092\"}', '1551361075', '1551361075', '0');
INSERT INTO `fence_alarm` VALUES ('84', '18', '1551361125', '1551361125', '{\"lat\": \"27.737535\", \"lng\": \"100.823155\"}', '{\"lat\": \"27.737535\", \"lng\": \"100.823155\"}', '1551361125', '1551361125', '0');
INSERT INTO `fence_alarm` VALUES ('85', '18', '1551361185', '1551361185', '{\"lat\": \"27.737496\", \"lng\": \"100.823118\"}', '{\"lat\": \"27.737496\", \"lng\": \"100.823118\"}', '1551361185', '1551361185', '0');
INSERT INTO `fence_alarm` VALUES ('86', '18', '1551361245', '1551361245', '{\"lat\": \"27.737605\", \"lng\": \"100.823288\"}', '{\"lat\": \"27.737605\", \"lng\": \"100.823288\"}', '1551361245', '1551361245', '0');
INSERT INTO `fence_alarm` VALUES ('87', '18', '1551366763', '1551366763', '{\"lat\": \"27.737606\", \"lng\": \"100.823196\"}', '{\"lat\": \"27.737606\", \"lng\": \"100.823196\"}', '1551366763', '1551366763', '0');
INSERT INTO `fence_alarm` VALUES ('88', '18', '1551366823', '1551366823', '{\"lat\": \"27.737490\", \"lng\": \"100.823196\"}', '{\"lat\": \"27.737490\", \"lng\": \"100.823196\"}', '1551366823', '1551366823', '0');
INSERT INTO `fence_alarm` VALUES ('89', '18', '1551366883', '1551366883', '{\"lat\": \"27.737513\", \"lng\": \"100.823197\"}', '{\"lat\": \"27.737513\", \"lng\": \"100.823197\"}', '1551366883', '1551366883', '0');
INSERT INTO `fence_alarm` VALUES ('90', '18', '1551366941', '1551366941', '{\"lat\": \"27.737496\", \"lng\": \"100.823196\"}', '{\"lat\": \"27.737496\", \"lng\": \"100.823196\"}', '1551366941', '1551366941', '0');
INSERT INTO `fence_alarm` VALUES ('91', '18', '1551367003', '1551367003', '{\"lat\": \"27.737562\", \"lng\": \"100.823207\"}', '{\"lat\": \"27.737562\", \"lng\": \"100.823207\"}', '1551367003', '1551367003', '0');
INSERT INTO `fence_alarm` VALUES ('92', '18', '1551367063', '1551367063', '{\"lat\": \"27.737301\", \"lng\": \"100.823098\"}', '{\"lat\": \"27.737301\", \"lng\": \"100.823098\"}', '1551367063', '1551367063', '0');
INSERT INTO `fence_alarm` VALUES ('93', '18', '1551367123', '1551367123', '{\"lat\": \"27.737412\", \"lng\": \"100.823186\"}', '{\"lat\": \"27.737412\", \"lng\": \"100.823186\"}', '1551367123', '1551367123', '0');
INSERT INTO `fence_alarm` VALUES ('94', '18', '1551367186', '1551367186', '{\"lat\": \"27.737415\", \"lng\": \"100.823192\"}', '{\"lat\": \"27.737415\", \"lng\": \"100.823192\"}', '1551367186', '1551367186', '0');
INSERT INTO `fence_alarm` VALUES ('95', '18', '1551367242', '1551367242', '{\"lat\": \"27.737406\", \"lng\": \"100.823121\"}', '{\"lat\": \"27.737406\", \"lng\": \"100.823121\"}', '1551367242', '1551367242', '0');
INSERT INTO `fence_alarm` VALUES ('96', '18', '1551367303', '1551367303', '{\"lat\": \"27.737588\", \"lng\": \"100.823210\"}', '{\"lat\": \"27.737588\", \"lng\": \"100.823210\"}', '1551367303', '1551367303', '0');
INSERT INTO `fence_alarm` VALUES ('97', '18', '1551367366', '1551367366', '{\"lat\": \"27.737700\", \"lng\": \"100.823233\"}', '{\"lat\": \"27.737700\", \"lng\": \"100.823233\"}', '1551367366', '1551367366', '0');
INSERT INTO `fence_alarm` VALUES ('98', '18', '1551367426', '1551367426', '{\"lat\": \"27.737523\", \"lng\": \"100.823172\"}', '{\"lat\": \"27.737523\", \"lng\": \"100.823172\"}', '1551367426', '1551367426', '0');
INSERT INTO `fence_alarm` VALUES ('99', '18', '1551367486', '1551367486', '{\"lat\": \"27.737531\", \"lng\": \"100.823209\"}', '{\"lat\": \"27.737531\", \"lng\": \"100.823209\"}', '1551367486', '1551367486', '0');
INSERT INTO `fence_alarm` VALUES ('100', '18', '1551367545', '1551367545', '{\"lat\": \"27.737585\", \"lng\": \"100.823217\"}', '{\"lat\": \"27.737585\", \"lng\": \"100.823217\"}', '1551367545', '1551367545', '0');
INSERT INTO `fence_alarm` VALUES ('101', '18', '1551367609', '1551367609', '{\"lat\": \"27.737496\", \"lng\": \"100.823201\"}', '{\"lat\": \"27.737496\", \"lng\": \"100.823201\"}', '1551367609', '1551367609', '0');
INSERT INTO `fence_alarm` VALUES ('102', '18', '1551367666', '1551367666', '{\"lat\": \"27.737447\", \"lng\": \"100.823141\"}', '{\"lat\": \"27.737447\", \"lng\": \"100.823141\"}', '1551367666', '1551367666', '0');
INSERT INTO `fence_alarm` VALUES ('103', '18', '1551367732', '1551367732', '{\"lat\": \"27.737428\", \"lng\": \"100.823236\"}', '{\"lat\": \"27.737428\", \"lng\": \"100.823236\"}', '1551367732', '1551367732', '0');
INSERT INTO `fence_alarm` VALUES ('104', '18', '1551367789', '1551367789', '{\"lat\": \"27.737418\", \"lng\": \"100.823215\"}', '{\"lat\": \"27.737418\", \"lng\": \"100.823215\"}', '1551367789', '1551367789', '0');
INSERT INTO `fence_alarm` VALUES ('105', '18', '1551367848', '1551367848', '{\"lat\": \"27.737614\", \"lng\": \"100.823241\"}', '{\"lat\": \"27.737614\", \"lng\": \"100.823241\"}', '1551367848', '1551367848', '0');
INSERT INTO `fence_alarm` VALUES ('106', '18', '1551367906', '1551367906', '{\"lat\": \"27.737451\", \"lng\": \"100.823220\"}', '{\"lat\": \"27.737451\", \"lng\": \"100.823220\"}', '1551367906', '1551367906', '0');
INSERT INTO `fence_alarm` VALUES ('107', '18', '1551367966', '1551367966', '{\"lat\": \"27.737516\", \"lng\": \"100.823165\"}', '{\"lat\": \"27.737516\", \"lng\": \"100.823165\"}', '1551367966', '1551367966', '0');
INSERT INTO `fence_alarm` VALUES ('108', '18', '1551368029', '1551368029', '{\"lat\": \"27.737537\", \"lng\": \"100.823199\"}', '{\"lat\": \"27.737537\", \"lng\": \"100.823199\"}', '1551368029', '1551368029', '0');
INSERT INTO `fence_alarm` VALUES ('109', '18', '1551368086', '1551368086', '{\"lat\": \"27.737275\", \"lng\": \"100.823218\"}', '{\"lat\": \"27.737275\", \"lng\": \"100.823218\"}', '1551368086', '1551368086', '0');
INSERT INTO `fence_alarm` VALUES ('110', '18', '1551368149', '1551368149', '{\"lat\": \"27.737510\", \"lng\": \"100.823317\"}', '{\"lat\": \"27.737510\", \"lng\": \"100.823317\"}', '1551368149', '1551368149', '0');
INSERT INTO `fence_alarm` VALUES ('111', '18', '1551368218', '1551368218', '{\"lat\": \"27.736580\", \"lng\": \"100.823014\"}', '{\"lat\": \"27.736580\", \"lng\": \"100.823014\"}', '1551368218', '1551368218', '0');
INSERT INTO `fence_alarm` VALUES ('112', '18', '1551368270', '1551368270', '{\"lat\": \"27.737292\", \"lng\": \"100.823171\"}', '{\"lat\": \"27.737292\", \"lng\": \"100.823171\"}', '1551368270', '1551368270', '0');
INSERT INTO `fence_alarm` VALUES ('113', '18', '1551368329', '1551368329', '{\"lat\": \"27.737356\", \"lng\": \"100.823216\"}', '{\"lat\": \"27.737356\", \"lng\": \"100.823216\"}', '1551368329', '1551368329', '0');
INSERT INTO `fence_alarm` VALUES ('114', '18', '1551368386', '1551368386', '{\"lat\": \"27.737457\", \"lng\": \"100.823196\"}', '{\"lat\": \"27.737457\", \"lng\": \"100.823196\"}', '1551368386', '1551368386', '0');
INSERT INTO `fence_alarm` VALUES ('115', '18', '1551368444', '1551368444', '{\"lat\": \"27.737441\", \"lng\": \"100.823186\"}', '{\"lat\": \"27.737441\", \"lng\": \"100.823186\"}', '1551368444', '1551368444', '0');
INSERT INTO `fence_alarm` VALUES ('116', '18', '1551368569', '1551368569', '{\"lat\": \"27.737408\", \"lng\": \"100.823191\"}', '{\"lat\": \"27.737408\", \"lng\": \"100.823191\"}', '1551368569', '1551368569', '0');
INSERT INTO `fence_alarm` VALUES ('117', '18', '1551368632', '1551368632', '{\"lat\": \"27.737172\", \"lng\": \"100.823152\"}', '{\"lat\": \"27.737172\", \"lng\": \"100.823152\"}', '1551368632', '1551368632', '0');
INSERT INTO `fence_alarm` VALUES ('118', '18', '1551368689', '1551368689', '{\"lat\": \"27.737358\", \"lng\": \"100.823180\"}', '{\"lat\": \"27.737358\", \"lng\": \"100.823180\"}', '1551368689', '1551368689', '0');
INSERT INTO `fence_alarm` VALUES ('119', '18', '1551368746', '1551368746', '{\"lat\": \"27.737162\", \"lng\": \"100.823147\"}', '{\"lat\": \"27.737162\", \"lng\": \"100.823147\"}', '1551368746', '1551368746', '0');
INSERT INTO `fence_alarm` VALUES ('120', '18', '1551368806', '1551368806', '{\"lat\": \"27.737404\", \"lng\": \"100.823145\"}', '{\"lat\": \"27.737404\", \"lng\": \"100.823145\"}', '1551368806', '1551368806', '0');
INSERT INTO `fence_alarm` VALUES ('121', '18', '1551368866', '1551368866', '{\"lat\": \"27.737462\", \"lng\": \"100.823143\"}', '{\"lat\": \"27.737462\", \"lng\": \"100.823143\"}', '1551368866', '1551368866', '0');
INSERT INTO `fence_alarm` VALUES ('122', '18', '1551368935', '1551368935', '{\"lat\": \"27.737664\", \"lng\": \"100.823191\"}', '{\"lat\": \"27.737664\", \"lng\": \"100.823191\"}', '1551368935', '1551368935', '0');
INSERT INTO `fence_alarm` VALUES ('123', '18', '1551369000', '1551369000', '{\"lat\": \"27.737322\", \"lng\": \"100.823134\"}', '{\"lat\": \"27.737322\", \"lng\": \"100.823134\"}', '1551369000', '1551369000', '0');
INSERT INTO `fence_alarm` VALUES ('124', '18', '1551369059', '1551369059', '{\"lat\": \"27.737368\", \"lng\": \"100.823154\"}', '{\"lat\": \"27.737368\", \"lng\": \"100.823154\"}', '1551369059', '1551369059', '0');
INSERT INTO `fence_alarm` VALUES ('125', '18', '1551369115', '1551369115', '{\"lat\": \"27.737231\", \"lng\": \"100.823177\"}', '{\"lat\": \"27.737231\", \"lng\": \"100.823177\"}', '1551369115', '1551369115', '0');
INSERT INTO `fence_alarm` VALUES ('126', '18', '1551369172', '1551369172', '{\"lat\": \"27.737319\", \"lng\": \"100.823146\"}', '{\"lat\": \"27.737319\", \"lng\": \"100.823146\"}', '1551369172', '1551369172', '0');
INSERT INTO `fence_alarm` VALUES ('127', '18', '1551369232', '1551369232', '{\"lat\": \"27.737133\", \"lng\": \"100.823173\"}', '{\"lat\": \"27.737133\", \"lng\": \"100.823173\"}', '1551369232', '1551369232', '0');
INSERT INTO `fence_alarm` VALUES ('128', '18', '1551369292', '1551369292', '{\"lat\": \"27.737434\", \"lng\": \"100.823142\"}', '{\"lat\": \"27.737434\", \"lng\": \"100.823142\"}', '1551369292', '1551369292', '0');
INSERT INTO `fence_alarm` VALUES ('129', '18', '1551369349', '1551369349', '{\"lat\": \"27.737823\", \"lng\": \"100.823227\"}', '{\"lat\": \"27.737823\", \"lng\": \"100.823227\"}', '1551369349', '1551369349', '0');
INSERT INTO `fence_alarm` VALUES ('130', '18', '1551369556', '1551369556', '{\"lat\": \"27.737578\", \"lng\": \"100.823200\"}', '{\"lat\": \"27.737578\", \"lng\": \"100.823200\"}', '1551369556', '1551369556', '0');
INSERT INTO `fence_alarm` VALUES ('131', '18', '1551369616', '1551369616', '{\"lat\": \"27.737490\", \"lng\": \"100.823227\"}', '{\"lat\": \"27.737490\", \"lng\": \"100.823227\"}', '1551369616', '1551369616', '0');
INSERT INTO `fence_alarm` VALUES ('132', '18', '1551369676', '1551369676', '{\"lat\": \"27.738058\", \"lng\": \"100.823421\"}', '{\"lat\": \"27.738058\", \"lng\": \"100.823421\"}', '1551369676', '1551369676', '0');
INSERT INTO `fence_alarm` VALUES ('133', '18', '1551369736', '1551369736', '{\"lat\": \"27.737755\", \"lng\": \"100.823282\"}', '{\"lat\": \"27.737755\", \"lng\": \"100.823282\"}', '1551369736', '1551369736', '0');
INSERT INTO `fence_alarm` VALUES ('134', '18', '1551369796', '1551369796', '{\"lat\": \"27.737556\", \"lng\": \"100.823153\"}', '{\"lat\": \"27.737556\", \"lng\": \"100.823153\"}', '1551369796', '1551369796', '0');
INSERT INTO `fence_alarm` VALUES ('135', '18', '1551369857', '1551369857', '{\"lat\": \"27.737805\", \"lng\": \"100.823295\"}', '{\"lat\": \"27.737805\", \"lng\": \"100.823295\"}', '1551369857', '1551369857', '0');
INSERT INTO `fence_alarm` VALUES ('136', '18', '1551369916', '1551369916', '{\"lat\": \"27.737572\", \"lng\": \"100.823192\"}', '{\"lat\": \"27.737572\", \"lng\": \"100.823192\"}', '1551369916', '1551369916', '0');
INSERT INTO `fence_alarm` VALUES ('137', '18', '1551369976', '1551369976', '{\"lat\": \"27.737600\", \"lng\": \"100.823195\"}', '{\"lat\": \"27.737600\", \"lng\": \"100.823195\"}', '1551369976', '1551369976', '0');
INSERT INTO `fence_alarm` VALUES ('138', '18', '1551370036', '1551370036', '{\"lat\": \"27.736769\", \"lng\": \"100.822731\"}', '{\"lat\": \"27.736769\", \"lng\": \"100.822731\"}', '1551370036', '1551370036', '0');
INSERT INTO `fence_alarm` VALUES ('139', '18', '1551370096', '1551370096', '{\"lat\": \"27.737731\", \"lng\": \"100.823256\"}', '{\"lat\": \"27.737731\", \"lng\": \"100.823256\"}', '1551370096', '1551370096', '0');
INSERT INTO `fence_alarm` VALUES ('140', '18', '1551370157', '1551370157', '{\"lat\": \"27.737692\", \"lng\": \"100.823275\"}', '{\"lat\": \"27.737692\", \"lng\": \"100.823275\"}', '1551370157', '1551370157', '0');
INSERT INTO `fence_alarm` VALUES ('141', '18', '1551370216', '1551370216', '{\"lat\": \"27.737811\", \"lng\": \"100.823294\"}', '{\"lat\": \"27.737811\", \"lng\": \"100.823294\"}', '1551370216', '1551370216', '0');
INSERT INTO `fence_alarm` VALUES ('142', '18', '1551370277', '1551370277', '{\"lat\": \"27.737862\", \"lng\": \"100.823310\"}', '{\"lat\": \"27.737862\", \"lng\": \"100.823310\"}', '1551370277', '1551370277', '0');
INSERT INTO `fence_alarm` VALUES ('143', '18', '1551370336', '1551370336', '{\"lat\": \"27.737606\", \"lng\": \"100.823197\"}', '{\"lat\": \"27.737606\", \"lng\": \"100.823197\"}', '1551370336', '1551370336', '0');
INSERT INTO `fence_alarm` VALUES ('144', '18', '1551370397', '1551370397', '{\"lat\": \"27.737530\", \"lng\": \"100.823172\"}', '{\"lat\": \"27.737530\", \"lng\": \"100.823172\"}', '1551370397', '1551370397', '0');
INSERT INTO `fence_alarm` VALUES ('145', '18', '1551370457', '1551370457', '{\"lat\": \"27.737548\", \"lng\": \"100.823187\"}', '{\"lat\": \"27.737548\", \"lng\": \"100.823187\"}', '1551370457', '1551370457', '0');
INSERT INTO `fence_alarm` VALUES ('146', '18', '1551370517', '1551370517', '{\"lat\": \"27.737515\", \"lng\": \"100.823213\"}', '{\"lat\": \"27.737515\", \"lng\": \"100.823213\"}', '1551370517', '1551370517', '0');
INSERT INTO `fence_alarm` VALUES ('147', '18', '1551370577', '1551370577', '{\"lat\": \"27.737615\", \"lng\": \"100.823218\"}', '{\"lat\": \"27.737615\", \"lng\": \"100.823218\"}', '1551370577', '1551370577', '0');
INSERT INTO `fence_alarm` VALUES ('148', '18', '1551370637', '1551370637', '{\"lat\": \"27.737532\", \"lng\": \"100.823185\"}', '{\"lat\": \"27.737532\", \"lng\": \"100.823185\"}', '1551370637', '1551370637', '0');
INSERT INTO `fence_alarm` VALUES ('149', '18', '1551370698', '1551370698', '{\"lat\": \"27.737588\", \"lng\": \"100.823191\"}', '{\"lat\": \"27.737588\", \"lng\": \"100.823191\"}', '1551370698', '1551370698', '0');
INSERT INTO `fence_alarm` VALUES ('150', '18', '1551370757', '1551370757', '{\"lat\": \"27.737609\", \"lng\": \"100.823216\"}', '{\"lat\": \"27.737609\", \"lng\": \"100.823216\"}', '1551370757', '1551370757', '0');
INSERT INTO `fence_alarm` VALUES ('151', '18', '1551370817', '1551370817', '{\"lat\": \"27.737566\", \"lng\": \"100.823180\"}', '{\"lat\": \"27.737566\", \"lng\": \"100.823180\"}', '1551370817', '1551370817', '0');
INSERT INTO `fence_alarm` VALUES ('152', '18', '1551370877', '1551370877', '{\"lat\": \"27.737563\", \"lng\": \"100.823151\"}', '{\"lat\": \"27.737563\", \"lng\": \"100.823151\"}', '1551370877', '1551370877', '0');
INSERT INTO `fence_alarm` VALUES ('153', '18', '1551370937', '1551370937', '{\"lat\": \"27.737559\", \"lng\": \"100.823196\"}', '{\"lat\": \"27.737559\", \"lng\": \"100.823196\"}', '1551370937', '1551370937', '0');
INSERT INTO `fence_alarm` VALUES ('154', '18', '1551370997', '1551370997', '{\"lat\": \"27.737654\", \"lng\": \"100.823225\"}', '{\"lat\": \"27.737654\", \"lng\": \"100.823225\"}', '1551370997', '1551370997', '0');
INSERT INTO `fence_alarm` VALUES ('155', '18', '1551371057', '1551371057', '{\"lat\": \"27.737606\", \"lng\": \"100.823210\"}', '{\"lat\": \"27.737606\", \"lng\": \"100.823210\"}', '1551371057', '1551371057', '0');
INSERT INTO `fence_alarm` VALUES ('156', '18', '1551371117', '1551371117', '{\"lat\": \"27.737595\", \"lng\": \"100.823219\"}', '{\"lat\": \"27.737595\", \"lng\": \"100.823219\"}', '1551371117', '1551371117', '0');
INSERT INTO `fence_alarm` VALUES ('157', '18', '1551371177', '1551371177', '{\"lat\": \"27.737548\", \"lng\": \"100.823105\"}', '{\"lat\": \"27.737548\", \"lng\": \"100.823105\"}', '1551371177', '1551371177', '0');
INSERT INTO `fence_alarm` VALUES ('158', '18', '1551371237', '1551371237', '{\"lat\": \"27.737524\", \"lng\": \"100.823150\"}', '{\"lat\": \"27.737524\", \"lng\": \"100.823150\"}', '1551371237', '1551371237', '0');
INSERT INTO `fence_alarm` VALUES ('159', '18', '1551371297', '1551371297', '{\"lat\": \"27.737598\", \"lng\": \"100.823153\"}', '{\"lat\": \"27.737598\", \"lng\": \"100.823153\"}', '1551371297', '1551371297', '0');
INSERT INTO `fence_alarm` VALUES ('160', '18', '1551371357', '1551371357', '{\"lat\": \"27.737550\", \"lng\": \"100.823145\"}', '{\"lat\": \"27.737550\", \"lng\": \"100.823145\"}', '1551371357', '1551371357', '0');
INSERT INTO `fence_alarm` VALUES ('161', '18', '1551371417', '1551371417', '{\"lat\": \"27.737511\", \"lng\": \"100.823218\"}', '{\"lat\": \"27.737511\", \"lng\": \"100.823218\"}', '1551371417', '1551371417', '0');
INSERT INTO `fence_alarm` VALUES ('162', '18', '1551371477', '1551371477', '{\"lat\": \"27.737505\", \"lng\": \"100.823202\"}', '{\"lat\": \"27.737505\", \"lng\": \"100.823202\"}', '1551371477', '1551371477', '0');
INSERT INTO `fence_alarm` VALUES ('163', '18', '1551371537', '1551371537', '{\"lat\": \"27.737521\", \"lng\": \"100.823175\"}', '{\"lat\": \"27.737521\", \"lng\": \"100.823175\"}', '1551371537', '1551371537', '0');
INSERT INTO `fence_alarm` VALUES ('164', '18', '1551403845', '1551403845', '{\"lat\": \"27.737621\", \"lng\": \"100.823181\"}', '{\"lat\": \"27.737621\", \"lng\": \"100.823181\"}', '1551403845', '1551403845', '0');

-- ----------------------------
-- Table structure for fence_bicycles
-- ----------------------------
DROP TABLE IF EXISTS `fence_bicycles`;
CREATE TABLE `fence_bicycles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fence_id` int(11) DEFAULT NULL,
  `bicycle_id` int(11) DEFAULT NULL,
  `created` int(255) DEFAULT '0',
  `updated` int(11) DEFAULT '0',
  `deleted` int(255) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fence_bicycles
-- ----------------------------
INSERT INTO `fence_bicycles` VALUES ('1', '13', '5', '1550673476', '1550673476', '0');
INSERT INTO `fence_bicycles` VALUES ('2', '14', '5', '1550673476', '1550673476', '0');
INSERT INTO `fence_bicycles` VALUES ('3', '15', '6', '1551019908', '1551019908', '0');

-- ----------------------------
-- Table structure for fences
-- ----------------------------
DROP TABLE IF EXISTS `fences`;
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

-- ----------------------------
-- Records of fences
-- ----------------------------
INSERT INTO `fences` VALUES ('1', '阿萨德', '[{\"lat\": 29.547881, \"lng\": 106.516717}, {\"lat\": 29.536758, \"lng\": 106.52031}, {\"lat\": 29.538895, \"lng\": 106.531378}, {\"lat\": 29.546373, \"lng\": 106.52915}]', null, '1550663686', '1550663686', '1550664574');
INSERT INTO `fences` VALUES ('2', '1', '[{\"lat\": 29.550018, \"lng\": 106.501194}, {\"lat\": 29.537638, \"lng\": 106.50335}, {\"lat\": 29.542917, \"lng\": 106.505794}, {\"lat\": 29.546247, \"lng\": 106.506584}, {\"lat\": 29.548321, \"lng\": 106.505003}, {\"lat\": 29.545933, \"lng\": 106.504213}]', null, '1550663761', '1550663761', '0');
INSERT INTO `fences` VALUES ('3', '2', '[{\"lat\": 29.546876, \"lng\": 106.512046}, {\"lat\": 29.539272, \"lng\": 106.514418}, {\"lat\": 29.541283, \"lng\": 106.516861}, {\"lat\": 29.542602, \"lng\": 106.515567}, {\"lat\": 29.544111, \"lng\": 106.517651}, {\"lat\": 29.547001, \"lng\": 106.518729}, {\"lat\": 29.54543, \"lng\": 106.521173}, {\"lat\": 29.549578, \"lng\": 106.52067}, {\"lat\": 29.55096, \"lng\": 106.517005}, {\"lat\": 29.548635, \"lng\": 106.517508}, {\"lat\": 29.548447, \"lng\": 106.515208}, {\"lat\": 29.549955, \"lng\": 106.514202}, {\"lat\": 29.552971, \"lng\": 106.511974}, {\"lat\": 29.551212, \"lng\": 106.511399}, {\"lat\": 29.550395, \"lng\": 106.512333}, {\"lat\": 29.549955, \"lng\": 106.510896}, {\"lat\": 29.54851, \"lng\": 106.511974}, {\"lat\": 29.548321, \"lng\": 106.510752}, {\"lat\": 29.54719, \"lng\": 106.510465}]', null, '1550663761', '1550663761', '0');
INSERT INTO `fences` VALUES ('4', '3', '[{\"lat\": 29.547881, \"lng\": 106.530156}, {\"lat\": 29.544676, \"lng\": 106.530156}, {\"lat\": 29.54122, \"lng\": 106.528359}, {\"lat\": 29.541346, \"lng\": 106.523329}, {\"lat\": 29.547818, \"lng\": 106.523688}, {\"lat\": 29.552908, \"lng\": 106.525341}, {\"lat\": 29.553977, \"lng\": 106.532527}, {\"lat\": 29.555233, \"lng\": 106.525053}, {\"lat\": 29.550583, \"lng\": 106.539498}, {\"lat\": 29.559066, \"lng\": 106.530587}, {\"lat\": 29.545619, \"lng\": 106.533246}, {\"lat\": 29.548007, \"lng\": 106.539283}]', null, '1550663761', '1550663761', '0');
INSERT INTO `fences` VALUES ('5', 'asdf', '[{\"lat\": 29.55184, \"lng\": 106.510537}, {\"lat\": 29.543105, \"lng\": 106.512262}, {\"lat\": 29.543671, \"lng\": 106.524694}, {\"lat\": 29.549452, \"lng\": 106.518298}, {\"lat\": 29.552468, \"lng\": 106.51837}, {\"lat\": 29.547693, \"lng\": 106.515783}, {\"lat\": 29.550709, \"lng\": 106.513483}, {\"lat\": 29.552343, \"lng\": 106.529222}]', null, '1550665886', '1550665886', '0');
INSERT INTO `fences` VALUES ('6', 'xcvbb', '[{\"lat\": 29.549201, \"lng\": 106.508381}, {\"lat\": 29.541534, \"lng\": 106.506728}, {\"lat\": 29.543671, \"lng\": 106.523904}, {\"lat\": 29.550709, \"lng\": 106.519592}, {\"lat\": 29.553788, \"lng\": 106.515424}, {\"lat\": 29.546562, \"lng\": 106.515496}, {\"lat\": 29.548635, \"lng\": 106.512477}, {\"lat\": 29.552908, \"lng\": 106.511902}, {\"lat\": 29.555296, \"lng\": 106.510178}, {\"lat\": 29.566983, \"lng\": 106.50759}]', null, '1550668625', '1550668625', '1550668683');
INSERT INTO `fences` VALUES ('13', 'asdzc', '[{\"lat\": 29.54719, \"lng\": 106.504824}, {\"lat\": 29.543357, \"lng\": 106.505902}, {\"lat\": 29.543734, \"lng\": 106.511507}, {\"lat\": 29.544613, \"lng\": 106.509639}]', '42', '1550673476', '1550673476', '0');
INSERT INTO `fences` VALUES ('14', 'wqeyh', '[{\"lat\": 29.549201, \"lng\": 106.520274}, {\"lat\": 29.551652, \"lng\": 106.521927}, {\"lat\": 29.548887, \"lng\": 106.525449}, {\"lat\": 29.547316, \"lng\": 106.523077}, {\"lat\": 29.543859, \"lng\": 106.522933}, {\"lat\": 29.542351, \"lng\": 106.519125}]', '43', '1550673476', '1550673476', '0');
INSERT INTO `fences` VALUES ('15', '测试电子围栏', '[{\"lat\": 29.6175, \"lng\": 106.298887}, {\"lat\": 29.61706, \"lng\": 106.298734}, {\"lat\": 29.616715, \"lng\": 106.300064}, {\"lat\": 29.61706, \"lng\": 106.300297}, {\"lat\": 29.617837, \"lng\": 106.299723}]', '44', '1551019908', '1551019908', '0');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('1', 'OR201902245c7181ce9e3b6', '6', '1550942670', '1550942737', '1.12', '4', '{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"0.00\", \"token\": \"824DMW00LRCYAXHXNMLVW2DVK4UGSOSRHB6WQ4JFKKJG6FTEOELTU9VK7G3H40667BAULRLADOQ5OY6GS5WP5WC1U3KVIUHFL0QOX0LJNWUAF2QQOQ5F79EMB1PMQ4TB\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}', '{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}', '1550942670', '1550942670', '0', null, '1', '0');
INSERT INTO `orders` VALUES ('2', 'OR201902245c7182b2a6ffc', '6', '1550942898', '1550943132', '4.00', '4', '{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"0.00\", \"token\": \"824DMW00LRCYAXHXNMLVW2DVK4UGSOSRHB6WQ4JFKKJG6FTEOELTU9VK7G3H40667BAULRLADOQ5OY6GS5WP5WC1U3KVIUHFL0QOX0LJNWUAF2QQOQ5F79EMB1PMQ4TB\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}', '{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}', '1550942898', '1550942898', '0', null, '1', '0');
INSERT INTO `orders` VALUES ('7', 'OR201902245c7188c421b58', '6', '1550944452', '1550981087', '611.00', '4', '{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"0.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}', '{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}', '1550944452', '1550944452', '0', null, '1', '0');
INSERT INTO `orders` VALUES ('8', 'OR201902245c7217f938388', '6', '1550981113', '1550990784', '162.00', '3', '{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"0.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}', '{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}', '1550981113', '1550981113', '0', null, '1', '641');
INSERT INTO `orders` VALUES ('11', 'OR201902245c723d97ef457', '6', '1550990743', '1550990907', '3.00', '3', '{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"0.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}', '{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}', '1550990743', '1550990743', '0', null, '1', '0');
INSERT INTO `orders` VALUES ('12', 'OR201902245c723ead3d650', '6', '1550991021', '1551010598', '327.00', '3', '{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"0.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}', '{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}', '1550991021', '1550991021', '0', null, '1', '0');
INSERT INTO `orders` VALUES ('13', 'OR201902245c728b50578ae', '6', '1551010640', '1551010689', '1.00', '3', '{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"0.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}', '{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}', '1551010640', '1551010640', '0', null, '1', '0');
INSERT INTO `orders` VALUES ('14', 'OR201902245c729619a1934', '6', '1551013401', '1551013417', '1.00', '4', '{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"499669.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}', '{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}', '1551013401', '1551013401', '0', null, '1', '0');
INSERT INTO `orders` VALUES ('15', 'OR201902245c72966fa0549', '6', '1551013487', '1551013490', '1.00', '3', '{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"499669.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}', '{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}', '1551013487', '1551013487', '0', null, '1', '0');
INSERT INTO `orders` VALUES ('16', 'OR201902245c729a2f0b9c0', '6', '1551014447', '1551017793', '0.00', '2', '{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"499506.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}', '{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}', '1551014447', '1551014447', '0', '123456789', '1', '0');
INSERT INTO `orders` VALUES ('18', 'OR201902285c77ab1ccecdb', '6', '1551346460', '1551403890', '958.00', '3', '{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"499506.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}', '{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}', '1551346460', '1551346460', '0', null, '1', '0');
INSERT INTO `orders` VALUES ('19', 'OR201903015c788b9b0b80a', '6', '1551403931', '1551403944', '1.00', '3', '{\"id\": 1, \"nick\": \"蔡正军\", \"money\": \"498548.00\", \"mobile\": null, \"openid\": \"ovJH64q6DhFNbwGVWB2OlKgkrxW8\", \"created\": \"2019-02-23 19:12:41\", \"deleted\": 0, \"updated\": \"2019-02-23 19:12:41\"}', '{\"id\": 6, \"status\": {\"status\": 2, \"status_info\": \"使用中\"}, \"created\": \"2019-02-23 20:58:39\", \"deleted\": 0, \"updated\": \"2019-02-23 21:04:56\", \"dailyPrice\": \"1440.00\", \"hourlyPrice\": \"60.00\", \"lock_number\": \"866160033560827\", \"bicycle_name\": \"可以随意调用接口的车\", \"bicycle_number\": \"001\"}', '1551403931', '1551403931', '0', null, '1', '0');

-- ----------------------------
-- Table structure for system_info
-- ----------------------------
DROP TABLE IF EXISTS `system_info`;
CREATE TABLE `system_info` (
  `yingyanAk` varchar(128) DEFAULT NULL COMMENT '百度鹰眼服务ak',
  `service_id` varchar(15) DEFAULT NULL COMMENT '百度鹰眼轨迹服务service_id',
  `browerAk` varchar(128) DEFAULT NULL,
  `wx_appid` varchar(50) DEFAULT NULL,
  `wx_appsecret` varchar(128) DEFAULT NULL,
  `lock_token` varchar(128) DEFAULT NULL,
  `tencent_map_key` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of system_info
-- ----------------------------
INSERT INTO `system_info` VALUES ('ySWPa1ipCqxDgcYphFvIbZWcN6gG1VRR', '208795', 'XhyLag9s3zKpfr3t05TuDGVzd91Z5HjC', 'wxa4930391436e886d', '5696395d5659d0dc23bbb450f8f6ff07', '48A91502513526909A5D91A10BB1E39D', 'QQ5BZ-25JW3-CFH3X-37TXW-BCPN5-BLFQM');
