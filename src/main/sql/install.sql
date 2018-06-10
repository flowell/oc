-- ----------------------------------
-- Table structure for t_auth_user
-- ----------------------------------
DROP TABLE IF EXISTS `t_auth_user`;
CREATE TABLE `t_auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `realname` varchar(20) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(20) NOT NULL DEFAULT '' COMMENT '密码',
  PRIMARY KEY (`id`),
  UNIQUE KEY `T_AUTH_USER_USERNAME_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户表';
-- -------------------------
-- Record of t_auth_user
-- -------------------------
INSERT INTO `t_auth_user` VALUES ('1', '黄天日成', 'nissianbrother', 'nissian');


-- nb
-- Table structure of t_user_course
-- --------------------------------------
DROP TABLE IF EXISTS `t_user_course`;
CREATE TABLE `t_user_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL DEFAULT '0' COMMENT '课程id',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户学习课程表';
-- ----------------------------
-- Record of t_user_course
-- ----------------------------
INSERT INTO `t_user_course` VALUES ('1', '1', '1');


-- -----------------------------------
-- Table structure of t_course
-- -----------------------------------
DROP TABLE IF EXISTS `t_course`;
CREATE TABLE `t_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT  '' COMMENT '课程名称',
  `user_id` int(11) NOT NULL COMMENT '老师id',
  `introduction` text COMMENT '课程介绍',
  `begin_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态: 未开始(0), 进行中（1）, 已结束(2)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='课程表';
-- ----------------------------------
-- Record of t_course
-- ----------------------------------
INSERT INTO `t_course` VALUES ('1', '日成哥带你踏遍荒野无敌手', 1, '想要和日成哥一起去浪漫的土耳其吗？想要和日成哥去浪漫的迈阿密吗？马上行动吧！', '2018-06-21 00:00:00', '2018-06-22 00:00:00', '0')


-- ------------------------------------
-- Table structure of t_course_file
-- ------------------------------------
DROP TABLE IF EXISTS `t_course_file`;
CREATE TABLE `t_course_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL DEFAULT '0' COMMENT '课程id',
  `file_key` text NOT NULL COMMENT '文件路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='课程文件表';

