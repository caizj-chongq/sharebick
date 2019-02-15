/*
Navicat MySQL Data Transfer

Source Server         : homestead
Source Server Version : 50719
Source Host           : 192.168.10.10:3306
Source Database       : sharebicycle

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2019-02-15 16:13:09
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
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of admin_group_navigate
-- ----------------------------
INSERT INTO `admin_group_navigate` VALUES ('54', '2', '5');
INSERT INTO `admin_group_navigate` VALUES ('5', '2', '6');
INSERT INTO `admin_group_navigate` VALUES ('9', '2', '7');
INSERT INTO `admin_group_navigate` VALUES ('14', '2', '8');
INSERT INTO `admin_group_navigate` VALUES ('21', '2', '8');
INSERT INTO `admin_group_navigate` VALUES ('64', '3', '5');
INSERT INTO `admin_group_navigate` VALUES ('6', '3', '6');
INSERT INTO `admin_group_navigate` VALUES ('10', '3', '7');
INSERT INTO `admin_group_navigate` VALUES ('15', '3', '8');
INSERT INTO `admin_group_navigate` VALUES ('57', '4', '5');
INSERT INTO `admin_group_navigate` VALUES ('11', '4', '7');
INSERT INTO `admin_group_navigate` VALUES ('16', '4', '8');
INSERT INTO `admin_group_navigate` VALUES ('65', '5', '5');
INSERT INTO `admin_group_navigate` VALUES ('66', '6', '5');
INSERT INTO `admin_group_navigate` VALUES ('55', '8', '5');
INSERT INTO `admin_group_navigate` VALUES ('7', '8', '6');
INSERT INTO `admin_group_navigate` VALUES ('12', '8', '7');
INSERT INTO `admin_group_navigate` VALUES ('17', '8', '8');
INSERT INTO `admin_group_navigate` VALUES ('67', '9', '5');
INSERT INTO `admin_group_navigate` VALUES ('8', '9', '6');
INSERT INTO `admin_group_navigate` VALUES ('13', '9', '7');
INSERT INTO `admin_group_navigate` VALUES ('18', '9', '8');
INSERT INTO `admin_group_navigate` VALUES ('68', '10', '5');
INSERT INTO `admin_group_navigate` VALUES ('63', '12', '5');

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of admin_groups
-- ----------------------------
INSERT INTO `admin_groups` VALUES ('1', '1', '1', '0', '1546870103', '1546870103');
INSERT INTO `admin_groups` VALUES ('5', 'admin', 'admin', '0', '1547465792', '0');
INSERT INTO `admin_groups` VALUES ('6', 'qwer', 'qw', '1546870097', '1547465785', '1547465785');
INSERT INTO `admin_groups` VALUES ('7', 'admin', 'admin', '1546874706', '1547465782', '1547465782');
INSERT INTO `admin_groups` VALUES ('8', 'admin', 'admin', '1546874721', '1547465780', '1547465780');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
INSERT INTO `admin_users` VALUES ('2', 'admin1', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '123456', '123456', '1', '0', '1546759837', '1546761337');
INSERT INTO `admin_users` VALUES ('3', 'admin2', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '123456', '123456', '1', '0', '1546759956', '1546759956');
INSERT INTO `admin_users` VALUES ('4', 'admin2', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '123456', '123456', '1', '0', '1546759980', '1546759980');
INSERT INTO `admin_users` VALUES ('5', '123', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '123456', '123456', '1', '1550137160', '1546759991', '1546759991');
INSERT INTO `admin_users` VALUES ('6', '12', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '123456', '123456', '1', '1550137054', '1546760012', '1546760012');
INSERT INTO `admin_users` VALUES ('7', '1', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '1', '1', '1', '1546765335', '1546760034', '1546765335');
INSERT INTO `admin_users` VALUES ('8', 'admin1', '8cb2237d0679ca88db6464eac60da96345513964', '123456', '123456', '1', '1546765315', '1546761117', '1546765315');
INSERT INTO `admin_users` VALUES ('9', 'admin1', '8cb2237d0679ca88db6464eac60da96345513964', '123456', '123456', '1', '1546765311', '1546761144', '1546765311');
INSERT INTO `admin_users` VALUES ('11', 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', 'admin', 'admin', '5', '0', '0', '0');

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin_users_operations
-- ----------------------------
INSERT INTO `admin_users_operations` VALUES ('1', '1', '1550132838', '1', '192.168.10.1', '1550132838');
INSERT INTO `admin_users_operations` VALUES ('2', '1', '1550135308', '1', '192.168.10.1', '1550135308');
INSERT INTO `admin_users_operations` VALUES ('3', '11', '1550199537', '1', '192.168.10.1', '1550199537');

-- ----------------------------
-- Table structure for bicycle_reports
-- ----------------------------
DROP TABLE IF EXISTS `bicycle_reports`;
CREATE TABLE `bicycle_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bicycle_id` int(11) DEFAULT '0',
  `type` int(11) DEFAULT '0' COMMENT '车辆反馈类别 ',
  `remark` varchar(200) DEFAULT NULL,
  `images` json DEFAULT NULL,
  `status` int(11) DEFAULT '0' COMMENT '处理状态',
  `created` int(11) DEFAULT '0',
  `updated` int(11) DEFAULT '0',
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bicycles
-- ----------------------------
INSERT INTO `bicycles` VALUES ('1', '1550200835', '1550202026', '0', '3', '1', '1');
INSERT INTO `bicycles` VALUES ('2', '1550201624', '1550202135', '0', '2', '2', '3');

-- ----------------------------
-- Table structure for clients
-- ----------------------------
DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL,
  `secret` varchar(128) DEFAULT NULL,
  `nick` varchar(15) DEFAULT NULL,
  `created` int(11) DEFAULT '0',
  `updated` int(11) DEFAULT '0',
  `deleted` int(11) DEFAULT '0',
  `mobile` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of clients
-- ----------------------------
INSERT INTO `clients` VALUES ('1', '1', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '113311', '1550138323', '1550138865', '1550139140', '13311111111');
INSERT INTO `clients` VALUES ('2', '1123', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '12134', '1550139128', '1550139135', '1550139137', '13322222222');

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of clients_operations
-- ----------------------------
