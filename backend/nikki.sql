/*
 Navicat Premium Dump SQL

 Source Server         : MySQL80
 Source Server Type    : MySQL
 Source Server Version : 80039 (8.0.39)
 Source Host           : localhost:3306
 Source Schema         : nikki

 Target Server Type    : MySQL
 Target Server Version : 80039 (8.0.39)
 File Encoding         : 65001

 Date: 06/10/2026 19:44:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for clazz
-- ----------------------------
DROP TABLE IF EXISTS `clazz`;
CREATE TABLE `clazz`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID,主键',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '班级名称',
  `room` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '班级教室',
  `begin_date` date NOT NULL COMMENT '开课时间',
  `end_date` date NOT NULL COMMENT '结课时间',
  `master_id` int UNSIGNED NULL DEFAULT NULL COMMENT '班主任ID, 关联员工表ID',
  `subject` tinyint UNSIGNED NOT NULL COMMENT '学科, 1:java, 2:前端, 3:大数据, 4:Python, 5:Go, 6: 嵌入式',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '班级表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of clazz
-- ----------------------------
INSERT INTO `clazz` VALUES (1, 'JavaEE就业163期', '212', '2024-04-30', '2024-06-29', 10, 1, '2024-06-01 17:08:23', '2024-06-01 17:39:58');
INSERT INTO `clazz` VALUES (2, '前端就业90期', '210', '2024-07-10', '2024-01-20', 3, 2, '2024-06-01 17:45:12', '2024-06-01 17:45:12');
INSERT INTO `clazz` VALUES (3, 'JavaEE就业165期', '108', '2024-06-15', '2024-12-25', 6, 1, '2024-06-01 17:45:40', '2024-06-01 17:45:40');
INSERT INTO `clazz` VALUES (4, 'JavaEE就业166期', '105', '2024-07-20', '2024-02-20', 20, 1, '2024-06-01 17:46:10', '2024-06-01 17:46:10');
INSERT INTO `clazz` VALUES (5, '大数据就业58期', '209', '2024-08-01', '2024-02-15', 7, 3, '2024-06-01 17:51:21', '2024-06-01 17:51:21');
INSERT INTO `clazz` VALUES (6, 'JavaEE就业167期', '325', '2024-11-20', '2024-05-10', 27, 1, '2024-11-15 11:35:46', '2026-09-24 09:53:07');

-- ----------------------------
-- Table structure for dept
-- ----------------------------
DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID, 主键',
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '部门名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dept
-- ----------------------------
INSERT INTO `dept` VALUES (1, '财务部', '2024-09-25 09:47:40', '2026-09-13 17:31:16');
INSERT INTO `dept` VALUES (3, '咨询部', '2024-09-25 09:47:40', '2024-09-30 21:26:24');
INSERT INTO `dept` VALUES (4, '失业部', '2024-09-25 09:47:40', '2026-09-13 17:32:21');
INSERT INTO `dept` VALUES (8, '人事部', '2026-09-13 15:59:26', '2026-09-13 15:59:26');
INSERT INTO `dept` VALUES (9, '管理部', '2026-09-13 16:01:07', '2026-09-13 16:01:07');

-- ----------------------------
-- Table structure for emp
-- ----------------------------
DROP TABLE IF EXISTS `emp`;
CREATE TABLE `emp`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID,主键',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '123456' COMMENT '密码',
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '姓名',
  `gender` tinyint UNSIGNED NOT NULL COMMENT '性别, 1:男, 2:女',
  `phone` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号',
  `job` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '职位, 1 班主任, 2 讲师 , 3 学工主管, 4 教研主管, 5 咨询师',
  `salary` int UNSIGNED NULL DEFAULT NULL COMMENT '薪资',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `entry_date` date NULL DEFAULT NULL COMMENT '入职日期',
  `dept_id` int UNSIGNED NULL DEFAULT NULL COMMENT '部门ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  UNIQUE INDEX `phone`(`phone` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '员工表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of emp
-- ----------------------------
INSERT INTO `emp` VALUES (1, 'shinaian', '123456', '施耐庵', 1, '13309090001', 4, 15000, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2000-01-01', 2, '2023-10-20 16:35:33', '2023-11-16 16:11:26');
INSERT INTO `emp` VALUES (2, 'songjiang', '123456', '宋江', 1, '13309090002', 2, 8600, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2015-01-01', 2, '2023-10-20 16:35:33', '2023-10-20 16:35:37');
INSERT INTO `emp` VALUES (3, 'lujunyi', '123456', '卢俊义', 1, '13309090003', 2, 8900, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2008-05-01', 2, '2023-10-20 16:35:33', '2023-10-20 16:35:39');
INSERT INTO `emp` VALUES (4, 'wuyong', '123456', '吴用', 1, '13309090004', 2, 9200, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2007-01-01', 2, '2023-10-20 16:35:33', '2023-10-20 16:35:41');
INSERT INTO `emp` VALUES (5, 'gongsunsheng', '123456', '公孙胜', 1, '13309090005', 2, 9500, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2012-12-05', 2, '2023-10-20 16:35:33', '2023-10-20 16:35:43');
INSERT INTO `emp` VALUES (6, 'huosanniang', '123456', '扈三娘', 2, '13309090006', 3, 6500, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2013-09-05', 1, '2023-10-20 16:35:33', '2023-10-20 16:35:45');
INSERT INTO `emp` VALUES (7, 'chaijin', '123456', '柴进', 1, '13309090007', 1, 4700, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2005-08-01', 1, '2023-10-20 16:35:33', '2023-10-20 16:35:47');
INSERT INTO `emp` VALUES (8, 'likui', '123456', '李逵', 1, '13309090008', 1, 4800, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2014-11-09', 1, '2023-10-20 16:35:33', '2023-10-20 16:35:49');
INSERT INTO `emp` VALUES (9, 'wusong', '123456', '武松', 1, '13309090009', 1, 4900, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2011-03-11', 1, '2023-10-20 16:35:33', '2023-10-20 16:35:51');
INSERT INTO `emp` VALUES (10, 'linchong', '123456', '林冲', 1, '13309090010', 1, 5000, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2013-09-05', 1, '2023-10-20 16:35:33', '2023-10-20 16:35:53');
INSERT INTO `emp` VALUES (11, 'huyanzhuo', '123456', '呼延灼', 1, '13309090011', 2, 9700, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2007-02-01', 2, '2023-10-20 16:35:33', '2023-10-20 16:35:55');
INSERT INTO `emp` VALUES (12, 'xiaoliguang', '123456', '小李广', 1, '13309090012', 2, 10000, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2008-08-18', 2, '2023-10-20 16:35:33', '2023-10-20 16:35:57');
INSERT INTO `emp` VALUES (13, 'yangzhi', '123456', '杨志', 1, '13309090013', 1, 5300, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2012-11-01', 1, '2023-10-20 16:35:33', '2023-10-20 16:35:59');
INSERT INTO `emp` VALUES (14, 'shijin', '123456', '史进', 1, '13309090014', 2, 10600, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2002-08-01', 2, '2023-10-20 16:35:33', '2023-10-20 16:36:01');
INSERT INTO `emp` VALUES (15, 'sunerniang', '123456', '孙二娘', 2, '13309090015', 2, 10900, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2011-05-01', 2, '2023-10-20 16:35:33', '2023-10-20 16:36:03');
INSERT INTO `emp` VALUES (16, 'luzhishen', '123456', '鲁智深', 1, '13309090016', 2, 9600, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2010-01-01', 2, '2023-10-20 16:35:33', '2023-10-20 16:36:05');
INSERT INTO `emp` VALUES (17, 'liying', '12345678', '李应', 1, '13309090017', 1, 5800, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2015-03-21', 1, '2023-10-20 16:35:33', '2023-10-20 16:36:07');
INSERT INTO `emp` VALUES (18, 'shiqian', '123456', '时迁', 1, '13309090018', 2, 10200, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2015-01-01', 2, '2023-10-20 16:35:33', '2023-10-20 16:36:09');
INSERT INTO `emp` VALUES (19, 'gudasao', '123456', '顾大嫂', 2, '13309090019', 2, 10500, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2008-01-01', 2, '2023-10-20 16:35:33', '2023-10-20 16:36:11');
INSERT INTO `emp` VALUES (20, 'ruanxiaoer', '123456', '阮小二', 1, '13309090020', 2, 10800, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2018-01-01', 2, '2023-10-20 16:35:33', '2023-10-20 16:36:13');
INSERT INTO `emp` VALUES (21, 'ruanxiaowu', '123456', '阮小五', 1, '13309090021', 5, 5200, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2015-01-01', 3, '2023-10-20 16:35:33', '2023-10-20 16:36:15');
INSERT INTO `emp` VALUES (22, 'ruanxiaoqi', '123456', '阮小七', 1, '13309090022', 5, 5500, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2016-01-01', 3, '2023-10-20 16:35:33', '2023-10-20 16:36:17');
INSERT INTO `emp` VALUES (23, 'ruanji', '123456', '阮籍', 1, '13309090023', 5, 5800, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2012-01-01', 3, '2023-10-20 16:35:33', '2023-10-20 16:36:19');
INSERT INTO `emp` VALUES (24, 'tongwei', '123456', '童威', 1, '13309090024', 5, 5000, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2006-01-01', 3, '2023-10-20 16:35:33', '2023-10-20 16:36:21');
INSERT INTO `emp` VALUES (25, 'tongmeng', '123456', '童猛', 1, '13309090025', 5, 4800, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2002-01-01', 3, '2023-10-20 16:35:33', '2023-10-20 16:36:23');
INSERT INTO `emp` VALUES (26, 'yanshun', '123456', '燕顺', 1, '13309090026', 5, 5400, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2011-01-01', 3, '2023-10-20 16:35:33', '2023-11-08 22:12:46');
INSERT INTO `emp` VALUES (27, 'lijun', '123456', '李俊', 1, '13309090027', 2, 6600, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2004-01-01', 2, '2023-10-20 16:35:33', '2023-11-16 17:56:59');
INSERT INTO `emp` VALUES (28, 'lizhong', '123456', '李忠', 1, '13309090028', 5, 5000, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2007-01-01', 3, '2023-10-20 16:35:33', '2023-11-17 16:34:22');
INSERT INTO `emp` VALUES (30, 'liyun', '123456', '李云', 1, '13309090030', NULL, NULL, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2020-03-01', NULL, '2023-10-20 16:35:33', '2023-10-20 16:36:31');
INSERT INTO `emp` VALUES (36, 'linghuchong', '123456', '令狐冲', 1, '18809091212', 2, 6800, 'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg', '2023-10-19', 2, '2023-10-20 20:44:54', '2023-11-09 09:41:04');

-- ----------------------------
-- Table structure for emp_expr
-- ----------------------------
DROP TABLE IF EXISTS `emp_expr`;
CREATE TABLE `emp_expr`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID, 主键',
  `emp_id` int UNSIGNED NULL DEFAULT NULL COMMENT '员工ID',
  `begin` date NULL DEFAULT NULL COMMENT '开始时间',
  `end` date NULL DEFAULT NULL COMMENT '结束时间',
  `company` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '公司名称',
  `job` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '职位',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工作经历' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of emp_expr
-- ----------------------------
INSERT INTO `emp_expr` VALUES (1, NULL, '1981-12-22', '2011-09-10', '字节跳动', '软件测试');
INSERT INTO `emp_expr` VALUES (2, NULL, '1981-12-22', '2011-09-10', '字节跳动', 'AI');
INSERT INTO `emp_expr` VALUES (3, NULL, '1981-12-22', '2011-09-10', '百度', 'AI');

-- ----------------------------
-- Table structure for operate_log
-- ----------------------------
DROP TABLE IF EXISTS `operate_log`;
CREATE TABLE `operate_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `operate_emp_id` int UNSIGNED NULL DEFAULT NULL COMMENT '操作人ID',
  `operate_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作的类名',
  `method_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作的方法名',
  `method_params` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '方法参数',
  `return_value` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '返回值, 存储json格式',
  `cost_time` int NULL DEFAULT NULL COMMENT '方法执行耗时, 单位:ms',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of operate_log
-- ----------------------------
INSERT INTO `operate_log` VALUES (1, 1, '2026-09-20 16:04:48', 'org.example.controller.DeptController', 'add', '[Dept(id=null, name=hjknj, createTime=2026-09-20T16:04:48.204939900, updateTime=2026-09-20T16:04:48.204939900)]', 'Result(code=1, msg=success, data=null)', 19);
INSERT INTO `operate_log` VALUES (2, 1, '2026-09-20 16:05:02', 'org.example.controller.DeptController', 'delete', '[10]', 'Result(code=1, msg=success, data=null)', 6);
INSERT INTO `operate_log` VALUES (3, 1, '2026-09-20 20:12:25', 'org.example.controller.DeptController', 'add', '[Dept(id=null, name=545, createTime=2026-09-20T20:12:25.176202200, updateTime=2026-09-20T20:12:25.176202200)]', 'Result(code=1, msg=success, data=null)', 28);
INSERT INTO `operate_log` VALUES (4, 1, '2026-09-20 20:14:48', 'org.example.controller.DeptController', 'delete', '[11]', 'Result(code=1, msg=success, data=null)', 18);
INSERT INTO `operate_log` VALUES (5, 1, '2026-09-20 20:25:52', 'org.example.controller.DeptController', 'add', '[Dept(id=null, name=55, createTime=2026-09-20T20:25:50.985688600, updateTime=2026-09-20T20:25:50.985688600)]', 'Result(code=1, msg=success, data=null)', 566);
INSERT INTO `operate_log` VALUES (6, 2, '2026-09-20 20:26:12', 'org.example.controller.DeptController', 'delete', '[12]', 'Result(code=1, msg=success, data=null)', 24);
INSERT INTO `operate_log` VALUES (7, 2, '2026-09-23 22:25:29', 'org.example.controller.DeptController', 'add', '[Dept(id=null, name=公共, createTime=2026-09-23T22:25:28.646503900, updateTime=2026-09-23T22:25:28.646503900)]', 'Result(code=1, msg=success, data=null)', 55);
INSERT INTO `operate_log` VALUES (8, 2, '2026-09-23 22:43:31', 'org.example.controller.ClazzController', 'add', '[Clazz(id=7, name=python基础入门, room=245, beginDate=2026-09-07, endDate=2028-09-14, masterId=27, subject=4, createTime=2026-09-23T22:43:30.620641, updateTime=2026-09-23T22:43:30.620641, masterName=null, status=null)]', 'Result(code=1, msg=success, data=null)', 37);
INSERT INTO `operate_log` VALUES (9, NULL, '2026-09-24 09:52:54', 'org.example.controller.ClazzController', 'delete', '[7]', 'Result(code=1, msg=success, data=null)', 22);
INSERT INTO `operate_log` VALUES (10, 2, '2026-09-24 09:53:07', 'org.example.controller.ClazzController', 'update', '[Clazz(id=6, name=JavaEE就业167期, room=325, beginDate=2024-11-20, endDate=2024-05-10, masterId=27, subject=1, createTime=2024-11-15T11:35:46, updateTime=2026-09-24T09:53:06.768312100, masterName=null, status=null)]', 'Result(code=1, msg=success, data=null)', 21);
INSERT INTO `operate_log` VALUES (11, NULL, '2026-09-24 09:54:27', 'org.example.controller.StudentController', 'updateViolation', '[1, 4]', 'Result(code=1, msg=success, data=null)', 13);
INSERT INTO `operate_log` VALUES (12, NULL, '2026-09-24 09:54:44', 'org.example.controller.StudentController', 'updateViolation', '[5, 2]', 'Result(code=1, msg=success, data=null)', 2);
INSERT INTO `operate_log` VALUES (13, 2, '2026-09-24 09:55:05', 'org.example.controller.StudentController', 'update', '[Student(id=5, name=阿朱, no=2022000005, gender=2, phone=18800160002, idCard=110120000300200005, isCollege=1, address=北京市昌平区建材城西路5号, degree=5, graduationDate=2020-07-01, clazzId=1, violationCount=1, violationScore=2, createTime=2024-11-14T21:22:19, updateTime=2026-09-24T09:55:04.949997300, clazzName=JavaEE就业163期)]', 'Result(code=1, msg=success, data=null)', 19);
INSERT INTO `operate_log` VALUES (14, NULL, '2026-09-24 09:55:28', 'org.example.controller.StudentController', 'updateViolation', '[4, 3]', 'Result(code=1, msg=success, data=null)', 3);
INSERT INTO `operate_log` VALUES (15, 2, '2026-09-24 09:56:45', 'org.example.controller.StudentController', 'add', '[Student(id=19, name=韦一笑, no=2023105855, gender=2, phone=18379128640, idCard=360923200411081324, isCollege=1, address=江西省宜春市上高县新界埠乡车溪村, degree=4, graduationDate=2026-09-22, clazzId=4, violationCount=null, violationScore=null, createTime=2026-09-24T09:56:45.029502400, updateTime=2026-09-24T09:56:45.029502400, clazzName=null)]', 'Result(code=1, msg=success, data=null)', 25);
INSERT INTO `operate_log` VALUES (16, NULL, '2026-09-24 10:12:40', 'org.example.controller.StudentController', 'delete', '[[19]]', 'Result(code=1, msg=success, data=null)', 16);
INSERT INTO `operate_log` VALUES (17, 2, '2026-09-26 11:36:57', 'org.example.controller.StudentController', 'add', '[Student(id=20, name=刘瑶, no=2350489854, gender=2, phone=18379128640, idCard=360925400411081549, isCollege=1, address=江西省宜春市上高县新界埠乡车溪村, degree=2, graduationDate=2030-09-06, clazzId=5, violationCount=null, violationScore=null, createTime=2026-09-26T11:36:57.284114, updateTime=2026-09-26T11:36:57.284114, clazzName=null)]', 'Result(code=1, msg=success, data=null)', 22);
INSERT INTO `operate_log` VALUES (18, 2, '2026-09-26 11:38:01', 'org.example.controller.DeptController', 'delete', '[13]', 'Result(code=1, msg=success, data=null)', 18);
INSERT INTO `operate_log` VALUES (19, NULL, '2026-09-29 16:49:36', 'org.example.controller.DeptController', 'add', '[Dept(id=null, name=搜索, createTime=2026-09-29T16:49:36.037905900, updateTime=2026-09-29T16:49:36.037905900)]', 'Result(code=1, msg=success, data=null)', 54);
INSERT INTO `operate_log` VALUES (20, NULL, '2026-09-29 16:52:21', 'org.example.controller.DeptController', 'add', '[Dept(id=null, name=2, createTime=2026-09-29T16:52:21.264083800, updateTime=2026-09-29T16:52:21.264083800)]', 'Result(code=1, msg=success, data=null)', 5);
INSERT INTO `operate_log` VALUES (21, NULL, '2026-09-29 16:53:11', 'org.example.controller.DeptController', 'add', '[Dept(id=null, name=2222222, createTime=2026-09-29T16:53:10.598758600, updateTime=2026-09-29T16:53:10.598758600)]', 'Result(code=1, msg=success, data=null)', 13);
INSERT INTO `operate_log` VALUES (22, NULL, '2026-09-29 17:45:05', 'org.example.controller.DeptController', 'add', '[Dept(id=18, name=2222, createTime=2026-09-29T17:45:04.968084200, updateTime=2026-09-29T17:45:04.968084200)]', 'Result(code=1, msg=success, data=null)', 11);
INSERT INTO `operate_log` VALUES (23, NULL, '2026-09-29 17:45:14', 'org.example.controller.DeptController', 'add', '[Dept(id=18, name=229, createTime=2026-09-29T17:45:13.797892400, updateTime=2026-09-29T17:45:13.797892400)]', 'Result(code=1, msg=success, data=null)', 8);
INSERT INTO `operate_log` VALUES (24, NULL, '2026-09-29 17:55:23', 'org.example.controller.DeptController', 'add', '[Dept(id=15, name=23444445, createTime=2026-09-29T17:55:23.454342, updateTime=2026-09-29T17:55:23.454342)]', 'Result(code=1, msg=success, data=null)', 17);
INSERT INTO `operate_log` VALUES (25, NULL, '2026-09-29 20:37:16', 'org.example.controller.DeptController', 'delete', '[15]', 'Result(code=1, msg=success, data=null)', 49);
INSERT INTO `operate_log` VALUES (26, NULL, '2026-09-29 20:37:19', 'org.example.controller.DeptController', 'delete', '[20]', 'Result(code=1, msg=success, data=null)', 10);
INSERT INTO `operate_log` VALUES (27, NULL, '2026-09-29 20:37:22', 'org.example.controller.DeptController', 'delete', '[14]', 'Result(code=1, msg=success, data=null)', 18);
INSERT INTO `operate_log` VALUES (28, NULL, '2026-09-29 20:37:24', 'org.example.controller.DeptController', 'delete', '[18]', 'Result(code=1, msg=success, data=null)', 10);
INSERT INTO `operate_log` VALUES (29, NULL, '2026-09-29 20:37:26', 'org.example.controller.DeptController', 'delete', '[19]', 'Result(code=1, msg=success, data=null)', 0);
INSERT INTO `operate_log` VALUES (30, NULL, '2026-09-30 13:20:52', 'org.example.controller.DeptController', 'delete', '[21]', 'Result(code=1, msg=success, data=null)', 27);
INSERT INTO `operate_log` VALUES (31, 2, '2026-10-01 15:13:39', 'org.example.controller.StudentController', 'update', '[Student(id=20, name=刘瑶, no=2350489854, gender=2, phone=18379128640, idCard=360925400411081549, isCollege=1, address=江西省宜春市上高县新界埠乡车溪村, degree=2, graduationDate=2030-09-06, clazzId=5, violationCount=0, violationScore=0, createTime=2026-09-26T11:36:57, updateTime=2026-10-01T15:13:38.623478400, clazzName=大数据就业58期)]', 'Result(code=1, msg=success, data=null)', 50);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID,主键',
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '姓名',
  `no` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学号',
  `gender` tinyint UNSIGNED NOT NULL COMMENT '性别, 1: 男, 2: 女',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号',
  `id_card` char(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '身份证号',
  `is_college` tinyint UNSIGNED NOT NULL COMMENT '是否来自于院校, 1:是, 0:否',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系地址',
  `degree` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '最高学历, 1:初中, 2:高中, 3:大专, 4:本科, 5:硕士, 6:博士',
  `graduation_date` date NULL DEFAULT NULL COMMENT '毕业时间',
  `clazz_id` int UNSIGNED NOT NULL COMMENT '班级ID, 关联班级表ID',
  `violation_count` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '违纪次数',
  `violation_score` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '违纪扣分',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `no`(`no` ASC) USING BTREE,
  UNIQUE INDEX `phone`(`phone` ASC) USING BTREE,
  UNIQUE INDEX `id_card`(`id_card` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, '段誉', '2022000001', 1, '18800000001', '110120000300200001', 1, '北京市昌平区建材城西路1号', 1, '2021-07-01', 2, 1, 4, '2024-11-14 21:22:19', '2026-09-24 09:54:27');
INSERT INTO `student` VALUES (2, '萧峰', '2022000002', 1, '18800210003', '110120000300200002', 1, '北京市昌平区建材城西路2号', 2, '2022-07-01', 1, 0, 0, '2024-11-14 21:22:19', '2024-11-14 21:22:19');
INSERT INTO `student` VALUES (3, '虚竹', '2022000003', 1, '18800013001', '110120000300200003', 1, '北京市昌平区建材城西路3号', 2, '2024-07-01', 1, 0, 0, '2024-11-14 21:22:19', '2024-11-14 21:22:19');
INSERT INTO `student` VALUES (4, '萧远山', '2022000004', 1, '18800003211', '110120000300200004', 1, '北京市昌平区建材城西路4号', 3, '2024-07-01', 1, 1, 3, '2024-11-14 21:22:19', '2026-09-24 09:55:28');
INSERT INTO `student` VALUES (5, '阿朱', '2022000005', 2, '18800160002', '110120000300200005', 1, '北京市昌平区建材城西路5号', 5, '2020-07-01', 1, 1, 2, '2024-11-14 21:22:19', '2026-09-24 09:55:05');
INSERT INTO `student` VALUES (6, '阿紫', '2022000006', 2, '18800000034', '110120000300200006', 1, '北京市昌平区建材城西路6号', 4, '2021-07-01', 2, 0, 0, '2024-11-14 21:22:19', '2024-11-14 21:22:19');
INSERT INTO `student` VALUES (7, '游坦之', '2022000007', 1, '18800000067', '110120000300200007', 1, '北京市昌平区建材城西路7号', 4, '2022-07-01', 2, 0, 0, '2024-11-14 21:22:19', '2024-11-14 21:22:19');
INSERT INTO `student` VALUES (8, '康敏', '2022000008', 2, '18800000077', '110120000300200008', 1, '北京市昌平区建材城西路8号', 5, '2024-07-01', 2, 0, 0, '2024-11-14 21:22:19', '2024-11-14 21:22:19');
INSERT INTO `student` VALUES (9, '徐长老', '2022000009', 1, '18800000341', '110120000300200009', 1, '北京市昌平区建材城西路9号', 3, '2024-07-01', 2, 0, 0, '2024-11-14 21:22:19', '2024-11-14 21:22:19');
INSERT INTO `student` VALUES (10, '云中鹤', '2022000010', 1, '18800006571', '110120000300200010', 1, '北京市昌平区建材城西路10号', 2, '2020-07-01', 2, 0, 0, '2024-11-14 21:22:19', '2024-11-14 21:22:19');
INSERT INTO `student` VALUES (11, '钟万仇', '2022000011', 1, '18800000391', '110120000300200011', 1, '北京市昌平区建材城西路11号', 4, '2021-07-01', 1, 0, 0, '2024-11-14 21:22:19', '2024-11-15 16:21:24');
INSERT INTO `student` VALUES (12, '崔百泉', '2022000012', 1, '18800000781', '110120000300200018', 1, '北京市昌平区建材城西路12号', 4, '2022-07-05', 3, 6, 17, '2024-11-14 21:22:19', '2024-12-13 14:33:58');
INSERT INTO `student` VALUES (13, '耶律洪基', '2022000013', 1, '18800008901', '110120000300200013', 1, '北京市昌平区建材城西路13号', 4, '2024-07-01', 2, 0, 0, '2024-11-14 21:22:19', '2024-11-15 16:21:21');
INSERT INTO `student` VALUES (14, '天山童姥', '2022000014', 2, '18800009201', '110120000300200014', 1, '北京市昌平区建材城西路14号', 4, '2024-07-01', 1, 0, 0, '2024-11-14 21:22:19', '2024-11-15 16:21:17');
INSERT INTO `student` VALUES (15, '刘竹庄', '2022000015', 1, '18800009401', '110120000300200015', 1, '北京市昌平区建材城西路15号', 3, '2020-07-01', 4, 0, 0, '2024-11-14 21:22:19', '2024-11-14 21:22:19');
INSERT INTO `student` VALUES (16, '李春来', '2022000016', 1, '18800008501', '110120000300200016', 1, '北京市昌平区建材城西路16号', 4, '2021-07-01', 4, 0, 0, '2024-11-14 21:22:19', '2024-11-14 21:22:19');
INSERT INTO `student` VALUES (17, '王语嫣', '2022000017', 2, '18800007601', '110120000300200017', 1, '北京市昌平区建材城西路17号', 2, '2022-07-01', 4, 0, 0, '2024-11-14 21:22:19', '2024-11-14 21:22:19');
INSERT INTO `student` VALUES (18, '郑成功', '2024001101', 1, '13309092345', '110110110110110110', 0, '北京市昌平区回龙观街道88号', 5, '2021-07-01', 3, 2, 7, '2024-11-15 16:26:18', '2024-11-15 16:40:10');
INSERT INTO `student` VALUES (20, '刘瑶', '2350489854', 2, '18379128640', '360925400411081549', 1, '江西省宜春市上高县新界埠乡车溪村', 2, '2030-09-06', 5, 0, 0, '2026-09-26 11:36:57', '2026-10-01 15:13:39');

SET FOREIGN_KEY_CHECKS = 1;
