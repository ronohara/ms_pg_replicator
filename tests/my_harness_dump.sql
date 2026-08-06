-- MySQL dump 10.13  Distrib 9.7.0, for Win64 (x86_64)
--
-- Host: x360.sentuny.com    Database: my_ref_harness
-- ------------------------------------------------------
-- Server version	8.0.46-0ubuntu0.24.04.3

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

--
-- Table structure for table `boolean_types`
--

DROP TABLE IF EXISTS `boolean_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boolean_types` (
  `id` bigint DEFAULT NULL,
  `row_label` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `col_bool` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boolean_types`
--

LOCK TABLES `boolean_types` WRITE;
/*!40000 ALTER TABLE `boolean_types` DISABLE KEYS */;
INSERT INTO `boolean_types` VALUES (1,'TRUE',1),(2,'FALSE',0),(3,'NULL',0);
/*!40000 ALTER TABLE `boolean_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency_types`
--

DROP TABLE IF EXISTS `currency_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currency_types` (
  `id` bigint DEFAULT NULL,
  `row_label` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `col_currency` decimal(19,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency_types`
--

LOCK TABLES `currency_types` WRITE;
/*!40000 ALTER TABLE `currency_types` DISABLE KEYS */;
INSERT INTO `currency_types` VALUES (1,'zero',0.0000),(2,'positive',12345.6789),(3,'negative',-99.9900),(4,'NULL',NULL);
/*!40000 ALTER TABLE `currency_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datetime_types`
--

DROP TABLE IF EXISTS `datetime_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datetime_types` (
  `id` bigint DEFAULT NULL,
  `row_label` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `col_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datetime_types`
--

LOCK TABLES `datetime_types` WRITE;
/*!40000 ALTER TABLE `datetime_types` DISABLE KEYS */;
INSERT INTO `datetime_types` VALUES (1,'2026-01-15','2026-01-15 12:00:00'),(2,'epoch','1899-12-30 00:00:00'),(3,'NULL',NULL);
/*!40000 ALTER TABLE `datetime_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `decimal_types`
--

DROP TABLE IF EXISTS `decimal_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `decimal_types` (
  `id` bigint DEFAULT NULL,
  `row_label` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `col_currency` decimal(19,4) DEFAULT NULL,
  `col_dec_0` decimal(19,4) DEFAULT NULL,
  `col_dec_2` decimal(19,4) DEFAULT NULL,
  `col_dec_6` decimal(19,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `decimal_types`
--

LOCK TABLES `decimal_types` WRITE;
/*!40000 ALTER TABLE `decimal_types` DISABLE KEYS */;
INSERT INTO `decimal_types` VALUES (1,'zero',0.0000,0.0000,0.0000,0.0000),(2,'positive',12345.6789,42.0000,123.4500,0.1235),(3,'negative s0',NULL,-7.0000,NULL,NULL),(4,'negative s2',NULL,NULL,-99.9900,NULL),(5,'negative s6',NULL,NULL,NULL,0.0000),(6,'negative currency',-99.9900,NULL,NULL,NULL),(7,'scale=6 small',NULL,NULL,NULL,1.0000),(8,'NULL',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `decimal_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `float_types`
--

DROP TABLE IF EXISTS `float_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `float_types` (
  `id` bigint DEFAULT NULL,
  `row_label` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `col_single` float DEFAULT NULL,
  `col_double` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `float_types`
--

LOCK TABLES `float_types` WRITE;
/*!40000 ALTER TABLE `float_types` DISABLE KEYS */;
INSERT INTO `float_types` VALUES (1,'zero',0,0),(2,'pi',3.14159,3.14159265358979),(3,'negative',-0.00015,-2.225e-308),(4,'NULL',NULL,NULL);
/*!40000 ALTER TABLE `float_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guid_types`
--

DROP TABLE IF EXISTS `guid_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guid_types` (
  `id` bigint DEFAULT NULL,
  `row_label` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `col_guid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guid_types`
--

LOCK TABLES `guid_types` WRITE;
/*!40000 ALTER TABLE `guid_types` DISABLE KEYS */;
INSERT INTO `guid_types` VALUES (1,'guid1','12345678-ABCD-EF01-2345-6789ABCDEF01'),(2,'zero','00000000-0000-0000-0000-000000000000'),(3,'NULL',NULL);
/*!40000 ALTER TABLE `guid_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integer_types`
--

DROP TABLE IF EXISTS `integer_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `integer_types` (
  `id` bigint DEFAULT NULL,
  `row_label` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `col_byte` tinyint unsigned DEFAULT NULL,
  `col_int` int DEFAULT NULL,
  `col_long` bigint DEFAULT NULL,
  `col_bigint` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integer_types`
--

LOCK TABLES `integer_types` WRITE;
/*!40000 ALTER TABLE `integer_types` DISABLE KEYS */;
INSERT INTO `integer_types` VALUES (1,'zero',0,0,0,0),(2,'positive typical',128,32767,2147483647,9223372036854775807),(3,'negative',NULL,-32768,-2147483648,-9223372036854775808),(4,'NULL',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `integer_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `text_types`
--

DROP TABLE IF EXISTS `text_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `text_types` (
  `id` bigint DEFAULT NULL,
  `row_label` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `col_text_50` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `col_memo` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `text_types`
--

LOCK TABLES `text_types` WRITE;
/*!40000 ALTER TABLE `text_types` DISABLE KEYS */;
INSERT INTO `text_types` VALUES (1,'empty','',''),(2,'hello','Hello World','Long memo text'),(3,'NULL',NULL,NULL);
/*!40000 ALTER TABLE `text_types` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-06  8:15:27
