/*
Navicat MySQL Data Transfer
Source Host     : localhost:3306
Source Database : community
Target Host     : localhost:3306
Target Database : community
Date: 2009-12-02 00:15:40
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `A_ID` int(11) NOT NULL auto_increment,
  `A_Topic` varchar(50) NOT NULL,
  `A_Content` text NOT NULL,
  `A_RevNum` int(11) NOT NULL default '0',
  `A_CreTime` datetime NOT NULL,
  `A_LastReUser` int(11) NOT NULL,
  `A_LastReTime` datetime NOT NULL,
  `A_IsTop` bit(1) NOT NULL,
  `U_ID` int(11) NOT NULL,
  `S_ID` int(11) NOT NULL,
  PRIMARY KEY  (`A_ID`),
  KEY `S_ID` (`S_ID`),
  KEY `U_ID` (`U_ID`),
  CONSTRAINT `article_ibfk_4` FOREIGN KEY (`S_ID`) REFERENCES `subcommunity` (`S_ID`),
  CONSTRAINT `article_ibfk_5` FOREIGN KEY (`U_ID`) REFERENCES `user` (`U_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('1', '巴黎香榭丽舍大街', '你好，这是第一条主题，关于巴黎香榭丽舍大街。\r\n<font face=\"微软雅黑\" weight=\"bolder\" size=14>Pairs</font>', '5', '2009-11-12 13:18:33', '1', '2009-11-23 01:33:25', '', '1', '1');
INSERT INTO `article` VALUES ('2', 'The IT Crowd', '英国喜剧短片。超搞笑！<font color=\"blue\">Moss.Jen,Joy</font>', '2', '2009-11-13 15:51:57', '1', '2009-11-19 17:13:02', '\0', '1', '1');
INSERT INTO `article` VALUES ('3', '发帖测试', 'test', '1', '2009-11-14 20:35:04', '1', '2009-11-19 16:44:19', '\0', '1', '1');
INSERT INTO `article` VALUES ('4', '先知 knowing', '            1959年，美国马塞诸塞州列辛顿威廉道斯小学，该校即将迎来校庆日，小女孩露辛达•安伯利（Lara Robinson 饰）提出的创意为校长所采纳。校庆日时，学生们将画下自己对未来的设想，并集中放入金属时间囊中埋入地下，准备50年后重新开启。校庆日之后，举止怪异的露辛达用鲜血在墙上写下奇怪文字，并向老师提出警告。\r\n　　    2009年，威廉道斯小学再次迎来校庆日，被埋藏地下50年之久的时间囊重见天日。小男孩凯勒（Chandler Canterbury 饰）得到露辛达的信，上面没有任何图画，整页布满毫无规律可言的数字。凯勒的父亲约翰（尼古拉斯•凯奇 Nicolas Cage 饰）夜晚研究这些数字，竟发现这是一组具有预言性的密码。文中的数字清楚记录了世界上过去50年所发生的各种灾难。除此之外，这组数字还包括了接下来将发生的重大灾难……   <img src=\"upload/knowing.jpg\">', '3', '2009-11-14 20:49:45', '27', '2009-11-18 23:27:01', '\0', '18', '2');
INSERT INTO `article` VALUES ('5', '你好', 'hello', '6', '2009-11-14 21:59:32', '22', '2009-11-17 00:22:16', '\0', '22', '1');
INSERT INTO `article` VALUES ('7', '物超所值', '        肥人，连饮水都会肥，所以物超所值！\r\n', '2', '2009-11-14 23:11:36', '1', '2009-11-16 22:32:13', '', '25', '1');
INSERT INTO `article` VALUES ('9', '天空不留下鸟的痕迹', '\r\nI\'m sorry to have to disturb you this late,girl.\r\n\r\nI mean, I\'m missing you.So..', '0', '2009-11-15 20:54:19', '21', '2009-11-15 20:54:19', '\0', '21', '3');
INSERT INTO `article` VALUES ('10', 'Just A Test', 'test', '0', '2009-11-15 21:01:04', '21', '2009-11-15 21:01:04', '', '21', '3');
INSERT INTO `article` VALUES ('13', 'King Of War', 'By Nicolas Cage', '0', '2009-11-15 21:12:12', '21', '2009-11-15 21:12:12', '\0', '21', '2');
INSERT INTO `article` VALUES ('15', '阿甘正传 or 美丽人生', 'good looking movies', '1', '2009-11-15 21:18:20', '18', '2009-11-17 10:40:40', '\0', '21', '1');
INSERT INTO `article` VALUES ('16', 'debug经验', '<font color=\"red\">很多bug就是因为CTRL+C,CTRL+V造成的，这次copy忘了把while改成if。</font>', '3', '2009-11-15 21:20:56', '18', '2009-11-17 10:40:54', '', '21', '1');

-- ----------------------------
-- Table structure for identify
-- ----------------------------
DROP TABLE IF EXISTS `identify`;
CREATE TABLE `identify` (
  `I_ID` int(11) NOT NULL auto_increment,
  `I_Name` varchar(20) NOT NULL,
  PRIMARY KEY  (`I_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of identify
-- ----------------------------
INSERT INTO `identify` VALUES ('1', 'admin');
INSERT INTO `identify` VALUES ('2', 'user');

-- ----------------------------
-- Table structure for revert
-- ----------------------------
DROP TABLE IF EXISTS `revert`;
CREATE TABLE `revert` (
  `R_ID` int(11) NOT NULL auto_increment,
  `R_Content` text NOT NULL,
  `R_CreTime` datetime NOT NULL,
  `A_ID` int(11) NOT NULL,
  `S_ID` int(11) NOT NULL,
  `U_ID` int(11) NOT NULL,
  PRIMARY KEY  (`R_ID`),
  KEY `A_ID` (`A_ID`),
  KEY `S_ID` (`S_ID`),
  KEY `U_ID` (`U_ID`),
  CONSTRAINT `revert_ibfk_4` FOREIGN KEY (`A_ID`) REFERENCES `article` (`A_ID`),
  CONSTRAINT `revert_ibfk_5` FOREIGN KEY (`S_ID`) REFERENCES `subcommunity` (`S_ID`),
  CONSTRAINT `revert_ibfk_6` FOREIGN KEY (`U_ID`) REFERENCES `user` (`U_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of revert
-- ----------------------------
INSERT INTO `revert` VALUES ('1', '戴高乐广场！塞纳河！', '2009-11-12 19:39:23', '1', '1', '18');
INSERT INTO `revert` VALUES ('3', '还有红磨坊！', '2009-11-13 12:48:19', '1', '1', '21');
INSERT INTO `revert` VALUES ('4', '卢浮宫！咖啡馆！凯旋门！', '2009-11-13 12:50:07', '1', '1', '22');
INSERT INTO `revert` VALUES ('6', '同性恋那集好搞！哈哈。', '2009-11-13 15:53:01', '2', '1', '1');
INSERT INTO `revert` VALUES ('7', '开玩笑！[green]文字[/green]', '2009-11-13 19:25:39', '2', '1', '22');
INSERT INTO `revert` VALUES ('8', '沙发', '2009-11-14 21:03:14', '4', '2', '18');
INSERT INTO `revert` VALUES ('9', '你好胖', '2009-11-14 21:59:38', '5', '1', '22');
INSERT INTO `revert` VALUES ('10', '笑话', '2009-11-14 21:59:44', '5', '1', '22');
INSERT INTO `revert` VALUES ('12', '吃饭了', '2009-11-14 22:02:01', '5', '1', '22');
INSERT INTO `revert` VALUES ('13', '吃了', '2009-11-14 23:02:42', '5', '1', '24');
INSERT INTO `revert` VALUES ('14', 'shit！', '2009-11-14 23:06:30', '4', '2', '24');
INSERT INTO `revert` VALUES ('15', '这是什么逻辑。。', '2009-11-14 23:13:53', '7', '1', '18');
INSERT INTO `revert` VALUES ('26', '<font color=\'red\'>把外键约束删掉了，麻烦。</font>', '2009-11-16 15:53:11', '5', '1', '1');
INSERT INTO `revert` VALUES ('27', '赞。', '2009-11-16 15:53:43', '16', '1', '1');
INSERT INTO `revert` VALUES ('28', '///', '2009-11-16 16:23:38', '16', '1', '1');
INSERT INTO `revert` VALUES ('29', '...', '2009-11-16 22:32:13', '7', '1', '1');
INSERT INTO `revert` VALUES ('31', '为什么！为什么有你好胖！', '2009-11-17 00:22:16', '5', '1', '22');
INSERT INTO `revert` VALUES ('33', '你好', '2009-11-17 10:40:40', '15', '1', '18');
INSERT INTO `revert` VALUES ('34', '哈哈', '2009-11-17 10:40:54', '16', '1', '18');
INSERT INTO `revert` VALUES ('35', '不能看的呀 ', '2009-11-18 23:27:01', '4', '2', '27');
INSERT INTO `revert` VALUES ('36', '可以发帖', '2009-11-19 16:44:19', '3', '1', '1');
INSERT INTO `revert` VALUES ('37', '头像测试。', '2009-11-22 21:56:22', '1', '1', '28');
INSERT INTO `revert` VALUES ('41', '更换头像！', '2009-11-23 01:33:25', '1', '1', '1');

-- ----------------------------
-- Table structure for subcommunity
-- ----------------------------
DROP TABLE IF EXISTS `subcommunity`;
CREATE TABLE `subcommunity` (
  `S_ID` int(11) NOT NULL auto_increment,
  `S_Name` varchar(50) NOT NULL,
  `S_Desc` varchar(200) NOT NULL,
  `S_ArtNum` int(11) NOT NULL default '0',
  `S_CreTime` date NOT NULL,
  `S_Status` bit(1) NOT NULL,
  PRIMARY KEY  (`S_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of subcommunity
-- ----------------------------
INSERT INTO `subcommunity` VALUES ('1', '悠远名城', '世界文明的发源地', '7', '2009-11-07', '');
INSERT INTO `subcommunity` VALUES ('2', '世界臆测集', '对未知总是好奇', '2', '2009-11-10', '');
INSERT INTO `subcommunity` VALUES ('3', '英式幽默', '别具一格的幽默', '2', '2009-11-11', '');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `U_ID` int(11) NOT NULL auto_increment,
  `U_Account` varchar(20) NOT NULL,
  `U_Passwd` char(6) NOT NULL,
  `U_Name` varchar(20) NOT NULL,
  `U_Gender` bit(1) NOT NULL default '',
  `U_Age` int(11) NOT NULL,
  `U_Email` varchar(50) NOT NULL,
  `U_Question` varchar(50) NOT NULL,
  `U_Answer` varchar(50) NOT NULL,
  `U_Image` varchar(50) NOT NULL default '00000000000000',
  `U_Identify` int(11) NOT NULL default '2',
  PRIMARY KEY  (`U_ID`),
  UNIQUE KEY `U_Account` (`U_Account`),
  KEY `U_Identify` (`U_Identify`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`U_Identify`) REFERENCES `identify` (`I_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'shanechu', '123123', 'shane', '', '20', 'enginzhu@gmail.com', '我叫什么？', '奥特曼', '20091123013126', '1');
INSERT INTO `user` VALUES ('11', 'single', 'anor', 'swall', '', '34', 'single@hot.com', '我的职业是什么？', '液态金属机器人', '00000000000000', '2');
INSERT INTO `user` VALUES ('18', 'aaa7782814', '666', '光影猪', '\0', '21', 'my@hot.com', '我的职业是什么？', '未来战士', '20091123013846', '2');
INSERT INTO `user` VALUES ('21', 'zhuzhu', '111111', '猪心未泯', '\0', '21', 'my@gdpc.com', '我最喜欢的动物是什么？', '狗', '20091123113039', '2');
INSERT INTO `user` VALUES ('22', 'wood', 'wood', '绝版西门庆', '', '21', 'wood8806@yahoo.com', '我最喜欢的动物是什么？', '熊猫', '00000000000000', '2');
INSERT INTO `user` VALUES ('23', 'shu', '123', 'shuge', '', '12', 'we@he.com', '我的职业是什么？', '程序员', '00000000000000', '2');
INSERT INTO `user` VALUES ('24', '00', '000', '00', '\0', '0', 'upleague@163.com', '我的职业是什么？', '00', '00000000000000', '2');
INSERT INTO `user` VALUES ('25', '707114316', '123456', '宝宝', '\0', '18', '707114316@qq.com', '我的职业是什么？', '学生', '00000000000000', '2');
INSERT INTO `user` VALUES ('26', '猪猪', '1212', '猪猪', '', '121', '12@12.com', '我最喜欢的动物是什么？', '12', '00000000000000', '2');
INSERT INTO `user` VALUES ('27', 'aaa139239', '139239', 'das', '', '26', '84791207@qq.com', '我的职业是什么？', 'sda', '00000000000000', '2');
INSERT INTO `user` VALUES ('28', 'parker', '123123', 'Parker', '', '21', '21@12.com', '我叫什么名字？', 'parker', '20091122095526', '2');
INSERT INTO `user` VALUES ('29', 'admin', 'admin', 'admin', '', '20', 'admin@admin.com', '我是不是管理员？', '是', '00000000000000', '1');
