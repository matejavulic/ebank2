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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `account` (
  `accountID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `currentBalance` decimal(20,3) NOT NULL DEFAULT '0.000',
  `garnishment` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Administrativna zabrana',
  `currencyID` int(10) unsigned NOT NULL DEFAULT '1',
  `dateOpened` datetime NOT NULL,
  `dateClosed` datetime DEFAULT NULL,
  `userID` int(10) unsigned NOT NULL,
  `branch` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Stari Grad',
  `limitMonthly` decimal(20,3) unsigned NOT NULL DEFAULT '150000.000',
  `usedLimit` decimal(20,3) unsigned NOT NULL DEFAULT '0.000',
  `accountTypeID` int(10) unsigned NOT NULL DEFAULT '1',
  `accountStatusID` int(10) unsigned NOT NULL DEFAULT '4',
  PRIMARY KEY (`accountID`),
  UNIQUE KEY `accountID_UNIQUE` (`accountID`),
  KEY `fkAccountsCurrencyID_idx` (`currencyID`),
  KEY `fkAccountsUserID_idx` (`userID`),
  KEY `fkAccountsAcountTypeID_idx` (`accountTypeID`),
  KEY `fkAccountsAccountStatusID_idx` (`accountStatusID`),
  CONSTRAINT `fkAccountsAccountStatusID` FOREIGN KEY (`accountStatusID`) REFERENCES `account_status` (`accountStatusID`) ON UPDATE CASCADE,
  CONSTRAINT `fkAccountsAccountTypeID` FOREIGN KEY (`accountTypeID`) REFERENCES `account_type` (`accountTypeID`) ON UPDATE CASCADE,
  CONSTRAINT `fkAccountsCurrencyID` FOREIGN KEY (`currencyID`) REFERENCES `currency` (`currencyID`) ON UPDATE CASCADE,
  CONSTRAINT `fkAccountsUserID` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=224 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (167,85369.000,0,1,'2019-08-13 01:30:19','0000-00-00 00:00:00',1,'NI-Pantelej',150000.000,69300.000,1,4),(168,49493.000,0,1,'2019-08-16 02:38:36','0000-00-00 00:00:00',1,'Stari Grad',150000.000,70000.000,1,4),(169,65774.000,0,1,'2019-08-19 12:02:03','0000-00-00 00:00:00',1,'Stari Grad',150000.000,65000.000,1,4),(171,71703.000,0,1,'2019-08-20 18:22:42','0000-00-00 00:00:00',1,'Stari Grad',150000.000,35500.000,1,4),(172,60373.000,0,1,'2019-08-21 01:44:59','0000-00-00 00:00:00',1,'Stari Grad',150000.000,50500.000,1,4),(173,36351.000,0,1,'2019-08-21 13:00:46','0000-00-00 00:00:00',1,'Stari Grad',150000.000,0.000,1,4),(174,57401.000,0,1,'2019-08-21 14:46:05','0000-00-00 00:00:00',1,'Stari Grad',150000.000,0.000,1,4),(175,72764.000,0,1,'2019-08-28 22:09:57','0000-00-00 00:00:00',1,'Stari Grad',150000.000,0.000,1,4),(176,38234.000,0,1,'2019-09-02 14:48:19','0000-00-00 00:00:00',1,'Stari Grad',150000.000,0.000,1,4),(177,51642.000,0,1,'2019-09-02 14:49:31','0000-00-00 00:00:00',1,'Stari Grad',150000.000,0.000,1,4),(178,50366.000,0,1,'2019-09-02 20:23:05','0000-00-00 00:00:00',1,'Stari Grad',150000.000,0.000,1,4),(179,91122.000,0,1,'2019-09-03 10:54:30','0000-00-00 00:00:00',1,'Stari Grad',150000.000,0.000,1,4),(180,51203.000,0,1,'2019-09-03 15:03:19','0000-00-00 00:00:00',1,'Stari Grad',150000.000,0.000,1,4),(181,67384.000,0,1,'2020-06-14 13:53:31','0000-00-00 00:00:00',1,'Stari Grad',150000.000,0.000,1,4),(182,37084.000,0,1,'2020-08-15 10:22:33','0000-00-00 00:00:00',1,'Stari Grad',150000.000,0.000,1,4),(183,0.000,0,1,'1970-12-01 00:00:00','1970-12-01 00:00:00',2,'Demo',0.000,0.000,1,4),(214,77470.000,0,1,'2020-08-16 14:00:22','0000-00-00 00:00:00',17,'Stari Grad',150000.000,0.000,1,4),(218,38695.000,0,1,'2020-08-16 14:34:32','0000-00-00 00:00:00',21,'Stari Grad',150000.000,0.000,1,4),(219,69446.000,0,1,'2020-08-16 15:50:57','0000-00-00 00:00:00',22,'Stari Grad',150000.000,0.000,1,4),(220,77346.000,0,1,'2020-08-16 16:21:54','0000-00-00 00:00:00',23,'Stari Grad',150000.000,0.000,1,4),(221,97296.000,0,1,'2020-08-16 17:26:32','0000-00-00 00:00:00',24,'Stari Grad',150000.000,0.000,1,4),(222,78638.000,0,1,'2020-08-17 15:39:55','0000-00-00 00:00:00',2,'Stari Grad',150000.000,0.000,1,4),(223,34244.000,0,1,'2020-08-17 15:40:42','0000-00-00 00:00:00',26,'Stari Grad',150000.000,0.000,1,4);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_status`
--

DROP TABLE IF EXISTS `account_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `account_status` (
  `accountStatusID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `statusName` varchar(45) COLLATE utf8_bin NOT NULL,
  `statusDescription` tinytext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`accountStatusID`),
  UNIQUE KEY `accountStatusD_UNIQUE` (`accountStatusID`),
  UNIQUE KEY `statusName_UNIQUE` (`statusName`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_status`
--

LOCK TABLES `account_status` WRITE;
/*!40000 ALTER TABLE `account_status` DISABLE KEYS */;
INSERT INTO `account_status` VALUES (1,'Dormant','Inoperative account due to nil customer initiated transaction for a give period of time the bank decides.'),(2,'Suspendend','Suspended account due to court order/bankrupcy/dispute/no funds.'),(3,'Partialy Suspended','With '),(4,'Active','Active account with regular transactions.'),(5,'Closed','Customer closed account.');
/*!40000 ALTER TABLE `account_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_type`
--

DROP TABLE IF EXISTS `account_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `account_type` (
  `accountTypeID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `typeName` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `typeDescription` tinytext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`accountTypeID`),
  UNIQUE KEY `accountTypeID_UNIQUE` (`accountTypeID`),
  UNIQUE KEY `typeName_UNIQUE` (`typeName`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_type`
--

LOCK TABLES `account_type` WRITE;
/*!40000 ALTER TABLE `account_type` DISABLE KEYS */;
INSERT INTO `account_type` VALUES (1,'Checking Account','For daily transactional needs.'),(2,'Certificate of Deposit','Invested money at a set interst rate for a pre-set period of time.'),(3,'Savings Account','Accumulating interest on funds saved for future needs.'),(4,'Money Market Account','Similar to savings accout, but require higher balance in order to avoid monthly service fee.'),(5,'Individual Retirement Account','Private pension fund.');
/*!40000 ALTER TABLE `account_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card`
--

DROP TABLE IF EXISTS `card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `card` (
  `cardID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `typeID` int(10) unsigned NOT NULL DEFAULT '1',
  `nameID` int(10) unsigned NOT NULL DEFAULT '1',
  `creationDate` datetime NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `userID` int(10) unsigned NOT NULL,
  `currentBalance` decimal(20,3) NOT NULL,
  `currencyID` int(10) unsigned NOT NULL DEFAULT '1',
  `statusID` int(10) unsigned NOT NULL DEFAULT '1',
  `serialNumber` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`cardID`),
  UNIQUE KEY `cardID_UNIQUE` (`cardID`),
  KEY `fkCardsTypeID_idx` (`typeID`),
  KEY `fkCardsNameID_idx` (`nameID`),
  KEY `fkCardsUserID_idx` (`userID`),
  KEY `fkCardsCurrencyID_idx` (`currencyID`),
  KEY `fkCardsStatusID_idx` (`statusID`),
  CONSTRAINT `fkCardsCurrencyID` FOREIGN KEY (`currencyID`) REFERENCES `currency` (`currencyID`) ON UPDATE CASCADE,
  CONSTRAINT `fkCardsNameID` FOREIGN KEY (`nameID`) REFERENCES `card_name` (`nameID`) ON UPDATE CASCADE,
  CONSTRAINT `fkCardsStatusID` FOREIGN KEY (`statusID`) REFERENCES `card_status` (`statusID`) ON UPDATE CASCADE,
  CONSTRAINT `fkCardsTypeID` FOREIGN KEY (`typeID`) REFERENCES `card_type` (`typeID`) ON UPDATE CASCADE,
  CONSTRAINT `fkCardsUserID` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card`
--

LOCK TABLES `card` WRITE;
/*!40000 ALTER TABLE `card` DISABLE KEYS */;
INSERT INTO `card` VALUES (1,1,1,'2020-12-12 12:12:12',NULL,1,1200.000,1,1,'2'),(2,1,1,'2020-12-12 12:12:12',NULL,1,1.000,1,1,'2'),(3,1,1,'2020-12-12 12:12:12',NULL,1,500.550,1,1,'2');
/*!40000 ALTER TABLE `card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card_name`
--

DROP TABLE IF EXISTS `card_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `card_name` (
  `nameID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cardName` varchar(45) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`nameID`),
  UNIQUE KEY `nameID_UNIQUE` (`nameID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card_name`
--

LOCK TABLES `card_name` WRITE;
/*!40000 ALTER TABLE `card_name` DISABLE KEYS */;
INSERT INTO `card_name` VALUES (1,'Dina Card'),(2,'MasterCard'),(3,'Visa'),(4,'Мир'),(5,'UnionPay'),(6,'American Express');
/*!40000 ALTER TABLE `card_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card_status`
--

DROP TABLE IF EXISTS `card_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `card_status` (
  `statusID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `statusName` varchar(45) COLLATE utf8_bin NOT NULL,
  `statusDescription` tinytext COLLATE utf8_bin,
  PRIMARY KEY (`statusID`),
  UNIQUE KEY `statusID_UNIQUE` (`statusID`),
  UNIQUE KEY `name_UNIQUE` (`statusName`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card_status`
--

LOCK TABLES `card_status` WRITE;
/*!40000 ALTER TABLE `card_status` DISABLE KEYS */;
INSERT INTO `card_status` VALUES (1,'Active',NULL),(2,'Suspended',NULL),(3,'Dormant',NULL),(4,'Expired',NULL),(5,'Stolen',NULL);
/*!40000 ALTER TABLE `card_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card_type`
--

DROP TABLE IF EXISTS `card_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `card_type` (
  `typeID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `typeName` varchar(45) COLLATE utf8_bin NOT NULL,
  `typeDescription` tinytext COLLATE utf8_bin,
  PRIMARY KEY (`typeID`),
  UNIQUE KEY `typeID_UNIQUE` (`typeID`),
  UNIQUE KEY `typeName_UNIQUE` (`typeName`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card_type`
--

LOCK TABLES `card_type` WRITE;
/*!40000 ALTER TABLE `card_type` DISABLE KEYS */;
INSERT INTO `card_type` VALUES (1,'Credit Card','The  cardholder can draw either for payment to a merchant for a purchase or as a cash advance to the cardholder.'),(2,'Debit Card','The cardholder withdraws funds from bank account.'),(3,'Prepaid Card','Similar to debit card, the cardholder can draw only funds payed in advance.'),(4,'Charge card','The cardholder is required to pay the full balance shown on the statement  by the payment due date.');
/*!40000 ALTER TABLE `card_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `currency` (
  `currencyID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `currencyName` char(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`currencyID`),
  UNIQUE KEY `currencyID_UNIQUE` (`currencyID`),
  UNIQUE KEY `name_UNIQUE` (`currencyName`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` VALUES (10,'ALL'),(14,'AUD'),(7,'BAM'),(3,'CNY'),(6,'EUR'),(5,'GBP'),(8,'HRK'),(11,'HUF'),(12,'INR'),(9,'MKD'),(1,'RSD'),(4,'RUB'),(2,'USD'),(13,'XDR');
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `transaction` (
  `transactionID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `paymentMethod` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Kartica',
  `senderAccountNumber` int(10) NOT NULL,
  `receiverAccountNumber` int(10) NOT NULL,
  `amount` double unsigned NOT NULL,
  `date` date NOT NULL,
  `dateKnjizenja` date NOT NULL,
  `description` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `refference` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT 'PPT-0375684-D-PROD',
  `currencyID` int(10) DEFAULT '1',
  PRIMARY KEY (`transactionID`),
  UNIQUE KEY `transactionID_UNIQUE` (`transactionID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,'Kartica',167,166,1000,'2019-01-01','2019-01-01','Konsultantske usluge','REF-166-167-PRO',1),(3,'Kartica',165,167,6000,'2019-01-02','2019-01-03','Trzni centar SHOPPP!','REF-167-166-PRO1',1),(4,'Uplata',165,167,3000,'2019-01-03','2019-01-04','Rata letovanja','REF',1),(5,'Uplata',165,165,1000,'2019-01-04','2019-01-04','B.S. - Benzin Gas','66-PRO1',1),(6,'Kartica',167,165,5500,'2019-01-05','2019-01-05','Salon namestaja - Fotelja','REF-167-166-PRO1',1),(7,'Kartica',167,165,200,'2019-01-06','2019-01-06','Knjizara 3M - Sveska','REF-167-166-PRO1',1),(8,'Kartica',165,165,750,'2019-01-07','2019-01-07','Kafic - Koktel x 3','REF-167-166-PRO1',1),(9,'Kartica',165,165,1100,'2019-01-08','2019-01-08','Restoran - Pica Kapricoza','REF-167-166-PRO1',1),(10,'Kartica',167,165,3000,'2019-01-09','2019-01-09','Autoservis Petko','REF-167-166-PRO1',1),(11,'Uplata',167,165,125,'2019-01-10','2019-01-10','Market Koala - Hleb, mleko, jogurt','REF-167-166-PRO1',1),(12,'Uplata',167,165,50,'2019-01-11','2019-01-11','Trafika - Zvake Zvacko','REF-167-166-PRO1',1),(13,'Kartica',167,165,130,'2019-01-12','2019-01-12','Kiosk - Sendvic','REF-167-166-PRO1',1),(14,'Kartica',167,165,2200,'2019-01-13','2019-01-13','BAS - Karta','REF-167-166-PRO1',1),(15,'Cek',167,165,1250,'2019-01-14','2019-01-14','Кафе City Zone - Ugostiteljstvo','REF-167-166-PRO1',1),(16,'Cek',167,165,20,'2019-01-15','2019-01-15','Posta - Markica','REF-167-166-PRO1',1),(17,'Cek',167,165,35000,'2019-01-16','2019-01-16','Prodavnica - Mobilni telefon Telmob D.O.O','REF-167-166-PRO1',1);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `userID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(45) COLLATE utf8_bin NOT NULL,
  `password` varchar(60) COLLATE utf8_bin NOT NULL,
  `name` varchar(45) COLLATE utf8_bin NOT NULL,
  `surname` varchar(45) COLLATE utf8_bin NOT NULL,
  `number` varchar(45) COLLATE utf8_bin NOT NULL,
  `address` varchar(45) COLLATE utf8_bin NOT NULL,
  `hnumber` smallint(10) DEFAULT NULL,
  `lastLogin` timestamp NULL DEFAULT NULL,
  `dateRegistered` timestamp NULL DEFAULT NULL,
  `defaultAccountID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `userID_UNIQUE` (`userID`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `password_UNIQUE` (`password`),
  KEY `fkUsersDeafultAccountID_idx` (`defaultAccountID`),
  CONSTRAINT `fkUsersAccountID` FOREIGN KEY (`defaultAccountID`) REFERENCES `account` (`accountID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'mmikic@pisma.rs','$2b$10$JiuGEMU0Xq2yjUf6GnLq3OFoJRYEIiy2LjBVIhjXW4o8/nnC0jXN.','Mika','Mikic','+3816367954317','Zlatiborska',41,'2020-08-17 19:25:48','2020-06-14 11:53:35',167),(2,'demo@demo.demo','demo','Demo','Demo','1','Demo',1,'1970-11-30 23:00:00','1970-11-30 23:00:00',183),(17,'pperic@pisma.rs','$2b$10$gpIKG3oX9iSn7psOeCUny.tx7cGbrbaEnvtL8sq3g1xEBdR7pixzm','Petar','Peric','+3816477466233','Vodovodska 4. deo',12,'2020-08-16 13:09:58','2020-08-16 12:00:23',214),(21,'mlukic@pisma.rs','$2b$10$3UslcOD5/2FYWi.ptf6J7.u/512KP3pHY.5yffBQBd5tB423PFs/.','Milica','Lukić','+3816279843353','Backa',27,'2020-08-16 13:52:39','2020-08-16 12:34:32',218),(22,'amarija@pisma.rs','$2b$10$wRZktXDw6U32XpnqQ3o92ertduJlz1TeZD32uqszjChtrj4zlCDWO','Ana','Marija','+3816116842669','Paunova 1. prilaz',38,'2020-08-16 13:51:02','2020-08-16 13:50:57',219),(23,'iperic@pisma.rs','$2b$10$8uOoj605VpiE5cJY/BVRLO2ADxN0/GUWoKE6r9JDC.MHTltSSpQ3S','Igor','Peric','+3816830829864','Vinogradska 1. prilaz',71,'2020-08-16 14:21:57','2020-08-16 14:21:54',220),(24,'mperic@pisma.rs','$2b$10$7oPPnAgQluRQj1nJVd8w.u24u3IqN8tSEeOUqYRQRW/A4zT/jqrBS','Marina','Peric','+3816032379097','Kruzni put 6',21,'2020-08-16 15:26:37','2020-08-16 15:26:32',221),(26,'smatic@pisma.rs','$2b$10$cp76iUvSuOE.EIG4jVS23eqETfCFjNvwc.XHk0h0KWCGvPsEUzZJW','Снежана','Матић','+3816388441677','Vodovodska 7. deo',22,'2020-08-17 19:25:41','2020-08-17 13:40:42',223);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ebank'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-17 21:29:05
