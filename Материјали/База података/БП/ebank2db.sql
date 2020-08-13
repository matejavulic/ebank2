CREATE DATABASE  IF NOT EXISTS `ebank2` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `ebank2`;
-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: localhost    Database: ebank2
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
  `PK_account_id` int(11) NOT NULL AUTO_INCREMENT,
  `FK_account_type_id` int(11) DEFAULT NULL,
  `FK_customer_id` int(11) DEFAULT NULL,
  `account_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `acount_date_opened` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `acount_date_closed` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `acount_current_ballance` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `acount_other_details` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FK_currency_code` int(11) DEFAULT NULL,
  `FK_account_status_id` int(11) DEFAULT NULL,
  `overdraft` int(11) DEFAULT NULL,
  `last_access_date` datetime DEFAULT NULL,
  `minimum_inflow` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'A minimum amount that has to be paid in every month.',
  PRIMARY KEY (`PK_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `address` (
  `PK_address_id` int(11) NOT NULL AUTO_INCREMENT,
  `FK address_type_id` int(11) DEFAULT NULL,
  `phone` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PK_address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ballance_history`
--

DROP TABLE IF EXISTS `ballance_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ballance_history` (
  `PK_ ballance_date` int(11) NOT NULL AUTO_INCREMENT,
  `FK_account_id` int(11) DEFAULT NULL,
  `ballance_at_date` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PK_ ballance_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ballance_history`
--

LOCK TABLES `ballance_history` WRITE;
/*!40000 ALTER TABLE `ballance_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `ballance_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banker`
--

DROP TABLE IF EXISTS `banker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `banker` (
  `PK_banker_id` int(11) NOT NULL AUTO_INCREMENT,
  `banker_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `surname` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `banker_email` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FK_ customer_id` int(11) DEFAULT NULL,
  `FK_ branch_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`PK_banker_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banker`
--

LOCK TABLES `banker` WRITE;
/*!40000 ALTER TABLE `banker` DISABLE KEYS */;
/*!40000 ALTER TABLE `banker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `branch` (
  `PK_ branch_id` int(11) NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `branch_city` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `branch_assets` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FK_branch_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`PK_ branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card`
--

DROP TABLE IF EXISTS `card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `card` (
  `PK_card_id` int(11) NOT NULL AUTO_INCREMENT,
  `FK_card_type_id` int(11) DEFAULT NULL,
  `FK _service_type_id` int(11) DEFAULT NULL,
  `FK_account_id` int(11) DEFAULT NULL,
  `FK_currency_code` int(11) DEFAULT NULL,
  PRIMARY KEY (`PK_card_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card`
--

LOCK TABLES `card` WRITE;
/*!40000 ALTER TABLE `card` DISABLE KEYS */;
/*!40000 ALTER TABLE `card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card_transaction`
--

DROP TABLE IF EXISTS `card_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `card_transaction` (
  `PK_card_transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `card_authorisation_code` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_gratuity` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_pin_verified` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_transaction_comment` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FK_card_id` int(11) DEFAULT NULL,
  `FK_merchant_id` int(11) DEFAULT NULL,
  `FK_ transaction_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`PK_card_transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card_transaction`
--

LOCK TABLES `card_transaction` WRITE;
/*!40000 ALTER TABLE `card_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `card_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract`
--

DROP TABLE IF EXISTS `contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `contract` (
  `PK_contract_id` int(11) NOT NULL AUTO_INCREMENT,
  `date_starts` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_ends` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contract_text` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contract_registry_number` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FK_contract_type_id` int(11) DEFAULT NULL,
  `FK_contract_status_code_id` int(11) DEFAULT NULL,
  `FK customer_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`PK_contract_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract`
--

LOCK TABLES `contract` WRITE;
/*!40000 ALTER TABLE `contract` DISABLE KEYS */;
/*!40000 ALTER TABLE `contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `customer` (
  `PK_customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `FK_customer_type_id` int(11) DEFAULT NULL,
  `customer_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_surname` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_phone` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_email` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_became_customer` date DEFAULT NULL,
  `date_quit_customer` date DEFAULT NULL,
  `other_details` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_last_login` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_transaction_password` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_client_number` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PK_customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_address`
--

DROP TABLE IF EXISTS `customer_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `customer_address` (
  `PK_customer_addresses_id` int(11) NOT NULL AUTO_INCREMENT,
  `FK_address_id` int(11) DEFAULT NULL,
  `FK_customer_id` int(11) DEFAULT NULL,
  `date_from` date DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  PRIMARY KEY (`PK_customer_addresses_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_address`
--

LOCK TABLES `customer_address` WRITE;
/*!40000 ALTER TABLE `customer_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_purchase`
--

DROP TABLE IF EXISTS `customer_purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `customer_purchase` (
  `PK_ purchase_id` int(11) NOT NULL AUTO_INCREMENT,
  `FK_customer_id` int(11) DEFAULT NULL,
  `FK service_code` int(11) DEFAULT NULL,
  `purchase_date` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `purchase_quantity` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `purchase_other_details` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PK_ purchase_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_purchase`
--

LOCK TABLES `customer_purchase` WRITE;
/*!40000 ALTER TABLE `customer_purchase` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_purchase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `loan` (
  `PK_ loan_id` int(11) NOT NULL AUTO_INCREMENT,
  `FK_loan_type_id` int(11) DEFAULT NULL,
  `FK_ branch_id` int(11) DEFAULT NULL,
  `FK _service_type_id` int(11) DEFAULT NULL,
  `FK_account_id` int(11) DEFAULT NULL,
  `loan_inetrest_rate` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `loan_borrowed` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `loan_period` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mortgage` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `loan_request_date` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `loan_approved_date` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `loan_guarantor` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `loan_repayment_plan` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_contract_starts` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_contract_ends` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FK_contract_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`PK_ loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merchant`
--

DROP TABLE IF EXISTS `merchant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `merchant` (
  `PK_merchant_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `FK_country_code` int(11) DEFAULT NULL,
  `FK_ category_code` int(11) DEFAULT NULL,
  PRIMARY KEY (`PK_merchant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchant`
--

LOCK TABLES `merchant` WRITE;
/*!40000 ALTER TABLE `merchant` DISABLE KEYS */;
/*!40000 ALTER TABLE `merchant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `party`
--

DROP TABLE IF EXISTS `party`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `party` (
  `PK_party_id` int(11) NOT NULL AUTO_INCREMENT,
  `party_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `party_phone` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `party_email` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PK_party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party`
--

LOCK TABLES `party` WRITE;
/*!40000 ALTER TABLE `party` DISABLE KEYS */;
/*!40000 ALTER TABLE `party` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `payment` (
  `PK_payment_id` int(11) NOT NULL,
  `payment_date` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payment_amount` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FK_contract_id` int(11) DEFAULT NULL,
  `FK_payment_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`PK_payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_and_service`
--

DROP TABLE IF EXISTS `product_and_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `product_and_service` (
  `PK_service_code` int(11) NOT NULL AUTO_INCREMENT,
  `FK_ merchant_id` int(11) DEFAULT NULL,
  `FK_ service_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`PK_service_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_and_service`
--

LOCK TABLES `product_and_service` WRITE;
/*!40000 ALTER TABLE `product_and_service` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_and_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_account_status`
--

DROP TABLE IF EXISTS `ref_account_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_account_status` (
  `PK_account_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `acount_status_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_status_description` tinytext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`PK_account_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_account_status`
--

LOCK TABLES `ref_account_status` WRITE;
/*!40000 ALTER TABLE `ref_account_status` DISABLE KEYS */;
INSERT INTO `ref_account_status` VALUES (1,'Dormant','Inoperative account due to nil customer initiated transaction for a give period of time the bank decides.'),(2,'Suspendend','Suspended account due to court order/bankrupcy/dispute/no funds.'),(3,'Partialy Suspended','With '),(4,'Active','Active account with regular transactions.'),(5,'Closed','Customer closed account.');
/*!40000 ALTER TABLE `ref_account_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_account_type`
--

DROP TABLE IF EXISTS `ref_account_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_account_type` (
  `PK account_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_type_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_type_descritption` tinytext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`PK account_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_account_type`
--

LOCK TABLES `ref_account_type` WRITE;
/*!40000 ALTER TABLE `ref_account_type` DISABLE KEYS */;
INSERT INTO `ref_account_type` VALUES (1,'Checking Account','For daily transactional needs.'),(2,'Certificate of Deposit','Invested money at a set interst rate for a pre-set period of time.'),(3,'Savings Account','Accumulating interest on funds saved for future needs.'),(4,'Money Market Account','Similar to savings accout, but require higher balance in order to avoid monthly service fee.'),(5,'Individual Retirement Account','Private pension fund.');
/*!40000 ALTER TABLE `ref_account_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_address_type`
--

DROP TABLE IF EXISTS `ref_address_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_address_type` (
  `PK_address_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `address_description` varchar(45) COLLATE utf8_unicode_ci DEFAULT 'Iz licne karte',
  PRIMARY KEY (`PK_address_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_address_type`
--

LOCK TABLES `ref_address_type` WRITE;
/*!40000 ALTER TABLE `ref_address_type` DISABLE KEYS */;
INSERT INTO `ref_address_type` VALUES (1,'From ID Card'),(2,'Temporary');
/*!40000 ALTER TABLE `ref_address_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_bai_issuer_code`
--

DROP TABLE IF EXISTS `ref_bai_issuer_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_bai_issuer_code` (
  `PK_bai_issuer_code_id` int(11) NOT NULL AUTO_INCREMENT,
  `bai_code` int(11) DEFAULT NULL,
  `bai_code_description` tinytext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`PK_bai_issuer_code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=553 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Bank Administration Institute Codes - BAI2';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_bai_issuer_code`
--

LOCK TABLES `ref_bai_issuer_code` WRITE;
/*!40000 ALTER TABLE `ref_bai_issuer_code` DISABLE KEYS */;
INSERT INTO `ref_bai_issuer_code` VALUES (1,10,'Opening Ledger Balance'),(2,11,'Average Opening Ledger MTD'),(3,12,'Average Opening Ledger YTD'),(4,15,'Closing Ledger Balance'),(5,20,'Average Closing Ledger MTD'),(6,21,'Avg Closing Ldgr-Previous Month'),(7,22,'Aggregate Balance Adjustments'),(8,24,'Avg Closing Ldgr YTD-Previous Month'),(9,25,'Average Closing Ledger YTD'),(10,30,'Current Ledger Balance'),(11,37,'ACH Net Position'),(12,39,'Open Avail + Tot Same-Day ACHDTC Deposits'),(13,40,'Opening Available'),(14,41,'Average Opening Available MTD'),(15,42,'Average Opening Available YTD'),(16,43,'Average Available-Previous Month'),(17,44,'Disbursing Opening Available Balance'),(18,45,'Closing Available'),(19,50,'Average Closing Available MTD'),(20,51,'Average Closing Available-Last Month'),(21,54,'Average Closing Available YTD-Last Month'),(22,55,'Average Closing Available YTD'),(23,56,'Loan Balance'),(24,57,'Mutual Fund Balance'),(25,86,'Transfer Calculation'),(26,87,'Target Balance Deficiency'),(27,88,'Total Funding Requirement'),(28,100,'Total Credits'),(29,101,'Total Credit Amount MTD'),(30,102,'Number of Credits'),(31,105,'Credits Not Detailed'),(32,106,'Deposits Subject to Float'),(33,107,'Total Adjustment Credits YTD'),(34,108,'Credit (any type)'),(35,109,'Total Current Day Lockbox CR'),(36,110,'Total Lockbox Deposits CR'),(37,115,'Lockbox Deposit'),(38,116,'Item in Lockbox Deposit'),(39,118,'Lockbox Adjustment Credit'),(40,120,'EDI Transaction Credit (Summary)'),(41,121,'EDI Transaction Credit (Detail)'),(42,122,'EDIBANX Credit Received'),(43,123,'EDIBANX Credit Return'),(44,130,'Total Concentration Credits'),(45,131,'Total DTC Credits'),(46,135,'DTC Concentration Credit'),(47,136,'Item in DTC Deposit'),(48,140,'Total ACH Credits'),(49,142,'ACH Credit Received'),(50,143,'Item in ACH Deposit'),(51,145,'ACH Concentration Credit'),(52,146,'Total Bank Card Deposits'),(53,147,'Credit Card Deposit CR'),(54,150,'Tot Preauth Pmt Credits'),(55,154,'Sweep Investment Credit'),(56,155,'Preauthorized Draft Credit'),(57,156,'Item IN Preauthorization DRFT CR'),(58,160,'Total ACH Disbursing Funding Credits'),(59,162,'Corp Trade Pmt Settlement'),(60,163,'Total Corp Trade Payment Credit'),(61,164,'Corporate Trade Payment Credit'),(62,165,'Preauthorized ACH Credit'),(63,166,'ACH Settlement'),(64,167,'ACH Settlement Credits'),(65,168,'ACH Credit Return'),(66,169,'Misc. ACH Credit'),(67,170,'Total Other Check Deposits'),(68,171,'Individual Loan Deposit'),(69,235,'Sweep-Principal CR'),(70,236,'Maturity of Debt Security'),(71,237,'Individual Collection Credit'),(72,238,'Sweep-Dividends CR'),(73,239,'Total Banker\'s Acceptance Credits'),(74,240,'Coupon Collections-Banks'),(75,241,'Bankers\' Acceptance'),(76,242,'Collection of Interest Income'),(77,243,'Matured Fed Funds Purchased'),(78,244,'Interest/Matured Principal Payment'),(79,245,'Monthly Dividends'),(80,246,'Commercial Paper'),(81,247,'Capital Charge'),(82,248,'Savings Bond Sales Adjustment'),(83,249,'Misc. Security Credit'),(84,250,'Total Checks Posted and Returned'),(85,251,'Total Debit Reversals'),(86,252,'Debit Reversal'),(87,254,'Posting Error Correction Credit'),(88,255,'Check Posted and Returned'),(89,256,'Total ACH Return Items'),(90,257,'Individual ACH Return Item'),(91,258,'ACH Reversal Credit'),(92,260,'Total Rejected Credits'),(93,261,'Individual Rejected Credit'),(94,263,'Overdraft'),(95,266,'Return Item'),(96,268,'Return Item Adjustment'),(97,270,'Total ZBA Credits'),(98,271,'Net Zero-Balance Amount'),(99,274,'Cumulative ZBA or Disbursement Credits'),(100,275,'ZBA Credit'),(101,276,'CMA Float Adjustment Credit'),(102,277,'CMA Credit Transfer'),(103,278,'ZBA Credit Adjustment'),(104,280,'Total Controlled Disbursing Credits'),(105,281,'Individual Controlled Disbursing Credit'),(106,285,'Total DTC Disbursing Credits'),(107,286,'Individual DTC Disbursing Credit'),(108,293,'Cash Letter Credit'),(109,294,'Total ATM Credits'),(110,295,'ATM Credit'),(111,301,'Commercial Deposit'),(112,302,'Correspondent Bank Deposit'),(113,359,'Interest Adjustment Credit'),(114,360,'Total Checks Less Wire TRF and Returned Checks'),(115,361,'Grand Total Credits Less Grand Total Debits'),(116,362,'Correspondent Collection'),(117,363,'Correspondent Collection Adjustment'),(118,364,'Loan Participation'),(119,366,'Coin & Currency Deposited'),(120,367,'Food Stamp Letter'),(121,368,'Food Stamp Adjustment'),(122,369,'Clearing Settlement Credit'),(123,370,'Total Back Value Credits'),(124,372,'Back Value Adjustment'),(125,373,'Customer Payroll'),(126,374,'FRB Statement Recap'),(127,376,'Savings Bond Letter or Adjustment'),(128,377,'Treasury Tax and Loan Credit'),(129,378,'Transfer of Treasury Credit'),(130,379,'FRB Gov\'t Checks Cash Letter Credit'),(131,381,'FRB Gov\'t Check Adjustment'),(132,382,'FRB Postal Money Order Credit'),(133,383,'FRB Postal Money Order Adjustment'),(134,384,'FRB Cash Letter Auto Charge Credit'),(135,385,'Total Universal Credits'),(136,386,'Fed Settlement Adjustment CR'),(137,387,'FRB Fine Sort Cash Letter Credit'),(138,388,'FRB Fine Sort Adjustment'),(139,389,'Total Freight Pmt Credits'),(140,390,'Total Miscellaneous Credits'),(141,391,'Universal Credit'),(142,392,'Freight Payment Credit'),(143,393,'Itemized Credit Over $10,000'),(144,394,'Cumulative Credits'),(145,395,'Check Reversal'),(146,397,'Float Adjustment'),(147,398,'Miscellaneous Fee Refund CR'),(148,399,'Miscellaneous Credit'),(149,400,'Total Debits'),(150,401,'Total Debit Amount MTD'),(151,402,'Number of Debits'),(152,403,'Today\'s Total Debits'),(153,405,'Tot DR Less Wire TR'),(154,406,'Debits Not Detailed'),(155,408,'Float Adjustment Debit'),(156,409,'Debit (any type)'),(157,490,'Total Outgoing Money Transfer'),(158,491,'Individual Outgoing Internal Money Transfer'),(159,493,'Customer Terminal Initiated Money Transfer'),(160,495,'Outgoing Money Transfer'),(161,496,'Money Transfer Adjustment'),(162,498,'Compensation'),(163,500,'Total Automatic Transfer Debits'),(164,501,'Individual Automatic Transfer Debit'),(165,502,'Bond Operations Debit'),(166,505,'Total Book Transfer Debits'),(167,506,'Book Transfer Debit'),(168,507,'Total International Money Trf Debit'),(169,508,'Individual International Money Trf Debits'),(170,510,'Total Intl Debits'),(171,512,'Letters of Credit Debit'),(172,513,'Letter of Credit'),(173,514,'Foreign Exchange Debit'),(174,515,'Total Letters of Credit'),(175,516,'Foreign Remittance Debit'),(176,518,'Foreign Collection Debit'),(177,522,'Foreign Checks Paid'),(178,524,'Commission'),(179,526,'International Money Market Trading'),(180,527,'Standing Order'),(181,529,'Misc. International Debit or Draft'),(182,530,'Total Security Debits'),(183,531,'Securities Purchased'),(184,532,'Total Amt of Securities Purchased'),(185,533,'Security Collection Debit'),(186,534,'Tot Misc Securities DB FF'),(187,535,'Purchase of Equity Securities'),(188,536,'Tot Misc Securities DB-CHF'),(189,537,'Total Collection Debit'),(190,538,'Matured Repurchase Order'),(191,539,'Total Banker\'s Acceptance Debit'),(192,540,'Coupon Collection Debit'),(193,541,'Banker\'s Acceptances'),(194,542,'Purchase of Debit Securities'),(195,543,'Domestic Collection'),(196,544,'Interest-Matured Principal Payment'),(197,546,'Commercial Paper'),(198,547,'Capital Change'),(199,548,'Savings Bond Sales Adjustment'),(200,549,'Miscellaneous Security Debit'),(201,625,'Total Broker Debits'),(202,626,'Total Fed Funds Purchased'),(203,627,'Sweep-Fed Funds Debit'),(204,628,'Total Cash Center Debits'),(205,629,'Cash Center Debit'),(206,630,'Total Debit Adjustment'),(207,631,'Debit Adjustment'),(208,632,'Total Trust Debits'),(209,633,'Trust Debit'),(210,634,'YTD Adjustment Debit'),(211,640,'Total Escrow Debits'),(212,641,'Individual Escrow Debit'),(213,644,'Individual Back Value Debit'),(214,646,'Transfer Calculation Debit'),(215,650,'Investments Purchased'),(216,651,'Individual Investment Purchased'),(217,652,'Total Bank Card Debits'),(218,653,'Bank Card Debit'),(219,654,'Interest Debit'),(220,655,'Total Investment Interest Debits'),(221,656,'Sweep-Mutual Fund Debit'),(222,657,'Futures Debit'),(223,658,'Principal Payments Debit'),(224,659,'Interest Adjustment Debit'),(225,661,'Account Analysis Fee'),(226,662,'Correspondent Collection Debit'),(227,663,'Correspondent Collection Adjustment'),(228,664,'Loan Participation'),(229,665,'Intercept Debits'),(230,666,'Currency and Coin Shipped'),(231,667,'Food Stamp Letter'),(232,668,'Food Stamp Adjustment'),(233,669,'Clearing Settlement Debit'),(234,670,'Total Back Value Debits'),(235,672,'Back Value Adjustment'),(236,673,'Customer Payroll'),(237,674,'FRB Statement Recap'),(238,676,'Savings Bond Letter or Adjustment'),(239,677,'Treasury Tax and Loan Debit'),(240,678,'Transfer of Treasury Debit'),(241,679,'FRB Government Checks Cash Letter Debit'),(242,681,'FRB Government Check Adjustment'),(243,682,'FRB Postal Money Order Debit'),(244,683,'FRB Postal Money Order Adjustment'),(245,778,'Adjustment Disb Debits'),(246,779,'Total Adjustment Disb Credits'),(247,780,'Total Adjustment Disb Debits'),(248,781,'Credit for Closed CD Debits'),(249,782,'Debit to Fund New CD'),(250,820,'Balance to be Settled for the Day'),(251,821,'Current Investment Balance'),(252,822,'Current Blocked Balance'),(253,823,'Current Overdraft Limit'),(254,824,'Interest'),(255,825,'Interest Not Posted'),(256,826,'IOF'),(257,827,'IOF Not Yet Posted'),(258,856,'Dep+ Transfer Credit'),(259,868,'Dep+ Transfer Debit'),(260,890,'Non-Monetary info'),(261,899,'Pre-Encoded Deposit Credit'),(262,901,'FundsNet Transfer Credit'),(263,904,'Vault Deposit Credit'),(264,906,'Today\'s Opening 1 Day Float'),(265,907,'Today\'s Opening 2+ Day Float'),(266,914,'1 Day Avail Balance'),(267,916,'2 Day Avail Balance'),(268,917,'3 Day Avail Balance'),(269,918,'4 Day Avail Balance'),(270,919,'5 Day Avail Balance'),(271,920,'Total Credit 0 Day Float'),(272,921,'SEPA Receipt'),(273,922,'SEPA Return'),(274,923,'SEPA Core DD Receipt'),(275,924,'SEPA B2B DD Receipt'),(276,925,'SEPA Core DD Payment Return'),(277,59,'Current Available (CRS Suppressed)'),(278,60,'Current Available'),(279,61,'Average Current Available MTD'),(280,62,'Average Current Available YTD'),(281,63,'Total Float'),(282,65,'Target Balance'),(283,66,'Adjusted Balance'),(284,67,'Adjusted Balance MTD'),(285,68,'Adjusted Balance YTD'),(286,70,'0-Day Float'),(287,72,'1-Day Float'),(288,73,'Float Adjustment'),(289,74,'2 or More Days Float'),(290,75,'3 or More Days Float'),(291,76,'Adjustment to Balances'),(292,77,'Average Adjustment to Balances MTD'),(293,78,'Average Adjustment to Balances YTD'),(294,79,'4-Day Float'),(295,80,'5-Day Float'),(296,81,'6-Day Float'),(297,82,'Average 1-Day Float MTD'),(298,83,'Average 1-Day Float YTD'),(299,84,'Average 2-Day Float MTD'),(300,85,'Average 2-Day Float YTD'),(301,172,'Deposit Correction'),(302,173,'Bank Prepared Deposit'),(303,174,'Other Deposit'),(304,175,'Check Deposit Package'),(305,176,'Re-presented Check Deposit'),(306,178,'List Post Credits'),(307,180,'Total Loan Proceeds'),(308,182,'Total Bank Prepared Deposits'),(309,184,'Draft Deposit'),(310,185,'Total Miscellaneous Deposits'),(311,186,'Total Cash Letter Credits'),(312,187,'Cash Letter Credit'),(313,188,'Total Cash Letter Adjustments'),(314,189,'Cash Letter Adjustment'),(315,190,'Total Incoming Money Transfers'),(316,191,'Individual Incoming Internal Money TRF'),(317,195,'Incoming Money Transfer'),(318,196,'Money Transfer Adjustment'),(319,198,'Compensation'),(320,200,'Total Automatic TRF Credits'),(321,201,'Individual Automatic Transfer Credits'),(322,202,'Bond Operations Credit'),(323,205,'Total Book Transfer Credits'),(324,206,'Book Transfer Credit'),(325,207,'Total International Money Transfer Credit'),(326,208,'Individual International Money TRF Credit'),(327,210,'Total International Credits'),(328,212,'Foreign Letter of Credit'),(329,213,'Letter of Credit'),(330,214,'Foreign Exchange of Credit'),(331,215,'Total Letters of Credit'),(332,216,'Foreign Remittance Credit'),(333,218,'Foreign Collection Credit'),(334,221,'Foreign Check Purchase'),(335,222,'Foreign Checks Deposited'),(336,224,'Commission'),(337,226,'International Money Market Trading'),(338,227,'Standing Order'),(339,229,'Misc. International Credit'),(340,230,'Total Security Credits'),(341,231,'Total Collection Credits'),(342,232,'Sale of Debt Security'),(343,233,'Securities Sold'),(344,234,'Sale of Equity Security'),(345,303,'Total Wire Transfers In-FF'),(346,304,'Total Wire Transfers-In-CHF'),(347,305,'Total Fed Funds Sold'),(348,306,'Fed Funds Sold'),(349,307,'Total Trust Credits'),(350,308,'Trust Credit'),(351,309,'Total Value-Dated Funds'),(352,310,'Total Commercial Deposits'),(353,315,'Total International Credits-FF'),(354,316,'Total International Credits-CHF'),(355,318,'Total Foreign Check Purchased'),(356,319,'Late Deposit'),(357,320,'Total Securities Sold-FF'),(358,321,'Total Securities Sold-CHF'),(359,324,'Total Securities Matured-FF'),(360,325,'Total Securities Matured-CHF'),(361,326,'Total Securities Interest'),(362,327,'Total Securities Matured'),(363,328,'Total Securities Interest-FF'),(364,329,'Total Securities Interest-CHF'),(365,330,'Total Escrow Credits'),(366,331,'Individual Escrow Credits'),(367,332,'Total Misc. Securities Credits-FF'),(368,336,'Total Misc. Securities Credits-CHF'),(369,338,'Total Securities Sold'),(370,340,'Total Broker Deposits'),(371,341,'Total Broker Deposits-FF'),(372,342,'Broker Deposit'),(373,343,'Total Brokers Deposits-CHF'),(374,344,'Individual Back Value Credit'),(375,345,'Item in Brokers Deposit'),(376,346,'Sweep Interest Income'),(377,347,'Sweep-Trans From Mutual Fund'),(378,348,'Futures Credit'),(379,349,'Sweep Principal Credit'),(380,350,'Total Sweep Credits'),(381,351,'Individual Investment Sold'),(382,352,'Total Cash Center Credits'),(383,353,'Cash Center Credit'),(384,354,'Interest Credit'),(385,355,'Investment Interest'),(386,356,'Total Credit Adjustment'),(387,357,'Credit Adjustment'),(388,358,'YTD Adjustment Credit'),(389,410,'Total YTD Adjustment'),(390,412,'Total Debits Excluding Returned Items'),(391,415,'Lockbox Debit'),(392,416,'Total Lockbox Debits'),(393,418,'Lockbox Adjustment Debit'),(394,420,'EDI Transaction Debits'),(395,421,'EDI Transaction Debit'),(396,422,'EDIBANX Transaction Debit'),(397,423,'EDIBANX Settlement Debit'),(398,430,'Total Payable Through Drafts'),(399,435,'Payable Through Draft'),(400,445,'ACH Concentration Debit'),(401,446,'Total ACH Disbursing Funding Debits'),(402,447,'ACH Prefunding Settlement DR'),(403,450,'Total ACH Debits'),(404,451,'ACH Debit Received'),(405,452,'Item in ACH Disbursement or Debit'),(406,454,'Sweep Investment Debit'),(407,455,'Preauthorized ACH Debit'),(408,462,'Account Holder Initiated ACH Debit'),(409,463,'Corporate Trade Payment Debits'),(410,464,'Corporate Trade Payment Debit'),(411,465,'Corporate Trade Pmt Settlement'),(412,466,'ACH Settlement'),(413,467,'ACH Settlement Debits'),(414,468,'ACH Debit Return'),(415,469,'Miscellaneous ACH Debit'),(416,470,'Total Check Paid'),(417,471,'Total Check Pd Cumulative MTD'),(418,472,'Cumulative Checks Paid'),(419,474,'Certified Check Debit'),(420,475,'Check Paid'),(421,476,'Federal Reserve Bank Letter Debit'),(422,477,'Bank Originated Debit'),(423,478,'Total List Post Debits'),(424,479,'List Post Debit'),(425,480,'Total Loan Payments'),(426,481,'Individual Loan Payment Debit'),(427,482,'Total Bank Originated Debits'),(428,484,'Draft'),(429,485,'DTC Debit'),(430,486,'Total Cash Letter Debits'),(431,487,'Cash Letter Debit'),(432,489,'Cash Letter Adjustment'),(433,550,'Total Deposited Items Returned'),(434,551,'Total Credit Reversals'),(435,552,'Credit Reversal'),(436,554,'Posting Error Correction Debit'),(437,555,'Deposited Item Returned'),(438,556,'Tot ACH Return Items'),(439,557,'Individual ACH Return Item'),(440,558,'ACH Reversal Debit'),(441,560,'Total Rejected Debits'),(442,561,'Individual Rejected Debit'),(443,563,'Overdraft'),(444,564,'Overdraft Fee'),(445,566,'Return Item'),(446,567,'Return Item Fee'),(447,568,'Return Item Adjustment'),(448,570,'Total ZBA Debits'),(449,574,'Cumulative ZBA Debits'),(450,575,'ZBA Debit'),(451,577,'ZBA Debit Transfer'),(452,578,'ZBA Debit Adjustment'),(453,580,'Total Controlled Disbursing Debits'),(454,581,'Individual Controlled Disbursing Debit'),(455,583,'Total Disbursing Checks Paid-Early Amt'),(456,584,'Total Disbursing Checks Paid-Later Amt'),(457,585,'Disbursing Funding Requirement'),(458,586,'FRB Presentment Estimate (FED estimate)'),(459,587,'Late Debits (After Notification)'),(460,590,'Total DTC Debits'),(461,594,'Total ATM Debits'),(462,595,'ATM Debit'),(463,596,'Total ARP Debits'),(464,597,'ARP Debit'),(465,610,'Total Funds Required'),(466,611,'Total Wires Transfers Out-CHF'),(467,612,'Total Wire Transfers Out FF'),(468,613,'Total International Debit CHF'),(469,614,'Total International Debit FF'),(470,615,'Tot Federal Reserve BK Comm BK Debit'),(471,616,'Federal Reserve Bank-Commercial Bank DB'),(472,617,'Total Securities Purchased-CHF'),(473,618,'Total Securities Purchased-FF'),(474,621,'Total Broker Debits'),(475,622,'Broker Debit'),(476,623,'Total Broker Debits-FF'),(477,684,'FRB Cash Letter Auto Charge Debit'),(478,685,'Total Universal Debits'),(479,686,'Fed Settlement Adjustment DR'),(480,687,'FRB Fine-Sort Cash Letter Debit'),(481,688,'FRB Fine-Sort Adjustment'),(482,689,'FRB Freight Pmt Debits'),(483,690,'Total Miscellaneous Debits'),(484,691,'Universal Debit'),(485,692,'Freight Payment Debit'),(486,693,'Itemized Debit Over $10,000'),(487,694,'Deposit Reversal'),(488,695,'Deposit Correction Debit'),(489,696,'Regular Collection Debit'),(490,697,'Cumulative Debits'),(491,698,'Miscellaneous Fees'),(492,699,'Miscellaneous Debit'),(493,701,'ACH Items Credit'),(494,702,'Domestic Collection Draft DR'),(495,706,'Trading Securities Credit'),(496,707,'Safekeeping Credit'),(497,708,'Trading Securities Debit'),(498,710,'Safekeeping Credit'),(499,711,'Safekeeping Debit'),(500,715,'ACH Disbursement Credits'),(501,716,'ACH Disbursement Debits'),(502,724,'Total Disb Opening Avail BAL'),(503,725,'Total ACH Disb Funding Credits'),(504,726,'Total ACH Disb Funding Debits'),(505,727,'Total Disb Chks Paid-1ST Pres'),(506,728,'Total Disb Chks Paid-2nd Pres'),(507,729,'Total Disbursement Funding Requirement'),(508,733,'Bill Pay Transfer Credit'),(509,734,'Bill Pay Adjustment Credit'),(510,738,'Controlled Disb Funding Debit'),(511,739,'Controlled Disb Funding Credit'),(512,741,'PC Bill Payment Debit'),(513,742,'Pre-Authorized BillPay Debit'),(514,743,'Bill Pay Transfer Debit'),(515,744,'Bill Pay Rep Assist Debit'),(516,745,'Bill Pay Adjustment Debit'),(517,746,'Telephone Bill Pay Debit'),(518,755,'Erin Return Charge Back Debit'),(519,766,'Erin Return Reclear Debit'),(520,777,'Adjustment Disb Credits'),(521,926,'SEPA B2B DD Payment Return'),(522,931,'Total Lockbox CR Item Count'),(523,936,'ACH Debit Reject'),(524,937,'Deposit Correction Cash Credit'),(525,938,'Deposit Correction Cash Debit'),(526,940,'Counter Check Debit'),(527,941,'Force Pay Debit'),(528,942,'Check Debit'),(529,943,'Check Debit'),(530,945,'Loan Interest Credit'),(531,946,'Intra Account Transfer Debit'),(532,947,'Loan Fee Credit'),(533,951,'Security Purchase Debit'),(534,952,'Repurchase Agreement Debit'),(535,953,'Insufficient Check Charge DR'),(536,956,'Purchased of CD Debit'),(537,960,'AutoBorrow Payment Debit'),(538,963,'Clearing Transfer Debit'),(539,964,'INClearing Settlement Debit'),(540,965,'Stop Pay Charge Debit'),(541,966,'Telephone Transfer Charge DR'),(542,968,'Account Analysis Charge Debit'),(543,972,'SEPA B2B DD Payment'),(544,973,'SEPA Core DD Receipt Return'),(545,974,'SEPA B2B DD Receipt Return'),(546,975,'SEPA Payment'),(547,976,'SEPA Core DD Payment'),(548,977,'Debit to Close Account'),(549,985,'Loan Interest Debit'),(550,987,'Loan Fee Debit'),(551,998,'Undefined Credit'),(552,999,'Undefined Debit');
/*!40000 ALTER TABLE `ref_bai_issuer_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_branch_type`
--

DROP TABLE IF EXISTS `ref_branch_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_branch_type` (
  `PK_branch_type` int(11) NOT NULL AUTO_INCREMENT,
  `branch_type_description` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PK_branch_type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_branch_type`
--

LOCK TABLES `ref_branch_type` WRITE;
/*!40000 ALTER TABLE `ref_branch_type` DISABLE KEYS */;
INSERT INTO `ref_branch_type` VALUES (1,'Small'),(2,'Medium'),(3,'Large');
/*!40000 ALTER TABLE `ref_branch_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_card_type`
--

DROP TABLE IF EXISTS `ref_card_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_card_type` (
  `PK_card_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `card_type_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_type_description` tinytext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`PK_card_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_card_type`
--

LOCK TABLES `ref_card_type` WRITE;
/*!40000 ALTER TABLE `ref_card_type` DISABLE KEYS */;
INSERT INTO `ref_card_type` VALUES (1,'Credit Card','The  cardholder can draw either for payment to a merchant for a purchase or as a cash advance to the cardholder.'),(2,'Debit Card','The cardholder withdraws funds from bank account.'),(3,'Prepaid Card','Similar to debit card, the cardholder can draw only funds payed in advance.'),(4,'Charge card','The cardholder is required to pay the full balance shown on the statement  by the payment due date.');
/*!40000 ALTER TABLE `ref_card_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_contract_status_code`
--

DROP TABLE IF EXISTS `ref_contract_status_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_contract_status_code` (
  `PK_contract_status_code_id` int(11) NOT NULL AUTO_INCREMENT,
  `contract_status_description` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PK_contract_status_code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_contract_status_code`
--

LOCK TABLES `ref_contract_status_code` WRITE;
/*!40000 ALTER TABLE `ref_contract_status_code` DISABLE KEYS */;
INSERT INTO `ref_contract_status_code` VALUES (1,'Active'),(2,'Inactive'),(3,'Breached'),(4,'Void');
/*!40000 ALTER TABLE `ref_contract_status_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_contract_type`
--

DROP TABLE IF EXISTS `ref_contract_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_contract_type` (
  `PK_contract_type` int(11) NOT NULL AUTO_INCREMENT,
  `contract_type_description` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PK_contract_type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_contract_type`
--

LOCK TABLES `ref_contract_type` WRITE;
/*!40000 ALTER TABLE `ref_contract_type` DISABLE KEYS */;
INSERT INTO `ref_contract_type` VALUES (1,'Loan Contract'),(2,'Deposit Contract'),(3,'Security Safes Contract'),(4,'Ebanking Contract'),(5,'Bank Services Contract');
/*!40000 ALTER TABLE `ref_contract_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_country_code`
--

DROP TABLE IF EXISTS `ref_country_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_country_code` (
  `PK_ country_code` int(11) NOT NULL AUTO_INCREMENT,
  `country_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `iso_alpha_3` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PK_ country_code`)
) ENGINE=InnoDB AUTO_INCREMENT=248 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Used as a part of IBAN number. Defined by ISO 3166 - 1 (alpha 3 codes).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_country_code`
--

LOCK TABLES `ref_country_code` WRITE;
/*!40000 ALTER TABLE `ref_country_code` DISABLE KEYS */;
INSERT INTO `ref_country_code` VALUES (1,'Afghanistan','AFG'),(2,'Aland Islands','ALA'),(3,'Albania','ALB'),(4,'Algeria','DZA'),(5,'American Samoa','ASM'),(6,'Andorra','AND'),(7,'Angola','AGO'),(8,'Anguilla','AIA'),(9,'Antarctica','ATA'),(10,'Antigua and Barbuda','ATG'),(11,'Argentina','ARG'),(12,'Armenia','ARM'),(13,'Aruba','ABW'),(14,'Australia','AUS'),(15,'Austria','AUT'),(16,'Azerbaijan','AZE'),(17,'Bahamas','BHS'),(18,'Bahrain','BHR'),(19,'Bangladesh','BGD'),(20,'Barbados','BRB'),(21,'Belarus','BLR'),(22,'Belgium','BEL'),(23,'Belize','BLZ'),(24,'Benin','BEN'),(25,'Bermuda','BMU'),(26,'Bhutan','BTN'),(27,'Bolivia','BOL'),(28,'Bosnia and Herzegovina','BIH'),(29,'Botswana/td>','BWA'),(30,'Bouvet Island','BVT'),(31,'Brazil','BRA'),(32,'British Virgin Islands','VGB'),(33,'British Indian Ocean Territory','IOT'),(34,'Brunei Darussalam','BRN'),(35,'Bulgaria','BGR'),(36,'Burkina Faso','BFA'),(37,'Burundi','BDI'),(38,'Cambodia','KHM'),(39,'Cameroon','CMR'),(40,'Canada','CAN'),(41,'Cape Verde','CPV'),(42,'Cayman Islands','CYM'),(43,'Central African Republic','CAF'),(44,'Chad','TCD'),(45,'Chile','CHL'),(46,'China','CHN'),(47,'Hong Kong, SAR China','HKG'),(48,'Macao, SAR China','MAC'),(49,'Christmas Island','CXR'),(50,'Cocos (Keeling) Islands','CCK'),(51,'Colombia','COL'),(52,'Comoros','COM'),(53,'Congo (Brazzaville)','COG'),(54,'Congo, (Kinshasa)','COD'),(55,'Cook Islands','COK'),(56,'Costa Rica','CRI'),(57,'Côte d\'Ivoire','CIV'),(58,'Croatia','HRV'),(59,'Cuba','CUB'),(60,'Cyprus','CYP'),(61,'Czech Republic','CZE'),(62,'Denmark','DNK'),(63,'Djibouti','DJI'),(64,'Dominica','DMA'),(65,'Dominican Republic','DOM'),(66,'Ecuador','ECU'),(67,'Egypt','EGY'),(68,'El Salvador','SLV'),(69,'Equatorial Guinea','GNQ'),(70,'Eritrea','ERI'),(71,'Estonia','EST'),(72,'Ethiopia','ETH'),(73,'Falkland Islands (Malvinas)','FLK'),(74,'Faroe Islands','FRO'),(75,'Fiji','FJI'),(76,'Finland','FIN'),(77,'France','FRA'),(78,'French Guiana','GUF'),(79,'French Polynesia','PYF'),(80,'French Southern Territories','ATF'),(81,'Gabon','GAB'),(82,'Gambia','GMB'),(83,'Georgia','GEO'),(84,'Germany','DEU'),(85,'Ghana','GHA'),(86,'Gibraltar','GIB'),(87,'Greece','GRC'),(88,'Greenland','GRL'),(89,'Grenada','GRD'),(90,'Guadeloupe','GLP'),(91,'Guam','GUM'),(92,'Guatemala','GTM'),(93,'Guernsey','GGY'),(94,'Guinea','GIN'),(95,'Guinea-Bissau','GNB'),(96,'Guyana','GUY'),(97,'Haiti','HTI'),(98,'Heard and Mcdonald Islands','HMD'),(99,'Holy See(Vatican City State)','VAT'),(100,'Honduras','HND'),(101,'Hungary','HUN'),(102,'Iceland','ISL'),(103,'India','IND'),(104,'Indonesia','IDN'),(105,'Iran, Islamic Republic of','IRN'),(106,'Iraq','IRQ'),(107,'Ireland','IRL'),(108,'Isle of Man','IMN'),(109,'Israel','ISR'),(110,'Italy','ITA'),(111,'Jamaica','JAM'),(112,'Japan','JPN'),(113,'Jersey','JEY'),(114,'Jordan','JOR'),(115,'Kazakhstan','KAZ'),(116,'Kenya','KEN'),(117,'Kiribati','KIR'),(118,'Korea (North)','PRK'),(119,'Korea (South)','KOR'),(120,'Kuwait','KWT'),(121,'Kyrgyzstan','KGZ'),(122,'Lao PDR','LAO'),(123,'Latvia','LVA'),(124,'Lebanon','LBN'),(125,'Lesotho','LSO'),(126,'Liberia','LBR'),(127,'Libya','LBY'),(128,'Liechtenstein','LIE'),(129,'Lithuania','LTU'),(130,'Luxembourg','LUX'),(131,'Macedonia, Republic of','MKD'),(132,'Madagascar','MDG'),(133,'Malawi','MWI'),(134,'Malaysia','MYS'),(135,'Maldives','MDV'),(136,'Mali','MLI'),(137,'Malta','MLT'),(138,'Marshall Islands','MHL'),(139,'Martinique','MTQ'),(140,'Mauritania','MRT'),(141,'Mauritius','MUS'),(142,'Mayotte','MYT'),(143,'Mexico','MEX'),(144,'Micronesia, Federated States of','FSM'),(145,'Moldova','MDA'),(146,'Monaco','MCO'),(147,'Mongolia','MNG'),(148,'Montenegro','MNE'),(149,'Montserrat','MSR'),(150,'Morocco','MAR'),(151,'Mozambique','MOZ'),(152,'Myanmar','MMR'),(153,'Namibia','NAM'),(154,'Nauru','NRU'),(155,'Nepal','NPL'),(156,'Netherlands','NLD'),(157,'Netherlands Antilles','ANT'),(158,'New Caledonia','NCL'),(159,'New Zealand','NZL'),(160,'Nicaragua','NIC'),(161,'Niger','NER'),(162,'Nigeria','NGA'),(163,'Niue','NIU'),(164,'Norfolk Island','NFK'),(165,'Northern Mariana Islands','MNP'),(166,'Norway','NOR'),(167,'Oman','OMN'),(168,'Pakistan','PAK'),(169,'Palau','PLW'),(170,'Palestinian Territory','PSE'),(171,'Panama','PAN'),(172,'Papua New Guinea','PNG'),(173,'Paraguay','PRY'),(174,'Peru','PER'),(175,'Philippines','PHL'),(176,'Pitcairn','PCN'),(177,'Poland','POL'),(178,'Portugal','PRT'),(179,'Puerto Rico','PRI'),(180,'Qatar','QAT'),(181,'Réunion','REU'),(182,'Romania','ROU'),(183,'Russian Federation','RUS'),(184,'Rwanda','RWA'),(185,'Saint-Barthélemy','BLM'),(186,'Saint Helena','SHN'),(187,'Saint Kitts and Nevis','KNA'),(188,'Saint Lucia','LCA'),(189,'Saint-Martin (French part)','MAF'),(190,'Saint Pierre and Miquelon','SPM'),(191,'Saint Vincent and Grenadines','VCT'),(192,'Samoa','WSM'),(193,'San Marino','SMR'),(194,'Sao Tome and Principe','STP'),(195,'Saudi Arabia','SAU'),(196,'Senegal','SEN'),(197,'Serbia','SRB'),(198,'Seychelles','SYC'),(199,'Sierra Leone','SLE'),(200,'Singapore','SGP'),(201,'Slovakia','SVK'),(202,'Slovenia','SVN'),(203,'Solomon Islands','SLB'),(204,'Somalia','SOM'),(205,'South Africa','ZAF'),(206,'South Georgia and the South Sandwich Islands','SGS'),(207,'South Sudan','SSD'),(208,'Spain','ESP'),(209,'Sri Lanka','LKA'),(210,'Sudan','SDN'),(211,'Suriname','SUR'),(212,'Svalbard and Jan Mayen Islands','SJM'),(213,'Swaziland','SWZ'),(214,'Sweden','SWE'),(215,'Switzerland','CHE'),(216,'Syrian Arab Republic (Syria)','SYR'),(217,'Taiwan, Republic of China','TWN'),(218,'Tajikistan','TJK'),(219,'Tanzania, United Republic of','TZA'),(220,'Thailand','THA'),(221,'Timor-Leste','TLS'),(222,'Togo','TGO'),(223,'Tokelau','TKL'),(224,'Tonga','TON'),(225,'Trinidad and Tobago','TTO'),(226,'Tunisia','TUN'),(227,'Turkey','TUR'),(228,'Turkmenistan','TKM'),(229,'Turks and Caicos Islands','TCA'),(230,'Tuvalu','TUV'),(231,'Uganda','UGA'),(232,'Ukraine','UKR'),(233,'United Arab Emirates','ARE'),(234,'United Kingdom','GBR'),(235,'United States of America','USA'),(236,'US Minor Outlying Islands','UMI'),(237,'Uruguay','URY'),(238,'Uzbekistan','UZB'),(239,'Vanuatu','VUT'),(240,'Venezuela(Bolivarian Republic)','VEN'),(241,'Viet Nam','VNM'),(242,'Virgin Islands, US','VIR'),(243,'Wallis and Futuna Islands','WLF'),(244,'Western Sahara','ESH'),(245,'Yemen','YEM'),(246,'Zambia','ZMB'),(247,'Zimbabwe','ZWE');
/*!40000 ALTER TABLE `ref_country_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_currency_code`
--

DROP TABLE IF EXISTS `ref_currency_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_currency_code` (
  `PK_currency_code_id` int(11) NOT NULL AUTO_INCREMENT,
  `currency_code` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `currency_code_country` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PK_currency_code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='ISO 4217 is a standard first published by International Organization for Standardization which delineates currency designators, country codes (alpha and numeric), and references to minor units.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_currency_code`
--

LOCK TABLES `ref_currency_code` WRITE;
/*!40000 ALTER TABLE `ref_currency_code` DISABLE KEYS */;
INSERT INTO `ref_currency_code` VALUES (1,'Albanian Lek','ALL'),(2,'Australian Dollar','AUD'),(3,'Convertible Marks','BAM'),(4,'Yuan Renminbi','CNY'),(5,'EUR','EUR'),(6,'British pound','GBP'),(7,'Kuna','HRK'),(8,'Serbian Dinar','RSD'),(9,'Hungarian Forinta','HUF'),(10,'Indian Rupee','INR'),(11,'Russian Ruble','RUB'),(12,'Denar','MKD'),(13,'US Dollar','USD'),(14,'IMF','XDR'),(15,'Swiss Franc','CHF'),(16,'Yen','JPY'),(17,'Argentine Peso','ARS'),(18,'Tenge','KZT'),(19,'Mexican Peso','MXN'),(20,'New Zealand Dollar','NZD'),(21,'Nuevo Sol','PEN'),(22,'SUCRE','XSU'),(23,'Zimbabwe Dollar','ZWL'),(24,'Bitcoin','BTC'),(25,'Ethereum','ETH'),(26,'Litecoin','LTC'),(27,'Bitcoin Cash','BCH'),(28,'Bitcoin SV','BSV'),(29,'Maker','MKR'),(30,'Mixin','XIN'),(31,'Primalbase Token','PBT'),(32,'IDEX Membership','IDXM'),(33,'ThoreCoin','THR'),(34,'42-coin','42'),(35,'bitGold','BITGOLD'),(36,'FOIN','FOIN'),(37,'RSK Smart Bit','RBTC'),(38,'DEXTER','DXR');
/*!40000 ALTER TABLE `ref_currency_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_customer_type`
--

DROP TABLE IF EXISTS `ref_customer_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_customer_type` (
  `PK_customer_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_type_description` varchar(45) COLLATE utf8_unicode_ci DEFAULT 'Civil',
  PRIMARY KEY (`PK_customer_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_customer_type`
--

LOCK TABLES `ref_customer_type` WRITE;
/*!40000 ALTER TABLE `ref_customer_type` DISABLE KEYS */;
INSERT INTO `ref_customer_type` VALUES (1,'Civil'),(2,'Entrepreneur'),(3,'Administrator'),(4,'Organisation');
/*!40000 ALTER TABLE `ref_customer_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_loan_type`
--

DROP TABLE IF EXISTS `ref_loan_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_loan_type` (
  `PK_loan_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `loan_type_description` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PK_loan_type_id`),
  UNIQUE KEY `loan_type_description_UNIQUE` (`loan_type_description`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_loan_type`
--

LOCK TABLES `ref_loan_type` WRITE;
/*!40000 ALTER TABLE `ref_loan_type` DISABLE KEYS */;
INSERT INTO `ref_loan_type` VALUES (3,'Car Loan'),(9,'Cash Advance Loan'),(11,'Cash Credit'),(4,'Consolidation Loan'),(12,'Consumer Credit'),(1,'Home Equity Loan'),(2,'Mortgage'),(8,'Payday Loan'),(6,'Personal Loan'),(5,'Refinancing Loan'),(7,'Student Loan');
/*!40000 ALTER TABLE `ref_loan_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_merchant_category`
--

DROP TABLE IF EXISTS `ref_merchant_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_merchant_category` (
  `PK category_id` int(11) NOT NULL AUTO_INCREMENT,
  `mcc_code` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mcc_description` tinytext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`PK category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=260 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='ISO 18245:2003 Retail financial services -- Merchant category codes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_merchant_category`
--

LOCK TABLES `ref_merchant_category` WRITE;
/*!40000 ALTER TABLE `ref_merchant_category` DISABLE KEYS */;
INSERT INTO `ref_merchant_category` VALUES (1,'4814','Telecommunication service including local and long distance calls, credit card calls, calls through use of magneticstrip reading telephones and fax services'),(2,'4815','VisaPhone'),(3,'4821','Telegraph services'),(4,'4829','Money Orders - Wire Transfer'),(5,'4899','Cable and other pay television (previously Cable Services)'),(6,'4900','Electric, Gas, Sanitary and Water Utilities'),(7,'5013','Motor vehicle supplies and new parts'),(8,'5021','Office and Commercial Furniture'),(9,'5039','Construction Materials, Not Elsewhere Classified'),(10,'5044','Office, Photographic, Photocopy, and Microfilm Equipment'),(11,'5045','Computers, Computer Peripheral Equipment, Software'),(12,'5046','Commercial Equipment, Not Elsewhere Classified'),(13,'5047','Medical, Dental Ophthalmic, Hospital Equipment and Supplies'),(14,'5051','Metal Service Centers and Offices'),(15,'5065','Electrical Parts and Equipment'),(16,'5072','Hardware Equipment and Supplies'),(17,'5074','Plumbing and Heating Equipment and Supplies'),(18,'5085','Industrial Supplies, Not Elsewhere Classified'),(19,'5094','Precious Stones and Metals, Watches and Jewelry'),(20,'5099','Durable Goods, Not Elsewhere Classified'),(21,'5111','Stationery, Office Supplies, Printing, and Writing Paper'),(22,'5122','Drugs, Drug Proprietors, and Druggist’s Sundries'),(23,'5131','Piece Goods, Notions, and Other Dry Goods'),(24,'5137','Men’s Women’s and Children’s Uniforms and Commercial Clothing'),(25,'5139','Commercial Footwear'),(26,'5169','Chemicals and Allied Products, Not Elsewhere Classified'),(27,'5172','Petroleum and Petroleum Products'),(28,'5192','Books, Periodicals, and Newspapers'),(29,'5193','Florists’ Supplies, Nursery Stock and Flowers'),(30,'5198','Paints, Varnishes, and Supplies'),(31,'5199','Non-durable Goods, Not Elsewhere Classified'),(32,'5200','Home Supply Warehouse Stores'),(33,'5211','Lumber and Building Materials Stores'),(34,'5231','Glass Stores'),(35,'5231','Paint and Wallpaper Stores'),(36,'5231','Wallpaper Stores'),(37,'5251','Hardware Stores'),(38,'5261','Nurseries – Lawn and Garden Supply Store'),(39,'5271','Mobile Home Dealers'),(40,'5300','Wholesale Clubs'),(41,'5309','Duty Free Store'),(42,'5310','Discount Stores'),(43,'5311','Department Stores'),(44,'5331','Variety Stores'),(45,'5399','Misc. General Merchandise'),(46,'5411','Grocery Stores'),(47,'5411','Supermarkets'),(48,'5422','Freezer and Locker Meat Provisioners'),(49,'5422','Meat Provisioners – Freezer and Locker'),(50,'5441','Candy Stores'),(51,'5441','Confectionery Stores'),(52,'5441','Nut Stores'),(53,'5451','Dairy Products Stores'),(54,'5462','Bakeries'),(55,'5499','Misc. Food Stores – Convenience Stores and Specialty Markets'),(56,'5511','Car and Truck Dealers (New and Used) Sales, Service, Repairs, Parts, and Leasing'),(57,'5521','Automobile and Truck Dealers (Used Only)'),(58,'5531','Automobile Supply Stores'),(59,'5532','Automotive Tire Stores'),(60,'5533','Automotive Parts, Accessories Stores'),(61,'5541','Service Stations ( with or without ancillary services)'),(62,'5542','Automated Fuel Dispensers'),(63,'5551','Boat Dealers'),(64,'5561','Recreational and Utility Trailers, Camp Dealers'),(65,'5571','Motorcycle Dealers'),(66,'5592','Motor Home Dealers'),(67,'5598','Snowmobile Dealers'),(68,'5611','Men’s and Boy’s Clothing and Accessories Stores'),(69,'5621','Women’s Ready - to - Wear Stores'),(70,'5631','Women’s Accessory and Specialty Shops'),(71,'5641','Children’s and Infant’s Wear Stores'),(72,'5651','Family Clothing Stores'),(73,'5655','Sports Apparel, Riding Apparel Stores'),(74,'5661','Shoe Stores'),(75,'5681','Furriers and Fur Shops'),(76,'5691','Men’s and Women’s Clothing Stores'),(77,'5697','Tailors, Seamstress, Mending, and Alterations'),(78,'5698','Wig and Toupee Stores'),(79,'5699','Miscellaneous Apparel and Accessory Shops'),(80,'5712','Furniture, Home Furnishings, and Equipment Stores, Except Appliances'),(81,'5713','Floor Covering Stores'),(82,'5714','Drapery, Window Covering and Upholstery Stores'),(83,'5718','Fireplace, Fireplace Screens, and Accessories Stores'),(84,'5719','Miscellaneous Home Furnishing Specialty Stores'),(85,'5722','Household Appliance Stores'),(86,'5732','Electronic Sales'),(87,'5733','Music Stores, Musical Instruments, Piano Sheet Music'),(88,'5734','Computer Software Stores'),(89,'5735','Record Shops'),(90,'5811','Caterers'),(91,'5812','Eating places and Restaurants'),(92,'5813','Drinking Places (Alcoholic Beverages), Bars, Taverns, Cocktail lounges, Nightclubs and Discotheques'),(93,'5814','Fast Food Restaurants'),(94,'5912','Drug Stores and Pharmacies'),(95,'5921','Package Stores - Beer, Wine, and Liquor'),(96,'5931','Used Merchandise and Secondhand Stores'),(97,'5832','Antique Shops - Sales, Repairs, and Restoration Services'),(98,'5933','Pawn Shops and Salvage Yards'),(99,'5935','Wrecking and Salvage Yards'),(100,'5937','Antique Reproductions'),(101,'5940','Bicycle Shops - Sales and Service'),(102,'5941','Sporting Goods Stores'),(103,'5942','Book Stores'),(104,'5943','Stationery Stores, Office and School Supply Stores'),(105,'5944','Watch, Clock, Jewelry, and Silverware Stores'),(106,'5945','Hobby, Toy, and Game Shops'),(107,'5946','Camera and Photographic Supply Stores'),(108,'5947','Card Shops, Gift, Novelty, and Souvenir Shops'),(109,'5948','Leather Foods Stores'),(110,'5949','Sewing, Needle, Fabric, and Price Goods Stores'),(111,'5950','Glassware/Crystal Stores'),(112,'5960','Direct Marketing - Insurance Service'),(113,'5961','Mail Order Houses Including Catalog Order Stores, Book/Record Clubs (No longer permitted for .S. original presentments)'),(114,'5962','Direct Marketing - Travel Related Arrangements Services'),(115,'5963','Door - to - Door Sales'),(116,'5964','Direct Marketing - Catalog Merchant'),(117,'5965','Direct Marketing - Catalog and Catalog and Retail Merchant Direct Marketing - Outbound Telemarketing Merchant'),(118,'5967','Direct Marketing -Inbound Teleservices Merchant'),(119,'5968','Direct Marketing - Continuity/Subscription Merchant'),(120,'5969','Direct Marketing - Not Elsewhere Classified'),(121,'5970','Artist’s Supply and Craft Shops'),(122,'5971','Art Dealers and Galleries'),(123,'5972','Stamp and Coin Stores - Philatelic and Numismatic Supplies'),(124,'5973','Religious Goods Stores'),(125,'5975','Hearing Aids - Sales, Service, and Supply Stores'),(126,'5976','Orthopedic Goods Prosthetic Devices'),(127,'5977','Cosmetic Stores'),(128,'5978','Typewriter Stores - Sales, Rental, Service'),(129,'5983','Fuel - Fuel Oil, Wood, Coal, Liquefied Petroleum'),(130,'5992','Florists'),(131,'5993','Cigar Stores and Stands'),(132,'5994','News Dealers and Newsstands'),(133,'5995','Pet Shops, Pet Foods, and Supplies Stores'),(134,'5996','Swimming Pools - Sales, Service, and Supplies'),(135,'5997','Electric Razor Stores - Sales and Service'),(136,'5998','Tent and Awning Shops'),(137,'5999','Miscellaneous and Specialty Retail Stores'),(138,'6010','Financial Institutions - Manual Cash Disbursements'),(139,'6011','Financial Institutions - Manual Cash Disbursements'),(140,'6012','Financial Institutions - Merchandise and Services'),(141,'6051','Non - Financial Institutions - Foreign Currency, Money Orders (not wire transfer) and Travelers Cheques'),(142,'6211','Security Brokers/Dealers'),(143,'6300','Insurance Sales, Underwriting, and Premiums'),(144,'6381','Insurance Premiums, (no longer valid for first presentment work)'),(145,'6399','Insurance, Not Elsewhere Classified ( no longer valid for first presentment work)'),(146,'7011','Lodging - Hotels, Motels, Resorts, Central Reservation Services (not elsewhere classified)'),(147,'7012','Timeshares'),(148,'7032','Sporting and Recreational Camps'),(149,'7033','Trailer Parks and Camp Grounds'),(150,'7210','Laundry, Cleaning, and Garment Services'),(151,'7211','Laundry - Family and Commercial'),(152,'7216','Dry Cleaners'),(153,'7217','Carpet and Upholstery Cleaning'),(154,'7221','Photographic Studios'),(155,'7230','Barber and Beauty Shops'),(156,'7251','Shop Repair Shops and Shoe Shine Parlors, and Hat Cleaning Shops'),(157,'7261','Funeral Service and Crematories'),(158,'7273','Dating and Escort Services'),(159,'7276','Tax Preparation Service'),(160,'7277','Counseling Service - Debt, Marriage, Personal'),(161,'7278','Buying/Shopping Services, Clubs'),(162,'7296','Clothing Rental - Costumes, Formal Wear, Uniforms'),(163,'7297','Massage Parlors'),(164,'7298','Health and Beauty Shops'),(165,'7299','Miscellaneous Personal Services ( not elsewhere classifies)'),(166,'7311','Advertising Services'),(167,'7321','Consumer Credit Reporting Agencies'),(168,'7332','Blueprinting and Photocopying Services'),(169,'7333','Commercial Photography, Art and Graphics'),(170,'7338','Quick Copy, Reproduction and Blueprinting Services'),(171,'7339','Stenographic and Secretarial Support Services'),(172,'7342','Disinfecting Services'),(173,'7342','Exterminating and Disinfecting Services'),(174,'7349','Cleaning and Maintenance, Janitorial Services'),(175,'7361','Employment Agencies, Temporary Help Services'),(176,'7372','Computer Programming, Integrated Systems Design and Data Processing Services'),(177,'7375','Information Retrieval Services'),(178,'7379','Computer Maintenance and Repair Services, Not Elsewhere Classified'),(179,'7392','Management, Consulting, and Public Relations Services'),(180,'7393','Protective and Security Services - Including Armored Cars and Guard Dogs'),(181,'7394','Equipment Rental and Leasing Services, Tool Rental, Furniture Rental, and Appliance Rental'),(182,'7395','Photofinishing Laboratories, Photo Developing'),(183,'7399','Business Services, Not Elsewhere Classified'),(184,'7512','Car Rental Companies ( Not Listed Below)'),(185,'7513','Truck and Utility Trailer Rentals'),(186,'7519','Motor Home and Recreational Vehicle Rentals'),(187,'7523','Automobile Parking Lots and Garages'),(188,'7531','Automotive Body Repair Shops'),(189,'7534','Tire Re - treading and Repair Shops'),(190,'7535','Paint Shops - Automotive'),(191,'7538','Automotive Service Shops'),(192,'7542','Car Washes'),(193,'7549','Towing Services'),(194,'7622','Radio Repair Shops'),(195,'7623','Air Conditioning and Refrigeration Repair Shops'),(196,'7629','Electrical And Small Appliance Repair Shops'),(197,'7631','Watch, Clock, and Jewelry Repair'),(198,'7641','Furniture, Furniture Repair, and Furniture Refinishing'),(199,'7692','Welding Repair'),(200,'7699','Repair Shops and Related Services - Miscellaneous'),(201,'7829','Motion Pictures and Video Tape Production and Distribution'),(202,'7832','Motion Picture Theaters'),(203,'7841','Video Tape Rental Stores'),(204,'7911','Dance Halls, Studios and Schools'),(205,'7922','Theatrical Producers (Except Motion Pictures), Ticket Agencies'),(206,'7929','Bands. Orchestras, and Miscellaneous Entertainers (Not Elsewhere Classified)'),(207,'7932','Billiard and Pool Establishments'),(208,'7933','Bowling Alleys'),(209,'7941','Commercial Sports, Athletic Fields, Professional Sport Clubs, and Sport Promoters'),(210,'7991','Tourist Attractions and Exhibits'),(211,'7992','Golf Courses - Public'),(212,'7993','Video Amusement Game Supplies'),(213,'7994','Video Game Arcades/Establishments'),(214,'7995','Betting (including Lottery Tickets, Casino Gaming Chips, Off - track Betting and Wagers)'),(215,'7996','Amusement Parks, Carnivals, Circuses, Fortune Tellers'),(216,'7997','Membership Clubs (Sports, Recreation, Athletic), Country Clubs, and Private Golf Courses'),(217,'7998','Aquariums, Sea - aquariums, Dolphinariums'),(218,'7999','Recreation Services (Not Elsewhere Classified)'),(219,'8011','Doctors and Physicians (Not Elsewhere Classified)'),(220,'8021','Dentists and Orthodontists'),(221,'8031','Osteopaths'),(222,'8041','Chiropractors'),(223,'8042','Optometrists and Ophthalmologists'),(224,'8043','Opticians, Opticians Goods and Eyeglasses'),(225,'8044','Opticians, Optical Goods, and Eyeglasses (no longer valid for first presentments)'),(226,'8049','Podiatrists and Chiropodists'),(227,'8050','Nursing and Personal Care Facilities'),(228,'8062','Hospitals'),(229,'8071','Medical and Dental Laboratories'),(230,'8099','Medical Services and Health Practitioners (Not Elsewhere Classified)'),(231,'8111','Legal Services and Attorneys'),(232,'8211','Elementary and Secondary Schools'),(233,'8220','Colleges, Junior Colleges, Universities, and Professional Schools'),(234,'8241','Correspondence Schools'),(235,'8244','Business and Secretarial Schools'),(236,'8249','Vocational Schools and Trade Schools'),(237,'8299','Schools and Educational Services ( Not Elsewhere Classified)'),(238,'8351','Child Care Services'),(239,'8398','Charitable and Social Service Organizations'),(240,'8641','Civic, Fraternal, and Social Associations'),(241,'8651','Political Organizations'),(242,'8661','Religious Organizations'),(243,'8675','Automobile Associations'),(244,'8699','Membership Organizations ( Not Elsewhere Classified)'),(245,'8734','Testing Laboratories ( non - medical)'),(246,'8911','Architectural - Engineering and Surveying Services'),(247,'8931','Accounting, Auditing, and Bookkeeping Services'),(248,'8999','Professional Services ( Not Elsewhere Defined)'),(249,'9211','Court Costs, including Alimony and Child Support'),(250,'9222','Fines'),(251,'9223','Bail and Bond Payments'),(252,'9311','Tax Payments'),(253,'9399','Government Services ( Not Elsewhere Classified)'),(254,'9402','Postal Services - Government Only'),(255,'9405','Intra - Government Transactions'),(256,'9700','Automated Referral Service (For Visa Only)'),(257,'9701','Visa Credential Service (For Visa Only)'),(258,'9702','GCAS Emergency Services (For Visa Only)'),(259,'9950','Intra - Company Purchases (For Visa Only)');
/*!40000 ALTER TABLE `ref_merchant_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_payment_type`
--

DROP TABLE IF EXISTS `ref_payment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_payment_type` (
  `PK_payment_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_type_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payment_type_description` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`PK_payment_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_payment_type`
--

LOCK TABLES `ref_payment_type` WRITE;
/*!40000 ALTER TABLE `ref_payment_type` DISABLE KEYS */;
INSERT INTO `ref_payment_type` VALUES (1,'Credit Transfer','A credit transfer is a payment initiated by the payer. The payer sends a payment instruction to his/her payment service provider (PSP), e.g. a bank. The payer’s PSP moves the funds to the payee’s PSP.'),(2,'Direct Debit','A direct debit is a transfer initiated by the payee via his/her payment service provider. Direct debits are often used for recurring payments, such as utility bills.'),(3,'Credit Card Payment',''),(4,'Dedit Card Payment',''),(5,'Credit Card Reference','Tokenization is the process of replacing sensitive credit card/payment data with unique, generated placeholder, or \"token\".'),(6,'Apple Pay','Apple Pay is a mobile payment method (digital wallet) by Apple Inc. that lets users make payments using an iPhone, Apple Watch, iPad or Mac.'),(7,'EPC QR code','The European Payments Council Quick Response Code guidelines define the content of a QR code that can be used to initiate SEPA credit transfer (SCT).'),(8,'Single Euro Payments Area','The SEPA Direct Debit (SDD) Schemes allow a merchant (biller) to collect funds from a customer (payer\'s) account, provided that a signed mandate has been completed by the customer.'),(9,'Ebank Payment','. It is used by customers who have accounts enabled with Internet banking. Instead of entering card details on the purchaser\'s site, in this system the payment gateway allows one to specify which bank they wish to pay from. Then the user is redirected to the bank\'s website, where one can authenticate oneself and then approve the payment.'),(10,'PayPal','PayPal is a global e-commerce business allowing payments and money transfers to be made through the Internet.'),(11,'Paytm','Paytm is an Indian e-commerce payment system and digital wallet company, based out of NOIDA SEZ, India.'),(12,'MovoCash','MovoCash is a digital payments company that offers a multi-featured e-wallet app. MovoCoin enables customers to conduct a one-time purchase with a digital card number.'),(13,'Paymentwall',''),(14,'Google Wallet',''),(15,'Android Pay',''),(16,'Яндекс.Деньги','«Яндекс.Деньги» — российская электронная платёжная система, реализующая идею электронных денег.'),(17,'PAYEER','Online e-wallet. Supports cryptocurrency payments.'),(18,'Alipay','Alipay (Chinese: 支付宝) is a third-party mobile and online payment platform, established in Hangzhou, China.'),(19,'WesternUnion',''),(20,'NBS IPS system','Instant payments can currently be initiated via electronic banking, mobile banking and by submitting payment orders at tellers of payment service providers in accordance with regulations.'),(21,'Cheque Payment','A cheque is a document that orders a bank to pay a specific amount of money from a person\'s account to the person in whose name the cheque has been issued. '),(22,'Bank Draft','A bank draft is a check that is drawn on a bank\'s funds and guaranteed by the bank that issues it.'),(23,'ATM','ATMs replace human bank tellers in performing giving banking functions such as deposits, withdrawals, account inquiries. ');
/*!40000 ALTER TABLE `ref_payment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_service_type`
--

DROP TABLE IF EXISTS `ref_service_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_service_type` (
  `PK service_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `service_type_description` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PK service_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_service_type`
--

LOCK TABLES `ref_service_type` WRITE;
/*!40000 ALTER TABLE `ref_service_type` DISABLE KEYS */;
INSERT INTO `ref_service_type` VALUES (1,'Mobile banking'),(2,'E-banking'),(3,'Overdraft'),(4,'Foreign Currency Exchange'),(5,'Consultancy'),(6,'Priority Banking'),(7,'Private Banking');
/*!40000 ALTER TABLE `ref_service_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_settlement_status`
--

DROP TABLE IF EXISTS `ref_settlement_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_settlement_status` (
  `PK_settlement_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `settlement_status_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `settlement_status_description` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`PK_settlement_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='	';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_settlement_status`
--

LOCK TABLES `ref_settlement_status` WRITE;
/*!40000 ALTER TABLE `ref_settlement_status` DISABLE KEYS */;
INSERT INTO `ref_settlement_status` VALUES (1,'Negotiation','The bank and the client are in direct negotiations.'),(2,'Voluntary Dismissal','Termination of a lawsuit by voluntary request of the plaintiff (the party who originally filed the lawsuit).'),(3,'Involuntary Dismissal','Involuntary dismissal is the termination of a court case despite the plaintiff\'s objection.'),(4,'Motion to Set Aside Judgment','An application to overturn or set aside a court\'s judgment, verdict or other final ruling in a case. Such a motion is proposed by a party who is dissatisfied with the end result of a case. Motions may be made at any time after entry of judgment, and in some circumstances years after the case has been closed by the courts.'),(5,'Trial','Trial in progerss.'),(6,'Appeal','The process in which cases are reviewed, where parties request a formal change to an official decision.'),(7,'Judgment','n law, a judgment is a decision of a court regarding the rights and liabilities of parties in a legal action or proceeding.');
/*!40000 ALTER TABLE `ref_settlement_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_settlement_type`
--

DROP TABLE IF EXISTS `ref_settlement_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_settlement_type` (
  `PK_settlement_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `settlement_description_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `settlement_description` tinytext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`PK_settlement_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_settlement_type`
--

LOCK TABLES `ref_settlement_type` WRITE;
/*!40000 ALTER TABLE `ref_settlement_type` DISABLE KEYS */;
INSERT INTO `ref_settlement_type` VALUES (1,'Out of Court Settlement',NULL),(2,'Mediation','A neutral third party is involved in resolving conflict between the bank and customer.'),(3,'Legal Remedy','Enforces a right, imposes a penalty, or makes another court order to impose its will.');
/*!40000 ALTER TABLE `ref_settlement_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_transaction_code`
--

DROP TABLE IF EXISTS `ref_transaction_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_transaction_code` (
  `PK_transaction_code_id` int(11) NOT NULL AUTO_INCREMENT,
  `FK_transaction_domain_id` int(11) NOT NULL,
  `FK_transaction_family_id` int(11) NOT NULL,
  `FK_transaction_subfamily_id` int(11) NOT NULL,
  PRIMARY KEY (`PK_transaction_code_id`),
  KEY `FK_transaction_domain_id_idx` (`FK_transaction_domain_id`),
  KEY `FK_transaction_family_id_idx` (`FK_transaction_family_id`),
  KEY `FK_transaction_subfamily_id_idx` (`FK_transaction_subfamily_id`),
  CONSTRAINT `FK_transaction_domain_id` FOREIGN KEY (`FK_transaction_domain_id`) REFERENCES `ref_transaction_domain` (`PK_transaction_domain_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_transaction_family_id` FOREIGN KEY (`FK_transaction_family_id`) REFERENCES `ref_transaction_family` (`PK_transaction_family_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_transaction_subfamily_id` FOREIGN KEY (`FK_transaction_subfamily_id`) REFERENCES `ref_transaction_subfamily` (`PK_transaction_subfamily_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=555 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='ISO200-22 transaction code part';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_transaction_code`
--

LOCK TABLES `ref_transaction_code` WRITE;
/*!40000 ALTER TABLE `ref_transaction_code` DISABLE KEYS */;
INSERT INTO `ref_transaction_code` VALUES (1,1,1,1),(2,1,1,2),(3,1,1,3),(4,1,1,4),(5,1,1,5),(6,1,1,6),(7,1,1,7),(8,1,1,8),(9,1,1,9),(10,1,1,10),(11,1,1,11),(12,1,1,12),(13,1,1,13),(14,1,1,14),(15,1,1,15),(16,1,1,16),(17,1,2,1),(18,1,2,2),(19,1,2,3),(20,1,2,4),(21,1,2,5),(22,1,2,6),(23,1,2,17),(24,1,2,8),(25,1,2,9),(26,1,2,10),(27,1,2,11),(28,1,2,12),(29,1,2,14),(30,1,2,18),(31,1,2,16),(32,1,3,1),(33,1,3,2),(34,1,3,3),(35,1,3,4),(36,1,3,5),(37,1,3,6),(38,1,3,7),(39,1,3,8),(40,1,3,9),(41,1,3,10),(42,1,3,11),(43,1,3,12),(44,1,3,13),(45,1,3,14),(46,1,3,15),(47,1,3,16),(48,1,4,19),(49,1,4,1),(50,1,4,2),(51,1,4,3),(52,1,4,4),(53,1,4,8),(54,1,4,9),(55,1,4,10),(56,1,4,11),(57,1,4,12),(58,1,4,14),(59,1,4,16),(60,1,5,19),(61,1,5,1),(62,1,5,2),(63,1,5,3),(64,1,5,4),(65,1,5,8),(66,1,5,9),(67,1,5,10),(68,1,5,11),(69,1,5,12),(70,1,5,14),(71,1,5,16),(72,1,6,1),(73,1,6,2),(74,1,6,3),(75,1,6,4),(76,1,6,5),(77,1,6,6),(78,1,6,7),(79,1,6,8),(80,1,6,9),(81,1,6,10),(82,1,6,11),(83,1,6,12),(84,1,6,13),(85,1,6,14),(86,1,6,15),(87,1,6,16),(88,1,7,11),(89,1,8,1),(90,1,8,2),(91,1,8,3),(92,1,8,4),(93,1,8,5),(94,1,8,6),(95,1,8,17),(96,1,8,8),(97,1,8,9),(98,1,8,10),(99,1,8,11),(100,1,8,12),(101,1,8,14),(102,1,8,18),(103,1,8,16),(104,1,9,1),(105,1,9,2),(106,1,9,3),(107,1,9,4),(108,1,9,5),(109,1,9,6),(110,1,9,7),(111,1,9,8),(112,1,9,9),(113,1,9,10),(114,1,9,11),(115,1,9,12),(116,1,9,13),(117,1,9,14),(118,1,9,15),(119,1,9,16),(120,1,10,12),(121,1,11,1),(122,1,11,2),(123,1,11,3),(124,1,11,4),(125,1,11,5),(126,1,11,6),(127,1,11,7),(128,1,11,8),(129,1,11,9),(130,1,11,10),(131,1,11,11),(132,1,11,12),(133,1,11,13),(134,1,11,14),(135,1,11,15),(136,1,11,16),(137,2,12,20),(138,2,12,21),(139,2,12,22),(140,2,12,23),(141,2,12,1),(142,2,12,24),(143,2,12,2),(144,2,12,3),(145,2,12,4),(146,2,12,5),(147,2,12,6),(148,2,12,8),(149,2,12,25),(150,2,12,26),(151,2,12,9),(152,2,12,27),(153,2,12,28),(154,2,12,10),(155,2,12,11),(156,2,12,12),(157,2,12,14),(158,2,12,16),(159,2,12,29),(160,2,12,30),(161,2,27,22),(162,2,27,23),(163,2,27,1),(164,2,27,2),(165,2,27,3),(166,2,27,4),(167,2,27,5),(168,2,27,31),(169,2,27,32),(170,2,27,33),(171,2,27,6),(172,2,27,8),(173,2,27,9),(174,2,27,10),(175,2,27,11),(176,2,27,12),(177,2,27,34),(178,2,27,14),(179,2,27,35),(180,2,27,16),(181,2,14,1),(182,2,14,2),(183,2,14,3),(184,2,14,4),(185,2,14,5),(186,2,14,6),(187,2,14,36),(188,2,14,37),(189,2,14,38),(190,2,14,8),(191,2,14,9),(192,2,14,10),(193,2,14,11),(194,2,14,12),(195,2,14,14),(196,2,14,39),(197,2,14,40),(198,2,14,16),(199,2,15,41),(200,2,15,42),(201,2,15,1),(202,2,15,2),(203,2,15,3),(204,2,15,4),(205,2,15,43),(206,2,15,5),(207,2,15,44),(208,2,15,6),(209,2,15,8),(210,2,15,45),(211,2,15,9),(212,2,15,46),(213,2,15,10),(214,2,15,11),(215,2,15,12),(216,2,15,14),(217,2,15,16),(218,2,16,47),(219,2,16,48),(220,2,16,49),(221,2,16,50),(222,2,16,51),(223,2,16,1),(224,2,16,52),(225,2,16,53),(226,2,16,54),(227,2,16,55),(228,2,16,2),(229,2,16,3),(230,2,16,4),(231,2,16,56),(232,2,16,5),(233,2,16,57),(234,2,16,6),(235,2,16,8),(236,2,16,58),(237,2,16,59),(238,2,16,9),(239,2,16,60),(240,2,16,10),(241,2,16,11),(242,2,16,61),(243,2,16,62),(244,2,16,12),(245,2,16,14),(246,2,16,16),(247,2,16,63),(248,2,16,64),(249,2,17,65),(250,2,17,66),(251,2,17,67),(252,2,17,68),(253,2,17,69),(254,2,17,70),(255,2,17,71),(256,2,17,72),(257,2,17,73),(258,2,17,1),(259,2,17,2),(260,2,17,3),(261,2,17,4),(262,2,17,5),(263,2,17,74),(264,2,17,75),(265,2,17,76),(266,2,17,77),(267,2,17,6),(268,2,17,78),(269,2,17,8),(270,2,17,79),(271,2,17,9),(272,2,17,80),(273,2,17,10),(274,2,17,11),(275,2,17,12),(276,2,17,81),(277,2,17,82),(278,2,17,14),(279,2,17,83),(280,2,17,84),(281,2,17,85),(282,2,17,86),(283,2,17,87),(284,2,17,16),(285,2,17,88),(286,2,18,1),(287,2,18,2),(288,2,18,3),(289,2,18,4),(290,2,18,5),(291,2,18,89),(292,2,18,6),(293,2,18,90),(294,2,18,91),(295,2,18,8),(296,2,18,92),(297,2,18,9),(298,2,18,10),(299,2,18,11),(300,2,18,93),(301,2,18,12),(302,2,18,94),(303,2,18,14),(304,2,18,95),(305,2,18,96),(306,2,18,97),(307,2,18,98),(308,2,18,99),(309,2,18,16),(310,2,19,65),(311,2,19,66),(312,2,19,67),(313,2,19,68),(314,2,19,69),(315,2,19,70),(316,2,19,71),(317,2,19,72),(318,2,19,73),(319,2,19,1),(320,2,19,2),(321,2,19,3),(322,2,19,4),(323,2,19,5),(324,2,19,74),(325,2,19,75),(326,2,19,76),(327,2,19,77),(328,2,19,6),(329,2,19,78),(330,2,19,8),(331,2,19,79),(332,2,19,9),(333,2,19,80),(334,2,19,10),(335,2,19,11),(336,2,19,12),(337,2,19,81),(338,2,19,82),(339,2,19,14),(340,2,19,83),(341,2,19,84),(342,2,19,85),(343,2,19,86),(344,2,19,87),(345,2,19,16),(346,2,19,88),(347,2,20,1),(348,2,20,2),(349,2,20,3),(350,2,20,4),(351,2,20,100),(352,2,20,5),(353,2,20,101),(354,2,20,6),(355,2,20,102),(356,2,20,8),(357,2,20,9),(358,2,20,10),(359,2,20,11),(360,2,20,12),(361,2,20,14),(362,2,20,16),(363,2,21,1),(364,2,21,2),(365,2,21,3),(366,2,21,4),(367,2,21,5),(368,2,21,31),(369,2,21,6),(370,2,21,8),(371,2,21,9),(372,2,21,10),(373,2,21,11),(374,2,21,12),(375,2,21,103),(376,2,21,14),(377,2,21,104),(378,2,21,16),(379,2,21,105),(380,2,4,19),(381,2,4,1),(382,2,4,2),(383,2,4,3),(384,2,4,4),(385,2,4,8),(386,2,4,9),(387,2,4,10),(388,2,4,11),(389,2,4,12),(390,2,4,14),(391,2,4,16),(392,2,5,19),(393,2,5,1),(394,2,5,2),(395,2,5,3),(396,2,5,4),(397,2,5,8),(398,2,5,9),(399,2,5,10),(400,2,5,11),(401,2,5,12),(402,2,5,14),(403,2,5,16),(404,2,5,106),(405,2,7,11),(406,2,10,12),(407,2,22,41),(408,2,22,42),(409,2,22,1),(410,2,22,2),(411,2,22,3),(412,2,22,4),(413,2,22,43),(414,2,22,5),(415,2,22,44),(416,2,22,6),(417,2,22,8),(418,2,22,45),(419,2,22,9),(420,2,22,46),(421,2,22,10),(422,2,22,11),(423,2,22,12),(424,2,22,14),(425,2,22,16),(426,2,23,47),(427,2,23,48),(428,2,23,49),(429,2,23,50),(430,2,23,51),(431,2,23,1),(432,2,23,52),(433,2,23,53),(434,2,23,54),(435,2,23,55),(436,2,23,2),(437,2,23,3),(438,2,23,4),(439,2,23,56),(440,2,23,5),(441,2,23,57),(442,2,23,6),(443,2,23,8),(444,2,23,58),(445,2,23,59),(446,2,23,9),(447,2,23,60),(448,2,23,10),(449,2,23,11),(450,2,23,61),(451,2,23,62),(452,2,23,12),(453,2,23,14),(454,2,23,16),(455,2,23,63),(456,2,23,64),(457,2,24,65),(458,2,24,66),(459,2,24,67),(460,2,24,68),(461,2,24,69),(462,2,24,70),(463,2,24,71),(464,2,24,72),(465,2,24,73),(466,2,24,1),(467,2,24,2),(468,2,24,3),(469,2,24,4),(470,2,24,5),(471,2,24,74),(472,2,24,75),(473,2,24,76),(474,2,24,77),(475,2,24,6),(476,2,24,78),(477,2,24,8),(478,2,24,79),(479,2,24,9),(480,2,24,80),(481,2,24,10),(482,2,24,11),(483,2,24,12),(484,2,24,81),(485,2,24,82),(486,2,24,14),(487,2,24,83),(488,2,24,84),(489,2,24,85),(490,2,24,86),(491,2,24,87),(492,2,24,16),(493,2,24,88),(494,2,26,1),(495,2,26,2),(496,2,26,3),(497,2,26,4),(498,2,26,5),(499,2,26,89),(500,2,26,6),(501,2,26,90),(502,2,26,91),(503,2,26,8),(504,2,26,92),(505,2,26,9),(506,2,26,10),(507,2,26,11),(508,2,26,93),(509,2,26,12),(510,2,26,94),(511,2,26,14),(512,2,26,95),(513,2,26,96),(514,2,26,97),(515,2,26,98),(516,2,26,99),(517,2,26,16),(518,2,25,65),(519,2,25,66),(520,2,25,67),(521,2,25,68),(522,2,25,69),(523,2,25,70),(524,2,25,71),(525,2,25,72),(526,2,25,73),(527,2,25,1),(528,2,25,2),(529,2,25,3),(530,2,25,4),(531,2,25,5),(532,2,25,74),(533,2,25,75),(534,2,25,76),(535,2,25,77),(536,2,25,6),(537,2,25,78),(538,2,25,8),(539,2,25,79),(540,2,25,9),(541,2,25,80),(542,2,25,10),(543,2,25,11),(544,2,25,12),(545,2,25,81),(546,2,25,82),(547,2,25,14),(548,2,25,83),(549,2,25,84),(550,2,25,85),(551,2,25,86),(552,2,25,87),(553,2,25,16),(554,2,25,88);
/*!40000 ALTER TABLE `ref_transaction_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_transaction_domain`
--

DROP TABLE IF EXISTS `ref_transaction_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_transaction_domain` (
  `PK_transaction_domain_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `domain_code` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PK_transaction_domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='ISO200-22';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_transaction_domain`
--

LOCK TABLES `ref_transaction_domain` WRITE;
/*!40000 ALTER TABLE `ref_transaction_domain` DISABLE KEYS */;
INSERT INTO `ref_transaction_domain` VALUES (1,'Loans, Deposits & Syndications','LDAS'),(2,'Payments','PMNT');
/*!40000 ALTER TABLE `ref_transaction_domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_transaction_family`
--

DROP TABLE IF EXISTS `ref_transaction_family`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_transaction_family` (
  `PK_transaction_family_id` int(11) NOT NULL AUTO_INCREMENT,
  `family_code` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `family_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PK_transaction_family_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='ISO200-22';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_transaction_family`
--

LOCK TABLES `ref_transaction_family` WRITE;
/*!40000 ALTER TABLE `ref_transaction_family` DISABLE KEYS */;
INSERT INTO `ref_transaction_family` VALUES (1,'CSLN','Consumer Loans'),(2,'FTDP','Fixed Term Deposits'),(3,'FTLN','Fixed Term Loans'),(4,'MCOP','Miscellaneous Credit Operations'),(5,'MDOP','Miscellaneous Debit Operations'),(6,'MGLN','Mortgage Loans'),(7,'NTAV','Not Available'),(8,'NTDP','Notice Deposits'),(9,'NTLN','Notice Loans'),(10,'OTHR','Other'),(11,'SYDN','Syndications'),(12,'CNTR','Counter Transactions'),(14,'DRFT','Drafts'),(15,'ICCN','Issued Cash Concentration Transactions'),(16,'ICHQ','Issued Cheques'),(17,'ICDT','Issued Credit Transfers'),(18,'IDDT','Issued Direct Debits'),(19,'IRCT','Issued Real-Time Credit Transfers'),(20,'LBOX','Lockbox Transactions'),(21,'MCRD','Merchant Card Transactions'),(22,'RCCN','Received Cash Concentration Transactions'),(23,'RCHQ','Received Cheques'),(24,'RCDT','Received Credit Transfers'),(25,'RRCT','Received Real-Time Credit Transfers'),(26,'RDDT','Received Direct Debits'),(27,'CCRD','Customer Card Transactions');
/*!40000 ALTER TABLE `ref_transaction_family` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_transaction_status`
--

DROP TABLE IF EXISTS `ref_transaction_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_transaction_status` (
  `PK_transaction_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_status_code` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transaction_status_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transaction_status_description` tinytext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`PK_transaction_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_transaction_status`
--

LOCK TABLES `ref_transaction_status` WRITE;
/*!40000 ALTER TABLE `ref_transaction_status` DISABLE KEYS */;
INSERT INTO `ref_transaction_status` VALUES (1,'SBM','Submitted','The transaction is pending in internet banking.  It has not yet been received by the banking system.'),(2,'SPE','Submitted Pending Execution','The transaction is pending for execution in the banking system.'),(3,'ACP','Accepted','The transaction has been received and will be processed manually.'),(4,'PAP','Pending Approval','The transaction is pending for approval from other User(s) - applicable only for accounts with multiple signatures.'),(5,'CMP','Completed','The transaction has been completed successfully.'),(6,'PFE','Pending Future Execution','The transaction is pending to be executed on the date entered.'),(7,'DCL','Declined by User','The transaction has been declined by a User - available only if a transaction is in status Pending (Future Execution) or Pending Approval.'),(8,'RJC','Rejected by System','The transaction has been rejected by the banking system. '),(9,'FLD','Failed','The transaction failed to be executed due to an abnormal error such as system failure, future transactions that fail to be executed due to unavailability of funds.'),(10,'EXP','Expired','The transaction has expired because not all required users have approved it by the end of its execution date.');
/*!40000 ALTER TABLE `ref_transaction_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_transaction_subfamily`
--

DROP TABLE IF EXISTS `ref_transaction_subfamily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_transaction_subfamily` (
  `PK_transaction_subfamily_id` int(11) NOT NULL AUTO_INCREMENT,
  `subfamily_code` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subfamily_name` tinytext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`PK_transaction_subfamily_id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='ISO200-22';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_transaction_subfamily`
--

LOCK TABLES `ref_transaction_subfamily` WRITE;
/*!40000 ALTER TABLE `ref_transaction_subfamily` DISABLE KEYS */;
INSERT INTO `ref_transaction_subfamily` VALUES (1,'CHRG','Charges (Generic)'),(2,'COMM','Commission (Generic)'),(3,'COME','Commission Excluding Taxes (Generic)'),(4,'COMI','Commission Including Taxes (Generic)'),(5,'CAJT','Credit Adjustments (Generic)'),(6,'DAJT','Debit Adjustments (Generic)'),(7,'DDWN','Drawdown'),(8,'FEES','Fees (Generic)'),(9,'INTR','Interests (Generic)'),(10,'COMT','Non Taxable Commissions (Generic)'),(11,'NTAV','Not Available'),(12,'OTHR','Other'),(13,'PPAY','Principal Payment'),(14,'RIMB','Reimbursement (Generic)'),(15,'RNEW','Renewal'),(16,'TAXE','Taxes (Generic)'),(17,'DPST','Deposit'),(18,'RPMT','Repayment'),(19,'ADJT','Adjustments (Generic)'),(20,'BCDP','Branch Deposit'),(21,'BCWD','Branch Withdrawl'),(22,'CDPT','Cash Deposit'),(23,'CWDL','Cash Withdrawal'),(24,'CHKD','Check Deposit'),(25,'FCDP','Foreign Currencies Deposit'),(26,'FCWD','Foreign Currencies Withdrawal'),(27,'MSCD','Miscellaneous Deposit'),(28,'MIXD','Mixed Deposit'),(29,'TCDP ','Travellers Cheques Deposit'),(30,'TCWD ','Travellers Cheques Withdrawal'),(31,'POSC ','Credit Card Payment'),(32,'XBCW','Cross-Border Cash Withdrawal'),(33,'XBCP','Cross-Border Credit Card Payment'),(34,'POSD ','Point-of-Sale (POS) Payment  - Debit Card'),(35,'SMRT','Smart-Card Payment'),(36,'DDFT','Discounted Draft'),(37,'UDFT','Dishonoured/Unpaid Draft'),(38,'DMCG','Draft Maturity Change'),(39,'STAM','Settlement At Maturity'),(40,'STLR','Settlement Under Reserve'),(41,'ACON','ACH Concentration'),(42,'BACT','Branch Account Transfer'),(43,'COAT','Corporate Own Account Transfer'),(44,'XICT','Cross-Border Intra Company Transfer'),(45,'FIOA ','Financial Institution Own Account Transfer'),(46,'ICCT','Intra Company Transfer'),(47,'ARPD','ARP Debit'),(48,'BCHQ','Bank Cheque '),(49,'CASH','Cash Letter'),(50,'CSHA','Cash Letter Adjustment'),(51,'CCCH','Certified Customer Cheque'),(52,'CCHQ','Cheque'),(53,'CQRV','Cheque Reversal'),(54,'URCQ','Cheque Under Reserve'),(55,'CLCQ','Circular Cheque'),(56,'CDIS','Controlled Disbursement'),(57,'CRCQ','Crossed Cheque'),(58,'XBCQ','Foreign Cheque'),(59,'XRCQ','Foreign Cheque Under Reserve'),(60,'NPCC','Non Presented Circular Cheques'),(61,'OPCQ ','Open Cheque'),(62,'ORCQ','Order Cheque'),(63,'UPCQ','Unpaid Cheque'),(64,'XPCQ','Unpaid Foreign Cheque'),(65,'ACOR','ACH Corporate Trade'),(66,'ACDT','ACH Credit'),(67,'ADBT','ACH Debit'),(68,'APAC','ACH Pre-Authorised'),(69,'ARET','ACH Return'),(70,'AREV','ACH Reversal'),(71,'ASET','ACH Settlement'),(72,'ATXN','ACH Transaction'),(73,'AUTT','Automatic Transfer'),(74,'VCOM','Credit Transfer With Agreed Commercial Information'),(75,'XBCT','Cross-Border Credit Transfer'),(76,'XBSA','Cross-Border Payroll/Salary Payment'),(77,'XBST','Cross-Border Standing Order'),(78,'DMCT','Domestic Credit Transfer'),(79,'FICT','Financial Institution Credit Transfer'),(80,'BOOK','Internal Book Transfer'),(81,'SALA','Payroll/Salary Payment'),(82,'PRCT','Priority Credit Transfer'),(83,'RPCR','Reversal Due To Payment Cancellation Request'),(84,'RRTN','Reversal Due To Payment Return'),(85,'SDVA','Same Day Value Credit Transfer'),(86,'ESCT','SEPA Credit Transfer'),(87,'STDO','Standing Order'),(88,'TTLS','Treasury Tax And Loan Service'),(89,'XBDD','Cross-Border Direct Debit'),(90,'PMDD ','Direct Debit Payment'),(91,'URDD','Direct Debit Under Reserve'),(92,'FIDD ','Financial Institution Direct Debit Payment'),(93,'OODD','One-Off Direct Debit'),(94,'PADD','Pre-Authorised Direct Debit'),(95,'RCDD ','Reversal Due To Payment Cancellation Request'),(96,'PRDD ','Reversal Due To Payment Reversal'),(97,'UPDD ','Reversal Due To Return/Unpaid Direct Debit'),(98,'BBDD ','SEPA B2B Direct Debit'),(99,'ESDD ','SEPA Core Direct Debit'),(100,'LBCA','Credit Adjustment'),(101,'LBDB','Debit'),(102,'LBDP ','Deposit'),(103,'POSP','Point-of-Sale (POS) Payment'),(104,'SMCD','Smart-Card Payment'),(105,'UPCT','Unpaid Card Transaction'),(106,'IADD','Invoice Accepted with Differed Due Date');
/*!40000 ALTER TABLE `ref_transaction_subfamily` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_transaction_type`
--

DROP TABLE IF EXISTS `ref_transaction_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ref_transaction_type` (
  `PK_ transaction_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `FK_transaction_code_id` int(11) DEFAULT NULL,
  `FK_bai_issuer_code_id` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PK_ transaction_type_id`),
  KEY `FK_transaction_code_id_idx` (`FK_transaction_code_id`),
  CONSTRAINT `FK_transaction_code_id` FOREIGN KEY (`FK_transaction_code_id`) REFERENCES `ref_transaction_code` (`PK_transaction_code_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='ISO 200-22 + BAI2';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_transaction_type`
--

LOCK TABLES `ref_transaction_type` WRITE;
/*!40000 ALTER TABLE `ref_transaction_type` DISABLE KEYS */;
INSERT INTO `ref_transaction_type` VALUES (1,149,'228'),(2,139,'228'),(3,159,'228'),(4,169,'228'),(5,69,'228'),(6,245,'228'),(7,333,'228'),(8,225,'228');
/*!40000 ALTER TABLE `ref_transaction_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settlement`
--

DROP TABLE IF EXISTS `settlement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `settlement` (
  `PK_settlement_id` int(11) NOT NULL,
  `date_deal` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_cancelled` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `settlement_text` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `settlement_amount` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FK_settlement_type_id` int(11) DEFAULT NULL,
  `FK_settlement_status_id` int(11) DEFAULT NULL,
  `FK_contract_id` int(11) DEFAULT NULL,
  `FK_account_id` int(11) DEFAULT NULL,
  `FK_loan_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`PK_settlement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settlement`
--

LOCK TABLES `settlement` WRITE;
/*!40000 ALTER TABLE `settlement` DISABLE KEYS */;
/*!40000 ALTER TABLE `settlement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `transaction` (
  `PK_transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `FK_account_id` int(11) DEFAULT NULL,
  `FK_purchase_id` int(11) DEFAULT NULL,
  `FK_ transaction_type_id` int(11) DEFAULT NULL,
  `FK _transaction_message_id` int(11) DEFAULT NULL,
  `FK_related_ transaction_id` int(11) DEFAULT NULL,
  `other_details` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FK_currency_id` int(11) DEFAULT NULL,
  `date_of_transaction` datetime DEFAULT NULL,
  `transaction_amount` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FK_transaction_status_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`PK_transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_message`
--

DROP TABLE IF EXISTS `transaction_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `transaction_message` (
  `PK_message_id` int(11) NOT NULL AUTO_INCREMENT,
  `FK_ party_id` int(11) DEFAULT NULL,
  `FK_account_id` int(11) DEFAULT NULL,
  `FK_counterparty_id` int(11) DEFAULT NULL,
  `FK_ transaction_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`PK_message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_message`
--

LOCK TABLES `transaction_message` WRITE;
/*!40000 ALTER TABLE `transaction_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ebank2'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-23  4:57:26
