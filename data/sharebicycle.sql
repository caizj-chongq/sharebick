
/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : localhost:3306
 Source Schema         : sharebicycle

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 21/02/2019 10:57:01
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
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_users
-- ----------------------------
INSERT INTO `admin_users` VALUES (2, 'admin1', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '123456', '123456', 1, 0, 1546759837, 1546761337);
INSERT INTO `admin_users` VALUES (3, 'admin2', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '123456', '123456', 1, 0, 1546759956, 1546759956);
INSERT INTO `admin_users` VALUES (4, 'admin2', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '123456', '123456', 1, 0, 1546759980, 1546759980);
INSERT INTO `admin_users` VALUES (5, '123', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '123456', '123456', 1, 1550137160, 1546759991, 1546759991);
INSERT INTO `admin_users` VALUES (6, '12', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '123456', '123456', 1, 1550137054, 1546760012, 1546760012);
INSERT INTO `admin_users` VALUES (7, '1', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '1', '1', 1, 1546765335, 1546760034, 1546765335);
INSERT INTO `admin_users` VALUES (8, 'admin1', '8cb2237d0679ca88db6464eac60da96345513964', '123456', '123456', 1, 1546765315, 1546761117, 1546765315);
INSERT INTO `admin_users` VALUES (9, 'admin1', '8cb2237d0679ca88db6464eac60da96345513964', '123456', '123456', 1, 1546765311, 1546761144, 1546765311);
INSERT INTO `admin_users` VALUES (11, 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', 'admin', 'admin', 5, 0, 0, 0);

-- ----------------------------
-- Table structure for admin_users_operations
-- ----------------------------
DROP TABLE IF EXISTS `admin_users_operations`;
CREATE TABLE `admin_users_operations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `time` int(11) NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT NULL,
  `ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_users_operations
-- ----------------------------
INSERT INTO `admin_users_operations` VALUES (1, 1, 1550132838, 1, '192.168.10.1', 1550132838);
INSERT INTO `admin_users_operations` VALUES (2, 1, 1550135308, 1, '192.168.10.1', 1550135308);
INSERT INTO `admin_users_operations` VALUES (3, 11, 1550199537, 1, '192.168.10.1', 1550199537);
INSERT INTO `admin_users_operations` VALUES (4, 11, 1550415324, 1, '127.0.0.1', 1550415323);
INSERT INTO `admin_users_operations` VALUES (5, 11, 1550415334, 1, '127.0.0.1', 1550415334);
INSERT INTO `admin_users_operations` VALUES (6, 11, 1550589994, 1, '127.0.0.1', 1550589994);
INSERT INTO `admin_users_operations` VALUES (7, 11, 1550662336, 1, '127.0.0.1', 1550662336);
INSERT INTO `admin_users_operations` VALUES (8, 11, 1550668601, 1, '127.0.0.1', 1550668601);

-- ----------------------------
-- Table structure for bicycle_reports
-- ----------------------------
DROP TABLE IF EXISTS `bicycle_reports`;
CREATE TABLE `bicycle_reports`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bicycle_id` int(11) NULL DEFAULT 0,
  `type` int(11) NULL DEFAULT 0 COMMENT '车辆反馈类别 ',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `images` json NULL,
  `status` int(11) NULL DEFAULT 0 COMMENT '处理状态',
  `created` int(11) NULL DEFAULT 0,
  `updated` int(11) NULL DEFAULT 0,
  `deleted` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bicycles
-- ----------------------------
DROP TABLE IF EXISTS `bicycles`;
CREATE TABLE `bicycles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` int(11) NULL DEFAULT 0,
  `updated` int(11) NULL DEFAULT 0,
  `deleted` int(11) NULL DEFAULT 0,
  `lock_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bicycle_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT 0 COMMENT '车辆状态',
  `bicycle_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '车辆名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bicycles
-- ----------------------------
INSERT INTO `bicycles` VALUES (1, 1550200835, 1550202026, 0, '3', '1', 1, NULL);
INSERT INTO `bicycles` VALUES (2, 1550201624, 1550202135, 0, '2', '2', 3, NULL);
INSERT INTO `bicycles` VALUES (3, 1550665395, 1550665395, 0, '123', '3', 1, 'q2341');
INSERT INTO `bicycles` VALUES (4, 1550673347, 1550673347, 1550673791, 'qwerty', '123', 1, 'asdklqwer');
INSERT INTO `bicycles` VALUES (5, 1550673410, 1550673410, 0, '1234', '12435', 1, '3141234');

-- ----------------------------
-- Table structure for clients
-- ----------------------------
DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `secret` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nick` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `money` decimal(18, 2) NULL DEFAULT 0.00,
  `created` int(11) NULL DEFAULT 0,
  `updated` int(11) NULL DEFAULT 0,
  `deleted` int(11) NULL DEFAULT 0,
  `mobile` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of clients
-- ----------------------------
INSERT INTO `clients` VALUES (1, '1', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '113311', 0.00, 1550138323, 1550138865, 1550139140, '13311111111');
INSERT INTO `clients` VALUES (2, '1123', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '12134', 0.00, 1550139128, 1550139135, 1550139137, '13322222222');
INSERT INTO `clients` VALUES (3, '123412', 'c129b324aee662b04eccf68babba85851346dff9', 'qwerqwer', 100.00, 1550675695, 1550675695, 0, '13311111111');

-- ----------------------------
-- Table structure for clients_operations
-- ----------------------------
DROP TABLE IF EXISTS `clients_operations`;
CREATE TABLE `clients_operations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NULL DEFAULT 0,
  `time` int(11) NULL DEFAULT 0 COMMENT '操作时间',
  `type` int(11) NULL DEFAULT NULL COMMENT '操作类型',
  `ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for fence_bicycles
-- ----------------------------
DROP TABLE IF EXISTS `fence_bicycles`;
CREATE TABLE `fence_bicycles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fence_id` int(11) NULL DEFAULT NULL,
  `bicycle_id` int(11) NULL DEFAULT NULL,
  `created` int(255) NULL DEFAULT 0,
  `updated` int(11) NULL DEFAULT 0,
  `deleted` int(255) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fence_bicycles
-- ----------------------------
INSERT INTO `fence_bicycles` VALUES (1, 13, 5, 1550673476, 1550673476, 0);
INSERT INTO `fence_bicycles` VALUES (2, 14, 5, 1550673476, 1550673476, 0);

-- ----------------------------
-- Table structure for fences
-- ----------------------------
DROP TABLE IF EXISTS `fences`;
CREATE TABLE `fences`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子围栏名称',
  `points` json NULL COMMENT '围栏顶点',
  `fence_id` int(11) NULL DEFAULT NULL COMMENT '百度鹰眼服务端电子围栏id',
  `created` int(11) NULL DEFAULT 0,
  `updated` int(11) NULL DEFAULT 0,
  `deleted` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fences
-- ----------------------------
INSERT INTO `fences` VALUES (1, '阿萨德', '[{\"lat\": 29.547881, \"lng\": 106.516717}, {\"lat\": 29.536758, \"lng\": 106.52031}, {\"lat\": 29.538895, \"lng\": 106.531378}, {\"lat\": 29.546373, \"lng\": 106.52915}]', NULL, 1550663686, 1550663686, 1550664574);
INSERT INTO `fences` VALUES (2, '1', '[{\"lat\": 29.550018, \"lng\": 106.501194}, {\"lat\": 29.537638, \"lng\": 106.50335}, {\"lat\": 29.542917, \"lng\": 106.505794}, {\"lat\": 29.546247, \"lng\": 106.506584}, {\"lat\": 29.548321, \"lng\": 106.505003}, {\"lat\": 29.545933, \"lng\": 106.504213}]', NULL, 1550663761, 1550663761, 0);
INSERT INTO `fences` VALUES (3, '2', '[{\"lat\": 29.546876, \"lng\": 106.512046}, {\"lat\": 29.539272, \"lng\": 106.514418}, {\"lat\": 29.541283, \"lng\": 106.516861}, {\"lat\": 29.542602, \"lng\": 106.515567}, {\"lat\": 29.544111, \"lng\": 106.517651}, {\"lat\": 29.547001, \"lng\": 106.518729}, {\"lat\": 29.54543, \"lng\": 106.521173}, {\"lat\": 29.549578, \"lng\": 106.52067}, {\"lat\": 29.55096, \"lng\": 106.517005}, {\"lat\": 29.548635, \"lng\": 106.517508}, {\"lat\": 29.548447, \"lng\": 106.515208}, {\"lat\": 29.549955, \"lng\": 106.514202}, {\"lat\": 29.552971, \"lng\": 106.511974}, {\"lat\": 29.551212, \"lng\": 106.511399}, {\"lat\": 29.550395, \"lng\": 106.512333}, {\"lat\": 29.549955, \"lng\": 106.510896}, {\"lat\": 29.54851, \"lng\": 106.511974}, {\"lat\": 29.548321, \"lng\": 106.510752}, {\"lat\": 29.54719, \"lng\": 106.510465}]', NULL, 1550663761, 1550663761, 0);
INSERT INTO `fences` VALUES (4, '3', '[{\"lat\": 29.547881, \"lng\": 106.530156}, {\"lat\": 29.544676, \"lng\": 106.530156}, {\"lat\": 29.54122, \"lng\": 106.528359}, {\"lat\": 29.541346, \"lng\": 106.523329}, {\"lat\": 29.547818, \"lng\": 106.523688}, {\"lat\": 29.552908, \"lng\": 106.525341}, {\"lat\": 29.553977, \"lng\": 106.532527}, {\"lat\": 29.555233, \"lng\": 106.525053}, {\"lat\": 29.550583, \"lng\": 106.539498}, {\"lat\": 29.559066, \"lng\": 106.530587}, {\"lat\": 29.545619, \"lng\": 106.533246}, {\"lat\": 29.548007, \"lng\": 106.539283}]', NULL, 1550663761, 1550663761, 0);
INSERT INTO `fences` VALUES (5, 'asdf', '[{\"lat\": 29.55184, \"lng\": 106.510537}, {\"lat\": 29.543105, \"lng\": 106.512262}, {\"lat\": 29.543671, \"lng\": 106.524694}, {\"lat\": 29.549452, \"lng\": 106.518298}, {\"lat\": 29.552468, \"lng\": 106.51837}, {\"lat\": 29.547693, \"lng\": 106.515783}, {\"lat\": 29.550709, \"lng\": 106.513483}, {\"lat\": 29.552343, \"lng\": 106.529222}]', NULL, 1550665886, 1550665886, 0);
INSERT INTO `fences` VALUES (6, 'xcvbb', '[{\"lat\": 29.549201, \"lng\": 106.508381}, {\"lat\": 29.541534, \"lng\": 106.506728}, {\"lat\": 29.543671, \"lng\": 106.523904}, {\"lat\": 29.550709, \"lng\": 106.519592}, {\"lat\": 29.553788, \"lng\": 106.515424}, {\"lat\": 29.546562, \"lng\": 106.515496}, {\"lat\": 29.548635, \"lng\": 106.512477}, {\"lat\": 29.552908, \"lng\": 106.511902}, {\"lat\": 29.555296, \"lng\": 106.510178}, {\"lat\": 29.566983, \"lng\": 106.50759}]', NULL, 1550668625, 1550668625, 1550668683);
INSERT INTO `fences` VALUES (13, 'asdzc', '[{\"lat\": 29.54719, \"lng\": 106.504824}, {\"lat\": 29.543357, \"lng\": 106.505902}, {\"lat\": 29.543734, \"lng\": 106.511507}, {\"lat\": 29.544613, \"lng\": 106.509639}]', 42, 1550673476, 1550673476, 0);
INSERT INTO `fences` VALUES (14, 'wqeyh', '[{\"lat\": 29.549201, \"lng\": 106.520274}, {\"lat\": 29.551652, \"lng\": 106.521927}, {\"lat\": 29.548887, \"lng\": 106.525449}, {\"lat\": 29.547316, \"lng\": 106.523077}, {\"lat\": 29.543859, \"lng\": 106.522933}, {\"lat\": 29.542351, \"lng\": 106.519125}]', 43, 1550673476, 1550673476, 0);

-- ----------------------------
-- Table structure for system_info
-- ----------------------------
DROP TABLE IF EXISTS `system_info`;
CREATE TABLE `system_info`  (
  `yingyanAk` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '百度鹰眼服务ak',
  `service_id` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '百度鹰眼轨迹服务service_id',
  `browerAk` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_info
-- ----------------------------
INSERT INTO `system_info` VALUES ('ySWPa1ipCqxDgcYphFvIbZWcN6gG1VRR', '208795', 'XhyLag9s3zKpfr3t05TuDGVzd91Z5HjC');

SET FOREIGN_KEY_CHECKS = 1;
