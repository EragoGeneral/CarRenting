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

/*Table structure for table `system_menus` */

DROP TABLE IF EXISTS `system_menus`;

CREATE TABLE `system_menus` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `Name` varchar(20) NOT NULL COMMENT '菜单名称',
  `Link` varchar(100) DEFAULT NULL COMMENT '菜单链接',
  `Display_Order` int(11) DEFAULT NULL COMMENT '显示顺序',
  `Parent_ID` int(11) NOT NULL COMMENT '父节点ID',
  `Level` int(11) DEFAULT NULL COMMENT '菜单层级',
  `Path` varchar(50) DEFAULT NULL COMMENT '菜单路径',
  `Is_Deleted` varchar(1) NOT NULL COMMENT '是否有效',
  `Create_By` int(11) DEFAULT NULL COMMENT '创建人',
  `Create_Date` datetime DEFAULT NULL COMMENT '创建时间',
  `Update_By` int(11) DEFAULT NULL COMMENT '最后更新人',
  `Update_Date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`ID`,`Name`,`Parent_ID`,`Is_Deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `system_menus` */

insert  into `system_menus`(`ID`,`Name`,`Link`,`Display_Order`,`Parent_ID`,`Level`,`Path`,`Is_Deleted`,`Create_By`,`Create_Date`,`Update_By`,`Update_Date`) values (1,'系统管理','/System',1,-1,1,'1','0',1,'2016-07-20 10:50:03',1,'2016-07-20 10:50:08'),(2,'用户管理','resources/pages/user/user_list.html',1,1,2,'1.2','0',1,'2016-07-20 11:02:16',1,'2016-07-20 11:02:18'),(3,'菜单管理','resources/pages/menu/menus_list.html',3,1,2,'1.3','0',1,'2016-07-21 14:41:10',1,'2016-07-21 14:41:12'),(4,'供应商管理','/Provider',2,-1,1,'4','0',1,'2016-07-21 14:42:26',1,'2016-07-21 14:42:28'),(5,'供应商查询','resources/pages/provider/pro_list.html',1,4,2,'4.5','0',1,'2016-07-21 14:43:43',1,'2016-07-21 14:43:45'),(6,'角色管理','role/manage',2,1,2,'1.5','0',1,'2016-07-23 16:12:27',1,'2016-07-23 16:12:28');

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `system_users` */

insert  into `system_users`(`ID`,`Login_Name`,`User_Name`,`Password`,`Gender`,`Birth`,`Dept_No`,`Email`,`Mobile`,`Address`,`Create_By`,`Create_Date`,`Update_By`,`Update_Date`,`Is_Deleted`) values (1,'admin','系统管理员','admin','M','1991-01-14',0,'aa@gmail.com','13966201125','广东省深圳市南山区高新南七道',1,'2016-07-20 10:52:15',1,'2016-07-20 16:57:21','0'),(2,'Sales','销售主管','123456','F','1984-02-21',2,'sales@sina.com','17099382771',NULL,1,'2016-07-21 10:27:36',1,'2016-07-21 10:27:38','0'),(5,'HR','人事主管','123456','F','1989-06-30',1,'hr@gmail.com','13655230078',NULL,1,'2016-07-20 17:06:38',1,'2016-07-20 17:06:38','0'),(6,'zhangsan','张三','123456','M','1990-10-21',1,'zs@163.com','18933652201',NULL,1,'2016-07-21 10:23:29',1,'2016-07-21 10:23:26','0'),(7,'Lisi','李四','123456','F','1992-11-10',1,'ls@163.com','15200930092',NULL,1,'2016-07-21 10:24:14',1,'2016-07-21 10:24:17','0'),(8,'wangwu','王五','123456','M','1989-09-21',1,'ww@sohu.com','18300928810',NULL,1,'2016-07-21 10:25:03',1,'2016-07-21 10:25:06','0'),(9,'Support','技术支持','123456','F','1993-02-15',3,NULL,'15109886522',NULL,1,'2016-07-22 16:31:22',1,'2016-07-22 16:31:39','0');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `ubt_system_roles` */

insert  into `ubt_system_roles`(`ID`,`Code`,`Name`,`Order_No`,`Description`,`Create_By`,`Create_Date`,`Update_By`,`Update_Date`,`Is_Deleted`) values (1,'admin','超级管理员',1,'超级管理员，拥有全部权限',1,'2016-07-23 15:58:21',1,'2016-07-23 15:58:21','0');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
