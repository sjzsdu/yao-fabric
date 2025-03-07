-- MySQL dump 10.13  Distrib 8.1.0, for macos13.3 (arm64)
--
-- Host: sh-cdb-45xs0s2w.sql.tencentcdb.com    Database: yao-fabric
-- ------------------------------------------------------
-- Server version	5.7.18-txsql-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'ae11af4c-11d2-11eb-bcee-94292fc1ddff:1-966967';

--
-- Table structure for table `admin_user`
--

DROP TABLE IF EXISTS `admin_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `department_ids` json DEFAULT NULL COMMENT 'T:json|部门',
  `role_ids` json DEFAULT NULL COMMENT 'T:json|角色',
  `type` enum('admin','staff','user','robot') NOT NULL DEFAULT 'user' COMMENT '账号类型 admin 管理员, staff 员工, user 用户, robot 机器人',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机号',
  `password` varchar(256) DEFAULT NULL COMMENT '登录密码',
  `password2nd` varchar(256) DEFAULT NULL COMMENT '操作密码',
  `name` varchar(80) DEFAULT NULL COMMENT '姓名',
  `idcard` varchar(256) DEFAULT NULL COMMENT '身份证号码',
  `key` varchar(256) DEFAULT NULL COMMENT 'API Key',
  `secret` varchar(256) DEFAULT NULL COMMENT 'API 密钥',
  `extra` json DEFAULT NULL COMMENT 'T:json|扩展信息',
  `status` enum('enabled','disabled') NOT NULL DEFAULT 'enabled' COMMENT '用户状态 enabled 有效, disabled 无效',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '::Delete At',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '::Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '::Updated At',
  `__restore_data` json DEFAULT NULL COMMENT 'T:json|',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_unique` (`key`),
  UNIQUE KEY `type_email_unique` (`type`,`email`),
  UNIQUE KEY `type_mobile_unique` (`type`,`mobile`),
  KEY `email_index` (`email`),
  KEY `mobile_index` (`mobile`),
  KEY `password_index` (`password`),
  KEY `password2nd_index` (`password2nd`),
  KEY `name_index` (`name`),
  KEY `idcard_index` (`idcard`),
  KEY `secret_index` (`secret`),
  KEY `status_index` (`status`),
  KEY `created_at_index` (`created_at`),
  KEY `updated_at_index` (`updated_at`),
  KEY `deleted_at_index` (`deleted_at`),
  KEY `type_index` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_user`
--

LOCK TABLES `admin_user` WRITE;
/*!40000 ALTER TABLE `admin_user` DISABLE KEYS */;
INSERT INTO `admin_user` VALUES (1,NULL,NULL,'admin','xiang@iqka.com',NULL,'$2a$04$gDARS9ZCIzyQFVl1sERs1up5.rL1w1KtstT6T.fGaVrkBFl82KRDm',NULL,'管理员',NULL,'8304925176','EA2257D8280FEEAB00697FFADF1008B54A7DAEA20C97B0EC4C1470E908C120C90143DB63EE66B0CDFF9F69917680151E','{\"sex\": \"男\"}','enabled',NULL,'2023-07-17 12:59:32',NULL,NULL),(2,'[1]','[1]','staff','test004@163.com','FB503AD9E4875740445976187ED932F1','$2a$04$lo4C4gbh0.BQldFqRhOCkOlcsDLJD0w/25BD6sT7YhWgg/BUtfIwG',NULL,'张飞','4BD94B75BE16B4ABE222EB95D51374919DF8AC31BB97FAF1EBA90EF00480F538',NULL,NULL,NULL,'enabled',NULL,'2023-07-17 13:18:51',NULL,NULL),(3,'[4, 3, 5]','[2]','staff','test005@163.com','50F32F3860CB0D3F2EEFA78CF1E16FE4','$2a$04$hm8hIQ.NxqIzleuaZeAPeeF0TvyUaK/jKyrBK17TrkxnptkycOoji',NULL,'关羽',NULL,NULL,NULL,'null','enabled',NULL,'2023-07-17 13:39:33','2023-08-10 23:23:20',NULL),(4,'[5]','[3]','staff','zhaoyun@163.com','50EFCF4784A79540D1BE6BA8143C0EE5','$2a$04$LOY6zUwzyX7NjkNtz7wEGOUvkex9uhS1vqRUyn74YZuGkMNZA6bEO',NULL,'赵云','4BD94B75BE16B4ABE222EB95D51374919DF8AC31BB97FAF1EBA90EF00480F538',NULL,NULL,NULL,'enabled',NULL,'2023-07-18 13:53:04',NULL,NULL);
/*!40000 ALTER TABLE `admin_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(200) NOT NULL COMMENT '公司名称',
  `short_name` varchar(64) DEFAULT NULL COMMENT 'ShortName',
  `tel` varchar(64) DEFAULT NULL COMMENT '电话',
  `fax` varchar(64) DEFAULT NULL COMMENT '传真',
  `__DEL__province` varchar(50) DEFAULT NULL COMMENT '省份',
  `__DEL__city` varchar(50) DEFAULT NULL COMMENT '城市',
  `__DEL__district` varchar(50) DEFAULT NULL COMMENT '区县',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `lng` decimal(12,6) unsigned DEFAULT NULL COMMENT 'Longitude',
  `lat` decimal(12,6) unsigned DEFAULT NULL COMMENT 'Latitude',
  `type` enum('customer','supplier') NOT NULL DEFAULT 'customer' COMMENT '公司类型 customer 客户, supplier 供应商',
  `logo` json DEFAULT NULL COMMENT 'T:json|LOGO',
  `images` json DEFAULT NULL COMMENT 'T:json|图集',
  `summary` varchar(1024) DEFAULT NULL COMMENT '简介',
  `credit_code` varchar(200) DEFAULT NULL COMMENT '营业执照',
  `tax_code` varchar(200) DEFAULT NULL COMMENT '税务登记号',
  `bank_code` varchar(200) DEFAULT NULL COMMENT '银行账户',
  `bank_name` varchar(200) DEFAULT NULL COMMENT '开户行',
  `link` varchar(200) DEFAULT NULL COMMENT '网址',
  `tags` json DEFAULT NULL COMMENT 'T:json|Tags',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '::Delete At',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '::Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '::Updated At',
  `__restore_data` json DEFAULT NULL COMMENT 'T:json|',
  `area` json DEFAULT NULL COMMENT 'T:json|地区',
  `user_id` int(11) DEFAULT NULL COMMENT '员工',
  `department_id` int(11) DEFAULT NULL COMMENT '部门',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique` (`name`),
  UNIQUE KEY `tel_unique` (`tel`),
  KEY `short_name_index` (`short_name`),
  KEY `fax_index` (`fax`),
  KEY `province_index` (`__DEL__province`),
  KEY `city_index` (`__DEL__city`),
  KEY `district_index` (`__DEL__district`),
  KEY `address_index` (`address`),
  KEY `type_index` (`type`),
  KEY `created_at_index` (`created_at`),
  KEY `updated_at_index` (`updated_at`),
  KEY `deleted_at_index` (`deleted_at`),
  KEY `user_id_index` (`user_id`),
  KEY `department_id_index` (`department_id`),
  KEY `lng_index` (`lng`),
  KEY `lat_index` (`lat`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,'绍兴市金桥纺织有限公司','金桥纺织','0575-88132538',NULL,NULL,NULL,NULL,'袍江工业区北二路北',NULL,NULL,'customer','null','null',NULL,'91330600760191559U',NULL,NULL,NULL,NULL,'[\"家庭作坊\", \"初创公司\"]',NULL,'2023-08-02 14:27:55','2023-08-03 11:59:10',NULL,'[\"浙江省\", \"绍兴市\", \"越城区\"]',3,5),(2,'广州润微服装有限公司','润微服装','13000000000',NULL,NULL,NULL,NULL,'江南大道南362号3414房',NULL,NULL,'customer','[\"http://yao-fabric-1252427671.cos.ap-shanghai.myqcloud.com/logo/2023-08-03/acQXLulfXoE7IcYL.jpg\"]','null',NULL,'914401016893200382',NULL,NULL,NULL,' www.realwill.com','[\"经营规范\"]',NULL,'2023-08-03 11:48:31','2023-08-16 12:30:07',NULL,'[\"广东省\", \"广州市\", \"海珠区\"]',0,0),(3,'杭州叁幂服装有限责任公司','叁幂服装',NULL,NULL,NULL,NULL,NULL,'康达路508号3号楼4层',NULL,NULL,'customer',NULL,NULL,NULL,'91330110MA7HP7U014',NULL,NULL,NULL,NULL,'[\"家庭作坊\"]',NULL,'2023-08-04 13:25:56','2023-08-16 12:30:10',NULL,'[\"浙江省\", \"杭州市\", \"临安区\"]',0,0),(4,'浙江原色数码印花科技有限公司','原色数码','0575-88132540','0575-46783453',NULL,NULL,NULL,'轻纺大厦3栋301',NULL,NULL,'supplier','null','null',NULL,NULL,NULL,NULL,NULL,NULL,'[\"经营规范\"]',NULL,'2023-08-09 13:24:35','2023-08-16 12:29:57',NULL,'[\"浙江省\", \"绍兴市\", \"柯桥区\"]',1,2),(5,'绍兴市紫青纺织有限公司','紫青纺织','13455556666',NULL,NULL,NULL,NULL,'柯北贸易中心7幢405',NULL,NULL,'customer','null','null',NULL,NULL,NULL,NULL,NULL,NULL,'[\"家庭作坊\"]',NULL,'2023-08-09 13:26:38','2023-08-16 12:32:05',NULL,'[\"浙江省\", \"绍兴市\", \"柯桥区\"]',0,0),(6,'杭州纺业链科技有限公司','纺业链','0571-23456754',NULL,NULL,NULL,NULL,'杭州市西湖区西溪产业园9幢304',NULL,NULL,'customer','null','null',NULL,NULL,NULL,NULL,NULL,NULL,'null',NULL,'2023-08-09 13:32:18','2023-08-09 13:36:03',NULL,'[\"浙江省\", \"杭州市\", \"西湖区\"]',1,1);
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL COMMENT '部门名称',
  `description` varchar(1024) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL COMMENT '上级部门id,department表主键id',
  `order` int(11) NOT NULL DEFAULT '1' COMMENT '排序越大越靠前',
  `user_id` int(11) DEFAULT NULL COMMENT '部门领导id',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '::Delete At',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '::Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '::Updated At',
  `__restore_data` json DEFAULT NULL COMMENT 'T:json|',
  PRIMARY KEY (`id`),
  KEY `created_at_index` (`created_at`),
  KEY `updated_at_index` (`updated_at`),
  KEY `deleted_at_index` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'总经理','负责公司总体的计划',0,99,2,NULL,'2023-07-17 12:56:40',NULL,NULL),(2,'市场部','负责市场推广',0,99,NULL,NULL,'2023-07-17 12:56:40',NULL,NULL),(3,'生产部','负责生产管理',0,98,NULL,NULL,'2023-07-17 12:56:40',NULL,NULL),(4,'行政部','负责公司日常办公秩序维护等',0,98,NULL,NULL,'2023-07-17 12:56:41',NULL,NULL),(5,'销售部','负责产品销售等',0,98,NULL,NULL,'2023-07-17 12:56:41',NULL,NULL),(6,'抖音营销部','负责市场推广和营销',2,1,2,NULL,'2023-07-17 13:32:57',NULL,NULL),(7,'一分厂','生产化纤面料',3,90,2,NULL,'2023-07-17 13:33:31',NULL,NULL);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dict`
--

DROP TABLE IF EXISTS `dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dict` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL COMMENT '字典名称',
  `remark` varchar(1024) DEFAULT NULL,
  `items` json DEFAULT NULL COMMENT 'T:json|',
  `order` int(11) NOT NULL DEFAULT '1' COMMENT '排序越大越靠前',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '::Delete At',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '::Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '::Updated At',
  `__restore_data` json DEFAULT NULL COMMENT 'T:json|',
  PRIMARY KEY (`id`),
  KEY `created_at_index` (`created_at`),
  KEY `updated_at_index` (`updated_at`),
  KEY `deleted_at_index` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dict`
--

LOCK TABLES `dict` WRITE;
/*!40000 ALTER TABLE `dict` DISABLE KEYS */;
INSERT INTO `dict` VALUES (1,'面料标签','面料标签系统，通过标签来标识面料的特点','[{\"id\": \"_NNI0MWy3UUVguX_O8x5Tw1690669727981\", \"color\": \"#121258\", \"label\": \"春夏\", \"chosen\": false, \"status\": true, \"selected\": false}, {\"id\": \"_8cTEsvFzB4Zwk8ll1Iy201690669743297\", \"color\": \"#581212\", \"label\": \"秋冬\", \"chosen\": false, \"selected\": false}, {\"id\": \"_bx7qWWqlLNLPzcfKG5-V_1690669778158\", \"color\": \"#125812\", \"label\": \"磨砂\", \"chosen\": false, \"selected\": false}, {\"id\": \"_e59ShpXx90hT8WOjBu3TC1690669881222\", \"color\": \"#8e0a0a\", \"label\": \"日韩\", \"chosen\": false, \"status\": true, \"selected\": false}, {\"id\": \"_RzZtmhXKGM1R2og8sJ72e1690669862946\", \"color\": \"#d37171\", \"label\": \"欧美\", \"chosen\": false, \"selected\": false}]',99,NULL,'2023-07-17 12:59:31','2023-07-30 13:59:45',NULL),(2,'门幅单位','面料门幅的单位，权重是各单位的换算关系，比如米的权重是1,1米=100厘米，所以厘米的权重是100,1米=39.37英寸，所以英寸的权重是39.37','[{\"id\": \"_mq8VUtdhMcyARZZaVA-VR1689945640353\", \"label\": \"厘米\", \"chosen\": false, \"status\": true, \"weight\": 100, \"selected\": false}, {\"id\": \"_VQtRAu0tHUtfWeErJyb-v1689945701549\", \"label\": \"米\", \"chosen\": false, \"status\": false, \"weight\": 1, \"selected\": false}, {\"id\": \"_OH33MoiZYd8SPbf40vhWr1689945686983\", \"label\": \"英寸\", \"chosen\": false, \"weight\": 39.37, \"selected\": false}]',90,NULL,'2023-07-21 13:24:44','2023-07-29 22:23:14',NULL),(3,'克重单位','克重单位， 衡量面料的厚重成都','[{\"id\": \"_s3kNtseMyaFWKKNuJDDKe1689945917442\", \"color\": \"#345455\", \"label\": \"g/m^2\", \"chosen\": false, \"status\": true, \"selected\": false}, {\"id\": \"_P5sARpxd4YwRlbmiR3Usj1689945938278\", \"color\": \"#337766\", \"label\": \"g/m\", \"chosen\": false, \"selected\": false}]',90,NULL,'2023-07-21 13:26:44','2023-07-29 22:23:01',NULL),(4,'only a test',NULL,NULL,1,'2023-07-21 13:35:53','2023-07-21 13:35:49',NULL,'{\"id\": 4}'),(5,'asdf',NULL,NULL,1,'2023-07-21 13:55:43','2023-07-21 13:55:38',NULL,'{\"id\": 5}'),(6,'公司标签','公司标签，标签系统可以用来标识和分类公司单位','[{\"id\": \"_lp24PQoKpMgqCm8z97NNQ1690983840018\", \"color\": \"#480303\", \"label\": \"上市公司\", \"chosen\": false, \"selected\": false}, {\"id\": \"_AVKWE7p0UYku0Br4NiMc41690983866104\", \"color\": \"#1902bd\", \"label\": \"家庭作坊\"}, {\"id\": \"_-Nylk_g12vLvzCfl8JYli1690983885659\", \"color\": \"#721e1e\", \"label\": \"初创公司\"}, {\"id\": \"_SPd2q_NvHQ3REqvIpRz8X1690983909905\", \"label\": \"经营规范\"}]',1,NULL,'2023-08-02 13:45:34',NULL,NULL),(7,'联系人标签',NULL,'[{\"id\": \"_LDS3ynAjxTx7ShPgsOWMl1691624902210\", \"color\": \"#3fd307\", \"label\": \"随和\", \"chosen\": false, \"selected\": false}, {\"id\": \"_UONIY9Ww2uCnXomQ9ZE5c1691624920884\", \"color\": \"#ea0c0c\", \"label\": \"易怒\"}, {\"id\": \"_SvK57nn1TnU4YiJSY4lkM1691624947653\", \"label\": \"斤斤计较\"}, {\"id\": \"_OkYXkplpu2MDTxlIcyZ4K1691625021355\", \"label\": \"乐于助人\"}, {\"id\": \"_kZGWAUuU-vAugze_RDjd-1691625039861\", \"label\": \"热情\"}]',67,'2023-08-09 23:51:36','2023-08-09 23:51:05',NULL,'{\"id\": 7}'),(8,'联系人标签',NULL,'[{\"id\": \"_LDS3ynAjxTx7ShPgsOWMl1691624902210\", \"color\": \"#3fd307\", \"label\": \"随和\", \"chosen\": false, \"selected\": false}, {\"id\": \"_UONIY9Ww2uCnXomQ9ZE5c1691624920884\", \"color\": \"#ea0c0c\", \"label\": \"易怒\"}, {\"id\": \"_SvK57nn1TnU4YiJSY4lkM1691624947653\", \"label\": \"斤斤计较\"}, {\"id\": \"_OkYXkplpu2MDTxlIcyZ4K1691625021355\", \"color\": \"#d8128c\", \"label\": \"乐于助人\"}, {\"id\": \"_kZGWAUuU-vAugze_RDjd-1691625039861\", \"color\": \"#2c10c4\", \"label\": \"热情\"}]',67,NULL,'2023-08-09 23:51:22',NULL,NULL);
/*!40000 ALTER TABLE `dict` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dict_item`
--

DROP TABLE IF EXISTS `dict_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dict_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `label` varchar(50) NOT NULL COMMENT '字典项名称',
  `color` varchar(50) NOT NULL COMMENT '颜色',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '默认选中 true 是 false 否',
  `dict_id` int(11) NOT NULL COMMENT '字典项id',
  `order` int(11) NOT NULL DEFAULT '1' COMMENT '排序越大越靠前',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dict_item`
--

LOCK TABLES `dict_item` WRITE;
/*!40000 ALTER TABLE `dict_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `dict_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dictitem`
--

DROP TABLE IF EXISTS `dictitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dictitem` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `label` varchar(50) NOT NULL COMMENT '字典项名称',
  `color` varchar(50) NOT NULL COMMENT '颜色',
  `dict_id` int(11) NOT NULL COMMENT '字典项id',
  `order` int(11) NOT NULL DEFAULT '1' COMMENT '排序越大越靠前',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '::Delete At',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '::Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '::Updated At',
  `__restore_data` json DEFAULT NULL COMMENT 'T:json|',
  PRIMARY KEY (`id`),
  KEY `created_at_index` (`created_at`),
  KEY `updated_at_index` (`updated_at`),
  KEY `deleted_at_index` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dictitem`
--

LOCK TABLES `dictitem` WRITE;
/*!40000 ALTER TABLE `dictitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `dictitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fabric`
--

DROP TABLE IF EXISTS `fabric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fabric` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(64) NOT NULL COMMENT '::Name',
  `width` decimal(10,2) NOT NULL COMMENT '::Width',
  `width_unit` varchar(200) NOT NULL DEFAULT '厘米' COMMENT '门幅单位',
  `weight` decimal(4,1) NOT NULL COMMENT '::Weight',
  `weight_unit` varchar(200) NOT NULL DEFAULT 'g/m2' COMMENT '克重单位',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '::Delete At',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '::Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '::Updated At',
  `__restore_data` json DEFAULT NULL COMMENT 'T:json|',
  `__DEL__height_unit` varchar(50) DEFAULT NULL,
  `tags` json NOT NULL COMMENT 'T:json|面料标签',
  `images` json DEFAULT NULL COMMENT 'T:json|',
  PRIMARY KEY (`id`),
  KEY `name_index` (`name`),
  KEY `created_at_index` (`created_at`),
  KEY `updated_at_index` (`updated_at`),
  KEY `deleted_at_index` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fabric`
--

LOCK TABLES `fabric` WRITE;
/*!40000 ALTER TABLE `fabric` DISABLE KEYS */;
INSERT INTO `fabric` VALUES (2,3,'针织罗马布',156.00,'cm',350.0,'g/m2','2023-07-21 00:33:23','2023-07-17 12:59:34',NULL,NULL,NULL,'null',NULL),(3,2,'针织雪纺',150.00,'cm',80.0,'g/m2',NULL,'2023-07-17 12:59:34','2023-07-28 11:50:27',NULL,NULL,'[\"厚重\", \"春夏\"]','[\"/20230725/BAE3EC18-CD34-4F9D-B385-D9448C66B7E3.jpeg\", \"http://yao-fabric-1252427671.cos.ap-shanghai.myqcloud.com/fabric/2023-07-28/ut4_nRbepEJUb_M4.jpeg\", \"http://yao-fabric-1252427671.cos.ap-shanghai.myqcloud.com/fabric/2023-07-28/BrUneXShQxzebBP7.jpeg\"]'),(4,5,'麂皮绒',150.00,'cm',180.0,'g/m2',NULL,'2023-07-17 12:59:34','2023-07-25 00:25:45',NULL,NULL,'[\"秋冬\", \"春夏\"]','[\"/20230725/BAE3EC18-CD34-4F9D-B385-D9448C66B7E3.jpeg\"]'),(5,2,'大西瓜面料',23.00,'cm',150.0,'g/m2','2023-07-21 15:33:52','2023-07-21 00:33:18',NULL,NULL,NULL,'null',NULL),(6,NULL,'tatata',150.00,'cm',230.0,'g/m2','2023-07-21 14:30:39','2023-07-21 14:10:41',NULL,NULL,NULL,'null',NULL),(7,3,'空气层',156.00,'厘米',230.0,'g/m^2',NULL,'2023-07-22 08:17:40','2023-07-24 14:04:59',NULL,NULL,'[\"轻薄\", \"秋冬\"]','[\"/20230724/D5E2D919-2C33-4E8D-A17D-87A7ACF5822F.jpeg\", \"/20230724/E73B6CE2-B4D5-4BDD-8D1C-3AD6B21D89C9.jpeg\"]'),(8,4,'慕斯段',156.00,'厘米',230.0,'g/m^2',NULL,'2023-07-28 12:22:13',NULL,NULL,NULL,'[\"轻薄\", \"秋冬\", \"春夏\"]','[\"http://yao-fabric-1252427671.cos.ap-shanghai.myqcloud.com/fabric/2023-07-28/4YGjo2gMqN88Xq-D.webp\"]'),(9,3,'雪花绒',180.00,'厘米',280.0,'g/m2',NULL,'2023-07-29 22:55:03','2023-08-05 15:07:26',NULL,NULL,'[\"春夏\", \"秋冬\", \"日韩\"]','[\"http://yao-fabric-1252427671.cos.ap-shanghai.myqcloud.com/fabric/2023-07-30/M-_6Jh1D7mfh87nD.webp\", \"http://yao-fabric-1252427671.cos.ap-shanghai.myqcloud.com/fabric/2023-07-30/PutuCgpadVOm2pC8.webp\"]'),(10,2,'格子3D',180.00,'厘米',280.0,'g/m2',NULL,'2023-07-29 22:57:30','2023-08-05 15:07:26',NULL,NULL,'[\"春夏\", \"日韩\"]','[\"http://yao-fabric-1252427671.cos.ap-shanghai.myqcloud.com/fabric/2023-07-30/gU5fe8c9ggqILiU4.jpg\"]'),(11,1,'雪花丝面料',160.00,'厘米',156.0,'g/m2',NULL,'2023-08-10 13:05:58',NULL,NULL,NULL,'[\"春夏\", \"日韩\"]','[\"http://yao-fabric-1252427671.cos.ap-shanghai.myqcloud.com/fabric/2023-08-10/hAthK3a8EpccBVVU.jpg\"]');
/*!40000 ALTER TABLE `fabric` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fabric_category`
--

DROP TABLE IF EXISTS `fabric_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fabric_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(128) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT '1' COMMENT '排序越大越靠前',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '::Delete At',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '::Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '::Updated At',
  `__restore_data` json DEFAULT NULL COMMENT 'T:json|',
  PRIMARY KEY (`id`),
  KEY `name_index` (`name`),
  KEY `created_at_index` (`created_at`),
  KEY `updated_at_index` (`updated_at`),
  KEY `deleted_at_index` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fabric_category`
--

LOCK TABLES `fabric_category` WRITE;
/*!40000 ALTER TABLE `fabric_category` DISABLE KEYS */;
INSERT INTO `fabric_category` VALUES (1,NULL,'针织类',NULL,1,NULL,'2023-07-17 12:59:32',NULL,NULL),(2,1,'单面',NULL,1,NULL,'2023-07-17 12:59:32',NULL,NULL),(3,1,'双面',NULL,1,NULL,'2023-07-17 12:59:32',NULL,NULL),(4,NULL,'梭织',NULL,1,NULL,'2023-07-17 12:59:32',NULL,NULL),(5,4,'平纹',NULL,1,NULL,'2023-07-17 12:59:32',NULL,NULL),(6,4,'罗纹',NULL,1,NULL,'2023-07-17 12:59:32',NULL,NULL),(7,4,'斜纹',NULL,1,NULL,'2023-07-17 12:59:32',NULL,NULL);
/*!40000 ALTER TABLE `fabric_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follow`
--

DROP TABLE IF EXISTS `follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follow` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) NOT NULL COMMENT '标题',
  `remark` varchar(1024) DEFAULT NULL COMMENT '详情',
  `company_id` int(11) DEFAULT NULL,
  `person_id` int(11) DEFAULT NULL,
  `images` json DEFAULT NULL COMMENT 'T:json|快照',
  `user_id` int(11) DEFAULT NULL COMMENT '员工',
  `department_id` int(11) DEFAULT NULL COMMENT '部门',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '::Delete At',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '::Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '::Updated At',
  `__restore_data` json DEFAULT NULL COMMENT 'T:json|',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique` (`name`),
  KEY `user_id_index` (`user_id`),
  KEY `department_id_index` (`department_id`),
  KEY `created_at_index` (`created_at`),
  KEY `updated_at_index` (`updated_at`),
  KEY `deleted_at_index` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow`
--

LOCK TABLES `follow` WRITE;
/*!40000 ALTER TABLE `follow` DISABLE KEYS */;
INSERT INTO `follow` VALUES (1,'联络感情，咨询新订单','近期开发新产品比较多，会有比较大的订单',4,1,'null',2,1,NULL,'2023-08-14 14:12:31','2023-08-16 12:29:20',NULL),(2,'welcome',NULL,4,5,NULL,2,1,NULL,'2023-08-15 14:03:12',NULL,NULL),(3,'客户今天有点忙',NULL,1,2,NULL,2,1,NULL,'2023-08-15 14:08:18',NULL,NULL),(4,'联络感情，咨询新订单--------',NULL,4,2,NULL,2,1,NULL,'2023-08-15 14:32:09',NULL,NULL),(5,'联络感情，咨询新订单222222222',NULL,1,1,NULL,2,1,NULL,'2023-08-15 14:32:39',NULL,NULL);
/*!40000 ALTER TABLE `follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL COMMENT '权限名称',
  `path` varchar(50) DEFAULT NULL COMMENT '前端访问的url路径',
  `icon` varchar(50) DEFAULT NULL COMMENT '图标',
  `category` enum('items','setting','button') NOT NULL DEFAULT 'items' COMMENT '权限类别：items用户权限，setting管理员权限, button按钮权限',
  `blocks` tinyint(1) NOT NULL DEFAULT '0' COMMENT '区块 true 是 false 否',
  `parent_id` int(11) DEFAULT NULL COMMENT '上级权限id,menu表主键id',
  `order` int(11) DEFAULT '1' COMMENT '排序越大越靠前',
  `visible_menu` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示 true 是 false 否',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '::Delete At',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '::Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '::Updated At',
  `__restore_data` json DEFAULT NULL COMMENT 'T:json|',
  PRIMARY KEY (`id`),
  KEY `category_index` (`category`),
  KEY `created_at_index` (`created_at`),
  KEY `updated_at_index` (`updated_at`),
  KEY `deleted_at_index` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'管理员','/x/Table/admin.user','icon-user','setting',0,0,100,1,NULL,'2023-07-17 12:56:41','2023-07-17 13:30:50',NULL),(2,'系统设置','/setting','icon-settings','setting',0,0,101,1,NULL,'2023-07-17 12:56:41',NULL,NULL),(3,'系统设置','/setting','','setting',0,2,1,1,NULL,NULL,NULL,NULL),(4,'部门管理','/x/Table/admin.department','icon-archive','setting',0,2,1,1,NULL,'2023-07-17 12:56:42',NULL,NULL),(5,'权限管理','/x/Table/admin.menu','icon-archive','setting',0,2,1,1,NULL,'2023-07-17 12:56:42',NULL,NULL),(6,'产品管理','/x/table/product.fabric','icon-coffee','items',0,NULL,1,1,NULL,NULL,NULL,NULL),(7,'面料分类','/x/Table/product.category',' ','items',0,6,1,1,NULL,NULL,NULL,NULL),(8,'面料管理','/x/Table/product.fabric',' ','items',0,6,1,1,NULL,NULL,NULL,NULL),(9,'角色管理','/x/Table/admin.role',' ','setting',0,2,1,1,NULL,NULL,NULL,NULL),(10,'宠物管理','/x/table/demo.pet',' ','items',0,6,1,1,NULL,NULL,NULL,NULL),(11,'字典管理','/x/Table/admin.dict',' ','setting',0,2,1,1,NULL,NULL,NULL,NULL),(12,'查看','','','button',0,8,1,1,NULL,'2023-07-17 13:34:41','2023-07-17 13:38:11',NULL),(13,'编辑',NULL,NULL,'button',0,8,1,1,NULL,'2023-07-17 13:36:38',NULL,NULL),(14,'添加',NULL,NULL,'button',0,8,1,1,NULL,'2023-07-18 13:17:02','2023-07-18 13:17:17',NULL),(15,'删除',NULL,NULL,'button',0,8,1,1,NULL,'2023-07-18 13:17:28',NULL,NULL),(16,'添加',NULL,NULL,'button',0,4,1,1,NULL,'2023-07-19 00:18:52',NULL,NULL),(17,'编辑',NULL,NULL,'button',0,4,1,1,NULL,'2023-07-19 00:19:37',NULL,NULL),(18,'删除',NULL,NULL,'button',0,4,1,1,NULL,'2023-07-19 00:19:54',NULL,NULL),(19,'编辑',NULL,NULL,'button',0,9,1,1,NULL,'2023-07-19 00:20:13',NULL,NULL),(20,'添加',NULL,NULL,'button',0,9,1,1,NULL,'2023-07-19 00:20:35',NULL,NULL),(21,'删除',NULL,NULL,'button',0,9,1,1,NULL,'2023-07-19 00:20:49',NULL,NULL),(22,'编辑',NULL,NULL,'button',0,5,1,1,NULL,'2023-07-19 00:21:22',NULL,NULL),(23,'添加',NULL,NULL,'button',0,5,1,1,NULL,'2023-07-19 00:22:19',NULL,NULL),(24,'删除',NULL,NULL,'button',0,5,1,1,NULL,'2023-07-19 00:22:32',NULL,NULL),(25,'编辑',NULL,NULL,'button',0,11,1,1,NULL,'2023-07-19 00:22:48',NULL,NULL),(26,'添加',NULL,NULL,'button',0,11,1,1,NULL,'2023-07-19 00:23:12',NULL,NULL),(27,'删除',NULL,NULL,'button',0,11,1,1,NULL,'2023-07-19 00:23:30',NULL,NULL),(28,'添加',NULL,NULL,'button',0,1,1,1,NULL,'2023-07-20 11:55:52',NULL,NULL),(29,'编辑',NULL,NULL,'button',0,1,1,1,NULL,'2023-07-20 11:56:12',NULL,NULL),(30,'重置密码',NULL,NULL,'button',0,1,1,1,NULL,'2023-07-20 11:56:28',NULL,NULL),(31,'删除',NULL,NULL,'button',0,1,1,1,NULL,'2023-07-20 11:56:38','2023-07-21 15:08:57',NULL),(32,'仓库管理','/x/Table/product.fabric','icon-home','items',0,NULL,1,1,NULL,'2023-07-29 23:34:48','2023-08-02 00:14:16',NULL),(33,'CRM','/x/table/crm.company','icon-users','items',0,NULL,1,1,NULL,'2023-08-02 00:18:43','2023-08-02 12:10:36',NULL),(34,'往来单位','/x/table/crm.company',NULL,'items',0,33,1,1,NULL,'2023-08-02 12:11:01',NULL,NULL),(35,'添加',NULL,NULL,'button',0,34,1,1,NULL,'2023-08-02 12:11:20','2023-08-02 12:11:28',NULL),(36,'编辑',NULL,NULL,'button',0,34,1,1,NULL,'2023-08-02 13:37:21',NULL,NULL),(37,'删除',NULL,NULL,'button',0,34,1,1,NULL,'2023-08-02 13:37:40',NULL,NULL),(38,'查看',NULL,NULL,'button',0,34,1,1,NULL,'2023-08-02 13:37:52',NULL,'{\"id\": 38}'),(39,'联系人','/x/table/crm.person',NULL,'items',0,33,1,1,NULL,'2023-08-03 12:47:34',NULL,'{\"id\": 39}'),(40,'查看',NULL,NULL,'button',0,39,1,1,NULL,'2023-08-03 12:49:16',NULL,NULL),(41,'添加',NULL,NULL,'button',0,39,1,1,NULL,'2023-08-03 12:49:37',NULL,NULL),(42,'编辑',NULL,NULL,'button',0,39,1,1,NULL,'2023-08-03 12:50:16',NULL,NULL),(43,'删除',NULL,NULL,'button',0,39,1,1,NULL,'2023-08-03 12:50:31',NULL,NULL),(44,'归属',NULL,NULL,'button',0,34,1,1,NULL,'2023-08-12 14:21:38',NULL,'{\"id\": 44}'),(45,'归属',NULL,NULL,'button',0,39,1,1,NULL,'2023-08-12 14:21:53',NULL,NULL),(46,'客户管理','/x/table/crm.custom',NULL,'items',0,33,1,1,'2023-08-14 12:31:36','2023-08-13 09:35:38','2023-08-13 09:53:56','{\"id\": 46}'),(47,'查看',NULL,NULL,'button',0,46,1,1,NULL,'2023-08-13 11:36:28',NULL,NULL),(48,'添加',NULL,NULL,'button',0,46,1,1,NULL,'2023-08-13 11:36:48',NULL,NULL),(49,'编辑',NULL,NULL,'button',0,46,1,1,NULL,'2023-08-13 11:36:59',NULL,NULL),(50,'删除',NULL,NULL,'button',0,46,1,1,NULL,'2023-08-13 11:37:12',NULL,NULL),(51,'归属',NULL,NULL,'button',0,46,1,1,NULL,'2023-08-13 11:37:28',NULL,NULL),(52,'OA','/x/table/oa.todo','icon-airpay','items',0,NULL,1,1,NULL,'2023-08-14 12:32:58','2023-08-14 12:48:36',NULL),(53,'公海','/x/table/crm.pool',NULL,'items',0,33,1,1,NULL,'2023-08-14 12:39:48','2023-08-14 12:48:34',NULL),(54,'抢占',NULL,NULL,'button',0,53,1,1,NULL,'2023-08-14 12:41:16',NULL,NULL),(55,'跟进管理','/x/table/crm.follow',NULL,'items',0,33,1,1,NULL,'2023-08-14 12:48:31',NULL,NULL),(56,'添加',NULL,NULL,'button',0,55,1,1,NULL,'2023-08-14 12:49:04',NULL,NULL),(57,'编辑',NULL,NULL,'button',0,55,1,1,NULL,'2023-08-14 12:49:43',NULL,NULL),(58,'删除',NULL,NULL,'button',0,55,1,1,NULL,'2023-08-14 12:50:00',NULL,NULL),(59,'查看',NULL,NULL,'button',0,55,1,1,NULL,'2023-08-14 12:50:16',NULL,NULL),(60,'加入公海',NULL,NULL,'button',0,34,1,1,NULL,'2023-08-16 00:03:53',NULL,NULL);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) NOT NULL COMMENT '姓名',
  `mobile` varchar(100) DEFAULT NULL COMMENT '手机号',
  `wechat` varchar(100) DEFAULT NULL COMMENT '微信号',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `area` json DEFAULT NULL COMMENT 'T:json|地区',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `company_id` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '::Delete At',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '::Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '::Updated At',
  `__restore_data` json DEFAULT NULL COMMENT 'T:json|',
  `tags` json DEFAULT NULL COMMENT 'T:json|Tags',
  `user_id` int(11) DEFAULT NULL COMMENT '员工',
  `department_id` int(11) DEFAULT NULL COMMENT '部门',
  `__DEL__remark` varchar(100) NOT NULL COMMENT '任务详情',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique` (`name`),
  KEY `address_index` (`address`),
  KEY `created_at_index` (`created_at`),
  KEY `updated_at_index` (`updated_at`),
  KEY `deleted_at_index` (`deleted_at`),
  KEY `user_id_index` (`user_id`),
  KEY `department_id_index` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'张三','13755669900',NULL,'123133556@qq.com',NULL,NULL,1,NULL,'2023-08-03 13:30:50',NULL,NULL,NULL,NULL,NULL,''),(2,'刘德华','13755669901',NULL,'12313446@qq.com','null',NULL,1,NULL,'2023-08-05 07:40:40','2023-08-10 23:31:01',NULL,'null',3,4,''),(3,'张学友','13755669902',NULL,NULL,NULL,NULL,3,NULL,'2023-08-05 07:43:25',NULL,NULL,NULL,NULL,NULL,''),(4,'郭富城','13755669903',NULL,'123133246@qq.com','null',NULL,2,NULL,'2023-08-05 07:43:53','2023-08-10 00:13:53',NULL,'[\"斤斤计较\"]',1,NULL,''),(5,'刀郎','13755669900',NULL,NULL,'null',NULL,4,NULL,'2023-08-10 00:06:45','2023-08-10 00:13:43',NULL,'[\"乐于助人\"]',1,NULL,''),(6,'1692022265239600000',NULL,NULL,NULL,NULL,NULL,4,'2023-08-14 14:11:05','2023-08-14 14:07:31',NULL,'{\"name\": \"联络感情，咨询新订单\"}',NULL,2,1,'');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL COMMENT '角色名称',
  `remark` varchar(1024) DEFAULT NULL,
  `rule_ids` json DEFAULT NULL COMMENT 'T:json|',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 true 启用 false 停用',
  `order` int(11) NOT NULL DEFAULT '1' COMMENT '排序越大越靠前',
  `data` enum('all','self','department') NOT NULL DEFAULT 'all' COMMENT '数据权限: all 所有数据, self 自己数据, department 部门数据',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '::Delete At',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '::Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '::Updated At',
  `__restore_data` json DEFAULT NULL COMMENT 'T:json|',
  PRIMARY KEY (`id`),
  KEY `data_index` (`data`),
  KEY `created_at_index` (`created_at`),
  KEY `updated_at_index` (`updated_at`),
  KEY `deleted_at_index` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'管理员','拥有所有的权限','[\"*\"]',1,99,'all',NULL,'2023-07-17 12:55:01','2023-07-17 13:27:10',NULL),(2,'厂长','负责生产管理和新产品的开发管理','[6, 8, 10, 7, 32, 33, 34, 37, 38, 36, 35, 39, 40, 43, 42, 41]',1,34,'department',NULL,'2023-07-17 13:25:46','2023-08-10 12:58:39',NULL),(3,'销售员','销售某一方的市场','[10, 12, 6, 7, 8, 13, 14, 32, 33, 34, 38, 36, 35, 39, 40, 42, 41]',1,1,'self',NULL,'2023-07-17 13:29:23','2023-08-10 12:59:08',NULL);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_department`
--

DROP TABLE IF EXISTS `user_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_department` (
  `user_id` int(11) NOT NULL COMMENT '员工id',
  `department_id` int(11) NOT NULL COMMENT '部门id',
  UNIQUE KEY `user_department` (`user_id`,`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_department`
--

LOCK TABLES `user_department` WRITE;
/*!40000 ALTER TABLE `user_department` DISABLE KEYS */;
INSERT INTO `user_department` VALUES (3,3),(3,4),(3,5);
/*!40000 ALTER TABLE `user_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yao_demo_pet`
--

DROP TABLE IF EXISTS `yao_demo_pet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yao_demo_pet` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(80) DEFAULT NULL,
  `type` enum('cat','dog','others') NOT NULL,
  `status` enum('checked','curing','cured') NOT NULL,
  `mode` enum('enabled','disabled') NOT NULL,
  `online` enum('0','1') NOT NULL DEFAULT '0',
  `detail` varchar(200) DEFAULT NULL,
  `appearance` json DEFAULT NULL COMMENT 'T:json|',
  `curing_status` enum('0','1','2') NOT NULL DEFAULT '0',
  `stay` datetime DEFAULT NULL,
  `cost` int(11) NOT NULL,
  `images` json DEFAULT NULL COMMENT 'T:json|',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '::Delete At',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '::Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '::Updated At',
  `__restore_data` json DEFAULT NULL COMMENT 'T:json|',
  PRIMARY KEY (`id`),
  KEY `name_index` (`name`),
  KEY `type_index` (`type`),
  KEY `status_index` (`status`),
  KEY `mode_index` (`mode`),
  KEY `curing_status_index` (`curing_status`),
  KEY `created_at_index` (`created_at`),
  KEY `updated_at_index` (`updated_at`),
  KEY `deleted_at_index` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yao_demo_pet`
--

LOCK TABLES `yao_demo_pet` WRITE;
/*!40000 ALTER TABLE `yao_demo_pet` DISABLE KEYS */;
INSERT INTO `yao_demo_pet` VALUES (1,'luma','dog','checked','enabled','1',NULL,'[3]','0','2023-07-23 01:38:44',2000,NULL,NULL,'2023-07-22 01:39:15',NULL,NULL);
/*!40000 ALTER TABLE `yao_demo_pet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yao_neo_conversation`
--

DROP TABLE IF EXISTS `yao_neo_conversation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yao_neo_conversation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sid` varchar(255) NOT NULL,
  `rid` varchar(255) DEFAULT NULL,
  `cid` varchar(200) DEFAULT NULL,
  `role` varchar(200) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `content` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expired_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sid_index` (`sid`),
  KEY `rid_index` (`rid`),
  KEY `cid_index` (`cid`),
  KEY `role_index` (`role`),
  KEY `name_index` (`name`),
  KEY `created_at_index` (`created_at`),
  KEY `updated_at_index` (`updated_at`),
  KEY `expired_at_index` (`expired_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yao_neo_conversation`
--

LOCK TABLES `yao_neo_conversation` WRITE;
/*!40000 ALTER TABLE `yao_neo_conversation` DISABLE KEYS */;
/*!40000 ALTER TABLE `yao_neo_conversation` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-26 15:36:00
