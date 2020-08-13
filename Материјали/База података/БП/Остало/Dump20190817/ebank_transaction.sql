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
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `transaction` (
  `transactionID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `paymentMethod` varchar(45) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Kartica',
  `senderAccountNumber` int(10) NOT NULL,
  `receiverAccountNumber` int(10) NOT NULL,
  `amount` double unsigned NOT NULL,
  `date` date NOT NULL,
  `dateKnjizenja` date NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `refference` varchar(45) COLLATE utf8_unicode_ci DEFAULT 'PPT-0375684-D-PROD',
  `currencyID` int(10) DEFAULT '1',
  PRIMARY KEY (`transactionID`),
  UNIQUE KEY `transactionID_UNIQUE` (`transactionID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,'Kartica',167,166,1000,'2019-01-01','2019-01-01','Konsultantske usluge','REF-166-167-PRO',1),(3,'Kartica',165,167,2000,'2019-01-02','2019-01-03','Prevod spisa','REF-167-166-PRO1',1),(4,'Uplata',165,167,500,'2019-01-03','0000-00-00','Rata letovanja','REF',1),(5,'Uplata',165,165,2999,'2019-01-04','2019-01-02','Lekovi','66-PRO1',1),(6,'Kartica',167,165,5500,'2019-01-05','2019-01-02','Voda','REF-167-166-PRO1',1),(7,'Kartica',167,165,550,'2019-01-06','2019-01-02','Prasko','REF-167-166-PRO1',1),(8,'Kartica',165,165,700,'2019-01-07','2019-01-02','Kafic','REF-167-166-PRO1',1),(9,'Kartica',165,165,3500,'2019-01-08','2019-01-02','Restoran','REF-167-166-PRO1',1),(10,'Kartica',167,165,3000,'2019-01-09','2019-01-02','Kola','REF-167-166-PRO1',1),(11,'Uplata',167,165,125,'2019-01-10','2019-01-02','Market','REF-167-166-PRO1',1),(12,'Uplata',167,165,12000,'2019-01-11','2019-01-02','Market','REF-167-166-PRO1',1),(13,'Kartica',167,165,123500,'2019-01-12','2019-01-02','Kiosk','REF-167-166-PRO1',1),(14,'Kartica',167,165,34000,'2019-01-13','2019-01-02','BAS','REF-167-166-PRO1',1),(15,'Cek',167,165,3400,'2019-01-14','2019-01-02','Кафе City Zone - Ugostiteljstvo','REF-167-166-PRO1',1),(16,'Cek',167,165,200,'2019-01-15','2019-01-02','Kafic','REF-167-166-PRO1',1),(17,'Cek',167,165,10000,'2019-01-16','2019-01-02','Kafic','REF-167-166-PRO1',1);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-17  0:08:13
