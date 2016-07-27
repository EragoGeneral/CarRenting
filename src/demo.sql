/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.7.13-log : Database - mybatis
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`mybatis` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `mybatis`;

/*Table structure for table `class` */

DROP TABLE IF EXISTS `class`;

CREATE TABLE `class` (
  `c_id` int(11) NOT NULL AUTO_INCREMENT,
  `c_name` varchar(20) DEFAULT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `class` */

insert  into `class`(`c_id`,`c_name`,`teacher_id`) values (1,'class_a',1),(2,'class_b',2);

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `s_id` int(11) NOT NULL AUTO_INCREMENT,
  `s_name` varchar(20) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `student` */

insert  into `student`(`s_id`,`s_name`,`class_id`) values (1,'student_A',1),(2,'student_B',1),(3,'student_C',1),(4,'student_D',2),(5,'student_E',2),(6,'student_F',2);

/*Table structure for table `system_menus` */

DROP TABLE IF EXISTS `system_menus`;

CREATE TABLE `system_menus` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `Name` varchar(20) NOT NULL COMMENT '菜单名称',
  `Link` varchar(100) DEFAULT NULL COMMENT '菜单链接',
  `Display_Order` int(11) DEFAULT NULL COMMENT '显示顺序',
  `Parent_ID` int(11) NOT NULL COMMENT '父节点ID',
  `Level` int(11) DEFAULT NULL COMMENT '菜单层级',
  `Type` int(11) DEFAULT NULL COMMENT '资源类型',
  `Path` varchar(50) DEFAULT NULL COMMENT '菜单路径',
  `Is_Deleted` varchar(1) NOT NULL COMMENT '是否有效',
  `Create_By` int(11) DEFAULT NULL COMMENT '创建人',
  `Create_Date` datetime DEFAULT NULL COMMENT '创建时间',
  `Update_By` int(11) DEFAULT NULL COMMENT '最后更新人',
  `Update_Date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`ID`,`Name`,`Parent_ID`,`Is_Deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `system_menus` */

insert  into `system_menus`(`ID`,`Name`,`Link`,`Display_Order`,`Parent_ID`,`Level`,`Type`,`Path`,`Is_Deleted`,`Create_By`,`Create_Date`,`Update_By`,`Update_Date`) values (1,'系统管理','/System',1,-1,1,NULL,'1','0',1,'2016-07-20 10:50:03',1,'2016-07-20 10:50:08'),(2,'用户管理','user/manage',1,1,2,NULL,'1.2','0',1,'2016-07-20 11:02:16',1,'2016-07-20 11:02:18'),(3,'菜单管理','resources/pages/menu/menus_list.html',3,1,2,NULL,'1.3','0',1,'2016-07-21 14:41:10',1,'2016-07-21 14:41:12'),(4,'供应商管理','/Provider',2,-1,1,NULL,'4','1',1,'2016-07-21 14:42:26',1,'2016-07-21 14:42:28'),(5,'供应商查询','resources/pages/provider/pro_list.html',1,4,2,NULL,'4.5','1',1,'2016-07-21 14:43:43',1,'2016-07-21 14:43:45'),(6,'角色管理','role/manage',2,1,2,NULL,'1.5','0',1,'2016-07-23 16:12:27',1,'2016-07-23 16:12:28'),(7,'资源管理','resource/manage',3,1,2,NULL,'1.7','0',1,'2016-07-26 10:05:38',1,'2016-07-26 10:05:40');

/*Table structure for table `system_users` */

DROP TABLE IF EXISTS `system_users`;

CREATE TABLE `system_users` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `Login_Name` varchar(30) NOT NULL,
  `User_Name` varchar(30) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `Gender` varchar(1) DEFAULT NULL,
  `Birth` date DEFAULT NULL,
  `Dept_No` int(11) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Mobile` varchar(11) DEFAULT NULL,
  `Address` varchar(200) DEFAULT NULL,
  `Create_By` int(11) DEFAULT NULL,
  `Create_Date` datetime DEFAULT NULL,
  `Update_By` int(11) DEFAULT NULL,
  `Update_Date` datetime DEFAULT NULL,
  `Is_Deleted` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `system_users` */

insert  into `system_users`(`ID`,`Login_Name`,`User_Name`,`Password`,`Gender`,`Birth`,`Dept_No`,`Email`,`Mobile`,`Address`,`Create_By`,`Create_Date`,`Update_By`,`Update_Date`,`Is_Deleted`) values (1,'admin','系统管理员','admin','M','1991-01-14',0,'aa@gmail.com','13966201125','广东省深圳市南山区高新南七道',1,'2016-07-20 10:52:15',1,'2016-07-20 16:57:21','0'),(2,'Sales','销售主管','123456','F','1984-02-21',2,'sales@sina.com','17099382771',NULL,1,'2016-07-21 10:27:36',1,'2016-07-21 10:27:38','0'),(5,'HR','人事主管','123456','F','1989-06-30',1,'hr@gmail.com','13655230078',NULL,1,'2016-07-20 17:06:38',1,'2016-07-20 17:06:38','0'),(6,'zhangsan','张三','123456','M','1990-10-21',1,'zs@163.com','18933652201',NULL,1,'2016-07-21 10:23:29',1,'2016-07-21 10:23:26','0'),(7,'Lisi','李四','123456','F','1992-11-10',1,'ls@163.com','15200930092',NULL,1,'2016-07-21 10:24:14',1,'2016-07-21 10:24:17','0'),(8,'wangwu','王五','123456','M','1989-09-21',1,'ww@sohu.com','18300928810',NULL,1,'2016-07-21 10:25:03',1,'2016-07-21 10:25:06','0'),(9,'Support','技术支持','123456','F','1993-02-15',3,'support@qq.com','15109886522',NULL,1,'2016-07-22 16:31:22',1,'2016-07-27 14:40:10','0'),(10,'OP1','秦六合','123456','F','1993-08-03',NULL,NULL,'13789099382',NULL,1,'2016-07-26 14:22:45',1,'2016-07-26 14:24:11','0'),(11,'sale1','销售专员1','123456','F','1994-02-11',NULL,'sales1@sina.com','18966352210',NULL,1,'2016-07-27 14:01:36',1,'2016-07-27 14:02:47','0'),(12,'sale2','销售专员2','123456','F','1990-12-26',NULL,'sales2@gmail.com','17533021156',NULL,1,'2016-07-27 14:16:31',1,'2016-07-27 14:16:44','0');

/*Table structure for table `teacher` */

DROP TABLE IF EXISTS `teacher`;

CREATE TABLE `teacher` (
  `t_id` int(11) NOT NULL AUTO_INCREMENT,
  `t_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`t_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `teacher` */

insert  into `teacher`(`t_id`,`t_name`) values (1,'teacher1'),(2,'teacher2');

/*Table structure for table `ubt_system_resources` */

DROP TABLE IF EXISTS `ubt_system_resources`;

CREATE TABLE `ubt_system_resources` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `Name` varchar(20) NOT NULL COMMENT '资源名称',
  `Description` varchar(200) DEFAULT NULL COMMENT '资源描述',
  `Url` varchar(100) DEFAULT NULL COMMENT '资源链接',
  `Display_Order` int(11) DEFAULT NULL COMMENT '显示顺序',
  `Parent_ID` int(11) NOT NULL COMMENT '父节点ID',
  `Level` int(11) DEFAULT NULL COMMENT '资源层级',
  `Type` int(11) DEFAULT NULL COMMENT '资源类型',
  `Path` varchar(50) DEFAULT NULL COMMENT '资源路径',
  `Is_Deleted` varchar(1) NOT NULL COMMENT '是否有效',
  `Create_By` int(11) DEFAULT NULL COMMENT '创建人',
  `Create_Date` datetime DEFAULT NULL COMMENT '创建时间',
  `Update_By` int(11) DEFAULT NULL COMMENT '最后更新人',
  `Update_Date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`ID`,`Name`,`Parent_ID`,`Is_Deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `ubt_system_resources` */

insert  into `ubt_system_resources`(`ID`,`Name`,`Description`,`Url`,`Display_Order`,`Parent_ID`,`Level`,`Type`,`Path`,`Is_Deleted`,`Create_By`,`Create_Date`,`Update_By`,`Update_Date`) values (1,'系统管理','系统管理','/System',1,-1,1,1,'1','0',1,'2016-07-20 10:50:03',1,'2016-07-20 10:50:08'),(2,'用户管理','用户管理','resources/pages/user/user_list.html',1,1,2,1,'1.2','0',1,'2016-07-20 11:02:16',1,'2016-07-27 13:13:06'),(3,'菜单管理','菜单管理','resources/pages/menu/menus_list.html',3,1,2,1,'1.3','0',1,'2016-07-21 14:41:10',1,'2016-07-21 14:41:12'),(6,'角色管理','角色管理','role/manage',2,1,2,1,'1.6','0',1,'2016-07-23 16:12:27',1,'2016-07-23 16:12:28'),(7,'列表','角色列表','role/list',1,6,3,0,'1.6.7','0',1,'2016-07-25 17:26:14',1,'2016-07-25 17:26:16'),(8,'添加','角色添加','/role/add',2,6,3,0,'1.6.8','0',1,'2016-07-26 13:48:00',1,'2016-07-27 13:15:29'),(9,'修改','角色修改','/role/edit',3,6,3,0,'1.6.9','0',1,'2016-07-26 13:48:46',1,'2016-07-27 13:43:12'),(10,'列表','菜单列表','/resource/list',1,3,3,0,NULL,'0',1,'2016-07-26 16:33:54',1,'2016-07-26 16:33:54'),(11,'添加','添加菜单','/resource/add',1,3,NULL,0,NULL,'0',1,'2016-07-26 16:39:58',1,'2016-07-27 13:17:16'),(12,'添加','添加用户','/user/add',0,2,NULL,0,NULL,'0',1,'2016-07-27 13:16:07',1,'2016-07-27 13:17:09'),(13,'授权','角色授权','/role/grant',3,6,NULL,0,NULL,'0',1,'2016-07-27 13:17:44',1,'2016-07-27 13:17:54');

/*Table structure for table `ubt_system_role_resource` */

DROP TABLE IF EXISTS `ubt_system_role_resource`;

CREATE TABLE `ubt_system_role_resource` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Res_ID` int(11) DEFAULT NULL COMMENT '资源ID',
  `Role_ID` int(11) DEFAULT NULL COMMENT '角色ID',
  `Create_By` int(11) DEFAULT NULL,
  `Create_Date` datetime DEFAULT NULL,
  `Update_By` int(11) DEFAULT NULL,
  `Update_Date` datetime DEFAULT NULL,
  `Is_Deleted` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Res_ID` (`Res_ID`),
  KEY `Role_ID` (`Role_ID`),
  CONSTRAINT `ubt_system_role_resource_ibfk_1` FOREIGN KEY (`Res_ID`) REFERENCES `ubt_system_resources` (`ID`),
  CONSTRAINT `ubt_system_role_resource_ibfk_2` FOREIGN KEY (`Role_ID`) REFERENCES `ubt_system_roles` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

/*Data for the table `ubt_system_role_resource` */

insert  into `ubt_system_role_resource`(`ID`,`Res_ID`,`Role_ID`,`Create_By`,`Create_Date`,`Update_By`,`Update_Date`,`Is_Deleted`) values (40,6,6,1,'2016-07-27 10:44:05',1,'2016-07-27 19:24:47','1'),(41,7,6,1,'2016-07-27 10:44:05',1,'2016-07-27 19:24:47','1'),(42,6,6,1,'2016-07-27 10:44:17',1,'2016-07-27 19:24:47','1'),(43,7,6,1,'2016-07-27 10:44:17',1,'2016-07-27 19:24:47','1'),(44,8,6,1,'2016-07-27 10:44:17',1,'2016-07-27 19:24:47','1'),(45,6,6,1,'2016-07-27 19:24:47',1,'2016-07-27 19:24:47','0'),(46,7,6,1,'2016-07-27 19:24:47',1,'2016-07-27 19:24:47','0'),(47,8,6,1,'2016-07-27 19:24:47',1,'2016-07-27 19:24:47','0'),(48,9,6,1,'2016-07-27 19:24:47',1,'2016-07-27 19:24:47','0'),(49,13,6,1,'2016-07-27 19:24:47',1,'2016-07-27 19:24:47','0'),(50,2,10,1,'2016-07-27 19:25:03',1,'2016-07-27 19:25:03','0'),(51,12,10,1,'2016-07-27 19:25:03',1,'2016-07-27 19:25:03','0'),(52,6,10,1,'2016-07-27 19:25:03',1,'2016-07-27 19:25:03','0'),(53,7,10,1,'2016-07-27 19:25:03',1,'2016-07-27 19:25:03','0'),(54,8,10,1,'2016-07-27 19:25:03',1,'2016-07-27 19:25:03','0'),(55,9,10,1,'2016-07-27 19:25:03',1,'2016-07-27 19:25:03','0');

/*Table structure for table `ubt_system_roles` */

DROP TABLE IF EXISTS `ubt_system_roles`;

CREATE TABLE `ubt_system_roles` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(10) DEFAULT NULL,
  `Name` varchar(20) NOT NULL,
  `Order_No` int(11) DEFAULT NULL,
  `Description` varchar(200) DEFAULT NULL,
  `Create_By` int(11) DEFAULT NULL,
  `Create_Date` datetime DEFAULT NULL,
  `Update_By` int(11) DEFAULT NULL,
  `Update_Date` datetime DEFAULT NULL,
  `Is_Deleted` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `ubt_system_roles` */

insert  into `ubt_system_roles`(`ID`,`Code`,`Name`,`Order_No`,`Description`,`Create_By`,`Create_Date`,`Update_By`,`Update_Date`,`Is_Deleted`) values (1,'admin','超级管理员',1,'超级管理员，拥有全部权限',1,'2016-07-23 15:58:21',1,'2016-07-25 15:48:28','0'),(2,'op1','运维部门1',6,'负责部门1的运维工作',1,'2016-07-25 11:18:12',1,'2016-07-25 11:18:13','0'),(3,'op2','运维部门2',7,'负责部门2的运维工作',1,'2016-07-25 11:18:34',1,'2016-07-25 11:18:34','0'),(4,'financial','财务角色',3,'负责财务部门的工作',1,'2016-07-25 11:20:17',1,'2016-07-25 11:20:19','0'),(5,'market','市场角色',5,'负责市场部门的工作',1,'2016-07-25 11:20:21',1,'2016-07-25 11:20:23','0'),(6,'hr','人事角色',2,'负责人事部门的工作',1,'2016-07-25 11:20:25',1,'2016-07-27 10:44:59','0'),(7,'dev','研发角色',4,'负责研发部门的工作',1,'2016-07-25 11:20:28',1,'2016-07-25 11:20:30','0'),(8,'product','产品角色',NULL,'负责产品部门的工作',1,'2016-07-25 15:30:01',1,'2016-07-27 13:44:57','0'),(10,'office','行政角色',NULL,'负责行政部门的工作',1,'2016-07-25 15:49:24',1,'2016-07-25 15:49:34','0');

/*Table structure for table `ubt_system_user_role` */

DROP TABLE IF EXISTS `ubt_system_user_role`;

CREATE TABLE `ubt_system_user_role` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `User_ID` int(11) DEFAULT NULL COMMENT '用户ID',
  `Role_ID` int(11) DEFAULT NULL COMMENT '角色ID',
  `Create_By` int(11) DEFAULT NULL,
  `Create_Date` datetime DEFAULT NULL,
  `Update_By` int(11) DEFAULT NULL,
  `Update_Date` datetime DEFAULT NULL,
  `Is_Deleted` varchar(1) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

/*Data for the table `ubt_system_user_role` */

insert  into `ubt_system_user_role`(`ID`,`User_ID`,`Role_ID`,`Create_By`,`Create_Date`,`Update_By`,`Update_Date`,`Is_Deleted`) values (1,1,1,1,'2016-07-27 16:39:26',1,'2016-07-27 19:37:02','1'),(2,1,2,1,'2016-07-27 16:40:30',1,'2016-07-27 19:37:02','1'),(3,1,3,1,'2016-07-27 16:40:39',1,'2016-07-27 19:37:02','1'),(4,5,3,1,'2016-07-27 17:05:16',1,'2016-07-27 19:38:39','1'),(5,1,4,1,'2016-07-27 17:20:04',1,'2016-07-27 19:37:02','1'),(6,1,7,1,'2016-07-27 17:20:12',1,'2016-07-27 19:37:02','1'),(7,1,10,1,'2016-07-27 17:20:10',1,'2016-07-27 19:37:02','1'),(8,5,10,1,'2016-07-27 17:20:30',1,'2016-07-27 19:38:39','1'),(9,10,2,1,'2016-07-27 18:24:13',1,'2016-07-27 18:25:19','1'),(10,10,3,1,'2016-07-27 18:24:15',1,'2016-07-27 18:25:19','1'),(11,10,3,1,'2016-07-27 18:25:19',1,'2016-07-27 18:25:19','0'),(12,10,4,1,'2016-07-27 18:25:19',1,'2016-07-27 18:25:19','0'),(13,1,1,1,'2016-07-27 19:37:02',1,'2016-07-27 19:37:02','0'),(14,1,2,1,'2016-07-27 19:37:02',1,'2016-07-27 19:37:02','0'),(15,1,3,1,'2016-07-27 19:37:02',1,'2016-07-27 19:37:02','0'),(16,1,4,1,'2016-07-27 19:37:02',1,'2016-07-27 19:37:02','0'),(17,1,7,1,'2016-07-27 19:37:02',1,'2016-07-27 19:37:02','0'),(18,1,10,1,'2016-07-27 19:37:02',1,'2016-07-27 19:37:02','0'),(19,1,5,1,'2016-07-27 19:37:02',1,'2016-07-27 19:37:02','0'),(20,1,6,1,'2016-07-27 19:37:02',1,'2016-07-27 19:37:02','0'),(21,1,8,1,'2016-07-27 19:37:02',1,'2016-07-27 19:37:02','0'),(22,5,6,1,'2016-07-27 19:38:39',1,'2016-07-27 19:38:39','0');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
