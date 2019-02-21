/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : localhost:3306
 Source Schema         : sharebick

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 13/02/2019 01:38:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_group_navigate
-- ----------------------------
DROP TABLE IF EXISTS `admin_group_navigate`;
CREATE TABLE `admin_group_navigate`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `navigate_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `group_navigate`(`navigate_id`, `group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_group_navigate
-- ----------------------------
INSERT INTO `admin_group_navigate` VALUES (54, 2, 5);
INSERT INTO `admin_group_navigate` VALUES (5, 2, 6);
INSERT INTO `admin_group_navigate` VALUES (9, 2, 7);
INSERT INTO `admin_group_navigate` VALUES (14, 2, 8);
INSERT INTO `admin_group_navigate` VALUES (21, 2, 8);
INSERT INTO `admin_group_navigate` VALUES (64, 3, 5);
INSERT INTO `admin_group_navigate` VALUES (6, 3, 6);
INSERT INTO `admin_group_navigate` VALUES (10, 3, 7);
INSERT INTO `admin_group_navigate` VALUES (15, 3, 8);
INSERT INTO `admin_group_navigate` VALUES (57, 4, 5);
INSERT INTO `admin_group_navigate` VALUES (11, 4, 7);
INSERT INTO `admin_group_navigate` VALUES (16, 4, 8);
INSERT INTO `admin_group_navigate` VALUES (65, 5, 5);
INSERT INTO `admin_group_navigate` VALUES (66, 6, 5);
INSERT INTO `admin_group_navigate` VALUES (55, 8, 5);
INSERT INTO `admin_group_navigate` VALUES (7, 8, 6);
INSERT INTO `admin_group_navigate` VALUES (12, 8, 7);
INSERT INTO `admin_group_navigate` VALUES (17, 8, 8);
INSERT INTO `admin_group_navigate` VALUES (67, 9, 5);
INSERT INTO `admin_group_navigate` VALUES (8, 9, 6);
INSERT INTO `admin_group_navigate` VALUES (13, 9, 7);
INSERT INTO `admin_group_navigate` VALUES (18, 9, 8);
INSERT INTO `admin_group_navigate` VALUES (68, 10, 5);
INSERT INTO `admin_group_navigate` VALUES (63, 12, 5);

-- ----------------------------
-- Table structure for admin_groups
-- ----------------------------
DROP TABLE IF EXISTS `admin_groups`;
CREATE TABLE `admin_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '组名称 ',
  `desc` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简介',
  `created` int(11) NULL DEFAULT 0 COMMENT '创建时间',
  `updated` int(11) NULL DEFAULT 0 COMMENT '更新时间',
  `deleted` int(11) NULL DEFAULT 0 COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_groups
-- ----------------------------
INSERT INTO `admin_groups` VALUES (1, '1', '1', 0, 1546870103, 1546870103);
INSERT INTO `admin_groups` VALUES (5, 'admin', 'admin', 0, 1547465792, 0);
INSERT INTO `admin_groups` VALUES (6, 'qwer', 'qw', 1546870097, 1547465785, 1547465785);
INSERT INTO `admin_groups` VALUES (7, 'admin', 'admin', 1546874706, 1547465782, 1547465782);
INSERT INTO `admin_groups` VALUES (8, 'admin', 'admin', 1546874721, 1547465780, 1547465780);

-- ----------------------------
-- Table structure for admin_navigates
-- ----------------------------
DROP TABLE IF EXISTS `admin_navigates`;
CREATE TABLE `admin_navigates`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限名称',
  `route` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规则',
  `desc` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `parent_id` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_navigates
-- ----------------------------
INSERT INTO `admin_navigates` VALUES (1, '用户管理', 'index/user', '后台用户管理', 0);
INSERT INTO `admin_navigates` VALUES (2, '列表', 'index/user/index', '', 1);
INSERT INTO `admin_navigates` VALUES (3, '详情', 'index/user/show', '', 1);
INSERT INTO `admin_navigates` VALUES (4, '新增', 'index/user/store', '', 1);
INSERT INTO `admin_navigates` VALUES (5, '更新', 'index/user/update', '', 1);
INSERT INTO `admin_navigates` VALUES (6, '删除', 'index/user/destroy', '', 1);
INSERT INTO `admin_navigates` VALUES (7, '用户组管理', 'index/group', '后台用户组管理', 0);
INSERT INTO `admin_navigates` VALUES (8, '列表', 'index/group/index', '', 7);
INSERT INTO `admin_navigates` VALUES (9, '详情', 'index/group/show', '', 7);
INSERT INTO `admin_navigates` VALUES (10, '新增', 'index/group/store', '', 7);
INSERT INTO `admin_navigates` VALUES (11, '更新', 'index/group/update', '', 7);
INSERT INTO `admin_navigates` VALUES (12, '删除', 'index/group/destroy', '', 7);

-- ----------------------------
-- Table structure for admin_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_users`;
CREATE TABLE `admin_users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `secret` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `nick` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `real_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `group_id` int(11) NULL DEFAULT 0 COMMENT '用户组id',
  `deleted` int(11) NULL DEFAULT 0 COMMENT '删除时间',
  `created` int(11) NULL DEFAULT 0 COMMENT '创建时间',
  `updated` int(11) NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `group`(`group_id`) USING BTREE,
  INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_users
-- ----------------------------
INSERT INTO `admin_users` VALUES (1, 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `admin_users` VALUES (2, 'admin1', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '123456', '123456', 1, 0, 1546759837, 1546761337);
INSERT INTO `admin_users` VALUES (3, 'admin2', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '123456', '123456', 1, 0, 1546759956, 1546759956);
INSERT INTO `admin_users` VALUES (4, 'admin2', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '123456', '123456', 1, 0, 1546759980, 1546759980);
INSERT INTO `admin_users` VALUES (5, '123', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '123456', '123456', 1, 0, 1546759991, 1546759991);
INSERT INTO `admin_users` VALUES (6, '12', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '123456', '123456', 1, 0, 1546760012, 1546760012);
INSERT INTO `admin_users` VALUES (7, '1', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '1', '1', 1, 1546765335, 1546760034, 1546765335);
INSERT INTO `admin_users` VALUES (8, 'admin1', '8cb2237d0679ca88db6464eac60da96345513964', '123456', '123456', 1, 1546765315, 1546761117, 1546765315);
INSERT INTO `admin_users` VALUES (9, 'admin1', '8cb2237d0679ca88db6464eac60da96345513964', '123456', '123456', 1, 1546765311, 1546761144, 1546765311);

-- ----------------------------
-- Table structure for clients
-- ----------------------------
DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `secret` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nick` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
