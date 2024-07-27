CREATE DATABASE  IF NOT EXISTS `sales` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `sales`;
-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sales
-- ------------------------------------------------------
-- Server version	5.7.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `agents`
--

DROP TABLE IF EXISTS `agents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agents` (
  `agent_code` char(6) NOT NULL,
  `agent_name` char(40) DEFAULT NULL,
  `working_area` char(35) DEFAULT NULL,
  `commission` decimal(10,2) DEFAULT NULL,
  `phone_no` char(15) DEFAULT NULL,
  `country` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`agent_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agents`
--

LOCK TABLES `agents` WRITE;
/*!40000 ALTER TABLE `agents` DISABLE KEYS */;
INSERT INTO `agents` VALUES ('A001','Subbarao','Bangalore',0.14,'077-12346674',''),('A002','Mukesh','Mumbai',0.11,'029-12358964',''),('A003','Alex','London',0.13,'075-12458969',''),('A004','Ivan','Torento',0.15,'008-22544166',''),('A005','Anderson','Brisban',0.13,'045-21447739',''),('A006','McDen','London',0.15,'078-22255588',''),('A007','Ramasundar','Bangalore',0.15,'077-25814763',''),('A008','Alford','New York',0.12,'044-25874365',''),('A009','Benjamin','Hampshair',0.11,'008-22536178',''),('A010','Santakumar','Chennai',0.14,'007-22388644',''),('A011','Ravi Kumar','Bangalore',0.15,'077-45625874',''),('A012','Lucida','San Jose',0.12,'044-52981425','');
/*!40000 ALTER TABLE `agents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `cust_code` char(6) NOT NULL,
  `cust_name` char(40) NOT NULL,
  `cust_city` varchar(35) DEFAULT NULL,
  `working_area` varchar(35) NOT NULL,
  `cust_country` varchar(20) NOT NULL,
  `grade` int(11) DEFAULT NULL,
  `opening_amt` decimal(12,2) NOT NULL,
  `receive_amt` decimal(12,2) NOT NULL,
  `payment_amt` decimal(12,2) NOT NULL,
  `outstanding_amt` decimal(12,2) NOT NULL,
  `phone_no` varchar(17) NOT NULL,
  `agent_code` char(6) DEFAULT NULL,
  PRIMARY KEY (`cust_code`),
  KEY `customers_FK` (`agent_code`),
  CONSTRAINT `FK_b647c1bd599f48a6d87947da1ea` FOREIGN KEY (`agent_code`) REFERENCES `agents` (`agent_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES ('C00001','Micheal','New York','New York','USA',2,3000.00,5000.00,2000.00,6000.00,'CCCCCCC','A008'),('C00002','Bolt','New York','New York','USA',3,5000.00,7000.00,9000.00,3000.00,'DDNRDRH','A008'),('C00003','Martin','Torento','Torento','Canada',2,8000.00,7000.00,7000.00,8000.00,'MJYURFD','A004'),('C00004','Winston','Brisban','Brisban','Australia',1,5000.00,8000.00,7000.00,6000.00,'AAAAAAA','A005'),('C00005','Sasikant','Mumbai','Mumbai','India',1,7000.00,11000.00,7000.00,11000.00,'147-25896312','A002'),('C00006','Shilton','Torento','Torento','Canada',1,10000.00,7000.00,6000.00,11000.00,'DDDDDDD','A004'),('C00007','Ramanathan','Chennai','Chennai','India',1,7000.00,11000.00,9000.00,9000.00,'GHRDWSD','A010'),('C00008','Karolina','Torento','Torento','Canada',1,7000.00,7000.00,9000.00,5000.00,'HJKORED','A004'),('C00009','Ramesh','Mumbai','Mumbai','India',3,8000.00,7000.00,3000.00,12000.00,'Phone No','A002'),('C00010','Charles','Hampshair','Hampshair','UK',3,6000.00,4000.00,5000.00,5000.00,'MMMMMMM','A009'),('C00011','Sundariya','Chennai','Chennai','India',3,7000.00,11000.00,7000.00,11000.00,'PPHGRTS','A010'),('C00012','Steven','San Jose','San Jose','USA',1,5000.00,7000.00,9000.00,3000.00,'KRFYGJK','A012'),('C00013','Holmes','London','London','UK',2,6000.00,5000.00,7000.00,4000.00,'BBBBBBB','A003'),('C00014','Rangarappa','Bangalore','Bangalore','India',2,8000.00,11000.00,7000.00,12000.00,'AAAATGF','A001'),('C00015','Stuart','London','London','UK',1,6000.00,8000.00,3000.00,11000.00,'GFSGERS','A003'),('C00016','Venkatpati','Bangalore','Bangalore','India',2,8000.00,11000.00,7000.00,12000.00,'JRTVFDD','A007'),('C00017','Srinivas','Bangalore','Bangalore','India',2,8000.00,4000.00,3000.00,9000.00,'AAAAAAB','A007'),('C00018','Fleming','Brisban','Brisban','Australia',2,7000.00,7000.00,9000.00,5000.00,'NHBGVFC','A005'),('C00019','Yearannaidu','Chennai','Chennai','India',1,8000.00,7000.00,7000.00,8000.00,'ZZZZBFV','A010'),('C00020','Albert','New York','New York','USA',3,5000.00,7000.00,6000.00,6000.00,'BBBBSBB','A008'),('C00021','Jacks','Brisban','Brisban','Australia',1,7000.00,7000.00,7000.00,7000.00,'WERTGDF','A005'),('C00022','Avinash','Mumbai','Mumbai','India',2,7000.00,11000.00,9000.00,9000.00,'113-12345678','A002'),('C00023','Karl','London','London','UK',0,4000.00,6000.00,7000.00,3000.00,'AAAABAA','A006'),('C00024','Cook','London','London','UK',2,4000.00,9000.00,7000.00,6000.00,'FSDDSDF','A006'),('C00025','Ravindran','Bangalore','Bangalore','India',2,5000.00,7000.00,4000.00,8000.00,'AVAVAVA','A011');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,1722037437999,'SchemaUpdate1722037437999'),(2,1722037536421,'SchemaUpdate1722037536421');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `ord_num` decimal(6,0) NOT NULL,
  `ord_amount` decimal(12,2) NOT NULL,
  `advance_amount` decimal(12,2) NOT NULL,
  `ord_date` date NOT NULL,
  `cust_code` char(6) DEFAULT NULL,
  `agent_code` char(6) DEFAULT NULL,
  `ord_description` varchar(60) NOT NULL,
  PRIMARY KEY (`ord_num`),
  KEY `FK_669be2d4db3d4341bad19768e85` (`cust_code`),
  KEY `FK_fcaff738bc99c1ba91891fd73d4` (`agent_code`),
  CONSTRAINT `FK_669be2d4db3d4341bad19768e85` FOREIGN KEY (`cust_code`) REFERENCES `customers` (`cust_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_fcaff738bc99c1ba91891fd73d4` FOREIGN KEY (`agent_code`) REFERENCES `agents` (`agent_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (200100,1000.00,600.00,'2008-08-01','C00013','A003','SOD'),(200101,3000.00,1000.00,'2008-07-15','C00001','A008','SOD'),(200102,2000.00,300.00,'2008-05-25','C00012','A012','SOD'),(200103,1500.00,700.00,'2008-05-15','C00021','A005','SOD'),(200104,1500.00,500.00,'2008-03-13','C00006','A004','SOD'),(200105,2500.00,500.00,'2008-07-18','C00025','A011','SOD'),(200106,2500.00,700.00,'2008-04-20','C00005','A002','SOD'),(200107,4500.00,900.00,'2008-08-30','C00007','A010','SOD'),(200108,4000.00,600.00,'2008-02-15','C00008','A004','SOD'),(200109,3500.00,800.00,'2008-07-30','C00011','A010','SOD'),(200110,3000.00,500.00,'2008-04-15','C00019','A010','SOD'),(200111,1000.00,300.00,'2008-07-10','C00020','A008','SOD'),(200112,2000.00,400.00,'2008-05-30','C00016','A007','SOD'),(200113,4000.00,600.00,'2008-06-10','C00022','A002','SOD'),(200114,3500.00,2000.00,'2008-08-15','C00002','A008','SOD'),(200116,500.00,100.00,'2008-07-13','C00010','A009','SOD'),(200117,800.00,200.00,'2008-10-20','C00014','A001','SOD'),(200118,500.00,100.00,'2008-07-20','C00023','A006','SOD'),(200119,4000.00,700.00,'2008-09-16','C00007','A010','SOD'),(200120,500.00,100.00,'2008-07-20','C00009','A002','SOD'),(200121,1500.00,600.00,'2008-09-23','C00008','A004','SOD'),(200122,2500.00,400.00,'2008-09-16','C00003','A004','SOD'),(200123,500.00,100.00,'2008-09-16','C00022','A002','SOD'),(200124,500.00,100.00,'2008-06-20','C00017','A007','SOD'),(200125,2000.00,600.00,'2008-10-10','C00018','A005','SOD'),(200126,500.00,100.00,'2008-06-24','C00022','A002','SOD'),(200127,2500.00,400.00,'2008-07-20','C00015','A003','SOD'),(200128,3500.00,1500.00,'2008-07-20','C00009','A002','SOD'),(200129,2500.00,500.00,'2008-07-20','C00024','A006','SOD'),(200130,2500.00,400.00,'2008-07-30','C00025','A011','SOD'),(200131,900.00,150.00,'2008-08-26','C00012','A012','SOD'),(200133,1200.00,400.00,'2008-06-29','C00009','A002','SOD'),(200134,4200.00,1800.00,'2008-09-25','C00004','A005','SOD'),(200135,2000.00,800.00,'2008-09-16','C00007','A010','SOD');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_648e3f5447f725579d7d4ffdfb` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin'),(2,'agent'),(3,'customer'),(4,'guest');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `first_name` char(40) DEFAULT NULL,
  `last_name` char(40) DEFAULT NULL,
  `email` char(40) DEFAULT NULL,
  `password` char(80) NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deleted_at` timestamp(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_97672ac88f789774dd47f7c8be` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','User','admin@admin.com','$2a$10$SFSb6r.euS1ktIeQtiBqueL.0sm6BpMIKADd26ipdT.FWMCe2mupS','2024-07-27 00:02:22.000000','2024-07-27 00:02:22.000000',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_roles_roles`
--

DROP TABLE IF EXISTS `users_roles_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_roles_roles` (
  `usersId` bigint(20) NOT NULL,
  `rolesId` int(11) NOT NULL,
  PRIMARY KEY (`usersId`,`rolesId`),
  KEY `IDX_df951a64f09865171d2d7a502b` (`usersId`),
  KEY `IDX_b2f0366aa9349789527e0c36d9` (`rolesId`),
  CONSTRAINT `FK_b2f0366aa9349789527e0c36d97` FOREIGN KEY (`rolesId`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_df951a64f09865171d2d7a502b1` FOREIGN KEY (`usersId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_roles_roles`
--

LOCK TABLES `users_roles_roles` WRITE;
/*!40000 ALTER TABLE `users_roles_roles` DISABLE KEYS */;
INSERT INTO `users_roles_roles` VALUES (1,1);
/*!40000 ALTER TABLE `users_roles_roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-26 19:05:37
