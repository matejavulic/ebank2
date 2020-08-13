-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: localhost    Database: ebank
-- ------------------------------------------------------
-- Server version	5.7.26-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `accounts` (
  `accountID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `currentBalance` decimal(20,3) NOT NULL DEFAULT '0.000',
  `accountType` varchar(45) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Tekuci',
  `garnishment` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Administrativna zabrana',
  `currencyID` int(10) unsigned NOT NULL DEFAULT '1',
  `dateOpened` datetime NOT NULL,
  `dateClosed` datetime DEFAULT NULL,
  `clientID` char(24) COLLATE utf8_unicode_ci NOT NULL,
  `branch` varchar(45) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Stari Grad',
  `limitMonthly` decimal(20,3) unsigned NOT NULL DEFAULT '15000.000',
  `usedLimit` decimal(20,3) unsigned NOT NULL DEFAULT '0.000',
  PRIMARY KEY (`accountID`),
  UNIQUE KEY `accountID_UNIQUE` (`accountID`),
  KEY `fkAccountsCurrencyID_idx` (`currencyID`),
  CONSTRAINT `fkAccountsCurrencyID` FOREIGN KEY (`currencyID`) REFERENCES `currencies` (`currencyID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (165,74375.000,'Tekuci',0,1,'2019-08-13 01:26:57','0000-00-00 00:00:00','5d51f5c11ef4a32e54828408','Stari Grad',15000.000,0.000),(166,66385.000,'Tekuci',0,1,'2019-08-13 01:29:11','0000-00-00 00:00:00','5d51f6471ef4a32e54828409','Stari Grad',15000.000,0.000),(167,85369.000,'Tekuci',0,1,'2019-08-13 01:30:19','0000-00-00 00:00:00','5d51f68b1ef4a32e5482840a','Stari Grad',15000.000,0.000),(168,49493.000,'Tekuci',0,1,'2019-08-16 02:38:36','0000-00-00 00:00:00','5d55fb0cd3f3e43654aa7e24','Stari Grad',15000.000,0.000);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-17  0:08:12
