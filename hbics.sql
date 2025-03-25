-- MySQL dump 10.13  Distrib 5.7.44, for Linux (x86_64)
--
-- Host: localhost    Database: db_school_management_system
-- ------------------------------------------------------
-- Server version	5.7.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `academic_records`
--

DROP TABLE IF EXISTS `academic_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_records` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `institution` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `graduation_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `academic_records_uuid_unique` (`uuid`),
  KEY `academic_records_profile_id_foreign` (`profile_id`),
  CONSTRAINT `academic_records_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_records`
--

LOCK TABLES `academic_records` WRITE;
/*!40000 ALTER TABLE `academic_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `academic_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `achievements`
--

DROP TABLE IF EXISTS `achievements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `achievements` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `achievements_uuid_unique` (`uuid`),
  UNIQUE KEY `achievements_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `achievements`
--

LOCK TABLES `achievements` WRITE;
/*!40000 ALTER TABLE `achievements` DISABLE KEYS */;
/*!40000 ALTER TABLE `achievements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admission_stage_statuses`
--

DROP TABLE IF EXISTS `admission_stage_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admission_stage_statuses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admission_stage_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_number` int(11) NOT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admission_stage_statuses_admission_stage_id_foreign` (`admission_stage_id`),
  CONSTRAINT `admission_stage_statuses_admission_stage_id_foreign` FOREIGN KEY (`admission_stage_id`) REFERENCES `admission_stages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admission_stage_statuses`
--

LOCK TABLES `admission_stage_statuses` WRITE;
/*!40000 ALTER TABLE `admission_stage_statuses` DISABLE KEYS */;
INSERT INTO `admission_stage_statuses` VALUES (1,'bd3a1932-f594-11ef-93fa-0200a013a61c',1,'Menunggu',1,'',0,'2025-02-28 05:27:45','2025-03-04 02:59:19',NULL),(2,'bd3a4df8-f594-11ef-b46c-0200a013a61c',1,'Lanjut',2,'',1,'2025-02-28 05:27:45','2025-03-04 02:59:19',NULL),(3,'bd3ab446-f594-11ef-9532-0200a013a61c',2,'Menunggu',1,'',0,'2025-02-28 05:27:45','2025-03-04 02:59:19',NULL),(4,'bd3ae286-f594-11ef-8eeb-0200a013a61c',2,'Lanjut',2,'',1,'2025-02-28 05:27:45','2025-03-04 02:59:19',NULL),(5,'bd3b4960-f594-11ef-86be-0200a013a61c',3,'Menunggu',1,'',0,'2025-02-28 05:27:45','2025-03-04 02:59:19',NULL),(6,'bd3b77aa-f594-11ef-a6ae-0200a013a61c',3,'Lulus',2,'',1,'2025-02-28 05:27:45','2025-03-04 02:59:19',NULL),(7,'bd3ba806-f594-11ef-b9da-0200a013a61c',3,'Gagal',3,'',1,'2025-02-28 05:27:45','2025-03-04 02:59:19',NULL),(8,'bd3c0a94-f594-11ef-8440-0200a013a61c',4,'Menunggu',1,'',0,'2025-02-28 05:27:45','2025-03-04 02:59:19',NULL),(9,'bd3c3fc8-f594-11ef-bd37-0200a013a61c',4,'Selesai',2,'',1,'2025-02-28 05:27:45','2025-03-04 02:59:19',NULL),(10,'bd3c9d9c-f594-11ef-9a2e-0200a013a61c',5,'Menunggu',1,'',0,'2025-02-28 05:27:45','2025-03-04 02:59:19',NULL),(11,'bd3ccf4c-f594-11ef-93dd-0200a013a61c',5,'Selesai',2,'',1,'2025-02-28 05:27:45','2025-03-04 02:59:19',NULL),(12,'bd3e1c6c-f594-11ef-ac92-0200a013a61c',6,'Menunggu',1,'',0,'2025-02-28 05:27:45','2025-03-04 03:01:46',NULL),(13,'bd3e51e6-f594-11ef-abe8-0200a013a61c',6,'Lulus',2,'',1,'2025-02-28 05:27:45','2025-03-04 03:01:46',NULL),(14,'bd3e80a8-f594-11ef-b5b9-0200a013a61c',6,'Gagal',3,'',1,'2025-02-28 05:27:45','2025-03-04 03:01:46',NULL),(15,'bd3ee02a-f594-11ef-8059-0200a013a61c',7,'Menunggu',1,'',0,'2025-02-28 05:27:45','2025-03-04 03:01:46',NULL),(16,'bd3f0fbe-f594-11ef-855e-0200a013a61c',7,'Selesai',2,'',1,'2025-02-28 05:27:45','2025-03-04 03:01:46',NULL),(17,'bd3f753a-f594-11ef-92ab-0200a013a61c',8,'Menunggu',1,'',0,'2025-02-28 05:27:45','2025-03-04 03:01:46',NULL),(18,'bd3fa58c-f594-11ef-aca7-0200a013a61c',8,'Selesai',2,'',1,'2025-02-28 05:27:45','2025-03-04 03:01:46',NULL),(19,'bd40f9a0-f594-11ef-91dd-0200a013a61c',9,'Menunggu',1,'',0,'2025-02-28 05:27:45','2025-03-03 01:07:15',NULL),(20,'bd412b6e-f594-11ef-8c43-0200a013a61c',9,'Lulus',2,'',1,'2025-02-28 05:27:45','2025-03-03 01:07:15',NULL),(21,'bd415c7e-f594-11ef-a070-0200a013a61c',9,'Gagal',3,'',1,'2025-02-28 05:27:45','2025-03-03 01:07:15',NULL),(22,'bd41cf06-f594-11ef-b74e-0200a013a61c',10,'Menunggu',1,'',0,'2025-02-28 05:27:45','2025-03-03 01:07:15',NULL),(23,'bd41fd32-f594-11ef-b7c1-0200a013a61c',10,'Selesai',2,'',1,'2025-02-28 05:27:45','2025-03-03 01:07:15',NULL),(24,'bd4263c6-f594-11ef-b949-0200a013a61c',11,'Menunggu',1,'',0,'2025-02-28 05:27:45','2025-03-03 01:07:15',NULL),(25,'bd429378-f594-11ef-b253-0200a013a61c',11,'Selesai',2,'',1,'2025-02-28 05:27:45','2025-03-03 01:07:15',NULL),(26,'bd43bc8a-f594-11ef-b114-0200a013a61c',12,'Menunggu',1,'',0,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(27,'bd43ea48-f594-11ef-bc67-0200a013a61c',12,'Lulus',2,'',1,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(28,'bd441d24-f594-11ef-936b-0200a013a61c',12,'Gagal',3,'',1,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(29,'bd447df0-f594-11ef-a075-0200a013a61c',13,'Menunggu',1,'',0,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(30,'bd44aeba-f594-11ef-a839-0200a013a61c',13,'Selesai',2,'',1,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(31,'bd450d4c-f594-11ef-bcc1-0200a013a61c',14,'Menunggu',1,'',0,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(32,'bd4538a8-f594-11ef-add2-0200a013a61c',14,'Selesai',2,'',1,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(33,'f230b70a-f8a4-11ef-a106-0200a013a61c',20,'Menunggu',1,NULL,0,'2025-03-04 03:01:19','2025-03-04 03:01:46',NULL),(34,'f23103ea-f8a4-11ef-a7e8-0200a013a61c',20,'Selesai',2,NULL,1,'2025-03-04 03:01:19','2025-03-04 03:01:46',NULL);
/*!40000 ALTER TABLE `admission_stage_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admission_stages`
--

DROP TABLE IF EXISTS `admission_stages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admission_stages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_number` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admission_stages_model_type_model_id_index` (`model_type`,`model_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admission_stages`
--

LOCK TABLES `admission_stages` WRITE;
/*!40000 ALTER TABLE `admission_stages` DISABLE KEYS */;
INSERT INTO `admission_stages` VALUES (1,'bd39cce8-f594-11ef-b96a-0200a013a61c','App\\Models\\School',1,'PRE','Observasi Calon Siswa',1,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(2,'bd3a83ea-f594-11ef-b61e-0200a013a61c','App\\Models\\School',1,'PRE','Penyampaian Hasil Observasi Calon Siswa',2,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(3,'bd3b14b8-f594-11ef-879a-0200a013a61c','App\\Models\\School',1,'PRE','Wawancara Wali',3,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(4,'bd3bdbfa-f594-11ef-8e53-0200a013a61c','App\\Models\\School',1,'POST','Kelengkapan Seragam',4,'2025-02-28 05:27:45','2025-03-04 02:59:19',NULL),(5,'bd3c70e2-f594-11ef-ad42-0200a013a61c','App\\Models\\School',1,'POST','Kelengkapan Buku',5,'2025-02-28 05:27:45','2025-03-04 02:59:19',NULL),(6,'bd3de3a0-f594-11ef-b955-0200a013a61c','App\\Models\\School',2,'PRE','Wawancara Wali',1,'2025-02-28 05:27:45','2025-03-04 03:01:19',NULL),(7,'bd3eb2bc-f594-11ef-8e82-0200a013a61c','App\\Models\\School',2,'POST','Kelengkapan Seragam',2,'2025-02-28 05:27:45','2025-03-04 03:01:19',NULL),(8,'bd3f448e-f594-11ef-a6c3-0200a013a61c','App\\Models\\School',2,'POST','Kelengkapan Buku',3,'2025-02-28 05:27:45','2025-03-04 03:01:19',NULL),(9,'bd40c142-f594-11ef-892b-0200a013a61c','App\\Models\\School',3,'PRE','Wawancara Orang Tua / Wali',1,'2025-02-28 05:27:45','2025-03-03 01:07:15',NULL),(10,'bd419c16-f594-11ef-8072-0200a013a61c','App\\Models\\School',3,'POST','Kelengkapan Seragam',2,'2025-02-28 05:27:45','2025-03-03 01:07:15',NULL),(11,'bd4231da-f594-11ef-964a-0200a013a61c','App\\Models\\School',3,'POST','Kelengkapan Buku',3,'2025-02-28 05:27:45','2025-03-03 01:07:15',NULL),(12,'bd438684-f594-11ef-b1b3-0200a013a61c','App\\Models\\School',4,'PRE','Wawancara Wali',3,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(13,'bd444e2a-f594-11ef-b97d-0200a013a61c','App\\Models\\School',4,'POST','Kelengkapan Seragam',1,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(14,'bd44df66-f594-11ef-bf62-0200a013a61c','App\\Models\\School',4,'POST','Kelengkapan Buku',2,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(20,'f2305d0a-f8a4-11ef-9811-0200a013a61c','App\\Models\\School',2,'POST','Observarsi Penempatan Kelas & Pemilihan Eskul',4,'2025-03-04 03:01:19','2025-03-04 03:01:19',NULL);
/*!40000 ALTER TABLE `admission_stages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admission_student_quotas`
--

DROP TABLE IF EXISTS `admission_student_quotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admission_student_quotas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` bigint(20) unsigned NOT NULL,
  `school_year_id` bigint(20) unsigned NOT NULL,
  `school_grade_id` bigint(20) unsigned NOT NULL,
  `max_quota` int(11) NOT NULL DEFAULT '0',
  `used_quota` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admission_student_quotas_school_id_foreign` (`school_id`),
  KEY `admission_student_quotas_school_year_id_foreign` (`school_year_id`),
  KEY `admission_student_quotas_school_grade_id_foreign` (`school_grade_id`),
  CONSTRAINT `admission_student_quotas_school_grade_id_foreign` FOREIGN KEY (`school_grade_id`) REFERENCES `school_grades` (`id`),
  CONSTRAINT `admission_student_quotas_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `admission_stages` (`id`),
  CONSTRAINT `admission_student_quotas_school_year_id_foreign` FOREIGN KEY (`school_year_id`) REFERENCES `school_years` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admission_student_quotas`
--

LOCK TABLES `admission_student_quotas` WRITE;
/*!40000 ALTER TABLE `admission_student_quotas` DISABLE KEYS */;
INSERT INTO `admission_student_quotas` VALUES (1,'c479e434-01d8-11f0-817b-0200a013a61c',1,1,1,20,0,'2025-03-15 20:04:56','2025-03-15 20:04:56',NULL),(2,'c47a49ec-01d8-11f0-8360-0200a013a61c',1,1,2,52,0,'2025-03-15 20:04:56','2025-03-15 20:04:56',NULL),(3,'c47ac0de-01d8-11f0-b310-0200a013a61c',1,1,3,45,0,'2025-03-15 20:04:56','2025-03-15 20:04:56',NULL),(4,'c47b0404-01d8-11f0-88f7-0200a013a61c',1,1,4,60,0,'2025-03-15 20:04:56','2025-03-15 20:04:56',NULL);
/*!40000 ALTER TABLE `admission_student_quotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admission_student_stages`
--

DROP TABLE IF EXISTS `admission_student_stages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admission_student_stages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admission_student_id` bigint(20) unsigned NOT NULL,
  `admission_stage_id` bigint(20) unsigned NOT NULL,
  `admission_stage_status_id` bigint(20) unsigned NOT NULL,
  `officer_id` bigint(20) unsigned DEFAULT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admission_student_stages_admission_student_id_foreign` (`admission_student_id`),
  KEY `admission_student_stages_admission_stage_id_foreign` (`admission_stage_id`),
  KEY `admission_student_stages_admission_stage_status_id_foreign` (`admission_stage_status_id`),
  KEY `admission_student_stages_officer_id_foreign` (`officer_id`),
  CONSTRAINT `admission_student_stages_admission_stage_id_foreign` FOREIGN KEY (`admission_stage_id`) REFERENCES `admission_stages` (`id`),
  CONSTRAINT `admission_student_stages_admission_stage_status_id_foreign` FOREIGN KEY (`admission_stage_status_id`) REFERENCES `admission_stage_statuses` (`id`),
  CONSTRAINT `admission_student_stages_admission_student_id_foreign` FOREIGN KEY (`admission_student_id`) REFERENCES `admission_students` (`id`),
  CONSTRAINT `admission_student_stages_officer_id_foreign` FOREIGN KEY (`officer_id`) REFERENCES `employees` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admission_student_stages`
--

LOCK TABLES `admission_student_stages` WRITE;
/*!40000 ALTER TABLE `admission_student_stages` DISABLE KEYS */;
/*!40000 ALTER TABLE `admission_student_stages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admission_students`
--

DROP TABLE IF EXISTS `admission_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admission_students` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_id` bigint(20) unsigned NOT NULL,
  `school_id` bigint(20) unsigned NOT NULL,
  `school_year_id` bigint(20) unsigned NOT NULL,
  `school_grade_id` bigint(20) unsigned NOT NULL,
  `registration_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submitted_at` datetime DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birth_place` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blood_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `religion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `languages` json DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `postal_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `previous_school` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_birth_place` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_birth_date` date DEFAULT NULL,
  `father_religion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_languages` json DEFAULT NULL,
  `father_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_address` text COLLATE utf8mb4_unicode_ci,
  `father_occupation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_position` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_national_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_birth_place` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_birth_date` date DEFAULT NULL,
  `mother_religion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_languages` json DEFAULT NULL,
  `mother_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_address` text COLLATE utf8mb4_unicode_ci,
  `mother_occupation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_position` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_national_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emergency_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emergency_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emergency_home_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emergency_relation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `need_vehicle` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `responsible_fee` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payer_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payer_home_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payer_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payer_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payer_relation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payer_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payer_company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payer_company_letter` text COLLATE utf8mb4_unicode_ci,
  `health_info_remark` text COLLATE utf8mb4_unicode_ci,
  `health_relate_family` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `use_insurance` tinyint(1) NOT NULL DEFAULT '0',
  `insurance_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `insurance_network` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recomended_hospital` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `doctor_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `families` json DEFAULT NULL,
  `questionnaires` json DEFAULT NULL,
  `family_card_attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_id_card_attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_id_card_attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birth_certificate_attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_report_attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `previous_school_letter_attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_info_sources` json DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `student_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admission_students_registration_number_unique` (`registration_number`),
  KEY `admission_students_transaction_id_foreign` (`transaction_id`),
  KEY `admission_students_school_id_foreign` (`school_id`),
  KEY `admission_students_school_year_id_foreign` (`school_year_id`),
  KEY `admission_students_school_grade_id_foreign` (`school_grade_id`),
  KEY `admission_students_student_id_foreign` (`student_id`),
  CONSTRAINT `admission_students_school_grade_id_foreign` FOREIGN KEY (`school_grade_id`) REFERENCES `school_grades` (`id`),
  CONSTRAINT `admission_students_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`),
  CONSTRAINT `admission_students_school_year_id_foreign` FOREIGN KEY (`school_year_id`) REFERENCES `school_years` (`id`),
  CONSTRAINT `admission_students_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `admission_students_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admission_students`
--

LOCK TABLES `admission_students` WRITE;
/*!40000 ALTER TABLE `admission_students` DISABLE KEYS */;
/*!40000 ALTER TABLE `admission_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `areas`
--

DROP TABLE IF EXISTS `areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hotline` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `areas_uuid_unique` (`uuid`),
  KEY `areas_model_type_model_id_index` (`model_type`,`model_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areas`
--

LOCK TABLES `areas` WRITE;
/*!40000 ALTER TABLE `areas` DISABLE KEYS */;
INSERT INTO `areas` VALUES (1,'bcc6b23a-f594-11ef-b863-0200a013a61c','App\\Models\\School',1,'KB & TK Happy Holy Kids',NULL,'admin.hhk@hbics.sch.id',NULL,NULL,NULL,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(2,'bcc76ac2-f594-11ef-ae7b-0200a013a61c','App\\Models\\School',2,'SDK Harapan Bangsa',NULL,'admin.sdk@hbics.sch.id',NULL,NULL,NULL,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(3,'bcc817b0-f594-11ef-99b8-0200a013a61c','App\\Models\\School',3,'SMPK Harapan Bangsa',NULL,'admin.smpk@hbics.sch.id',NULL,NULL,NULL,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(4,'bcc8f5d6-f594-11ef-950f-0200a013a61c','App\\Models\\School',4,'SMAK Harapan Bangsa',NULL,'admin.smak@hbics.sch.id',NULL,NULL,NULL,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(5,'bcc9d69a-f594-11ef-92c0-0200a013a61c','App\\Models\\Office',1,'HCM',NULL,NULL,NULL,NULL,NULL,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(6,'bcca72e4-f594-11ef-9864-0200a013a61c','App\\Models\\Office',2,'QRD',NULL,NULL,NULL,NULL,NULL,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(7,'bccb1096-f594-11ef-ad2a-0200a013a61c','App\\Models\\Office',3,'FA',NULL,NULL,NULL,NULL,NULL,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(8,'bccb9b06-f594-11ef-a46c-0200a013a61c','App\\Models\\Office',4,'ICC',NULL,NULL,NULL,NULL,NULL,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(9,'bccc2724-f594-11ef-9c71-0200a013a61c','App\\Models\\Office',5,'GA',NULL,NULL,NULL,NULL,NULL,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(10,'bcccb4a0-f594-11ef-94f5-0200a013a61c','App\\Models\\Office',6,'Management',NULL,NULL,NULL,NULL,NULL,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL);
/*!40000 ALTER TABLE `areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attachments_uuid_unique` (`uuid`),
  KEY `attachments_model_type_model_id_index` (`model_type`,`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachments`
--

LOCK TABLES `attachments` WRITE;
/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banners`
--

DROP TABLE IF EXISTS `banners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banners` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `banners_uuid_unique` (`uuid`),
  UNIQUE KEY `banners_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banners`
--

LOCK TABLES `banners` WRITE;
/*!40000 ALTER TABLE `banners` DISABLE KEYS */;
/*!40000 ALTER TABLE `banners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `careers`
--

DROP TABLE IF EXISTS `careers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `careers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `careers_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `careers`
--

LOCK TABLES `careers` WRITE;
/*!40000 ALTER TABLE `careers` DISABLE KEYS */;
/*!40000 ALTER TABLE `careers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certifications`
--

DROP TABLE IF EXISTS `certifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint(20) unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `institution` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `certification_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `certifications_uuid_unique` (`uuid`),
  KEY `certifications_profile_id_foreign` (`profile_id`),
  CONSTRAINT `certifications_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certifications`
--

LOCK TABLES `certifications` WRITE;
/*!40000 ALTER TABLE `certifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `certifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chats`
--

DROP TABLE IF EXISTS `chats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  `sender_id` bigint(20) unsigned NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `chats_uuid_unique` (`uuid`),
  KEY `chats_model_type_model_id_index` (`model_type`,`model_id`),
  KEY `chats_sender_id_foreign` (`sender_id`),
  CONSTRAINT `chats_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4025 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats`
--

LOCK TABLES `chats` WRITE;
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
/*!40000 ALTER TABLE `chats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `community_involvements`
--

DROP TABLE IF EXISTS `community_involvements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `community_involvements` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `responsibility` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `community_involvements_uuid_unique` (`uuid`),
  KEY `community_involvements_profile_id_foreign` (`profile_id`),
  CONSTRAINT `community_involvements_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `community_involvements`
--

LOCK TABLES `community_involvements` WRITE;
/*!40000 ALTER TABLE `community_involvements` DISABLE KEYS */;
/*!40000 ALTER TABLE `community_involvements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount_usages`
--

DROP TABLE IF EXISTS `discount_usages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discount_usages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `area_id` bigint(20) unsigned NOT NULL,
  `discount_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `discount_usages_uuid_unique` (`uuid`),
  KEY `discount_usages_area_id_foreign` (`area_id`),
  KEY `discount_usages_discount_id_foreign` (`discount_id`),
  CONSTRAINT `discount_usages_area_id_foreign` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  CONSTRAINT `discount_usages_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount_usages`
--

LOCK TABLES `discount_usages` WRITE;
/*!40000 ALTER TABLE `discount_usages` DISABLE KEYS */;
/*!40000 ALTER TABLE `discount_usages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `value` decimal(15,2) NOT NULL DEFAULT '0.00',
  `starts_at` datetime DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `quota` int(11) DEFAULT NULL,
  `used_quota` int(11) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `discounts_uuid_unique` (`uuid`),
  UNIQUE KEY `discounts_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_assignments`
--

DROP TABLE IF EXISTS `employee_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_assignments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `employee_id` bigint(20) unsigned NOT NULL,
  `area_id` bigint(20) unsigned NOT NULL,
  `position_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `employee_assignments_uuid_unique` (`uuid`),
  KEY `employee_assignments_employee_id_foreign` (`employee_id`),
  KEY `employee_assignments_area_id_foreign` (`area_id`),
  KEY `employee_assignments_position_id_foreign` (`position_id`),
  CONSTRAINT `employee_assignments_area_id_foreign` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  CONSTRAINT `employee_assignments_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`),
  CONSTRAINT `employee_assignments_position_id_foreign` FOREIGN KEY (`position_id`) REFERENCES `positions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_assignments`
--

LOCK TABLES `employee_assignments` WRITE;
/*!40000 ALTER TABLE `employee_assignments` DISABLE KEYS */;
INSERT INTO `employee_assignments` VALUES (1,'bd4735c2-f594-11ef-9331-0200a013a61c',1,1,2,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(2,'bd48c4a0-f594-11ef-a9f3-0200a013a61c',2,1,2,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(3,'bd4a1f08-f594-11ef-bc32-0200a013a61c',3,1,3,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(4,'bd4b7d94-f594-11ef-aaeb-0200a013a61c',4,7,4,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(5,'bd4e064a-f594-11ef-ac3e-0200a013a61c',6,1,5,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(6,'bd4f5d60-f594-11ef-9bae-0200a013a61c',7,1,6,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(7,'bd50bb56-f594-11ef-a787-0200a013a61c',8,1,2,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(8,'bd520448-f594-11ef-9a08-0200a013a61c',9,1,2,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(9,'bd53641e-f594-11ef-aaca-0200a013a61c',10,1,2,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(10,'bd54c5e8-f594-11ef-b0e9-0200a013a61c',11,1,2,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(11,'bd56138a-f594-11ef-a339-0200a013a61c',12,1,2,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(12,'bd576546-f594-11ef-9785-0200a013a61c',13,1,7,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(13,'bd58b4dc-f594-11ef-9371-0200a013a61c',14,1,2,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(14,'bd59fb80-f594-11ef-84b4-0200a013a61c',15,1,8,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(15,'bd5b4f80-f594-11ef-a9b9-0200a013a61c',16,1,9,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(16,'bd5cae16-f594-11ef-bdab-0200a013a61c',17,1,2,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(17,'bd5df7d0-f594-11ef-90b7-0200a013a61c',18,1,10,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(18,'bd5f5c9c-f594-11ef-8df6-0200a013a61c',19,1,2,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(19,'bd60c2d0-f594-11ef-ab90-0200a013a61c',20,1,11,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(20,'bd6230c0-f594-11ef-8919-0200a013a61c',21,1,2,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(21,'bd6397da-f594-11ef-a654-0200a013a61c',22,1,2,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(22,'bd64fd96-f594-11ef-b6e8-0200a013a61c',23,1,2,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(23,'bd667d74-f594-11ef-96ba-0200a013a61c',24,2,12,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(24,'bd67f55a-f594-11ef-95a0-0200a013a61c',25,2,13,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(25,'bd696e94-f594-11ef-8aab-0200a013a61c',26,2,14,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(26,'bd6adfa4-f594-11ef-b847-0200a013a61c',27,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(27,'bd6c6c20-f594-11ef-8bf0-0200a013a61c',28,2,16,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(28,'bd6e15b6-f594-11ef-a25b-0200a013a61c',29,2,17,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(29,'bd6fed6e-f594-11ef-b4e0-0200a013a61c',30,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(30,'bd71a622-f594-11ef-aa2d-0200a013a61c',31,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(31,'bd731e6c-f594-11ef-a8e4-0200a013a61c',32,10,18,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(32,'bd74c26c-f594-11ef-8b62-0200a013a61c',33,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(33,'bd76348a-f594-11ef-bb9e-0200a013a61c',34,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(34,'bd77c930-f594-11ef-9db4-0200a013a61c',35,2,19,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(35,'bd79a64c-f594-11ef-addd-0200a013a61c',36,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(36,'bd7b3048-f594-11ef-abf4-0200a013a61c',37,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(37,'bd7ca09a-f594-11ef-b7b3-0200a013a61c',38,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(38,'bd7e7e06-f594-11ef-83bf-0200a013a61c',39,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(39,'bd7ff646-f594-11ef-9c7a-0200a013a61c',40,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(40,'bd8197da-f594-11ef-a7f2-0200a013a61c',41,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(41,'bd830250-f594-11ef-9192-0200a013a61c',42,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(42,'bd84dc9c-f594-11ef-b690-0200a013a61c',43,2,20,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(43,'bd86bcd8-f594-11ef-96bc-0200a013a61c',44,2,21,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(44,'bd88c4b0-f594-11ef-b4b6-0200a013a61c',45,2,22,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(45,'bd8a7148-f594-11ef-85c4-0200a013a61c',46,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(46,'bd8cbc6e-f594-11ef-abf8-0200a013a61c',47,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(47,'bd8ebdfc-f594-11ef-86f2-0200a013a61c',48,4,23,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(48,'bd904492-f594-11ef-9448-0200a013a61c',49,6,24,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(49,'bd91a0b2-f594-11ef-abb9-0200a013a61c',50,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(50,'bd9317c6-f594-11ef-9139-0200a013a61c',51,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(51,'bd959f32-f594-11ef-b64e-0200a013a61c',52,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(52,'bd97add6-f594-11ef-b564-0200a013a61c',53,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(53,'bd99204e-f594-11ef-a46f-0200a013a61c',54,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(54,'bd9a8aba-f594-11ef-bcaa-0200a013a61c',55,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(55,'bd9c1308-f594-11ef-a211-0200a013a61c',56,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(56,'bd9d926e-f594-11ef-bf20-0200a013a61c',57,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(57,'bd9f12d8-f594-11ef-a0ce-0200a013a61c',58,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(58,'bda083d4-f594-11ef-9d73-0200a013a61c',59,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(59,'bda1fbe2-f594-11ef-b602-0200a013a61c',60,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(60,'bda3777e-f594-11ef-bdc1-0200a013a61c',61,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(61,'bda4e1d6-f594-11ef-bb12-0200a013a61c',62,2,15,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(62,'bda64b48-f594-11ef-a3eb-0200a013a61c',63,4,25,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(63,'bda7231a-f594-11ef-a45d-0200a013a61c',64,4,26,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(64,'bda87e86-f594-11ef-a9f9-0200a013a61c',65,3,27,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(65,'bda9f0f4-f594-11ef-9078-0200a013a61c',66,3,28,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(66,'bdabafc0-f594-11ef-ab8e-0200a013a61c',67,3,27,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(67,'bdad6400-f594-11ef-bc1d-0200a013a61c',68,4,23,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(68,'bdaef2b6-f594-11ef-8f7f-0200a013a61c',69,10,18,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(69,'bdb079ce-f594-11ef-9b40-0200a013a61c',70,4,29,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(70,'bdb1f376-f594-11ef-9fbd-0200a013a61c',71,4,23,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(71,'bdb30b1c-f594-11ef-aff7-0200a013a61c',72,4,30,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(72,'bdb47dbc-f594-11ef-a485-0200a013a61c',73,3,27,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(73,'bdb5f03e-f594-11ef-b8a3-0200a013a61c',74,10,18,'2025-02-28 05:27:45','2025-03-02 23:38:56','2025-03-02 23:38:56'),(74,'bdb7852a-f594-11ef-a287-0200a013a61c',75,3,27,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(75,'bdb8f04a-f594-11ef-add0-0200a013a61c',76,3,31,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(76,'bdbc8ec6-f594-11ef-a2ce-0200a013a61c',77,3,27,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(77,'bdbe1840-f594-11ef-8446-0200a013a61c',78,4,32,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(78,'bdc046a6-f594-11ef-9214-0200a013a61c',79,3,27,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(79,'bdc1d458-f594-11ef-88db-0200a013a61c',80,3,27,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(80,'bdc38f8c-f594-11ef-9a4d-0200a013a61c',81,3,33,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(81,'bdc565e6-f594-11ef-847c-0200a013a61c',82,3,27,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(82,'bdc75d4c-f594-11ef-b6fa-0200a013a61c',83,4,23,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(83,'bdc8f0b2-f594-11ef-85e6-0200a013a61c',84,4,23,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(84,'bdcb4088-f594-11ef-8ce9-0200a013a61c',85,4,23,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(85,'bdcd1a0c-f594-11ef-89a5-0200a013a61c',86,4,23,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(86,'bdcedc52-f594-11ef-80c9-0200a013a61c',87,4,23,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(87,'bdd0995c-f594-11ef-8637-0200a013a61c',88,4,23,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(88,'bdd274f2-f594-11ef-9374-0200a013a61c',89,4,23,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(89,'bdd419c4-f594-11ef-99d5-0200a013a61c',90,3,34,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(90,'bdd5858e-f594-11ef-bca3-0200a013a61c',91,10,18,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(91,'bdd701f2-f594-11ef-b1f4-0200a013a61c',92,7,35,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(92,'bdd89c60-f594-11ef-af28-0200a013a61c',93,7,35,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(93,'bdda7ed6-f594-11ef-b58f-0200a013a61c',94,7,35,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(94,'bddc4806-f594-11ef-a8f9-0200a013a61c',95,7,35,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(95,'bdddecba-f594-11ef-a73f-0200a013a61c',96,9,36,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(96,'bddf8fac-f594-11ef-abd6-0200a013a61c',97,5,37,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(97,'bde146da-f594-11ef-881c-0200a013a61c',98,9,38,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(98,'bde315f0-f594-11ef-8642-0200a013a61c',99,9,39,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(99,'bde4a776-f594-11ef-aee8-0200a013a61c',100,9,40,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(100,'bde681c2-f594-11ef-b34c-0200a013a61c',101,5,41,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(101,'bde856be-f594-11ef-b588-0200a013a61c',102,9,42,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(102,'bdea1ad0-f594-11ef-a9c3-0200a013a61c',103,9,42,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(103,'bdebf328-f594-11ef-85dc-0200a013a61c',104,9,40,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(104,'bdedaf1a-f594-11ef-9097-0200a013a61c',105,9,43,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(105,'bdef417c-f594-11ef-9676-0200a013a61c',106,9,40,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(106,'bdf0e130-f594-11ef-9479-0200a013a61c',107,9,42,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(107,'bdf1f1c4-f594-11ef-85a9-0200a013a61c',108,9,42,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(108,'bdf3839a-f594-11ef-a993-0200a013a61c',109,6,44,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(109,'bdf51a48-f594-11ef-8e1e-0200a013a61c',110,8,45,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(110,'bdf6b84e-f594-11ef-a95f-0200a013a61c',111,8,45,'2025-02-28 05:27:46','2025-02-28 07:30:48','2025-02-28 07:30:48'),(111,'bdf836ec-f594-11ef-ae82-0200a013a61c',112,6,46,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(112,'bdf9e1ea-f594-11ef-b54a-0200a013a61c',113,6,24,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(113,'bdfb99c2-f594-11ef-9b02-0200a013a61c',114,5,47,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(114,'bdfd655e-f594-11ef-a540-0200a013a61c',115,9,43,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(115,'bdfe81aa-f594-11ef-8aaf-0200a013a61c',116,2,48,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(116,'be004184-f594-11ef-80fe-0200a013a61c',117,4,23,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(117,'0a534c56-f5a5-11ef-9627-0200a013a61c',32,8,45,'2025-02-28 07:24:26','2025-02-28 07:24:26',NULL),(118,'138229be-f5a5-11ef-bfe8-0200a013a61c',15,8,45,'2025-02-28 07:24:41','2025-02-28 07:24:41',NULL),(119,'1aad6c1c-f5a5-11ef-a8ec-0200a013a61c',91,8,45,'2025-02-28 07:24:53','2025-02-28 07:24:53',NULL),(120,'2abcc378-f5a5-11ef-9429-0200a013a61c',69,8,45,'2025-02-28 07:25:20','2025-02-28 07:25:20',NULL),(121,'7d54b61a-f7bf-11ef-8e06-0200a013a61c',118,10,18,'2025-03-02 23:38:48','2025-03-02 23:38:48',NULL),(122,'88b9610e-f7bf-11ef-984c-0200a013a61c',15,10,18,'2025-03-02 23:39:07','2025-03-02 23:39:07',NULL),(123,'97736db6-f7bf-11ef-aacb-0200a013a61c',118,8,45,'2025-03-02 23:39:32','2025-03-02 23:39:32',NULL);
/*!40000 ALTER TABLE `employee_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint(20) unsigned NOT NULL,
  `identity_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `employees_uuid_unique` (`uuid`),
  UNIQUE KEY `employees_identity_number_unique` (`identity_number`),
  KEY `employees_profile_id_foreign` (`profile_id`),
  CONSTRAINT `employees_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'bd46cf92-f594-11ef-85a7-0200a013a61c',3,'000000000','2025-02-25',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(2,'bd486ac8-f594-11ef-af7a-0200a013a61c',4,'90.099.189.123','2024-07-10','2024-07-31','PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(3,'bd49c800-f594-11ef-9977-0200a013a61c',5,'04.002.080507','2007-05-08',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(4,'bd4b2164-f594-11ef-84d4-0200a013a61c',6,'02.144.140519','2019-05-14',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(5,'bd4c75e6-f594-11ef-9815-0200a013a61c',7,'201.1110.100.2000','2024-07-11','2027-03-04','PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(6,'bd4da6dc-f594-11ef-aa3f-0200a013a61c',8,'04.005.110110','2010-01-11',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(7,'bd4f0496-f594-11ef-a5d3-0200a013a61c',9,'03.10.010712','2012-07-01',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(8,'bd5066b0-f594-11ef-9f5a-0200a013a61c',10,'04.029.070714','2014-07-07',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(9,'bd51a778-f594-11ef-83c4-0200a013a61c',11,'04.026.160514','2014-05-16',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(10,'bd530bfe-f594-11ef-b587-0200a013a61c',12,'04.046.230622','2022-06-23','2025-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(11,'bd546242-f594-11ef-9aa3-0200a013a61c',13,'04.048.010822','2022-08-01','2025-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(12,'bd55b872-f594-11ef-8188-0200a013a61c',14,'03.07.241112','2011-11-24',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(13,'bd570c18-f594-11ef-a148-0200a013a61c',15,'04.02.1220615','2015-06-24',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(14,'bd585ae6-f594-11ef-b049-0200a013a61c',16,'04.049.130723','2023-07-13','2026-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(15,'bd59a1da-f594-11ef-a05b-0200a013a61c',17,'03.11.160113','2013-01-16',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(16,'bd5af472-f594-11ef-bc12-0200a013a61c',18,'04.043.180618','2018-06-18',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(17,'bd5c54ac-f594-11ef-bc0c-0200a013a61c',19,'03.004.010411','2011-04-01',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(18,'bd5d9af6-f594-11ef-a194-0200a013a61c',20,'04.045.210322','2022-03-21','2025-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(19,'bd5f042c-f594-11ef-ab01-0200a013a61c',21,'04.051.300819','2019-08-30','2025-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(20,'bd605caa-f594-11ef-a8eb-0200a013a61c',22,'04.044.240619','2019-06-24',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(21,'bd61cf86-f594-11ef-9361-0200a013a61c',23,'04.052.210624','2024-06-21','2027-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(22,'bd633d4e-f594-11ef-add7-0200a013a61c',24,'04.053.270624','2024-06-27','2027-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(23,'bd64a59e-f594-11ef-9c89-0200a013a61c',25,'04.050.210923','2023-09-21','2026-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(24,'bd661b0e-f594-11ef-9a98-0200a013a61c',26,'05.097.220616','2016-06-22',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(25,'bd6797e0-f594-11ef-92ad-0200a013a61c',27,'05.018.010811','2011-08-01',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(26,'bd6913c2-f594-11ef-a8f2-0200a013a61c',28,'05.038.010513','2013-05-01',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(27,'bd6a864e-f594-11ef-ace4-0200a013a61c',29,'05.159.010922','2022-09-01','2025-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(28,'bd6bf876-f594-11ef-805e-0200a013a61c',30,'05.091.280316','2016-03-28',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(29,'bd6da9e6-f594-11ef-928f-0200a013a61c',31,'05.089.280316','2016-03-28',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(30,'bd6f652e-f594-11ef-9ac9-0200a013a61c',32,'05.137.050421','2021-04-05',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(31,'bd7137a0-f594-11ef-a54c-0200a013a61c',33,'05.160.311022','2022-10-31','2025-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(32,'bd72c0ac-f594-11ef-9dfd-0200a013a61c',34,'02.153.080321','2021-03-08','2024-12-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(33,'bd745de0-f594-11ef-a469-0200a013a61c',35,'05.149.080721','2021-07-08',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(34,'bd75d99a-f594-11ef-9985-0200a013a61c',36,'05.162.030723','2023-07-03',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(35,'bd776b70-f594-11ef-998f-0200a013a61c',37,'05.086.280316','2016-03-28',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(36,'bd793dc4-f594-11ef-836d-0200a013a61c',38,'05.140.200421','2021-04-20',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(37,'bd7ac75c-f594-11ef-9a9c-0200a013a61c',39,'05.123.180219','2019-02-18',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(38,'bd7c3db2-f594-11ef-8be1-0200a013a61c',40,'05.161.211122','2022-11-21','2025-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(39,'bd7e10f6-f594-11ef-8a9e-0200a013a61c',41,'05.157.270622','2022-06-27','2025-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(40,'bd7f912e-f594-11ef-95c2-0200a013a61c',42,'05.158.270622','2022-06-27','2025-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(41,'bd81225a-f594-11ef-bb00-0200a013a61c',43,'05.079.041015','2015-10-04',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(42,'bd82aa1c-f594-11ef-ab78-0200a013a61c',44,'05.152.070322','2022-03-07','2025-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(43,'bd846e2e-f594-11ef-8eb5-0200a013a61c',45,'05.151.120721','2021-07-12',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(44,'bd865cc0-f594-11ef-9810-0200a013a61c',46,'05.138.050421','2021-04-05',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(45,'bd8862cc-f594-11ef-ad9c-0200a013a61c',47,'05.134.220321','2021-03-22',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(46,'bd8a07f8-f594-11ef-b358-0200a013a61c',48,'05.163.100723','2023-07-10','2026-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(47,'bd8c4d74-f594-11ef-a5b5-0200a013a61c',49,'05.154.240622','2022-06-24','2025-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(48,'bd8e4f34-f594-11ef-b4ea-0200a013a61c',50,'05.150.120721','2021-07-12',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(49,'bd8fe1dc-f594-11ef-8d51-0200a013a61c',51,'04.037.270420','2020-04-27',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(50,'bd9147ac-f594-11ef-83b7-0200a013a61c',52,'05.122.101218','2018-12-10',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(51,'bd92b3b2-f594-11ef-a00a-0200a013a61c',53,'05.146.160621','2021-06-16',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(52,'bd94c7d8-f594-11ef-9601-0200a013a61c',54,'05.166.060324','2024-03-06','2027-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(53,'bd974be8-f594-11ef-91f1-0200a013a61c',55,'05.167.130524','2024-05-13','2027-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(54,'bd98bc4e-f594-11ef-9edf-0200a013a61c',56,'05.168.280624','2024-06-28','2027-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(55,'bd9a2fb6-f594-11ef-b7d4-0200a013a61c',57,'05.169.270624','2024-07-01','2027-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(56,'bd9bac74-f594-11ef-89b1-0200a013a61c',58,'05.170.280624','2024-07-01','2027-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(57,'bd9d3314-f594-11ef-b208-0200a013a61c',59,'05.171.020724','2024-07-02','2027-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(58,'bd9eaa46-f594-11ef-892a-0200a013a61c',60,'05.172.110724','2024-07-11','2027-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(59,'bda027ae-f594-11ef-8f57-0200a013a61c',61,'05.173.110724','2024-07-11','2027-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(60,'bda19bde-f594-11ef-88b2-0200a013a61c',62,'05.174.080724','2024-07-08','2025-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(61,'bda30fa0-f594-11ef-aae8-0200a013a61c',63,'05.175.150724','2024-07-15','2027-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(62,'bda482a4-f594-11ef-ac68-0200a013a61c',64,'05.139.200421','2021-04-20',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(63,'bda5f332-f594-11ef-abb0-0200a013a61c',65,'06.01.010714','2006-09-01',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(64,'bda6c99c-f594-11ef-83c0-0200a013a61c',66,'06.014.120716','2016-07-12',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(65,'bda81f9a-f594-11ef-920f-0200a013a61c',67,'05.094.020516','2016-05-02',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(66,'bda9895c-f594-11ef-894a-0200a013a61c',68,'06.053.071019','2019-10-07',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(67,'bdab3a9a-f594-11ef-8620-0200a013a61c',69,'06.071.141022','2022-10-14','2025-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(68,'bdacf8ee-f594-11ef-9c41-0200a013a61c',70,'06.075.250523','2023-05-25','2026-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(69,'bdae90dc-f594-11ef-a683-0200a013a61c',71,'06.069.250722','2022-07-25','2025-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(70,'bdb01696-f594-11ef-9af9-0200a013a61c',72,'02.011.010811','2011-08-01',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(71,'bdb1943a-f594-11ef-84a3-0200a013a61c',73,'06.065.170621','2021-06-17',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(72,'bdb2abf4-f594-11ef-aef0-0200a013a61c',74,'06.040.031218','2018-12-03',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(73,'bdb417a0-f594-11ef-a9fc-0200a013a61c',75,'06.074.220523','2023-05-22','2026-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(74,'bdb593aa-f594-11ef-865a-0200a013a61c',76,'06.078.101123','2023-11-10','2025-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(75,'bdb7201c-f594-11ef-8264-0200a013a61c',77,'06.072.010323','2023-03-01','2026-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(76,'bdb8932a-f594-11ef-a9b3-0200a013a61c',78,'06.060.200421','2021-04-20',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(77,'bdbc1ea0-f594-11ef-9bc9-0200a013a61c',79,'06.073.010323','2023-03-01','2026-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(78,'bdbdbf3a-f594-11ef-88c2-0200a013a61c',80,'06.03.010614','2014-06-02',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(79,'bdbfd8ce-f594-11ef-8ffc-0200a013a61c',81,'06.070.110822','2022-08-11','2025-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(80,'bdc174ae-f594-11ef-81c1-0200a013a61c',82,'06.067.060722','2022-06-06','2026-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(81,'bdc32524-f594-11ef-94ff-0200a013a61c',83,'06.076.310523','2023-05-31','2026-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(82,'bdc4eec2-f594-11ef-8838-0200a013a61c',84,'06.066.160921','2021-09-16',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(83,'bdc6ecf4-f594-11ef-8188-0200a013a61c',85,'06.062.200421','2021-04-20',NULL,'PERMANENT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(84,'bdc88bae-f594-11ef-9bca-0200a013a61c',86,'06.079.250324','2024-03-25','2027-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(85,'bdcac248-f594-11ef-a570-0200a013a61c',87,'06.080.240624','2024-06-24','2027-06-20','CONTRACT','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(86,'bdccaa0e-f594-11ef-9f02-0200a013a61c',88,'06.081.240624','2024-06-24','2027-06-20','CONTRACT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(87,'bdce6876-f594-11ef-86be-0200a013a61c',89,'06.082.260624','2024-06-26','2027-06-20','CONTRACT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(88,'bdd0238c-f594-11ef-933d-0200a013a61c',90,'06.083.010724','2024-07-01','2027-06-20','CONTRACT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(89,'bdd20512-f594-11ef-9fcf-0200a013a61c',91,'06.084.100724','2024-07-10','2025-06-20','CONTRACT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(90,'bdd3ba4c-f594-11ef-9562-0200a013a61c',92,'06.058.190421','2021-04-19',NULL,'PERMANENT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(91,'bdd52968-f594-11ef-8e2b-0200a013a61c',93,'05.153.180422','2022-04-18','2025-06-20','CONTRACT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(92,'bdd69bb8-f594-11ef-aea7-0200a013a61c',94,'02.168.020323','2023-03-02','2025-03-02','CONTRACT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(93,'bdd82faa-f594-11ef-95c3-0200a013a61c',95,'02.161.210422','2022-04-21','2025-06-20','CONTRACT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(94,'bdd9fbd2-f594-11ef-9c55-0200a013a61c',96,'02.051.311014','2014-10-31',NULL,'PERMANENT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(95,'bddbd650-f594-11ef-8404-0200a013a61c',97,'02.163.020922','2022-10-12','2024-10-12','CONTRACT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(96,'bddd813a-f594-11ef-81bd-0200a013a61c',98,'02.099.080317','2017-03-08',NULL,'PERMANENT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(97,'bddf1554-f594-11ef-921e-0200a013a61c',99,'02.089.020816','2016-08-02',NULL,'PERMANENT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(98,'bde0d538-f594-11ef-8950-0200a013a61c',100,'02.165.010223','2023-02-01','2025-02-01','CONTRACT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(99,'bde2a6a6-f594-11ef-959a-0200a013a61c',101,'02.082.220216','2016-02-22',NULL,'PERMANENT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(100,'bde43cc8-f594-11ef-8aa2-0200a013a61c',102,'02.003.010107','2007-01-01',NULL,'PERMANENT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(101,'bde60698-f594-11ef-bfe8-0200a013a61c',103,'02.166.160223','2023-02-16','2026-06-20','CONTRACT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(102,'bde7da68-f594-11ef-9ec5-0200a013a61c',104,'02.138.170718','2018-07-17',NULL,'PERMANENT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(103,'bde99bb4-f594-11ef-8e6d-0200a013a61c',105,'02.009.180612','2009-06-18',NULL,'PERMANENT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(104,'bdeb7b96-f594-11ef-b37c-0200a013a61c',106,'02.001.010606','2006-06-01',NULL,'PERMANENT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(105,'bded3f3a-f594-11ef-971d-0200a013a61c',107,'02.101.310317','2017-03-31',NULL,'PERMANENT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(106,'bdeed5b6-f594-11ef-b070-0200a013a61c',108,'02.162.020922','2022-09-02','2024-12-03','CONTRACT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(107,'bdf07b96-f594-11ef-8c8e-0200a013a61c',109,'02.067.271112','2012-11-27',NULL,'PERMANENT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(108,'bdf18310-f594-11ef-8b90-0200a013a61c',110,'02.174.290424','2024-04-29','2025-04-28','CONTRACT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(109,'bdf31a68-f594-11ef-ba0c-0200a013a61c',111,'02.169.021023','2023-10-02',NULL,'PERMANENT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(110,'bdf4ae8c-f594-11ef-9748-0200a013a61c',112,'02.159.190922','2022-09-19','2024-09-19','CONTRACT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(111,'bdf64918-f594-11ef-8b8c-0200a013a61c',113,'02.167.160223','2023-02-16','2025-02-16','CONTRACT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(112,'bdf7cb26-f594-11ef-8ffa-0200a013a61c',114,'02.137.180618','2018-06-18',NULL,'PERMANENT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(113,'bdf9762e-f594-11ef-a577-0200a013a61c',115,'02.173.300123','2023-01-30','2025-06-20','CONTRACT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(114,'bdfb2a6e-f594-11ef-8d0a-0200a013a61c',116,'06.037.010617','2017-06-01',NULL,'PERMANENT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(115,'bdfce854-f594-11ef-819b-0200a013a61c',117,'02.175.280824','2024-08-28','2025-08-27','CONTRACT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(116,'bdfe00b8-f594-11ef-b64f-0200a013a61c',118,'05.176.220724','2024-07-22','2025-06-20','CONTRACT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(117,'bdffca42-f594-11ef-b247-0200a013a61c',119,'06.085.050824','2024-08-05','2027-06-20','CONTRACT','2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(118,'412425e0-f7bf-11ef-8bdb-0200a013a61c',120,'000.000.000001','2025-02-03','2026-02-03','PROBATION','2025-03-02 23:37:07','2025-03-02 23:38:25',NULL);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_datetime` datetime NOT NULL,
  `end_datetime` datetime NOT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `events_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experiences`
--

DROP TABLE IF EXISTS `experiences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `experiences` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint(20) unsigned NOT NULL,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `institution` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `reason_out` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `experiences_uuid_unique` (`uuid`),
  KEY `experiences_profile_id_foreign` (`profile_id`),
  CONSTRAINT `experiences_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experiences`
--

LOCK TABLES `experiences` WRITE;
/*!40000 ALTER TABLE `experiences` DISABLE KEYS */;
/*!40000 ALTER TABLE `experiences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extracurricular_objective_categories`
--

DROP TABLE IF EXISTS `extracurricular_objective_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extracurricular_objective_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `extracurricular_id` bigint(20) unsigned NOT NULL,
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `extracurricular_objective_categories_uuid_unique` (`uuid`),
  KEY `extracurricular_objective_categories_extracurricular_id_foreign` (`extracurricular_id`),
  KEY `extracurricular_objective_categories_parent_id_foreign` (`parent_id`),
  CONSTRAINT `extracurricular_objective_categories_extracurricular_id_foreign` FOREIGN KEY (`extracurricular_id`) REFERENCES `school_extracurriculars` (`id`),
  CONSTRAINT `extracurricular_objective_categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `extracurricular_objective_categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extracurricular_objective_categories`
--

LOCK TABLES `extracurricular_objective_categories` WRITE;
/*!40000 ALTER TABLE `extracurricular_objective_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `extracurricular_objective_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extracurricular_objectives`
--

DROP TABLE IF EXISTS `extracurricular_objectives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extracurricular_objectives` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `extracurricular_id` bigint(20) unsigned NOT NULL,
  `category_id` bigint(20) unsigned NOT NULL,
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  `school_year_id` bigint(20) unsigned DEFAULT NULL,
  `title` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `narrative` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `extracurricular_objectives_uuid_unique` (`uuid`),
  KEY `extracurricular_objectives_extracurricular_id_foreign` (`extracurricular_id`),
  KEY `extracurricular_objectives_category_id_foreign` (`category_id`),
  KEY `extracurricular_objectives_parent_id_foreign` (`parent_id`),
  KEY `extracurricular_objectives_school_year_id_foreign` (`school_year_id`),
  CONSTRAINT `extracurricular_objectives_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `extracurricular_objective_categories` (`id`),
  CONSTRAINT `extracurricular_objectives_extracurricular_id_foreign` FOREIGN KEY (`extracurricular_id`) REFERENCES `school_extracurriculars` (`id`),
  CONSTRAINT `extracurricular_objectives_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `extracurricular_objectives` (`id`),
  CONSTRAINT `extracurricular_objectives_school_year_id_foreign` FOREIGN KEY (`school_year_id`) REFERENCES `school_years` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extracurricular_objectives`
--

LOCK TABLES `extracurricular_objectives` WRITE;
/*!40000 ALTER TABLE `extracurricular_objectives` DISABLE KEYS */;
/*!40000 ALTER TABLE `extracurricular_objectives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extracurricular_rubric_scales`
--

DROP TABLE IF EXISTS `extracurricular_rubric_scales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extracurricular_rubric_scales` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rubric_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` decimal(8,2) NOT NULL,
  `narrative` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `extracurricular_rubric_scales_uuid_unique` (`uuid`),
  KEY `extracurricular_rubric_scales_rubric_id_foreign` (`rubric_id`),
  CONSTRAINT `extracurricular_rubric_scales_rubric_id_foreign` FOREIGN KEY (`rubric_id`) REFERENCES `extracurricular_rubrics` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extracurricular_rubric_scales`
--

LOCK TABLES `extracurricular_rubric_scales` WRITE;
/*!40000 ALTER TABLE `extracurricular_rubric_scales` DISABLE KEYS */;
/*!40000 ALTER TABLE `extracurricular_rubric_scales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extracurricular_rubrics`
--

DROP TABLE IF EXISTS `extracurricular_rubrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extracurricular_rubrics` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `extracurricular_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `extracurricular_rubrics_uuid_unique` (`uuid`),
  KEY `extracurricular_rubrics_extracurricular_id_foreign` (`extracurricular_id`),
  CONSTRAINT `extracurricular_rubrics_extracurricular_id_foreign` FOREIGN KEY (`extracurricular_id`) REFERENCES `school_extracurriculars` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extracurricular_rubrics`
--

LOCK TABLES `extracurricular_rubrics` WRITE;
/*!40000 ALTER TABLE `extracurricular_rubrics` DISABLE KEYS */;
/*!40000 ALTER TABLE `extracurricular_rubrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extracurricular_threshold_narratives`
--

DROP TABLE IF EXISTS `extracurricular_threshold_narratives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extracurricular_threshold_narratives` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `threshold_id` bigint(20) unsigned NOT NULL,
  `value` decimal(8,2) NOT NULL,
  `narrative` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `extracurricular_threshold_narratives_uuid_unique` (`uuid`),
  KEY `extracurricular_threshold_narratives_threshold_id_foreign` (`threshold_id`),
  CONSTRAINT `extracurricular_threshold_narratives_threshold_id_foreign` FOREIGN KEY (`threshold_id`) REFERENCES `extracurricular_thresholds` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extracurricular_threshold_narratives`
--

LOCK TABLES `extracurricular_threshold_narratives` WRITE;
/*!40000 ALTER TABLE `extracurricular_threshold_narratives` DISABLE KEYS */;
/*!40000 ALTER TABLE `extracurricular_threshold_narratives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extracurricular_threshold_scales`
--

DROP TABLE IF EXISTS `extracurricular_threshold_scales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extracurricular_threshold_scales` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `threshold_id` bigint(20) unsigned NOT NULL,
  `value` decimal(8,2) NOT NULL,
  `predicate` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `narrative` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `extracurricular_threshold_scales_uuid_unique` (`uuid`),
  KEY `extracurricular_threshold_scales_threshold_id_foreign` (`threshold_id`),
  CONSTRAINT `extracurricular_threshold_scales_threshold_id_foreign` FOREIGN KEY (`threshold_id`) REFERENCES `extracurricular_thresholds` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extracurricular_threshold_scales`
--

LOCK TABLES `extracurricular_threshold_scales` WRITE;
/*!40000 ALTER TABLE `extracurricular_threshold_scales` DISABLE KEYS */;
/*!40000 ALTER TABLE `extracurricular_threshold_scales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extracurricular_thresholds`
--

DROP TABLE IF EXISTS `extracurricular_thresholds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extracurricular_thresholds` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `extracurricular_id` bigint(20) unsigned NOT NULL,
  `school_year_id` bigint(20) unsigned DEFAULT NULL,
  `minimum_value` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `extracurricular_thresholds_uuid_unique` (`uuid`),
  KEY `extracurricular_thresholds_extracurricular_id_foreign` (`extracurricular_id`),
  KEY `extracurricular_thresholds_school_year_id_foreign` (`school_year_id`),
  CONSTRAINT `extracurricular_thresholds_extracurricular_id_foreign` FOREIGN KEY (`extracurricular_id`) REFERENCES `school_extracurriculars` (`id`),
  CONSTRAINT `extracurricular_thresholds_school_year_id_foreign` FOREIGN KEY (`school_year_id`) REFERENCES `school_years` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extracurricular_thresholds`
--

LOCK TABLES `extracurricular_thresholds` WRITE;
/*!40000 ALTER TABLE `extracurricular_thresholds` DISABLE KEYS */;
/*!40000 ALTER TABLE `extracurricular_thresholds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `families`
--

DROP TABLE IF EXISTS `families`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `families` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `relation` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `national_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birth_place` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birth_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `religion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `languages` json DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `education` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `occupation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `families_uuid_unique` (`uuid`),
  KEY `families_profile_id_foreign` (`profile_id`),
  CONSTRAINT `families_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `families`
--

LOCK TABLES `families` WRITE;
/*!40000 ALTER TABLE `families` DISABLE KEYS */;
INSERT INTO `families` VALUES (1,'d7e3b5b6-fe1a-11ef-8e9e-0200a013a61c',121,'-',NULL,'FATHER','-',NULL,NULL,NULL,NULL,'-',NULL,NULL,'-','2025-03-11 01:47:51','2025-03-11 01:47:51',NULL),(2,'d7e40386-fe1a-11ef-bf04-0200a013a61c',121,'-',NULL,'MOTHER','-',NULL,NULL,NULL,NULL,'-',NULL,NULL,'-','2025-03-11 01:47:51','2025-03-11 01:47:51',NULL),(3,'e10d7850-fee9-11ef-b700-0200a013a61c',125,'-',NULL,'FATHER','-',NULL,NULL,NULL,NULL,'-',NULL,NULL,'-','2025-03-12 02:29:52','2025-03-12 02:29:52',NULL),(4,'e10dcaa8-fee9-11ef-b8dd-0200a013a61c',125,'-',NULL,'MOTHER','-',NULL,NULL,NULL,NULL,'-',NULL,NULL,'-','2025-03-12 02:29:52','2025-03-12 02:29:52',NULL),(5,'e10eb4e0-fee9-11ef-b583-0200a013a61c',126,'-',NULL,'FATHER','-',NULL,NULL,NULL,NULL,'-',NULL,NULL,'-','2025-03-12 02:29:52','2025-03-12 02:29:52',NULL),(6,'e10ef4dc-fee9-11ef-9ee3-0200a013a61c',126,'-',NULL,'MOTHER','-',NULL,NULL,NULL,NULL,'-',NULL,NULL,'-','2025-03-12 02:29:52','2025-03-12 02:29:52',NULL),(11,'4bc89dd8-0934-11f0-817e-0242ac140002',129,'Welly',NULL,'FATHER','83423940350',NULL,NULL,NULL,'[]','8402850294',NULL,NULL,'Karyawan','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(12,'4bc91092-0934-11f0-840f-0242ac140002',129,'Dina',NULL,'MOTHER','49829542',NULL,NULL,NULL,'[]','0945824582',NULL,NULL,'Kepala sekolah','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(13,'4bca23f6-0934-11f0-8a5a-0242ac140002',130,'ALLEND GLEND PUNU',NULL,'FATHER','6471041312930001',NULL,NULL,NULL,'[]','082154580446',NULL,NULL,'KARYAWAN SWASTA','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(14,'4bca4c32-0934-11f0-ab1a-0242ac140002',130,'FONNY MAGDALENA SIWU',NULL,'MOTHER','6471046703950003',NULL,NULL,NULL,'[]','081254645273',NULL,NULL,'KARYAWAN SWASTA','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(15,'4bcaf6b4-0934-11f0-afed-0242ac140002',131,'CHRIST HENDRA YUDI',NULL,'FATHER','3175073004830003',NULL,NULL,NULL,'[]','082199319993',NULL,NULL,'PNS','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(16,'4bcb2bd4-0934-11f0-8707-0242ac140002',131,'ASRINA MARINA',NULL,'MOTHER','3175074208861001',NULL,NULL,NULL,'[]','08118428208',NULL,NULL,'PNS','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(17,'4bcba7da-0934-11f0-b99a-0242ac140002',132,'JON PRIA PANGIHUTAN SARAGIH',NULL,'FATHER','1208272807860001',NULL,NULL,NULL,'[]','081377448888',NULL,NULL,'WIRASWASTA','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(18,'4bcbd69c-0934-11f0-8427-0242ac140002',132,'ERPIANA PURBA',NULL,'MOTHER','1208274107890001',NULL,NULL,NULL,'[]','081348299333',NULL,NULL,'IRT','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(19,'4bcc5de2-0934-11f0-921a-0242ac140002',133,'TAN, HENDRY KRISTIAN TANDRYUS',NULL,'FATHER','6471022902880003',NULL,NULL,NULL,'[]','08115444388',NULL,NULL,'KARYAWAN SWASTA','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(20,'4bcc83ee-0934-11f0-8677-0242ac140002',133,'GRACAI CAROLINE',NULL,'MOTHER','3513146501910003',NULL,NULL,NULL,'[]','08115425177',NULL,NULL,'IRT','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(21,'4bcd0b0c-0934-11f0-9fac-0242ac140002',134,'HARDY CITRA',NULL,'FATHER','1271150305890001',NULL,NULL,NULL,'[]','081397911789',NULL,NULL,'WIRASWASTA','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(22,'4bcd3a28-0934-11f0-8a69-0242ac140002',134,'FONNY WATY HARJANTO',NULL,'MOTHER','6472044606900002',NULL,NULL,NULL,'[]','081347725555',NULL,NULL,'IRT','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(23,'4bcdc89e-0934-11f0-9a5a-0242ac140002',135,'SANTIOSO',NULL,'FATHER','3603182607870007',NULL,NULL,NULL,'[]','081316214677',NULL,NULL,'KARYAWAN SWASTA','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(24,'4bcdfa80-0934-11f0-a0e8-0242ac140002',135,'DEWI STEFANI SARI',NULL,'MOTHER','3603185909940001',NULL,NULL,NULL,'[]','085754789023',NULL,NULL,'WIRASWASTA','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(25,'4bce8cde-0934-11f0-9fe8-0242ac140002',136,'OBETNEGO TANDUK',NULL,'FATHER','6471020810770001',NULL,NULL,NULL,'[]','082150589774',NULL,NULL,'KARYAWAN SWASTA','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(26,'4bced0c2-0934-11f0-bfbf-0242ac140002',136,'GRACE LOUISE MARGARETH PONTOH',NULL,'MOTHER','3174105803790003',NULL,NULL,NULL,'[]','081219443310',NULL,NULL,'KARYAWAN SWASTA','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(27,'4bcf7450-0934-11f0-b74f-0242ac140002',137,'ANG, PUTRA SETIAWAN',NULL,'FATHER','6471048109840007',NULL,NULL,NULL,'[]','08130427425',NULL,NULL,'WIRASWASTA','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(28,'4bcfba96-0934-11f0-881f-0242ac140002',137,'TJENG, ELIYANTI PERMATASARI SETIAWAN',NULL,'MOTHER','6471025102840001',NULL,NULL,NULL,'[]','082156661984',NULL,NULL,'IRT','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(29,'4bd06fae-0934-11f0-a158-0242ac140002',138,'YONATAN',NULL,'FATHER','6471032712770001',NULL,NULL,NULL,'[]','08122183340',NULL,NULL,'PNS','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(30,'4bd09ab0-0934-11f0-834a-0242ac140002',138,'YULITA PUNDEWI SETYORINI',NULL,'MOTHER','3310125807790001',NULL,NULL,NULL,'[]','08122183340',NULL,NULL,'DOKTER','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(31,'4bd13344-0934-11f0-a106-0242ac140002',139,'WAWANG ADHIE WIBOWO',NULL,'FATHER','6471040309760003',NULL,NULL,NULL,'[]','08115408081',NULL,NULL,'KARYAWAN SWASTA','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(32,'4bd160a8-0934-11f0-bf95-0242ac140002',139,'RUTH MURWANI DUMASTHARY',NULL,'MOTHER','6471046604780004',NULL,NULL,NULL,'[]','082251608899',NULL,NULL,'KARYAWAN SWASTA','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(33,'4bd1ff68-0934-11f0-993b-0242ac140002',140,'DIMAS EKOSAPUTRO',NULL,'FATHER','6471051905830007',NULL,NULL,NULL,'[]','08115423271',NULL,NULL,'KARYAWAN BUMN','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(34,'4bd232c6-0934-11f0-b05e-0242ac140002',140,'MARIA BIRGITTA BUNGA HAPSARI',NULL,'MOTHER','3515085204850003',NULL,NULL,NULL,'[]','08113430450',NULL,NULL,'IRT','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(35,'4bd2d2da-0934-11f0-bc51-0242ac140002',141,'YERRICO CHRISTANTO',NULL,'FATHER','3573051501910007',NULL,NULL,NULL,'[]','082234919603',NULL,NULL,'KARYAWAN SWASTA','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(36,'4bd302b4-0934-11f0-a0ed-0242ac140002',141,'REINILDIS ATJNA CYNTIA RYNANTA',NULL,'MOTHER','3512074900910004',NULL,NULL,NULL,'[]','082150224040',NULL,NULL,'KARYAWAN SWASTA','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(37,'4bd3872a-0934-11f0-b14f-0242ac140002',142,'DANIEL TUMBUR HASINTONGAN HUTABARAT',NULL,'FATHER','6471052612740004',NULL,NULL,NULL,'[]','081250581732',NULL,NULL,'PNS','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(38,'4bd3c078-0934-11f0-8eb9-0242ac140002',142,'MILKE REYNA RUMAMBI',NULL,'MOTHER','7106044107850008',NULL,NULL,NULL,'[]','085298695500',NULL,NULL,'IRT','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(39,'4bd47dc4-0934-11f0-93a1-0242ac140002',143,'PANCAR FRANSCO',NULL,'FATHER','3275011404890020',NULL,NULL,NULL,'[]','08115444948',NULL,NULL,'KARYAWAN BUMN','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(40,'4bd6572a-0934-11f0-9277-0242ac140002',143,'KARTINI ROLITTA SIBARANI',NULL,'MOTHER','6471055102880006',NULL,NULL,NULL,'[]','08115444947',NULL,NULL,'PNS','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(41,'4bd6ffea-0934-11f0-b27d-0242ac140002',144,'yacobus Setiawan',NULL,'FATHER','2314123123',NULL,NULL,NULL,'[]','8918231830',NULL,NULL,'directur','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(42,'4bd73032-0934-11f0-9559-0242ac140002',144,'feby',NULL,'MOTHER','1231241231',NULL,NULL,NULL,'[]','9982772',NULL,NULL,'Ibu rumah tangga','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(43,'4bd7dbea-0934-11f0-97a1-0242ac140002',145,'Liem Yoel Salim',NULL,'FATHER','6471052406990001',NULL,NULL,NULL,'[]','81256662343',NULL,NULL,'Karyawan Swasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(44,'4bd80426-0934-11f0-896d-0242ac140002',145,'Felia Purnomo',NULL,'MOTHER','3578266401980003',NULL,NULL,NULL,'[]','895342431450',NULL,NULL,'IRT','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(45,'4bd8a2be-0934-11f0-b271-0242ac140002',146,'Jacky Chan',NULL,'FATHER','6471041801950002',NULL,NULL,NULL,'[]','08115907778',NULL,NULL,'Wiraswasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(46,'4bd8cc44-0934-11f0-aff0-0242ac140002',146,'Lie Chintia',NULL,'MOTHER','6471034701960005',NULL,NULL,NULL,'[]','085654751710',NULL,NULL,'IRT','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(47,'4bd95aec-0934-11f0-88e3-0242ac140002',147,'Pankrasius Guspa Ariyanto',NULL,'FATHER','3312071205980001',NULL,NULL,NULL,'[]','081285187726',NULL,NULL,'Karyawan Swasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(48,'4bd9840e-0934-11f0-9e5d-0242ac140002',147,'Loed Devine Abigail',NULL,'MOTHER','3171064608970001',NULL,NULL,NULL,'[]','082233839057',NULL,NULL,'Karyawan Swasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(49,'4bda0d66-0934-11f0-9a4d-0242ac140002',148,'Andre Lauw',NULL,'FATHER','6471052804920007',NULL,NULL,NULL,'[]','081254766001',NULL,NULL,'Wiraswasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(50,'4bda34ee-0934-11f0-84c1-0242ac140002',148,'Monica Oktavia Tjio',NULL,'MOTHER','6471054310950006',NULL,NULL,NULL,'[]','082234207605',NULL,NULL,'Wiraswasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(51,'4bdacd00-0934-11f0-8a04-0242ac140002',149,'Lim, Leondy Halim',NULL,'FATHER','6471041406890004',NULL,NULL,NULL,'[]','085101675889',NULL,NULL,'Wirausaha','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(52,'4bdaf85c-0934-11f0-acf1-0242ac140002',149,'Sheny Cuardi Tjoa',NULL,'MOTHER','6471055101940001',NULL,NULL,NULL,'[]','081952588918',NULL,NULL,'IRT','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(53,'4bdb7e94-0934-11f0-a7f6-0242ac140002',150,'Johannes Gunawan Sirait',NULL,'FATHER','1271072410870001',NULL,NULL,NULL,'[]','082218838888',NULL,NULL,'Karyawan BUMN','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(54,'4bdbb1e8-0934-11f0-afe1-0242ac140002',150,'Dewi Febriany Sidauruk',NULL,'MOTHER','1272014402930001',NULL,NULL,NULL,'[]','08115906622',NULL,NULL,'IRT','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(55,'4bdcc02e-0934-11f0-bafa-0242ac140002',151,'Angelis Andreas Gama',NULL,'FATHER','6471031303850003',NULL,NULL,NULL,'[]','081388718718',NULL,NULL,'Guru','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(56,'4bdd2d2a-0934-11f0-802a-0242ac140002',151,'Tirsa Ester Amanda Koroh',NULL,'MOTHER','\'6471056709920004',NULL,NULL,NULL,'[]','087761168928',NULL,NULL,'Guru','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(57,'4bddf82c-0934-11f0-98c4-0242ac140002',152,'Samuel Titu',NULL,'FATHER','6471040405570003',NULL,NULL,NULL,'[]','-',NULL,NULL,'Karyawan Swasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(58,'4bde2e8c-0934-11f0-b9df-0242ac140002',152,'Ritha',NULL,'MOTHER','6402064512721001',NULL,NULL,NULL,'[]','085290175375',NULL,NULL,'IRT','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(59,'4bded51c-0934-11f0-90e8-0242ac140002',153,'Adi Syahrial',NULL,'FATHER',NULL,NULL,NULL,NULL,'[]','081254295967',NULL,NULL,'Karyawan Swasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(60,'4bdf0af0-0934-11f0-a0e8-0242ac140002',153,'Sri Haryati',NULL,'MOTHER',NULL,NULL,NULL,NULL,'[]',NULL,NULL,NULL,'Karyawan Swasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(61,'4bdfb798-0934-11f0-8436-0242ac140002',154,'Ferdinand Leonardo Suwasa',NULL,'FATHER',NULL,NULL,NULL,NULL,'[]','081350177594',NULL,NULL,'Karyawan Swasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(62,'4bdff33e-0934-11f0-bf74-0242ac140002',154,'Gloria Siahaan',NULL,'MOTHER','6471030208820004',NULL,NULL,NULL,'[]','08115445880',NULL,NULL,'Karyawan Swasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(63,'4be0881c-0934-11f0-bd38-0242ac140002',155,'Kiki',NULL,'FATHER','1271060201890001',NULL,NULL,NULL,'[]','081370133037',NULL,NULL,'Karyawan Swasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(64,'4be0b1de-0934-11f0-b4e2-0242ac140002',155,'Melda Dwiyanti Kwong',NULL,'MOTHER','647104630920004',NULL,NULL,NULL,'[]','082148654273',NULL,NULL,'IRT','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(65,'4be13fa0-0934-11f0-9eef-0242ac140002',156,'Felik Klesia',NULL,'FATHER','647104-906820003',NULL,NULL,NULL,'[]','08115908585',NULL,NULL,'Wiraswata','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(66,'4be16a98-0934-11f0-99bb-0242ac140002',156,'Elisa Soesilo',NULL,'MOTHER','6471044905820010',NULL,NULL,NULL,'[]','08115989098',NULL,NULL,'Wiraswasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(67,'4be20fa2-0934-11f0-aff4-0242ac140002',157,'Felix Sanjaya Hartady',NULL,'FATHER',NULL,NULL,NULL,NULL,'[]','081385001300',NULL,NULL,'Notaris','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(68,'4be23d6a-0934-11f0-bcb0-0242ac140002',157,'Christiani Gotama',NULL,'MOTHER',NULL,NULL,NULL,NULL,'[]','081363086888',NULL,NULL,'IRT','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(69,'4be2ceec-0934-11f0-bc39-0242ac140002',158,'Yohanes Felix Wijaya',NULL,'FATHER','6471031103960001',NULL,NULL,NULL,'[]','085388882932',NULL,NULL,'Wiraswasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(70,'4be2f6e2-0934-11f0-bd0b-0242ac140002',158,'Sherly',NULL,'MOTHER','7106025404920003',NULL,NULL,NULL,'[]','082157269884',NULL,NULL,'IRT','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(71,'4be38e36-0934-11f0-beda-0242ac140002',159,'Sandra Fransisco Fernandez Panjaitan',NULL,'FATHER','6471041806860008',NULL,NULL,NULL,'[]','-',NULL,NULL,'Karyawan Swasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(72,'4be3c784-0934-11f0-8474-0242ac140002',159,'Elizabet Silaban',NULL,'MOTHER','3204284411920007',NULL,NULL,NULL,'[]','081345250007',NULL,NULL,'Karyawan Swasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(73,'4be455dc-0934-11f0-9f77-0242ac140002',160,'Denson Pardede',NULL,'FATHER','6203011711910003',NULL,NULL,NULL,'[]','085251720515',NULL,NULL,'Karyawan Swasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(74,'4be485ca-0934-11f0-b0b7-0242ac140002',160,'Anjelyn Susanti Purba',NULL,'MOTHER','6409014308910005',NULL,NULL,NULL,'[]','082155196364',NULL,NULL,'Guru','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(75,'4be5013a-0934-11f0-ad79-0242ac140002',161,'Jose Mario',NULL,'FATHER','6402112609900002',NULL,NULL,NULL,'[]','081250650257',NULL,NULL,'Wiraswasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(76,'4be532cc-0934-11f0-af88-0242ac140002',161,'Fatya Indah Marika',NULL,'MOTHER','6472034912950004',NULL,NULL,NULL,'[]','081250660257',NULL,NULL,'IRT','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(77,'4be5c296-0934-11f0-b7a2-0242ac140002',162,'Dian Mastatrianto',NULL,'FATHER',NULL,NULL,NULL,NULL,'[]','08114245111',NULL,NULL,'Wiraswasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(78,'4be5ebcc-0934-11f0-9314-0242ac140002',162,'Opin Ade Patria',NULL,'MOTHER',NULL,NULL,NULL,NULL,'[]','08114245222',NULL,NULL,'Wiraswasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(79,'4be68078-0934-11f0-a5d1-0242ac140002',163,'Andy Christian',NULL,'FATHER','6471031504840003',NULL,NULL,NULL,'[]','081347470315',NULL,NULL,'Karyawan Swasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(80,'4be6a76a-0934-11f0-aa34-0242ac140002',163,'Tjeng, Shindy Chandra',NULL,'MOTHER','6471045103880002',NULL,NULL,NULL,'[]','081253339688',NULL,NULL,'Karyawan Swasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(81,'4be72a82-0934-11f0-9563-0242ac140002',164,'Richard Widya Sengkey',NULL,'FATHER',NULL,NULL,NULL,NULL,'[]','081252997799',NULL,NULL,'Dokter Internis','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(82,'4be75cdc-0934-11f0-a1a6-0242ac140002',164,'The, Veronica Yoshinta',NULL,'MOTHER',NULL,NULL,NULL,NULL,'[]','0811598633',NULL,NULL,'Dokter jantung','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(83,'4becad9a-0934-11f0-85af-0242ac140002',165,'Adi Ananto R. Keni',NULL,'FATHER','0000',NULL,NULL,NULL,'[]','085250715275',NULL,NULL,'Pegawai BUMN','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(84,'4becde14-0934-11f0-8af3-0242ac140002',165,'Kirana Putri Karunia Tatoto',NULL,'MOTHER','0000',NULL,NULL,NULL,'[]','082227206688',NULL,NULL,'Ibu Rumah Tangga','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(85,'4bed81de-0934-11f0-9dc1-0242ac140002',166,'Tjhin Puk Sin',NULL,'FATHER','000',NULL,NULL,NULL,'[]','087886113045',NULL,NULL,'Wiraswasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(86,'4bedc130-0934-11f0-a4c0-0242ac140002',166,'Novianty',NULL,'MOTHER','000',NULL,NULL,NULL,'[]','085820224771',NULL,NULL,'Ibu Rumah Tangga','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(87,'4bee637e-0934-11f0-a985-0242ac140002',167,'Antony Chandra Tjan',NULL,'FATHER','000',NULL,NULL,NULL,'[]','0811532950',NULL,NULL,'Wiraswasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(88,'4beea47e-0934-11f0-8786-0242ac140002',167,'Lili Lauw',NULL,'MOTHER','000',NULL,NULL,NULL,'[]','085652022228',NULL,NULL,'IRT','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(89,'4bef5694-0934-11f0-8a23-0242ac140002',168,'Ign. Tigor Marihot Sinurat',NULL,'FATHER','000',NULL,NULL,NULL,'[]','081314302397',NULL,NULL,'Wiraswasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(90,'4bef9262-0934-11f0-be3a-0242ac140002',168,'wenny Hariaty Situmorang',NULL,'MOTHER','000',NULL,NULL,NULL,'[]','085222706972',NULL,NULL,'IRT','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(91,'4bf03b0e-0934-11f0-82c0-0242ac140002',169,'Parwoto',NULL,'FATHER','0000',NULL,NULL,NULL,'[]','081347083643',NULL,NULL,'Karyawan Swasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(92,'4bf06e80-0934-11f0-8ec3-0242ac140002',169,'Dwi Anggarini',NULL,'MOTHER','0000',NULL,NULL,NULL,'[]','08115353053',NULL,NULL,'Ibu Rumah Tangga','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(93,'4bf0f832-0934-11f0-becd-0242ac140002',170,'Rahmat Dianto',NULL,'FATHER','0000',NULL,NULL,NULL,'[]','082148674506',NULL,NULL,'Wiraswasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(94,'4bf11f42-0934-11f0-845c-0242ac140002',170,'Varianidia Veterini',NULL,'MOTHER','0000',NULL,NULL,NULL,'[]','082140955471',NULL,NULL,'Ibu Rumah Tangga','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(95,'4bf1bb00-0934-11f0-9886-0242ac140002',171,'Sarmauli Richie Albert Pakpahan',NULL,'FATHER','0000',NULL,NULL,NULL,'[]','08115402889',NULL,NULL,'Karyawan Swasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(96,'4bf1f75a-0934-11f0-9a92-0242ac140002',171,'Ramot Mayanti Valentina Sianturi',NULL,'MOTHER','0000',NULL,NULL,NULL,'[]','081362004492',NULL,NULL,'Ibu Rumah Tangga','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(97,'4bf2a1f0-0934-11f0-abe2-0242ac140002',172,'Deonesius Josia',NULL,'FATHER','000',NULL,NULL,NULL,'[]','085228829677',NULL,NULL,'Karyawan Swasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(98,'4bf2d0bc-0934-11f0-9cc3-0242ac140002',172,'Christine Charismawaty',NULL,'MOTHER','000',NULL,NULL,NULL,'[]','081808651949',NULL,NULL,'Ibu Rumah Tangga','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(99,'4bf35d34-0934-11f0-bf8c-0242ac140002',173,'Elfan',NULL,'FATHER','0000',NULL,NULL,NULL,'[]','000',NULL,NULL,'000','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(100,'4bf38e80-0934-11f0-82f0-0242ac140002',173,'Yuvita',NULL,'MOTHER','0000',NULL,NULL,NULL,'[]','0000',NULL,NULL,'0000','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(101,'4bf41fee-0934-11f0-a606-0242ac140002',174,'Manogar Sinaga',NULL,'FATHER','000',NULL,NULL,NULL,'[]','000',NULL,NULL,'000','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(102,'4bf451b2-0934-11f0-a366-0242ac140002',174,'Melysa Wati Bukarakombang',NULL,'MOTHER','000',NULL,NULL,NULL,'[]','000',NULL,NULL,'000','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(103,'4bf520b0-0934-11f0-a5d1-0242ac140002',175,'Andrias Susanto Nugroho',NULL,'FATHER','6471032803780004',NULL,NULL,NULL,'[]','082276197999',NULL,NULL,'POLRI','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(104,'4bf55e9a-0934-11f0-93db-0242ac140002',175,'Simatupang, Hamaria Mendrofa',NULL,'MOTHER','6471034503810003',NULL,NULL,NULL,'[]','08115808880',NULL,NULL,'Wiraswasta','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL);
/*!40000 ALTER TABLE `families` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faqs`
--

DROP TABLE IF EXISTS `faqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faqs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_number` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `faqs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faqs`
--

LOCK TABLES `faqs` WRITE;
/*!40000 ALTER TABLE `faqs` DISABLE KEYS */;
/*!40000 ALTER TABLE `faqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `galleries`
--

DROP TABLE IF EXISTS `galleries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `galleries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `galleries_uuid_unique` (`uuid`),
  UNIQUE KEY `galleries_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `galleries`
--

LOCK TABLES `galleries` WRITE;
/*!40000 ALTER TABLE `galleries` DISABLE KEYS */;
/*!40000 ALTER TABLE `galleries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gallery_items`
--

DROP TABLE IF EXISTS `gallery_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gallery_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gallery_id` bigint(20) unsigned NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_thumbnail` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gallery_items_uuid_unique` (`uuid`),
  KEY `gallery_items_gallery_id_foreign` (`gallery_id`),
  CONSTRAINT `gallery_items_gallery_id_foreign` FOREIGN KEY (`gallery_id`) REFERENCES `galleries` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gallery_items`
--

LOCK TABLES `gallery_items` WRITE;
/*!40000 ALTER TABLE `gallery_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `gallery_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `honor_prizes`
--

DROP TABLE IF EXISTS `honor_prizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `honor_prizes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `award_date` date NOT NULL,
  `institution` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `honor_prizes_uuid_unique` (`uuid`),
  KEY `honor_prizes_profile_id_foreign` (`profile_id`),
  CONSTRAINT `honor_prizes_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `honor_prizes`
--

LOCK TABLES `honor_prizes` WRITE;
/*!40000 ALTER TABLE `honor_prizes` DISABLE KEYS */;
/*!40000 ALTER TABLE `honor_prizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_skills`
--

DROP TABLE IF EXISTS `language_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language_skills` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reading` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `writing` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `speaking` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `language_skills_uuid_unique` (`uuid`),
  KEY `language_skills_profile_id_foreign` (`profile_id`),
  CONSTRAINT `language_skills_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_skills`
--

LOCK TABLES `language_skills` WRITE;
/*!40000 ALTER TABLE `language_skills` DISABLE KEYS */;
/*!40000 ALTER TABLE `language_skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_objective_categories`
--

DROP TABLE IF EXISTS `learning_objective_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `learning_objective_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_curriculum_id` bigint(20) unsigned NOT NULL,
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `learning_objective_categories_uuid_unique` (`uuid`),
  KEY `learning_objective_categories_school_curriculum_id_foreign` (`school_curriculum_id`),
  KEY `learning_objective_categories_parent_id_foreign` (`parent_id`),
  CONSTRAINT `learning_objective_categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `learning_objective_categories` (`id`),
  CONSTRAINT `learning_objective_categories_school_curriculum_id_foreign` FOREIGN KEY (`school_curriculum_id`) REFERENCES `school_curriculums` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_objective_categories`
--

LOCK TABLES `learning_objective_categories` WRITE;
/*!40000 ALTER TABLE `learning_objective_categories` DISABLE KEYS */;
INSERT INTO `learning_objective_categories` VALUES (1,'4bf6ffde-0934-11f0-9607-0242ac140002',1,NULL,'Capaian Pembelajaran','CP','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": true, \"scope_school_subject\": true}','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(2,'4bf7372e-0934-11f0-970a-0242ac140002',1,1,'Tujuan Pembelajaran','TP','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": true, \"scope_school_subject\": true}','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(3,'4bf7750e-0934-11f0-b58f-0242ac140002',1,NULL,'Ruang Lingkup Pembelajaran','RLP','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": true, \"scope_school_subject\": true}','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(4,'4bfc284c-0934-11f0-bdc4-0242ac140002',2,NULL,'Capaian Pembelajaran','CP','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": true, \"scope_school_subject\": true}','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(5,'4bfcade4-0934-11f0-85dd-0242ac140002',2,4,'Tujuan Pembelajaran','TP','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": true, \"scope_school_subject\": true}','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(6,'4bfcdf9e-0934-11f0-b121-0242ac140002',2,4,'Alur Tujuan Pembelajaran','ATP','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": true, \"scope_school_subject\": true}','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(7,'4d5256e4-0934-11f0-9008-0242ac140002',3,NULL,'CAPAIAN PEMBELAJARAN','CP','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": true, \"scope_school_subject\": true}','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(8,'4d5289f2-0934-11f0-a715-0242ac140002',3,7,'TUJUAN PEMBELAJARAN - 1','TP-1','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": true, \"scope_school_subject\": true}','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(9,'4d6cf76a-0934-11f0-a7b7-0242ac140002',4,NULL,'Capaian Pembelajaran','CP','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": true, \"scope_school_subject\": true}','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(10,'4d6d9f8a-0934-11f0-9980-0242ac140002',4,9,'Tujuan Pembelajaran','TP','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": true, \"scope_school_subject\": true}','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(11,'4d6e7b8a-0934-11f0-8e24-0242ac140002',4,NULL,'Ruang Lingkup Pembelajaran','RLP','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": true, \"scope_school_subject\": true}','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(12,'4d7a507c-0934-11f0-811d-0242ac140002',5,NULL,'Capaian Pembelajaran','CP','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": true, \"scope_school_subject\": true}','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(13,'4d7ac066-0934-11f0-a10f-0242ac140002',5,12,'Tujuan Pembelajaran','TP','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": true, \"scope_school_subject\": true}','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(14,'4d7b4b08-0934-11f0-a410-0242ac140002',5,NULL,'Learning Objective','LO','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": false, \"scope_school_subject\": true}','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(15,'4d7bc10a-0934-11f0-ba7f-0242ac140002',5,NULL,'Tujuan Pembelajaran P5','P5','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": false, \"scope_school_subject\": true}','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(16,'4d8e5658-0934-11f0-bba6-0242ac140002',6,NULL,'Capaian Pembelajaran','CP','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": true, \"scope_school_subject\": true}','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(17,'4d8efb08-0934-11f0-95d3-0242ac140002',6,16,'Tujuan Pembelajaran','TP','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": true, \"scope_school_subject\": true}','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(18,'4d8f39e2-0934-11f0-a2b3-0242ac140002',6,NULL,'Ruang Lingkup Pembelajaran','RLP','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": true, \"scope_school_subject\": true}','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(19,'4d9505a2-0934-11f0-a2ae-0242ac140002',7,NULL,'Capaian Pembelajaran KM','CP','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": true, \"scope_school_subject\": true}','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(20,'4d9541a2-0934-11f0-a39c-0242ac140002',7,19,'Tujuan Pembelajaran KM','TP','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": true, \"scope_school_subject\": true}','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(21,'4d956e7a-0934-11f0-8678-0242ac140002',7,NULL,'Learning Objective','LO','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": false, \"scope_school_subject\": true}','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(22,'4d959576-0934-11f0-ac89-0242ac140002',7,NULL,'Tujuan Pembelajaran P5','TP P5','{\"scope_school_year\": true, \"scope_school_grade\": true, \"scope_school_phase\": false, \"scope_school_subject\": true}','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL);
/*!40000 ALTER TABLE `learning_objective_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_objectives`
--

DROP TABLE IF EXISTS `learning_objectives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `learning_objectives` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_curriculum_id` bigint(20) unsigned NOT NULL,
  `category_id` bigint(20) unsigned NOT NULL,
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  `school_year_id` bigint(20) unsigned DEFAULT NULL,
  `school_phase_id` bigint(20) unsigned DEFAULT NULL,
  `school_grade_id` bigint(20) unsigned DEFAULT NULL,
  `school_subject_id` bigint(20) unsigned DEFAULT NULL,
  `title` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `narrative` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `learning_objectives_uuid_unique` (`uuid`),
  KEY `learning_objectives_school_curriculum_id_foreign` (`school_curriculum_id`),
  KEY `learning_objectives_category_id_foreign` (`category_id`),
  KEY `learning_objectives_parent_id_foreign` (`parent_id`),
  KEY `learning_objectives_school_year_id_foreign` (`school_year_id`),
  KEY `learning_objectives_school_phase_id_foreign` (`school_phase_id`),
  KEY `learning_objectives_school_grade_id_foreign` (`school_grade_id`),
  KEY `learning_objectives_school_subject_id_foreign` (`school_subject_id`),
  CONSTRAINT `learning_objectives_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `learning_objective_categories` (`id`),
  CONSTRAINT `learning_objectives_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `learning_objectives` (`id`),
  CONSTRAINT `learning_objectives_school_curriculum_id_foreign` FOREIGN KEY (`school_curriculum_id`) REFERENCES `school_curriculums` (`id`),
  CONSTRAINT `learning_objectives_school_grade_id_foreign` FOREIGN KEY (`school_grade_id`) REFERENCES `school_grades` (`id`),
  CONSTRAINT `learning_objectives_school_phase_id_foreign` FOREIGN KEY (`school_phase_id`) REFERENCES `school_phases` (`id`),
  CONSTRAINT `learning_objectives_school_subject_id_foreign` FOREIGN KEY (`school_subject_id`) REFERENCES `school_subjects` (`id`),
  CONSTRAINT `learning_objectives_school_year_id_foreign` FOREIGN KEY (`school_year_id`) REFERENCES `school_years` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=730 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_objectives`
--

LOCK TABLES `learning_objectives` WRITE;
/*!40000 ALTER TABLE `learning_objectives` DISABLE KEYS */;
INSERT INTO `learning_objectives` VALUES (1,'4bfdbf9a-0934-11f0-8d06-0242ac140002',2,4,NULL,1,1,1,2,'Nilai Agama Moral Dan Budi Pekerti','NAMB','Peserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(2,'4bfe72d2-0934-11f0-9354-0242ac140002',2,4,NULL,1,1,1,3,'Jati Diri','JT','Peserta didik diharapkan mampu mengenali, mengekspresikan, dan mengelola emosi diri serta membangun hubungan sosial secara sehat. Mengenal dan memiliki perilaku positif terhadap diri dan lingkungan (keluarga, sekolah, masyarakat, negara, dan dunia) serta rasa bangga sebagai anak Indonesia yang berlandaskan Pancasila. Menyesuaikan diri dengan lingkungan, aturan, dan norma yang berlaku.Menggunakan fungsi gerak (motorik kasar, halus, dan taktil) untuk mengeksplorasi dan memanipulasi berbagai objek dan lingkungan sekitar sebagai bentuk pengembangan diri.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(3,'4bff1e12-0934-11f0-9eab-0242ac140002',2,4,NULL,1,1,1,4,'Dasar-Dasar Literasi Dan STEAM','STEAM-L','Peserta didik diharapkan mampu mengenali dan memahami berbagai informasi, mengkomunikasikan perasaan dan pikiran secara lisan, tulisan, atau berbagai media, serta membangun percakapan.Menujukkan minat, kegemaran, dan berpartisipasi dalam kegaitan Pra membaca dan pra menulis.Mengenali mengunakan konsep pra matematika untuk memecahkan masalah di dalam kehidupan sehari-hari. Menunjukkan kemampuan dasar berpikir Kritis, kreatif, dan kolaboratif. Menunjukkan rasa ingin tahu melalui observasi, eksplorasi, dan eksprimen dengan menggunakan lingkungan sekitar dan media sebagai sumber belajar, untuk mendapatkan gagasan mengenai fenomena alam dan sosial. Menunjukkan kemampuan awal menggunakan dan merakayasa teknologi sederhana, untuk mencari informasi, dan gagasan, dan keterampilan secara aman dan bertanggung jawab. Mengeksplorasi berbagai proses seni, mengekspresikannnya serta mengapresiasi.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(4,'4bffc1fa-0934-11f0-9ec7-0242ac140002',2,5,3,1,1,1,4,'Menggunakan sebuah benda sesuai fungsinya','PG A-SBP-STEAML-002','Menggunakan sebuah benda sesuai fungsinya','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(5,'4c006a88-0934-11f0-85af-0242ac140002',2,4,NULL,1,1,1,5,'Nilai Agama Dan Budi Pekerti','NAMB','Peserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(6,'4c00e9c2-0934-11f0-90cd-0242ac140002',2,4,NULL,1,1,1,5,'Jati Diri','JT','Peserta didik diharapkan mampu mengenali, mengekspresikan, dan mengelola emosi diri serta membangun hubungan sosial secara sehat. Mengenal dan memiliki perilaku positif terhadap diri dan lingkungan (keluarga, sekolah, masyarakat, negara, dan dunia) serta rasa bangga sebagai anak Indonesia yang berlandaskan Pancasila. Menyesuaikan diri dengan lingkungan, aturan, dan norma yang berlaku.Menggunakan fungsi gerak (motorik kasar, halus, dan taktil) untuk mengeksplorasi dan memanipulasi berbagai objek dan lingkungan sekitar sebagai bentuk pengembangan diri.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(7,'4c019e44-0934-11f0-9c4d-0242ac140002',2,4,NULL,1,1,1,5,'Dasar-Dasar Literasi Dan STEAM','STEAM-L','Peserta didik diharapkan mampu mengenali dan memahami berbagai informasi, mengkomunikasikan perasaan dan pikiran secara lisan, tulisan, atau berbagai media, serta membangun percakapan.Menujukkan minat, kegemaran, dan berpartisipasi dalam kegaitan Pra membaca dan pra menulis.Mengenali mengunakan konsep pra matematika untuk memecahkan masalah di dalam kehidupan sehari-hari. Menunjukkan kemampuan dasar berpikir Kritis, kreatif, dan kolaboratif. Menunjukkan rasa ingin tahu melalui observasi, eksplorasi, dan eksprimen dengan menggunakan lingkungan sekitar dan media sebagai sumber belajar, untuk mendapatkan gagasan mengenai fenomena alam dan sosial. Menunjukkan kemampuan awal menggunakan dan merakayasa teknologi sederhana, untuk mencari informasi, dan gagasan, dan keterampilan secara aman dan bertanggung jawab. Mengeksplorasi berbagai proses seni, mengekspresikannnya serta mengapresiasi.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(8,'4c0234da-0934-11f0-afd9-0242ac140002',2,4,NULL,1,1,1,9,'Dasar-Dasar Literasi Dan STEAM','STEAM-L','Peserta didik diharapkan mampu mengenali dan memahami berbagai informasi, mengkomunikasikan perasaan dan pikiran secara lisan, tulisan, atau berbagai media, serta membangun percakapan.Menujukkan minat, kegemaran, dan berpartisipasi dalam kegaitan Pra membaca dan pra menulis.Mengenali mengunakan konsep pra matematika untuk memecahkan masalah di dalam kehidupan sehari-hari. Menunjukkan kemampuan dasar berpikir Kritis, kreatif, dan kolaboratif. Menunjukkan rasa ingin tahu melalui observasi, eksplorasi, dan eksprimen dengan menggunakan lingkungan sekitar dan media sebagai sumber belajar, untuk mendapatkan gagasan mengenai fenomena alam dan sosial. Menunjukkan kemampuan awal menggunakan dan merakayasa teknologi sederhana, untuk mencari informasi, dan gagasan, dan keterampilan secara aman dan bertanggung jawab. Mengeksplorasi berbagai proses seni, mengekspresikannnya serta mengapresiasi.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(9,'4c02c602-0934-11f0-b2b8-0242ac140002',2,5,8,1,1,1,9,'Bernyanyi lagu \"Kalau kau suka hati\" (Pegang mata, telinga, kaki, mulut, dll)','PGA-SS-STEAML-004','Bernyanyi lagu \"Kalau kau suka hati\" (Pegang mata, telinga, kaki, mulut, dll)','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(10,'4c036dfa-0934-11f0-9308-0242ac140002',2,4,NULL,1,1,1,10,'Nilai Agama Dan Budi Pekerti','NAMB','Peserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(11,'4c03fb62-0934-11f0-b210-0242ac140002',2,4,NULL,1,1,1,10,'Jati Diri','JT','Peserta didik diharapkan mampu mengenali, mengekspresikan, dan mengelola emosi diri serta membangun hubungan sosial secara sehat. Mengenal dan memiliki perilaku positif terhadap diri dan lingkungan (keluarga, sekolah, masyarakat, negara, dan dunia) serta rasa bangga sebagai anak Indonesia yang berlandaskan Pancasila. Menyesuaikan diri dengan lingkungan, aturan, dan norma yang berlaku.Menggunakan fungsi gerak (motorik kasar, halus, dan taktil) untuk mengeksplorasi dan memanipulasi berbagai objek dan lingkungan sekitar sebagai bentuk pengembangan diri.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(12,'4c049388-0934-11f0-a8f6-0242ac140002',2,4,NULL,1,1,1,10,'Dasar-Dasar Literasi Dan STEAM','STEAM-L','Peserta didik diharapkan mampu mengenali dan memahami berbagai informasi, mengkomunikasikan perasaan dan pikiran secara lisan, tulisan, atau berbagai media, serta membangun percakapan.Menujukkan minat, kegemaran, dan berpartisipasi dalam kegaitan Pra membaca dan pra menulis.Mengenali mengunakan konsep pra matematika untuk memecahkan masalah di dalam kehidupan sehari-hari. Menunjukkan kemampuan dasar berpikir Kritis, kreatif, dan kolaboratif. Menunjukkan rasa ingin tahu melalui observasi, eksplorasi, dan eksprimen dengan menggunakan lingkungan sekitar dan media sebagai sumber belajar, untuk mendapatkan gagasan mengenai fenomena alam dan sosial. Menunjukkan kemampuan awal menggunakan dan merakayasa teknologi sederhana, untuk mencari informasi, dan gagasan, dan keterampilan secara aman dan bertanggung jawab. Mengeksplorasi berbagai proses seni, mengekspresikannnya serta mengapresiasi.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(13,'4c053cd4-0934-11f0-b73d-0242ac140002',2,4,NULL,1,1,1,11,'Nilai Agama Dan Budi Pekerti','NAMB','Peserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(14,'4c05e6d4-0934-11f0-9c4d-0242ac140002',2,4,NULL,1,1,1,11,'Jati Diri','JT','Peserta didik diharapkan mampu mengenali, mengekspresikan, dan mengelola emosi diri serta membangun hubungan sosial secara sehat. Mengenal dan memiliki perilaku positif terhadap diri dan lingkungan (keluarga, sekolah, masyarakat, negara, dan dunia) serta rasa bangga sebagai anak Indonesia yang berlandaskan Pancasila. Menyesuaikan diri dengan lingkungan, aturan, dan norma yang berlaku.Menggunakan fungsi gerak (motorik kasar, halus, dan taktil) untuk mengeksplorasi dan memanipulasi berbagai objek dan lingkungan sekitar sebagai bentuk pengembangan diri.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(15,'4c069912-0934-11f0-a8cf-0242ac140002',2,4,NULL,1,1,1,11,'Dasar-Dasar Literasi Dan STEAM','STEAM-L','Peserta didik diharapkan mampu mengenali dan memahami berbagai informasi, mengkomunikasikan perasaan dan pikiran secara lisan, tulisan, atau berbagai media, serta membangun percakapan.Menujukkan minat, kegemaran, dan berpartisipasi dalam kegaitan Pra membaca dan pra menulis.Mengenali mengunakan konsep pra matematika untuk memecahkan masalah di dalam kehidupan sehari-hari. Menunjukkan kemampuan dasar berpikir Kritis, kreatif, dan kolaboratif. Menunjukkan rasa ingin tahu melalui observasi, eksplorasi, dan eksprimen dengan menggunakan lingkungan sekitar dan media sebagai sumber belajar, untuk mendapatkan gagasan mengenai fenomena alam dan sosial. Menunjukkan kemampuan awal menggunakan dan merakayasa teknologi sederhana, untuk mencari informasi, dan gagasan, dan keterampilan secara aman dan bertanggung jawab. Mengeksplorasi berbagai proses seni, mengekspresikannnya serta mengapresiasi.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(16,'4c07564a-0934-11f0-82d9-0242ac140002',2,4,NULL,1,1,1,12,'Nilai Agama Dan Budi Pekerti','NAMB','Peserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(17,'4c07f960-0934-11f0-a9fd-0242ac140002',2,4,NULL,1,1,1,12,'Jati Diri','JT','Peserta didik diharapkan mampu mengenali, mengekspresikan, dan mengelola emosi diri serta membangun hubungan sosial secara sehat. Mengenal dan memiliki perilaku positif terhadap diri dan lingkungan (keluarga, sekolah, masyarakat, negara, dan dunia) serta rasa bangga sebagai anak Indonesia yang berlandaskan Pancasila. Menyesuaikan diri dengan lingkungan, aturan, dan norma yang berlaku.Menggunakan fungsi gerak (motorik kasar, halus, dan taktil) untuk mengeksplorasi dan memanipulasi berbagai objek dan lingkungan sekitar sebagai bentuk pengembangan diri.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(18,'4c0884ac-0934-11f0-8714-0242ac140002',2,4,NULL,1,1,1,12,'Dasar-Dasar Literasi Dan STEAM','STEAM-L','Peserta didik diharapkan mampu mengenali dan memahami berbagai informasi, mengkomunikasikan perasaan dan pikiran secara lisan, tulisan, atau berbagai media, serta membangun percakapan.Menujukkan minat, kegemaran, dan berpartisipasi dalam kegaitan Pra membaca dan pra menulis.Mengenali mengunakan konsep pra matematika untuk memecahkan masalah di dalam kehidupan sehari-hari. Menunjukkan kemampuan dasar berpikir Kritis, kreatif, dan kolaboratif. Menunjukkan rasa ingin tahu melalui observasi, eksplorasi, dan eksprimen dengan menggunakan lingkungan sekitar dan media sebagai sumber belajar, untuk mendapatkan gagasan mengenai fenomena alam dan sosial. Menunjukkan kemampuan awal menggunakan dan merakayasa teknologi sederhana, untuk mencari informasi, dan gagasan, dan keterampilan secara aman dan bertanggung jawab. Mengeksplorasi berbagai proses seni, mengekspresikannnya serta mengapresiasi.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(19,'4c094e8c-0934-11f0-8aba-0242ac140002',2,4,NULL,1,1,2,2,'Nilai Agama Moral dan Budi Pekerti','NAMB','Peserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(20,'4c0a0b60-0934-11f0-8695-0242ac140002',2,4,NULL,1,1,2,9,'Jati Diri','JT','Peserta didik diharapkan mampu mengenali, mengekspresikan, dan mengelola emosi diri serta membangun hubungan sosial secara sehat. Mengenal dan memiliki perilaku positif terhadap diri dan lingkungan (keluarga, sekolah, masyarakat, negara, dan dunia) serta rasa bangga sebagai anak Indonesia yang berlandaskan Pancasila. Menyesuaikan diri dengan lingkungan, aturan, dan norma yang berlaku.Menggunakan fungsi gerak (motorik kasar, halus, dan taktil) untuk mengeksplorasi dan memanipulasi berbagai objek dan lingkungan sekitar sebagai bentuk pengembangan diri.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(21,'4c0aadd6-0934-11f0-9528-0242ac140002',2,4,NULL,1,1,2,9,'Dasar-Dasar Literasi Dan STEAM','STEAM-L','Peserta didik diharapkan mampu mengenali dan memahami berbagai informasi, mengkomunikasikan perasaan dan pikiran secara lisan, tulisan, atau berbagai media, serta membangun percakapan.Menujukkan minat, kegemaran, dan berpartisipasi dalam kegaitan Pra membaca dan pra menulis.Mengenali mengunakan konsep pra matematika untuk memecahkan masalah di dalam kehidupan sehari-hari. Menunjukkan kemampuan dasar berpikir Kritis, kreatif, dan kolaboratif. Menunjukkan rasa ingin tahu melalui observasi, eksplorasi, dan eksprimen dengan menggunakan lingkungan sekitar dan media sebagai sumber belajar, untuk mendapatkan gagasan mengenai fenomena alam dan sosial. Menunjukkan kemampuan awal menggunakan dan merakayasa teknologi sederhana, untuk mencari informasi, dan gagasan, dan keterampilan secara aman dan bertanggung jawab. Mengeksplorasi berbagai proses seni, mengekspresikannnya serta mengapresiasi.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(22,'4c0b4480-0934-11f0-a798-0242ac140002',2,4,NULL,1,1,3,2,'Nilai Agama Moral dan Budi Pekerti','NAMB','Peserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(23,'4c0c1dc4-0934-11f0-bcda-0242ac140002',2,4,NULL,1,1,4,2,'Nilai Agama Moral dan Budi Pekerti','NAMB','Peserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(24,'4c0cb716-0934-11f0-8ddb-0242ac140002',2,5,23,1,1,4,2,'Tahu akan hak nya dalam menunjukkan karakter kesabaran','TKB-SI-NAMB-004','Tahu akan hak nya dalam menunjukkan karakter kesabaran','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(25,'4c0d4e06-0934-11f0-8e0e-0242ac140002',2,5,23,1,1,4,2,'Budi Pekerti pada konteks PAUD meliputi kemampuan anak dalam menghargai diri, sesama manusia, dan alam.','TKB-SI-NAMB-009','Budi Pekerti pada konteks PAUD meliputi kemampuan anak dalam menghargai diri, sesama manusia, dan alam.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(26,'4c0de528-0934-11f0-95ea-0242ac140002',2,5,23,1,1,4,2,'Bertanggung jawab atas perilakunya untuk kebaikan diri sendiri sesuai kemampuan anak','TKB-SI-NAMB-008','Bertanggung jawab atas perilakunya untuk kebaikan diri sendiri sesuai kemampuan anak','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(27,'4c0eacd8-0934-11f0-9c4f-0242ac140002',2,5,23,1,1,4,2,'Mengatur diri sendiri dalam karakter mengampuni','TKB-SI-NAMB-007','Mengatur diri sendiri dalam karakter mengampuni','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(28,'4c0f91de-0934-11f0-b0a6-0242ac140002',2,5,23,1,1,4,2,'Berperilaku jujur kepada orang lain','TKB-SI-NAMB-005','Berperilaku jujur kepada orang lain','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(29,'4c10d346-0934-11f0-a91a-0242ac140002',2,5,23,1,1,4,2,'Mengerjakan ibadah karena bersyukur kepada Tuhan','TKB-SI-NAMB-006','Mengerjakan ibadah karena bersyukur kepada Tuhan','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(30,'4c1189c6-0934-11f0-af4d-0242ac140002',2,5,23,1,1,4,2,'Menjaga kebersihan diri dan lingkungan sesuai karakter keteraturan.','TKB-SI-NAMB-003','Menjaga kebersihan diri dan lingkungan sesuai karakter keteraturan.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(31,'4c122f48-0934-11f0-84e7-0242ac140002',2,5,23,1,1,4,2,'Mentaati aturan kelas (kegiatan, aturan) dengan baik','TKB-SI-NAMB-002','Mentaati aturan kelas (kegiatan, aturan) dengan baik','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(32,'4c12e172-0934-11f0-893c-0242ac140002',2,5,23,1,1,4,2,'Mengenal agama yang dianut saat ibadah.','TKB-SI-NAMB-001','Mengenal agama yang dianut saat ibadah.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(33,'4c13c3da-0934-11f0-8a33-0242ac140002',2,4,NULL,1,1,4,4,'Nilai Agama Dan Budi Pekerti','NAMB','Peserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(34,'4c148428-0934-11f0-a3a8-0242ac140002',2,6,33,1,1,4,4,'Penjelasan tentang anggota keluarga','TK B-SBP-NAMB-001a','Penjelasan tentang anggota keluarga','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(35,'4c152d38-0934-11f0-8c81-0242ac140002',2,6,33,1,1,4,4,'Penjelasan tentang fungsi masing-masing anggota keluarga','TK B-SBP-NAMB-001b','Penjelasan tentang fungsi masing-masing anggota keluarga','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(36,'4c15c6bc-0934-11f0-a5d7-0242ac140002',2,6,33,1,1,4,4,'Berdiskusi mengenai pembagian peran yang akan dimainkan','TK B-SBP-NAMB-001c','Berdiskusi mengenai pembagian peran yang akan dimainkan','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(37,'4c16636a-0934-11f0-957b-0242ac140002',2,6,33,1,1,4,4,'Pelaksanaan permainan peran','TK B-SBP-NAMB-001d','Pelaksanaan permainan peran','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(38,'4c17928a-0934-11f0-8da5-0242ac140002',2,6,33,1,1,4,4,'Penjelasan mengenai makanan dan minuman terutama makanan sehat','TK B-SBP-NAMB-002a','Penjelasan mengenai makanan dan minuman terutama makanan sehat','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(39,'4c18bfb6-0934-11f0-88f2-0242ac140002',2,6,33,1,1,4,4,'Penjelasan tentang contoh-contoh makanan sehat','TK B-SBP-NAMB-002b','Penjelasan tentang contoh-contoh makanan sehat','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(40,'4c19bc9a-0934-11f0-8f9d-0242ac140002',2,6,33,1,1,4,4,'Penjelasan tentang setting yang akan digunakan bermain peran hari ini','TK B-SBP-NAMB-002c','Penjelasan tentang setting yang akan digunakan bermain peran hari ini','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(41,'4c1a506a-0934-11f0-8d21-0242ac140002',2,6,33,1,1,4,4,'Berdiskusi mengenai pembagian peran yang akan dimainkan','TK B-SBP-NAMB-002d','Berdiskusi mengenai pembagian peran yang akan dimainkan','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(42,'4c1aec0a-0934-11f0-b5e2-0242ac140002',2,6,33,1,1,4,4,'Pelaksanaan bermain peran dengan setting restoran makanan sehat','TK B-SBP-NAMB-002e','Pelaksanaan bermain peran dengan setting restoran makanan sehat','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(43,'4c1b9402-0934-11f0-b1c8-0242ac140002',2,6,33,1,1,4,4,'Memperkenalkan jenis-jenis pakaian','TK B-SBP-NAMB-003a','Memperkenalkan jenis-jenis pakaian','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(44,'4c1cb0e4-0934-11f0-9ea1-0242ac140002',2,6,33,1,1,4,4,'Penjelasan tentang fungsi masing-masing jenis pakaian','TK B-SBP-NAMB-003b','Penjelasan tentang fungsi masing-masing jenis pakaian','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(45,'4c1e0e4e-0934-11f0-ab46-0242ac140002',2,6,33,1,1,4,4,'Berdiskusi mengenai pemilihan peran yang akan dimainkan','TK B-SBP-NAMB-003c','Berdiskusi mengenai pemilihan peran yang akan dimainkan','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(46,'4c1ed5ea-0934-11f0-8218-0242ac140002',2,6,33,1,1,4,4,'Pelaksanaan bermain peran','TK B-SBP-NAMB-003d','Pelaksanaan bermain peran','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(47,'4c1fb4f6-0934-11f0-9247-0242ac140002',2,6,33,1,1,4,4,'Penjelasan tentang pengertian kebersihan, keamanan, dan kesehatan','TK B-SBP-NAMB-004a','Penjelasan tentang pengertian kebersihan, keamanan, dan kesehatan','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(48,'4c2076ca-0934-11f0-bbfb-0242ac140002',2,6,33,1,1,4,4,'Penjelasan tentang bagaimana menjaga kebersihan, keamanan, dan kesehatan diri sendiri.','TK B-SBP-NAMB-004b','Penjelasan tentang bagaimana menjaga kebersihan, keamanan, dan kesehatan diri sendiri.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(49,'4c213c4a-0934-11f0-8e69-0242ac140002',2,6,33,1,1,4,4,'Penjelasan tentang cerita yang akan diperankan','TK B-SBP-NAMB-004c','Penjelasan tentang cerita yang akan diperankan','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(50,'4c21f586-0934-11f0-872b-0242ac140002',2,6,33,1,1,4,4,'Pembagian peran yang akan dimainkan','TK B-SBP-NAMB-004d','Pembagian peran yang akan dimainkan','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(51,'4c22bae8-0934-11f0-8ca2-0242ac140002',2,6,33,1,1,4,4,'Pelaksanaan bermain peran','TK B-SBP-NAMB-004e','Pelaksanaan bermain peran','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(52,'4c234fc6-0934-11f0-99c5-0242ac140002',2,6,33,1,1,4,4,'Penjelasan tentang  contoh-contoh binatang yang hidup di darat dan bagaimana ciri-cirinya.','TK B-SBP-NAMB-005a','Penjelasan tentang  contoh-contoh binatang yang hidup di darat dan bagaimana ciri-cirinya.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(53,'4c23fbba-0934-11f0-9617-0242ac140002',2,6,33,1,1,4,4,'Berdiskusi tentang pembagian peran yang akan dimainkan','TK B-SBP-NAMB-005b','Berdiskusi tentang pembagian peran yang akan dimainkan','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(54,'4c2484cc-0934-11f0-bea3-0242ac140002',2,6,33,1,1,4,4,'Mempersilahkan anak-anak bermain drama dengan peran yang telah dipilih.','TK B-SBP-NAMB-005c','Mempersilahkan anak-anak bermain drama dengan peran yang telah dipilih.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(55,'4c252850-0934-11f0-85ac-0242ac140002',2,5,33,1,1,4,4,'Mendorong anak untuk menggunakan imajinasi dan kreativitas dalam berperan sebagai anggota keluarga, seperti ibu, ayah, saudara, atau hewan peliharaan, serta menyesuaikan perilaku dan dialog sesuai dengan peran yang dimainkan.','TK B-SBP-NAMB-001','Mendorong anak untuk menggunakan imajinasi dan kreativitas dalam berperan sebagai anggota keluarga, seperti ibu, ayah, saudara, atau hewan peliharaan, serta menyesuaikan perilaku dan dialog sesuai dengan peran yang dimainkan.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(56,'4c25bf72-0934-11f0-b08a-0242ac140002',2,5,33,1,1,4,4,'Anak belajar untuk berkomunikasi secara jujur tentang perasaan mereka, baik saat senang maupun sedih, dalam konteks bermain peran tema makanan dan minuman.','TK B-SBP-NAMB-002','Anak belajar untuk berkomunikasi secara jujur tentang perasaan mereka, baik saat senang maupun sedih, dalam konteks bermain peran tema makanan dan minuman.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(57,'4c263e84-0934-11f0-995b-0242ac140002',2,5,33,1,1,4,4,'Mampu mendengarkan dan mengikuti petunjuk dari orang dewasa yang bertanggung jawab dengan baik.','TK B-SBP-NAMB-003','Mampu mendengarkan dan mengikuti petunjuk dari orang dewasa yang bertanggung jawab dengan baik.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(58,'4c26d1be-0934-11f0-b93e-0242ac140002',2,5,33,1,1,4,4,'Menunjukkan pemahaman tentang pentingnya kebersihan, keselamatan, dan kesehatan: Anak-anak akan dapat mengidentifikasi dan menjelaskan mengapa menjaga kebersihan, keselamatan, dan kesehatan adalah penting dalam kehidupan sehari-hari mereka.','TK B-SBP-NAMB-004','Menunjukkan pemahaman tentang pentingnya kebersihan, keselamatan, dan kesehatan: Anak-anak akan dapat mengidentifikasi dan menjelaskan mengapa menjaga kebersihan, keselamatan, dan kesehatan adalah penting dalam kehidupan sehari-hari mereka.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(59,'4c2772e0-0934-11f0-8d82-0242ac140002',2,5,33,1,1,4,4,'Menunjukkan pemahaman tentang pentingnya kebersihan, keselamatan, dan kesehatan: Anak-anak akan dapat mengidentifikasi dan menjelaskan mengapa menjaga kebersihan, keselamatan, dan kesehatan adalah penting dalam kehidupan sehari-hari mereka.','TK B-SBP-NAMB-005','Menunjukkan pemahaman tentang pentingnya kebersihan, keselamatan, dan kesehatan: Anak-anak akan dapat mengidentifikasi dan menjelaskan mengapa menjaga kebersihan, keselamatan, dan kesehatan adalah penting dalam kehidupan sehari-hari mereka.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(60,'4c281ec0-0934-11f0-b29c-0242ac140002',2,5,33,1,1,4,4,'Membantu anak mengidentifikasi dan mengenal berbagai hewan yang hidup di udara seperti burung, kupu-kupu, dan lalat.','TK B-SBP-NAMB-006','Membantu anak mengidentifikasi dan mengenal berbagai hewan yang hidup di udara seperti burung, kupu-kupu, dan lalat.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(61,'4c28cd20-0934-11f0-b63c-0242ac140002',2,5,33,1,1,4,4,'Mengajarkan pentingnya menghargai karya yang dibuat oleh orang lain, termasuk dalam konteks tema buah-buahan.','TK B-SBP-NAMB-007','Mengajarkan pentingnya menghargai karya yang dibuat oleh orang lain, termasuk dalam konteks tema buah-buahan.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(62,'4c296c30-0934-11f0-b525-0242ac140002',2,5,33,1,1,4,4,'Mendorong kerja sama, toleransi, dan penghargaan terhadap perbedaan dalam kegiatan berkelompok','TK B-SBP-NAMB-008','Mendorong kerja sama, toleransi, dan penghargaan terhadap perbedaan dalam kegiatan berkelompok','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(63,'4c2a10fe-0934-11f0-a6ab-0242ac140002',2,5,33,1,1,4,4,'Meningkatkan rasa percaya diri anak dalam berinteraksi dengan teman sebaya.','TK B-SBP-NAMB-009','Meningkatkan rasa percaya diri anak dalam berinteraksi dengan teman sebaya.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(64,'4c2ab3ec-0934-11f0-8a63-0242ac140002',2,5,33,1,1,4,4,'Anak-anak dapat membedakan berbagai jenis pekerjaan yang dilakukan oleh orang tua dan menghargai perbedaan tersebut.','TK B-SBP-NAMB-010','Anak-anak dapat membedakan berbagai jenis pekerjaan yang dilakukan oleh orang tua dan menghargai perbedaan tersebut.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(65,'4c2b4208-0934-11f0-a5c4-0242ac140002',2,5,33,1,1,4,4,'Mengidentifikasi dan mengenal berbagai komponen lingkungan di sekitar pantai dan kehidupan pesisir.','TK B-SBP-NAMB-011','Mengidentifikasi dan mengenal berbagai komponen lingkungan di sekitar pantai dan kehidupan pesisir.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(66,'4c2bca52-0934-11f0-81a1-0242ac140002',2,4,NULL,1,1,4,4,'Jati Diri','JT','Peserta didik diharapkan mampu mengenali, mengekspresikan, dan mengelola emosi diri serta membangun hubungan sosial secara sehat. Mengenal dan memiliki perilaku positif terhadap diri dan lingkungan (keluarga, sekolah, masyarakat, negara, dan dunia) serta rasa bangga sebagai anak Indonesia yang berlandaskan Pancasila. Menyesuaikan diri dengan lingkungan, aturan, dan norma yang berlaku.Menggunakan fungsi gerak (motorik kasar, halus, dan taktil) untuk mengeksplorasi dan memanipulasi berbagai objek dan lingkungan sekitar sebagai bentuk pengembangan diri.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(67,'4c2c6174-0934-11f0-84eb-0242ac140002',2,4,NULL,1,1,4,4,'Dasar-Dasar Literasi Dan STEAM','STEAM-L','Peserta didik diharapkan mampu mengenali dan memahami berbagai informasi, mengkomunikasikan perasaan dan pikiran secara lisan, tulisan, atau berbagai media, serta membangun percakapan.Menujukkan minat, kegemaran, dan berpartisipasi dalam kegaitan Pra membaca dan pra menulis.Mengenali mengunakan konsep pra matematika untuk memecahkan masalah di dalam kehidupan sehari-hari. Menunjukkan kemampuan dasar berpikir Kritis, kreatif, dan kolaboratif. Menunjukkan rasa ingin tahu melalui observasi, eksplorasi, dan eksprimen dengan menggunakan lingkungan sekitar dan media sebagai sumber belajar, untuk mendapatkan gagasan mengenai fenomena alam dan sosial. Menunjukkan kemampuan awal menggunakan dan merakayasa teknologi sederhana, untuk mencari informasi, dan gagasan, dan keterampilan secara aman dan bertanggung jawab. Mengeksplorasi berbagai proses seni, mengekspresikannnya serta mengapresiasi.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(68,'4c2ce112-0934-11f0-a87e-0242ac140002',2,6,67,1,1,4,4,'Penjelasan tentang jenis kelamin','TK B-SBP-STEAML-001a','Penjelasan tentang jenis kelamin','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(69,'4c2d6466-0934-11f0-9f00-0242ac140002',2,6,67,1,1,4,4,'Mengenalkan profesi sesuai jenis kelamin','TK B-SBP-STEAML-001b','Mengenalkan profesi sesuai jenis kelamin','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(70,'4c2e0416-0934-11f0-b80a-0242ac140002',2,6,67,1,1,4,4,'Berdiskusi tentang pembagian peran yang akan dimainkan','TK B-SBP-STEAML-001c','Berdiskusi tentang pembagian peran yang akan dimainkan','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(71,'4c2ea380-0934-11f0-ab92-0242ac140002',2,6,67,1,1,4,4,'Berdiskusi tentang alur cerita yang akan dimainkan','TK B-SBP-STEAML-001d','Berdiskusi tentang alur cerita yang akan dimainkan','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(72,'4c2f50e6-0934-11f0-b6d7-0242ac140002',2,6,67,1,1,4,4,'Pelaksanaan drama','TK B-SBP-STEAML-001e','Pelaksanaan drama','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(73,'4c2fd6ce-0934-11f0-a5eb-0242ac140002',2,6,67,1,1,4,4,'Kesimpulan','TK B-SBP-STEAML-001f','Kesimpulan','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(74,'4c3058ba-0934-11f0-8c1c-0242ac140002',2,6,67,1,1,4,4,'Penjelasan tentang bagian-bagian tubuh manusia','TK B-SBP-STEAML-002a','Penjelasan tentang bagian-bagian tubuh manusia','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(75,'4c30fefa-0934-11f0-b981-0242ac140002',2,6,67,1,1,4,4,'Penjelasan singkat tentang fungsi bagian-bagian tubuh manusia','TK B-SBP-STEAML-002b','Penjelasan singkat tentang fungsi bagian-bagian tubuh manusia','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(76,'4c31a3dc-0934-11f0-9238-0242ac140002',2,6,67,1,1,4,4,'Penjelasan tentang situasi cerita yang akan dimainkan( setting : Rumah Sakit dan keadaan di dalamnya)','TK B-SBP-STEAML-002c','Penjelasan tentang situasi cerita yang akan dimainkan( setting : Rumah Sakit dan keadaan di dalamnya)','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(77,'4c325318-0934-11f0-9ad6-0242ac140002',2,6,67,1,1,4,4,'Berdiskusi mengenai pembagian peran yang akan dimainkan.','TK B-SBP-STEAML-002d','Berdiskusi mengenai pembagian peran yang akan dimainkan.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(78,'4c32f570-0934-11f0-bb18-0242ac140002',2,6,67,1,1,4,4,'Pelaksanaan Bermain Peran','TK B-SBP-STEAML-002e','Pelaksanaan Bermain Peran','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(79,'4c33c39c-0934-11f0-a695-0242ac140002',2,5,67,1,1,4,4,'Memiliki rasa percaya diri dalam menjalankan peran jenis kelamin yang dipilihnya.','TK B-SBP-STEAML-001','Memiliki rasa percaya diri dalam menjalankan peran jenis kelamin yang dipilihnya.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(80,'4c3487fa-0934-11f0-ac7a-0242ac140002',2,5,67,1,1,4,4,'Meningkatkan Keterampilan Motorik Kasar dan Halus','TK B-SBP-STEAML-002','Meningkatkan Keterampilan Motorik Kasar dan Halus','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(81,'4c3542a8-0934-11f0-a795-0242ac140002',2,5,67,1,1,4,4,'Merangsang imajinasi anak-anak dan membangkitkan kreativitas mereka saat mereka menyusun cerita, mengembangkan karakter, dan mengeksplorasi berbagai skenario yang terjadi dalam kehidupan sehari-hari di lingkungan Hills Lifestyle.','TK B-SBP-STEAML-003','Merangsang imajinasi anak-anak dan membangkitkan kreativitas mereka saat mereka menyusun cerita, mengembangkan karakter, dan mengeksplorasi berbagai skenario yang terjadi dalam kehidupan sehari-hari di lingkungan Hills Lifestyle.','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(82,'4c35cc14-0934-11f0-b4a3-0242ac140002',2,4,NULL,1,1,4,3,'Dasar-Dasar Literasi Dan STEAM','STEAM-L','Peserta didik diharapkan mampu mengenali dan memahami berbagai informasi, mengkomunikasikan perasaan dan pikiran secara lisan, tulisan, atau berbagai media, serta membangun percakapan.Menujukkan minat, kegemaran, dan berpartisipasi dalam kegaitan Pra membaca dan pra menulis.Mengenali mengunakan konsep pra matematika untuk memecahkan masalah di dalam kehidupan sehari-hari. Menunjukkan kemampuan dasar berpikir Kritis, kreatif, dan kolaboratif. Menunjukkan rasa ingin tahu melalui observasi, eksplorasi, dan eksprimen dengan menggunakan lingkungan sekitar dan media sebagai sumber belajar, untuk mendapatkan gagasan mengenai fenomena alam dan sosial. Menunjukkan kemampuan awal menggunakan dan merakayasa teknologi sederhana, untuk mencari informasi, dan gagasan, dan keterampilan secara aman dan bertanggung jawab. Mengeksplorasi berbagai proses seni, mengekspresikannnya serta mengapresiasi.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(83,'4c36cb00-0934-11f0-af9a-0242ac140002',2,5,82,1,1,4,3,'Mengeksplor kemampuan anak dalam bermain dengan menggunakan berbagai media','TK B-SBA-STEAML-003','Mengeksplor kemampuan anak dalam bermain dengan menggunakan berbagai media','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(84,'4c379b70-0934-11f0-8be3-0242ac140002',2,4,NULL,1,1,4,3,'Jati Diri','JT','Peserta didik diharapkan mampu mengenali, mengekspresikan, dan mengelola emosi diri serta membangun hubungan sosial secara sehat. Mengenal dan memiliki perilaku positif terhadap diri dan lingkungan (keluarga, sekolah, masyarakat, negara, dan dunia) serta rasa bangga sebagai anak Indonesia yang berlandaskan Pancasila. Menyesuaikan diri dengan lingkungan, aturan, dan norma yang berlaku.Menggunakan fungsi gerak (motorik kasar, halus, dan taktil) untuk mengeksplorasi dan memanipulasi berbagai objek dan lingkungan sekitar sebagai bentuk pengembangan diri.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(85,'4c384156-0934-11f0-a767-0242ac140002',2,5,84,1,1,4,3,'Melakukan beberapa permainan fisik sesuai dengan aturan','TK B-SBA-JT-003','Melakukan beberapa permainan fisik sesuai dengan aturan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(86,'4c38d648-0934-11f0-89a9-0242ac140002',2,5,84,1,1,4,3,'Melakukan permainan dengan menggunakan tangan kanan dan kiri','TK B-SBA-JT-004','Melakukan permainan dengan menggunakan tangan kanan dan kiri','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(87,'4c397b70-0934-11f0-b63a-0242ac140002',2,5,84,1,1,4,3,'Mengkoordinasikan bagian tubuh dalam melakukan permainan melompat dan berjalan melewati rintangan','TK B-SBA-JT-001','Mengkoordinasikan bagian tubuh dalam melakukan permainan melompat dan berjalan melewati rintangan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(88,'4c3a87a4-0934-11f0-9e9d-0242ac140002',2,5,84,1,1,4,3,'Mengkoordinasikan gerakan tubuh untuk melatih kelenturan dan kelincahan tubuh','TK B-SBA-JT-002','Mengkoordinasikan gerakan tubuh untuk melatih kelenturan dan kelincahan tubuh','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(89,'4c3b2a24-0934-11f0-acb9-0242ac140002',2,4,NULL,1,1,4,3,'Nilai Agama Dan Budi Pekerti','NAMB','Peserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(90,'4c3bafb2-0934-11f0-8a19-0242ac140002',2,4,NULL,1,1,4,6,'Nilai Agama Dan Budi Pekerti','NAMB','Peserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sPeserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.ayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(91,'4c3c3306-0934-11f0-bb48-0242ac140002',2,4,NULL,1,1,4,6,'Jati Diri','JT','Peserta didik diharapkan mampu mengenali, mengekspresikan, dan mengelola emosi diri serta membangun hubungan sosial secara sehat. Mengenal dan memiliki perilaku positif terhadap diri dan lingkungan (keluarga, sekolah, masyarakat, negara, dan dunia) serta rasa bangga sebagai anak Indonesia yang berlandaskan Pancasila. Menyesuaikan diri dengan lingkungan, aturan, dan norma yang berlaku.Menggunakan fungsi gerak (motorik kasar, halus, dan taktil) untuk mengeksplorasi dan memanipulasi berbagai objek dan lingkungan sekitar sebagai bentuk pengembangan diri.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(92,'4c3cbb8c-0934-11f0-9371-0242ac140002',2,4,NULL,1,1,4,6,'Dasar-Dasar Literasi Dan STEAM','STEAM-L','Peserta didik diharapkan mampu mengenali dan memahami berbagai informasi, mengkomunikasikan perasaan dan pikiran secara lisan, tulisan, atau berbagai media, serta membangun percakapan.Menujukkan minat, kegemaran, dan berpartisipasi dalam kegaitan Pra membaca dan pra menulis.Mengenali mengunakan konsep pra matematika untuk memecahkan masalah di dalam kehidupan sehari-hari. Menunjukkan kemampuan dasar berpikir Kritis, kreatif, dan kolaboratif. Menunjukkan rasa ingin tahu melalui observasi, eksplorasi, dan eksprimen dengan menggunakan lingkungan sekitar dan media sebagai sumber belajar, untuk mendapatkan gagasan mengenai fenomena alam dan sosial. Menunjukkan kemampuan awal menggunakan dan merakayasa teknologi sederhana, untuk mencari informasi, dan gagasan, dan keterampilan secara aman dan bertanggung jawab. Mengeksplorasi berbagai proses seni, mengekspresikannnya serta mengapresiasi.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(93,'4c3d44e4-0934-11f0-8778-0242ac140002',2,5,92,1,1,4,6,'Menggunakan alat tulis dan alat makan dengan benar sendiri','TK B-MBI-STEAML-001','Menggunakan alat tulis dan alat makan dengan benar sendiri','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(94,'4c3dc81a-0934-11f0-870f-0242ac140002',2,5,92,1,1,4,6,'Membaca nama sendiri di kartu namanya sendiri','TK B-MBI-STEAML-002','Membaca nama sendiri di kartu namanya sendiri','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(95,'4c3e50aa-0934-11f0-a897-0242ac140002',2,5,92,1,1,4,6,'Menuliskan nama sendiri tanpa dibantu','TK B-MBI-STEAML-003','Menuliskan nama sendiri tanpa dibantu','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(96,'4c3eeb14-0934-11f0-98d8-0242ac140002',2,5,92,1,1,4,6,'Merepresentasikan macam   benda dalam bentuk gambar atau tulisan yang dibuat sendiri','TK B-MBI-STEAML-004','Merepresentasikan macam   benda dalam bentuk gambar atau tulisan yang dibuat sendiri','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(97,'4c3f8470-0934-11f0-8f39-0242ac140002',2,5,92,1,1,4,6,'Mengenal berbagai macam lambang huruf vokal dan konsonan melalui panca indra','TK B-MBI-STEAML-005','Mengenal berbagai macam lambang huruf vokal dan konsonan melalui panca indra','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(98,'4c400832-0934-11f0-8657-0242ac140002',2,5,92,1,1,4,6,'Memahami hubungan antara bunyi dan bentuk huruf dan menuliskannya di kertas','TK B-MBI-STEAML-006','Memahami hubungan antara bunyi dan bentuk huruf dan menuliskannya di kertas','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(99,'4c40ae0e-0934-11f0-a175-0242ac140002',2,5,92,1,1,4,6,'Mengulang kalimat yang lebih kompleks secara lisan','TK B-MBI-STEAML-007','Mengulang kalimat yang lebih kompleks secara lisan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(100,'4c414580-0934-11f0-a365-0242ac140002',2,5,92,1,1,4,6,'Berkomunikasi secara lisan, memiliki perbendaharaan kata untuk persiapan membaca, menulis dan berhitung','TK B-MBI-STEAML-008','Berkomunikasi secara lisan, memiliki perbendaharaan kata untuk persiapan membaca, menulis dan berhitung','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(101,'4c41d130-0934-11f0-ac6e-0242ac140002',2,5,92,1,1,4,6,'Mengenal berbagai huruf vokal dan konsonan pada benda-benda yang ada dirumah','TK B-MBI-STEAML-009','Mengenal berbagai huruf vokal dan konsonan pada benda-benda yang ada dirumah','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(102,'4c426884-0934-11f0-97d1-0242ac140002',2,5,92,1,1,4,6,'Melanjutkan sebagian cerita/dongeng yang telah diperdengarkan sesuai imajinasinya','TK B-MBI-STEAML-010','Melanjutkan sebagian cerita/dongeng yang telah diperdengarkan sesuai imajinasinya','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(103,'4c432102-0934-11f0-8adc-0242ac140002',2,5,92,1,1,4,6,'Menyebutkan simbol-simbol huruf yang dikenal pada gambar yang ditunjukan','TK B-MBI-STEAML-011','Menyebutkan simbol-simbol huruf yang dikenal pada gambar yang ditunjukan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(104,'4c43b950-0934-11f0-9ccf-0242ac140002',2,5,92,1,1,4,6,'Menjawab pertanyaan yang lebih kompleks secara lisan dalam bahasa Inggris','TK B-MBI-STEAML-012','Menjawab pertanyaan yang lebih kompleks secara lisan dalam bahasa Inggris','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(105,'4c445806-0934-11f0-bf5a-0242ac140002',2,5,92,1,1,4,6,'Menyebutkan lambang bilangan 1-10 saat menghitung makanan kesukaan','TK B-MBI-STEAML-013','Menyebutkan lambang bilangan 1-10 saat menghitung makanan kesukaan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(106,'4c44ed8e-0934-11f0-9cef-0242ac140002',2,5,92,1,1,4,6,'Mengerti beberapa perintah dan instruksi secara bersamaan','TK B-MBI-STEAML-014','Mengerti beberapa perintah dan instruksi secara bersamaan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(107,'4c459dce-0934-11f0-a4ce-0242ac140002',2,5,92,1,1,4,6,'Memahami hubungan antara bunyi dan bentuk huruf pada macam-macam pakaian pakaian','TK B-MBI-STEAML-015','Memahami hubungan antara bunyi dan bentuk huruf pada macam-macam pakaian pakaian','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(108,'4c464378-0934-11f0-a0a8-0242ac140002',2,5,92,1,1,4,6,'Mengenal suara huruf awal dari nama benda atau makanan yang dilihatnya','TK B-MBI-STEAML-016','Mengenal suara huruf awal dari nama benda atau makanan yang dilihatnya','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(109,'4c46c316-0934-11f0-9315-0242ac140002',2,5,92,1,1,4,6,'Senang dan menghargai bacaan','TK B-MBI-STEAML-017','Senang dan menghargai bacaan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(110,'4c475178-0934-11f0-bf6a-0242ac140002',2,5,92,1,1,4,6,'Menunjukkkan pemahaman konsep-konsep dalam buku cerita','TK B-MBI-STEAML-018','Menunjukkkan pemahaman konsep-konsep dalam buku cerita','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(111,'4c47e250-0934-11f0-8d44-0242ac140002',2,5,92,1,1,4,6,'Memahami arti kata dalam cerita','TK B-MBI-STEAML-019','Memahami arti kata dalam cerita','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(112,'4c489b28-0934-11f0-920e-0242ac140002',2,5,92,1,1,4,6,'Memiliki lebih banyak kata-kata untuk mengekpresikan ide pada orang lain','TK B-MBI-STEAML-020','Memiliki lebih banyak kata-kata untuk mengekpresikan ide pada orang lain','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(113,'4c49395c-0934-11f0-b0ff-0242ac140002',2,5,92,1,1,4,6,'Senang dan menghargai bacaan','TK B-MBI-STEAML-021','Senang dan menghargai bacaan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(114,'4c49bed6-0934-11f0-bd1f-0242ac140002',2,6,92,1,1,4,6,'Menyanyikan lagu \"I Love Myself\" song','TK B-MBI-STEAML-001a','Menyanyikan lagu \"I Love Myself\" song','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(115,'4c4a66ec-0934-11f0-866d-0242ac140002',2,6,92,1,1,4,6,'Menyebutkan namanya sendiri','TK B-MBI-STEAML-001b','Menyebutkan namanya sendiri','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(116,'4c4b01b0-0934-11f0-a11d-0242ac140002',2,6,92,1,1,4,6,'Anak menggunting kartu nama','TK B-MBI-STEAML-001c','Anak menggunting kartu nama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(117,'4c4b85cc-0934-11f0-b004-0242ac140002',2,6,92,1,1,4,6,'Mendorong peserta didik untuk menulis namanya sendiri di kartu nama dan menempelkan pada baju','TK B-MBI-STEAML-002a','Mendorong peserta didik untuk menulis namanya sendiri di kartu nama dan menempelkan pada baju','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(118,'4c4c3ca6-0934-11f0-b675-0242ac140002',2,6,92,1,1,4,6,'Anak memperkenalkan diri di depan kelas menggunakan kalimat berbahasa Inggris','TK B-MBI-STEAML-002b','Anak memperkenalkan diri di depan kelas menggunakan kalimat berbahasa Inggris','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(119,'4c4cc7d4-0934-11f0-8781-0242ac140002',2,6,92,1,1,4,6,'Menyanyikan lagu \"Girls and Boys\" song','TK B-MBI-STEAML-003a','Menyanyikan lagu \"Girls and Boys\" song','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(120,'4c4d64b4-0934-11f0-9ea7-0242ac140002',2,6,92,1,1,4,6,'Pengenalan karakteristik anak laki-laki dan perempuan','TK B-MBI-STEAML-003b','Pengenalan karakteristik anak laki-laki dan perempuan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(121,'4c4ded76-0934-11f0-8247-0242ac140002',2,6,92,1,1,4,6,'Menjelaskan perbedaan laki-laki dan perempuan lewat permainan gambar dan flashcards','TK B-MBI-STEAML-003c','Menjelaskan perbedaan laki-laki dan perempuan lewat permainan gambar dan flashcards','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(122,'4c4e8196-0934-11f0-a64b-0242ac140002',2,6,92,1,1,4,6,'Bermain \"gender grouping\" dan menyebutkan \"I am a girl\" or \"I am a boy\"','TK B-MBI-STEAML-003d','Bermain \"gender grouping\" dan menyebutkan \"I am a girl\" or \"I am a boy\"','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(123,'4c4f0e68-0934-11f0-ae87-0242ac140002',2,6,92,1,1,4,6,'Memilih gambar untuk di warnai dari worksheet \"Are you a boy or a girl?\"','TK B-MBI-STEAML-004a','Memilih gambar untuk di warnai dari worksheet \"Are you a boy or a girl?\"','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(124,'4c503040-0934-11f0-a42a-0242ac140002',2,6,92,1,1,4,6,'Menuliskan nama sendiri dan menggambar hal yang disukai','TK B-MBI-STEAML-004b','Menuliskan nama sendiri dan menggambar hal yang disukai','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(125,'4c50d22a-0934-11f0-89b2-0242ac140002',2,4,NULL,1,1,4,7,'Dasar-Dasar Literasi Dan STEAM','STEAM-L','Peserta didik diharapkan mampu mengenali dan memahami berbagai informasi, mengkomunikasikan perasaan dan pikiran secara lisan, tulisan, atau berbagai media, serta membangun percakapan.Menujukkan minat, kegemaran, dan berpartisipasi dalam kegaitan Pra membaca dan pra menulis.Mengenali mengunakan konsep pra matematika untuk memecahkan masalah di dalam kehidupan sehari-hari. Menunjukkan kemampuan dasar berpikir Kritis, kreatif, dan kolaboratif. Menunjukkan rasa ingin tahu melalui observasi, eksplorasi, dan eksprimen dengan menggunakan lingkungan sekitar dan media sebagai sumber belajar, untuk mendapatkan gagasan mengenai fenomena alam dan sosial. Menunjukkan kemampuan awal menggunakan dan merakayasa teknologi sederhana, untuk mencari informasi, dan gagasan, dan keterampilan secara aman dan bertanggung jawab. Mengeksplorasi berbagai proses seni, mengekspresikannnya serta mengapresiasi.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(126,'4c516d34-0934-11f0-b060-0242ac140002',2,5,125,1,1,4,7,'Mengenal berbagai macam lambang huruf vokal dan konsonan pada kata laki-laki atau perempuan','TK B-SP-STEAML-001','Mengenal berbagai macam lambang huruf vokal dan konsonan pada kata laki-laki atau perempuan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(127,'4c51f498-0934-11f0-af87-0242ac140002',2,5,125,1,1,4,7,'Menggunakan pensil untuk menulis laki-laki atau perempuan','TK B-SP-STEAML-002','Menggunakan pensil untuk menulis laki-laki atau perempuan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(128,'4c528502-0934-11f0-8229-0242ac140002',2,5,125,1,1,4,7,'Mengerti beberapa perintah secara bersamaan untuk menyentuh dua anggota tubuh yang disebutkan.','TK B-SP-STEAML-003','Mengerti beberapa perintah secara bersamaan untuk menyentuh dua anggota tubuh yang disebutkan.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(129,'4c53214c-0934-11f0-bb4e-0242ac140002',2,5,125,1,1,4,7,'Merepresentasikan berbagai macam   gambar anggota tubuh dengan katanya.','TK B-SP-STEAML-004','Merepresentasikan berbagai macam   gambar anggota tubuh dengan katanya.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(130,'4c53a996-0934-11f0-ad2c-0242ac140002',2,5,125,1,1,4,7,'Memahami aturan pada waktu masuk ke rumah','TK B-SP-STEAML-005','Memahami aturan pada waktu masuk ke rumah','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(131,'4c5431f4-0934-11f0-a407-0242ac140002',2,5,125,1,1,4,7,'Senang dan menghargai bacaan tentang rumah','TK B-SP-STEAML-006','Senang dan menghargai bacaan tentang rumah','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(132,'4c54b6c4-0934-11f0-9573-0242ac140002',2,5,125,1,1,4,7,'Menjawab pertanyaan yang lebih kompleks untuk mengetahui makanan dan minuman sehat.','TK B-SP-STEAML-007','Menjawab pertanyaan yang lebih kompleks untuk mengetahui makanan dan minuman sehat.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(133,'4c553d38-0934-11f0-8485-0242ac140002',2,5,125,1,1,4,7,'Menyebutkan kelompok gambar makanan dan minuman sehat yang memiliki bunyi huruf awal yang sama.','TK B-SP-STEAML-008','Menyebutkan kelompok gambar makanan dan minuman sehat yang memiliki bunyi huruf awal yang sama.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(134,'4c55b4ca-0934-11f0-aeba-0242ac140002',2,5,125,1,1,4,7,'Berkomunikasi secara lisan untuk menyebutkan jenis pakaian.','TK B-SP-STEAML-009','Berkomunikasi secara lisan untuk menyebutkan jenis pakaian.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(135,'4c563c06-0934-11f0-a6ac-0242ac140002',2,5,125,1,1,4,7,'Menyusun kalimat sederhana tentang jenis pakaian.','TK B-SP-STEAML-010','Menyusun kalimat sederhana tentang jenis pakaian.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(136,'4c56cac2-0934-11f0-a296-0242ac140002',2,5,125,1,1,4,7,'Memiliki lebih banyak kata-kata untuk mengekpresikan ide pada orang lain tentang menjaga kebersihan, keamanan, dan kesehatan.','TK B-SP-STEAML-011','Memiliki lebih banyak kata-kata untuk mengekpresikan ide pada orang lain tentang menjaga kebersihan, keamanan, dan kesehatan.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(137,'4c57558c-0934-11f0-8b4b-0242ac140002',2,5,125,1,1,4,7,'Melanjutkan sebagian cerita/dongeng yang telah diperdengarkan untuk mengetahui cara menjaga kebersihan, keamanan, dan kesehatan.','TK B-SP-STEAML-012','Melanjutkan sebagian cerita/dongeng yang telah diperdengarkan untuk mengetahui cara menjaga kebersihan, keamanan, dan kesehatan.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(138,'4c57f7bc-0934-11f0-8628-0242ac140002',2,5,125,1,1,4,7,'Menyebutkan simbol-simbol huruf yang dikenal pada nama binatang darat.','TK B-SP-STEAML-013','Menyebutkan simbol-simbol huruf yang dikenal pada nama binatang darat.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(139,'4c588844-0934-11f0-a850-0242ac140002',2,5,125,1,1,4,7,'Menunjukkkan pemahaman konsep-konsep dalam buku cerita tentang binatang yang hidup di darat.','TK B-SP-STEAML-014','Menunjukkkan pemahaman konsep-konsep dalam buku cerita tentang binatang yang hidup di darat.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(140,'4c591926-0934-11f0-b86d-0242ac140002',2,5,125,1,1,4,7,'Mengenal suara huruf   awal dari nama binatang udara.','TK B-SP-STEAML-015','Mengenal suara huruf   awal dari nama binatang udara.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(141,'4c59b070-0934-11f0-9e31-0242ac140002',2,5,125,1,1,4,7,'Menyebutkan kelompok gambar binatang yang memiliki bunyi/huruf awal yang sama.','TK B-SP-STEAML-016','Menyebutkan kelompok gambar binatang yang memiliki bunyi/huruf awal yang sama.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(142,'4c5a3b94-0934-11f0-a14a-0242ac140002',2,5,125,1,1,4,7,'Memahami hubungan antara bunyi dan bentuk huruf dari jenis buah yang disukai.','TK B-SP-STEAML-017','Memahami hubungan antara bunyi dan bentuk huruf dari jenis buah yang disukai.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(143,'4c5ac122-0934-11f0-8bd6-0242ac140002',2,5,125,1,1,4,7,'Memahami arti kata dalam cerita tentang buah.','TK B-SP-STEAML-018','Memahami arti kata dalam cerita tentang buah.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(144,'4c5b5e66-0934-11f0-ac6d-0242ac140002',2,6,125,1,1,4,7,'Mengenal berbagai macam lambang huruf vokal dan konsonan dengan menyanyikan lagu alphabet.','TK B-SP-STEAML-001a','Mengenal berbagai macam lambang huruf vokal dan konsonan dengan menyanyikan lagu alphabet.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(145,'4c5be624-0934-11f0-a871-0242ac140002',2,6,125,1,1,4,7,'Mengerti beberapa perintah secara bersamaan untuk menyanyikan lagu alphabet.','TK B-SP-STEAML-003a','Mengerti beberapa perintah secara bersamaan untuk menyanyikan lagu alphabet.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(146,'4c5c78fa-0934-11f0-9cd7-0242ac140002',2,6,125,1,1,4,7,'Memahami aturan dalam suatu permainan untuk menyanyikan lagu alphabet.','TK B-SP-STEAML-005a','Memahami aturan dalam suatu permainan untuk menyanyikan lagu alphabet.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(147,'4c5d1f58-0934-11f0-af91-0242ac140002',2,6,125,1,1,4,7,'Menjawab pertanyaan yang lebih kompleks tentang menyanyikan lagu alphabet.','TK B-SP-STEAML-007a','Menjawab pertanyaan yang lebih kompleks tentang menyanyikan lagu alphabet.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(148,'4c5dbf9e-0934-11f0-aaf1-0242ac140002',2,6,125,1,1,4,7,'Berkomunikasi secara lisan dengan menyanyikan lagu alphabet.','TK B-SP-STEAML-009a','Berkomunikasi secara lisan dengan menyanyikan lagu alphabet.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(149,'4c5e5ac6-0934-11f0-b475-0242ac140002',2,6,125,1,1,4,7,'Memiliki lebih banyak kata-kata untuk mengekpresikan ide pada orang lain pada waktu menyanyikan lagu alphabet.','TK B-SP-STEAML-011a','Memiliki lebih banyak kata-kata untuk mengekpresikan ide pada orang lain pada waktu menyanyikan lagu alphabet.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(150,'4c5f02f0-0934-11f0-9199-0242ac140002',2,6,125,1,1,4,7,'Menyebutkan simbol-simbol huruf yang dikenal dengan menyanyikan lagu alphabet.','TK B-SP-STEAML-013a','Menyebutkan simbol-simbol huruf yang dikenal dengan menyanyikan lagu alphabet.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(151,'4c5fa714-0934-11f0-ade2-0242ac140002',2,6,125,1,1,4,7,'Mengenal suara huruf   awal dari nama benda-benda yang ada di sekitarnya untuk menyanyikan lagu alphabet.','TK B-SP-STEAML-015a','Mengenal suara huruf   awal dari nama benda-benda yang ada di sekitarnya untuk menyanyikan lagu alphabet.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(152,'4c605bfa-0934-11f0-ad31-0242ac140002',2,6,125,1,1,4,7,'Memahami hubungan antara bunyi dan bentuk huruf untuk menyanyikan lagu alphabet.','TK B-SP-STEAML-017a','Memahami hubungan antara bunyi dan bentuk huruf untuk menyanyikan lagu alphabet.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(153,'4c60fa42-0934-11f0-a2e5-0242ac140002',2,4,NULL,1,1,4,7,'Jati Diri','JT','Peserta didik diharapkan mampu mengenali, mengekspresikan, dan mengelola emosi diri serta membangun hubungan sosial secara sehat. Mengenal dan memiliki perilaku positif terhadap diri dan lingkungan (keluarga, sekolah, masyarakat, negara, dan dunia) serta rasa bangga sebagai anak Indonesia yang berlandaskan Pancasila. Menyesuaikan diri dengan lingkungan, aturan, dan norma yang berlaku.Menggunakan fungsi gerak (motorik kasar, halus, dan taktil) untuk mengeksplorasi dan memanipulasi berbagai objek dan lingkungan sekitar sebagai bentuk pengembangan diri.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(154,'4c61a230-0934-11f0-a7d9-0242ac140002',2,4,NULL,1,1,4,7,'Nilai Agama Dan Budi Pekerti','NAMB','Peserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(155,'4c6226f6-0934-11f0-9af0-0242ac140002',2,4,NULL,1,1,4,11,'Nilai Agama Dan Budi Pekerti','NAMB','Peserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(156,'4c62a9f0-0934-11f0-9cfe-0242ac140002',2,5,155,1,1,4,11,'Mengenali pentingnya menjaga kebersihan serta keamanan diri dan lingkungan serta mampu melakukannya secara mandiri.','TKAB-SAFTELA-NAMB-001','Mengenali pentingnya menjaga kebersihan serta keamanan diri dan lingkungan serta mampu melakukannya secara mandiri.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(157,'4c632466-0934-11f0-84d8-0242ac140002',2,5,155,1,1,4,11,'Memahami dan menerapkan nilai-nilai kerjasama dan tanggung jawab dalam kegiatan di dalam dan di luar ruangan, serta mengenal lingkungan sekitar.','TKAB-SAFTELA-NAMB-002','Memahami dan menerapkan nilai-nilai kerjasama dan tanggung jawab dalam kegiatan di dalam dan di luar ruangan, serta mengenal lingkungan sekitar.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(158,'4c63c286-0934-11f0-aea7-0242ac140002',2,5,155,1,1,4,11,'Mengajukan pertanyaan tentang tanaman, hewan, fenomena alam, hubungan sebab akibat yang ditemukan.','TKAB-SAFTELA-NAMB-003','Mengajukan pertanyaan tentang tanaman, hewan, fenomena alam, hubungan sebab akibat yang ditemukan.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(159,'4c644486-0934-11f0-ad43-0242ac140002',2,5,155,1,1,4,11,'Menerapkan keterampilan dasar dalam menyiapkan makanan, termasuk kebersihan dan keamanan makanan.','TKAB-SAFTELA-NAMB-004','Menerapkan keterampilan dasar dalam menyiapkan makanan, termasuk kebersihan dan keamanan makanan.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(160,'4c64db9e-0934-11f0-9c65-0242ac140002',2,4,NULL,1,1,4,11,'Jati Diri','JT','Peserta didik diharapkan mampu mengenali, mengekspresikan, dan mengelola emosi diri serta membangun hubungan sosial secara sehat. Mengenal dan memiliki perilaku positif terhadap diri dan lingkungan (keluarga, sekolah, masyarakat, negara, dan dunia) serta rasa bangga sebagai anak Indonesia yang berlandaskan Pancasila. Menyesuaikan diri dengan lingkungan, aturan, dan norma yang berlaku.Menggunakan fungsi gerak (motorik kasar, halus, dan taktil) untuk mengeksplorasi dan memanipulasi berbagai objek dan lingkungan sekitar sebagai bentuk pengembangan diri.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(161,'4c655970-0934-11f0-8de0-0242ac140002',2,5,160,1,1,4,11,'Berkomunikasi yang baik, berbagi, dan menunjukkan empati terhadap perasaan orang lain.','TKAB-SAFTELA-JT-001','Berkomunikasi yang baik, berbagi, dan menunjukkan empati terhadap perasaan orang lain.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(162,'4c65e5f2-0934-11f0-9535-0242ac140002',2,5,160,1,1,4,11,'Mengidentifikasi dan menyelesaikan masalah sederhana dalam situasi sehari-hari.','TKAB-SAFTELA-JT-002','Mengidentifikasi dan menyelesaikan masalah sederhana dalam situasi sehari-hari.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(163,'4c666324-0934-11f0-81d5-0242ac140002',2,5,160,1,1,4,11,'Mengekspresikan diri melalui musik dan gerakan, serta berpartisipasi dalam aktivitas indvidual dengan penuh semangat.','TKAB-SAFTELA-JT-003','Mengekspresikan diri melalui musik dan gerakan, serta berpartisipasi dalam aktivitas indvidual dengan penuh semangat.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(164,'4c66f83e-0934-11f0-ba44-0242ac140002',2,4,NULL,1,1,4,11,'Dasar-Dasar Literasi Dan STEAM','STEAM-L','Peserta didik diharapkan mampu mengenali dan memahami berbagai informasi, mengkomunikasikan perasaan dan pikiran secara lisan, tulisan, atau berbagai media, serta membangun percakapan.Menujukkan minat, kegemaran, dan berpartisipasi dalam kegaitan Pra membaca dan pra menulis.Mengenali mengunakan konsep pra matematika untuk memecahkan masalah di dalam kehidupan sehari-hari. Menunjukkan kemampuan dasar berpikir Kritis, kreatif, dan kolaboratif. Menunjukkan rasa ingin tahu melalui observasi, eksplorasi, dan eksprimen dengan menggunakan lingkungan sekitar dan media sebagai sumber belajar, untuk mendapatkan gagasan mengenai fenomena alam dan sosial. Menunjukkan kemampuan awal menggunakan dan merakayasa teknologi sederhana, untuk mencari informasi, dan gagasan, dan keterampilan secara aman dan bertanggung jawab. Mengeksplorasi berbagai proses seni, mengekspresikannnya serta mengapresiasi.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(165,'4c67ee7e-0934-11f0-87b7-0242ac140002',2,5,164,1,1,4,11,'Membuat kerajinan tangan sederhana dengan menggunakan berbagai bahan, serta menunjukkan kreativitas dan imajinasi dalam proses pembuatannya.','TKAB-SAFTELA-STEAML-001','Membuat kerajinan tangan sederhana dengan menggunakan berbagai bahan, serta menunjukkan kreativitas dan imajinasi dalam proses pembuatannya.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(166,'4c68864a-0934-11f0-b8c7-0242ac140002',2,5,164,1,1,4,11,'Mendengarkan dan memahami cerita yang dibacakan, serta mampu memberikan tanggapan dan pendapat tentang isi cerita.','TKAB-SAFTELA-STEAML-002','Mendengarkan dan memahami cerita yang dibacakan, serta mampu memberikan tanggapan dan pendapat tentang isi cerita.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(167,'4c69107e-0934-11f0-84d7-0242ac140002',2,5,164,1,1,4,11,'Terampil menggunakan tangan kanan dan kiri serta koordinasi tangan dan mata','TKAB-SAFTELA-STEAML-003','Terampil menggunakan tangan kanan dan kiri serta koordinasi tangan dan mata','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(168,'4c699062-0934-11f0-af0d-0242ac140002',2,5,164,1,1,4,12,'Terampil menggunakan tangan kanan dan kiri serta koordinasi tangan dan mata','TKAB-SAFTELA-STEAML-003','Terampil menggunakan tangan kanan dan kiri serta koordinasi tangan dan mata','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(169,'4c6a240a-0934-11f0-afdc-0242ac140002',2,5,164,1,1,4,12,'Mendengarkan dan memahami cerita yang dibacakan, serta mampu memberikan tanggapan dan pendapat tentang isi cerita.','TKAB-SAFTELA-STEAML-002','Mendengarkan dan memahami cerita yang dibacakan, serta mampu memberikan tanggapan dan pendapat tentang isi cerita.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(170,'4c6ab820-0934-11f0-9306-0242ac140002',2,5,164,1,1,4,12,'Membuat kerajinan tangan sederhana dengan menggunakan berbagai bahan, serta menunjukkan kreativitas dan imajinasi dalam proses pembuatannya.','TKAB-SAFTELA-STEAML-001','Membuat kerajinan tangan sederhana dengan menggunakan berbagai bahan, serta menunjukkan kreativitas dan imajinasi dalam proses pembuatannya.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(171,'4c6b3bd8-0934-11f0-93d5-0242ac140002',2,4,NULL,1,1,4,10,'Dasar-Dasar Literasi Dan STEAM','STEAM-L','Peserta didik diharapkan mampu mengenali dan memahami berbagai informasi, mengkomunikasikan perasaan dan pikiran secara lisan, tulisan, atau berbagai media, serta membangun percakapan.Menujukkan minat, kegemaran, dan berpartisipasi dalam kegaitan Pra membaca dan pra menulis.Mengenali mengunakan konsep pra matematika untuk memecahkan masalah di dalam kehidupan sehari-hari. Menunjukkan kemampuan dasar berpikir Kritis, kreatif, dan kolaboratif. Menunjukkan rasa ingin tahu melalui observasi, eksplorasi, dan eksprimen dengan menggunakan lingkungan sekitar dan media sebagai sumber belajar, untuk mendapatkan gagasan mengenai fenomena alam dan sosial. Menunjukkan kemampuan awal menggunakan dan merakayasa teknologi sederhana, untuk mencari informasi, dan gagasan, dan keterampilan secara aman dan bertanggung jawab. Mengeksplorasi berbagai proses seni, mengekspresikannnya serta mengapresiasi.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(172,'4c6bd764-0934-11f0-b19b-0242ac140002',2,5,171,1,1,4,10,'Membuat kerajinan tangan sederhana dengan menggunakan berbagai bahan, serta menunjukkan kreativitas dan imajinasi dalam proses pembuatannya.','TKAB-SAFTELA-STEAM-L-001','Membuat kerajinan tangan sederhana dengan menggunakan berbagai bahan, serta menunjukkan kreativitas dan imajinasi dalam proses pembuatannya.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(173,'4c6c70b6-0934-11f0-b5e5-0242ac140002',2,5,171,1,1,4,10,'Mendengarkan dan memahami cerita yang dibacakan, serta mampu memberikan tanggapan dan pendapat tentang isi cerita.','TKAB-SAFTELA-STEAM-L-002','Mendengarkan dan memahami cerita yang dibacakan, serta mampu memberikan tanggapan dan pendapat tentang isi cerita.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(174,'4c6cf4d2-0934-11f0-8aba-0242ac140002',2,5,171,1,1,4,10,'Terampil menggunakan tangan kanan dan kiri serta koordinasi tangan dan mata','TKAB-SAFTELA-STEAM-L-003','Terampil menggunakan tangan kanan dan kiri serta koordinasi tangan dan mata','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(175,'4c6d9a4a-0934-11f0-a497-0242ac140002',2,6,171,1,1,4,10,'Memperhatikan penjelasan guru','TKAB-SAFTELA-STEAML-001a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(176,'4c6e1fba-0934-11f0-869c-0242ac140002',2,6,171,1,1,4,11,'Memperhatikan penjelasan guru','TKAB-SAFTELA-STEAML-001a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(177,'4c6ef098-0934-11f0-8952-0242ac140002',2,6,171,1,1,4,12,'Memperhatikan penjelasan guru','TKAB-SAFTELA-STEAML-001a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(178,'4c6f8f76-0934-11f0-abc8-0242ac140002',2,6,171,1,1,4,12,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-STEAML-001b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(179,'4c701ae0-0934-11f0-b51f-0242ac140002',2,6,171,1,1,4,11,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-STEAML-001b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(180,'4c70bf22-0934-11f0-91c7-0242ac140002',2,6,171,1,1,4,10,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-STEAML-001b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(181,'4c714b4a-0934-11f0-b14c-0242ac140002',2,6,171,1,1,4,10,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-STEAML-001c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(182,'4c71d57e-0934-11f0-893d-0242ac140002',2,6,171,1,1,4,11,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-STEAML-001c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(183,'4c726214-0934-11f0-85ea-0242ac140002',2,6,171,1,1,4,12,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-STEAML-001c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(184,'4c7302be-0934-11f0-9dd8-0242ac140002',2,6,171,1,1,4,12,'Bermain dan bekerjasama','TKAB-SAFTELA-STEAML-001d','Bermain dan bekerjasama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(185,'4c73b196-0934-11f0-82ed-0242ac140002',2,6,171,1,1,4,11,'Bermain dan bekerjasama','TKAB-SAFTELA-STEAML-001d','Bermain dan bekerjasama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(186,'4c745ad8-0934-11f0-8fc9-0242ac140002',2,6,171,1,1,4,10,'Bermain dan bekerjasama','TKAB-SAFTELA-STEAML-001d','Bermain dan bekerjasama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(187,'4c74e39a-0934-11f0-a963-0242ac140002',2,6,171,1,1,4,10,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-STEAML-001e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(188,'4c75802a-0934-11f0-8655-0242ac140002',2,6,171,1,1,4,11,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-STEAML-001e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(189,'4c760da6-0934-11f0-ad1e-0242ac140002',2,6,171,1,1,4,12,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-STEAML-001e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(190,'4c769b40-0934-11f0-9362-0242ac140002',2,6,171,1,1,4,12,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-STEAML-001f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(191,'4c772916-0934-11f0-ac28-0242ac140002',2,6,171,1,1,4,11,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-STEAML-001f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(192,'4c77b084-0934-11f0-b521-0242ac140002',2,6,171,1,1,4,10,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-STEAML-001f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(193,'4c782b40-0934-11f0-bb94-0242ac140002',2,6,171,1,1,4,10,'Memperhatikan penjelasan guru','TKAB-SAFTELA-STEAML-002a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(194,'4c78e210-0934-11f0-a335-0242ac140002',2,6,171,1,1,4,11,'Memperhatikan penjelasan guru','TKAB-SAFTELA-STEAML-002a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(195,'4c7974c8-0934-11f0-a165-0242ac140002',2,6,171,1,1,4,12,'Memperhatikan penjelasan guru','TKAB-SAFTELA-STEAML-002a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(196,'4c79f894-0934-11f0-8f3e-0242ac140002',2,6,171,1,1,4,12,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-STEAML-002b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(197,'4c7a8e58-0934-11f0-9160-0242ac140002',2,6,171,1,1,4,11,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-STEAML-002b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(198,'4c7b25e8-0934-11f0-823e-0242ac140002',2,6,171,1,1,4,10,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-STEAML-002b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(199,'4c7bc386-0934-11f0-a291-0242ac140002',2,6,171,1,1,4,10,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-STEAML-002c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(200,'4c7c522e-0934-11f0-9ad5-0242ac140002',2,6,171,1,1,4,11,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-STEAML-002c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(201,'4c7cd654-0934-11f0-a62e-0242ac140002',2,6,171,1,1,4,12,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-STEAML-002c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(202,'4c7d896e-0934-11f0-ac0f-0242ac140002',2,6,171,1,1,4,12,'Bermain dan bekerjasama','TKAB-SAFTELA-STEAML-002d','Bermain dan bekerjasama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(203,'4c7e17a8-0934-11f0-b74e-0242ac140002',2,6,171,1,1,4,11,'Bermain dan bekerjasama','TKAB-SAFTELA-STEAML-002d','Bermain dan bekerjasama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(204,'4c7ea736-0934-11f0-8c69-0242ac140002',2,6,171,1,1,4,10,'Bermain dan bekerjasama','TKAB-SAFTELA-STEAML-002d','Bermain dan bekerjasama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(205,'4c7f424a-0934-11f0-8c09-0242ac140002',2,6,171,1,1,4,10,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-STEAML-002e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(206,'4c7fcbb6-0934-11f0-a84d-0242ac140002',2,6,171,1,1,4,11,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-STEAML-002e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(207,'4c806d6e-0934-11f0-ba7b-0242ac140002',2,6,171,1,1,4,12,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-STEAML-002e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(208,'4c811f0c-0934-11f0-a7e1-0242ac140002',2,6,171,1,1,4,12,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-STEAML-002f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(209,'4c81a53a-0934-11f0-86e6-0242ac140002',2,6,171,1,1,4,11,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-STEAML-002f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(210,'4c8234fa-0934-11f0-bd37-0242ac140002',2,6,171,1,1,4,10,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-STEAML-002f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(211,'4c833882-0934-11f0-a420-0242ac140002',2,6,171,1,1,4,10,'Memperhatikan penjelasan guru','TKAB-SAFTELA-STEAML-003a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(212,'4c83b6fe-0934-11f0-9f08-0242ac140002',2,6,171,1,1,4,11,'Memperhatikan penjelasan guru','TKAB-SAFTELA-STEAML-003a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(213,'4c844f6a-0934-11f0-8ee1-0242ac140002',2,6,171,1,1,4,12,'Memperhatikan penjelasan guru','TKAB-SAFTELA-STEAML-003a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(214,'4c84d552-0934-11f0-80d9-0242ac140002',2,6,171,1,1,4,12,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-STEAML-003b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(215,'4c858254-0934-11f0-8308-0242ac140002',2,6,171,1,1,4,11,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-STEAML-003b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(216,'4c862376-0934-11f0-9dc8-0242ac140002',2,6,171,1,1,4,10,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-STEAML-003b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(217,'4c873f5e-0934-11f0-8854-0242ac140002',2,6,171,1,1,4,10,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-STEAML-003c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(218,'4c87dc7a-0934-11f0-b496-0242ac140002',2,6,171,1,1,4,11,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-STEAML-003c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(219,'4c887608-0934-11f0-ac94-0242ac140002',2,6,171,1,1,4,12,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-STEAML-003c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(220,'4c891180-0934-11f0-93b7-0242ac140002',2,6,171,1,1,4,12,'Bermain dan bekerjasama','TKAB-SAFTELA-STEAML-003d','Bermain dan bekerjasama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(221,'4c899236-0934-11f0-8b3f-0242ac140002',2,6,171,1,1,4,11,'Bermain dan bekerjasama','TKAB-SAFTELA-STEAML-003d','Bermain dan bekerjasama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(222,'4c8a104e-0934-11f0-b3dd-0242ac140002',2,6,171,1,1,4,10,'Bermain dan bekerjasama','TKAB-SAFTELA-STEAML-003d','Bermain dan bekerjasama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(223,'4c8aac20-0934-11f0-887b-0242ac140002',2,6,171,1,1,4,10,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-STEAML-003e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(224,'4c8b4180-0934-11f0-9f31-0242ac140002',2,6,171,1,1,4,11,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-STEAML-003e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(225,'4c8bc290-0934-11f0-b22e-0242ac140002',2,6,171,1,1,4,12,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-STEAML-003e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(226,'4c8c4c06-0934-11f0-9fbc-0242ac140002',2,6,171,1,1,4,12,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-STEAML-003f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(227,'4c8cd202-0934-11f0-9751-0242ac140002',2,6,171,1,1,4,11,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-STEAML-003f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(228,'4c8d8e7c-0934-11f0-a304-0242ac140002',2,6,171,1,1,4,10,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-STEAML-003f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(229,'4c8e33d6-0934-11f0-932f-0242ac140002',2,4,NULL,1,1,4,12,'Dasar-Dasar Literasi Dan STEAM','STEAM-L','Peserta didik diharapkan mampu mengenali dan memahami berbagai informasi, mengkomunikasikan perasaan dan pikiran secara lisan, tulisan, atau berbagai media, serta membangun percakapan.Menujukkan minat, kegemaran, dan berpartisipasi dalam kegaitan Pra membaca dan pra menulis.Mengenali mengunakan konsep pra matematika untuk memecahkan masalah di dalam kehidupan sehari-hari. Menunjukkan kemampuan dasar berpikir Kritis, kreatif, dan kolaboratif. Menunjukkan rasa ingin tahu melalui observasi, eksplorasi, dan eksprimen dengan menggunakan lingkungan sekitar dan media sebagai sumber belajar, untuk mendapatkan gagasan mengenai fenomena alam dan sosial. Menunjukkan kemampuan awal menggunakan dan merakayasa teknologi sederhana, untuk mencari informasi, dan gagasan, dan keterampilan secara aman dan bertanggung jawab. Mengeksplorasi berbagai proses seni, mengekspresikannnya serta mengapresiasi.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(230,'4c8eafd2-0934-11f0-84dd-0242ac140002',2,5,229,1,1,4,10,'Membuat kerajinan tangan sederhana dengan menggunakan berbagai bahan, serta menunjukkan kreativitas dan imajinasi dalam proses pembuatannya.','TKAB-SAFTELA-STEAML-001','Membuat kerajinan tangan sederhana dengan menggunakan berbagai bahan, serta menunjukkan kreativitas dan imajinasi dalam proses pembuatannya.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(231,'4c8f4082-0934-11f0-896f-0242ac140002',2,5,229,1,1,4,11,'Membuat kerajinan tangan sederhana dengan menggunakan berbagai bahan, serta menunjukkan kreativitas dan imajinasi dalam proses pembuatannya.','TKAB-SAFTELA-STEAML-001','Membuat kerajinan tangan sederhana dengan menggunakan berbagai bahan, serta menunjukkan kreativitas dan imajinasi dalam proses pembuatannya.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(232,'4c8fcd7c-0934-11f0-b160-0242ac140002',2,5,229,1,1,4,12,'Membuat kerajinan tangan sederhana dengan menggunakan berbagai bahan, serta menunjukkan kreativitas dan imajinasi dalam proses pembuatannya.','TKAB-SAFTELA-STEAML-001','Membuat kerajinan tangan sederhana dengan menggunakan berbagai bahan, serta menunjukkan kreativitas dan imajinasi dalam proses pembuatannya.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(233,'4c906b6a-0934-11f0-899e-0242ac140002',2,5,229,1,1,4,12,'Mendengarkan dan memahami cerita yang dibacakan, serta mampu memberikan tanggapan dan pendapat tentang isi cerita.','TKAB-SAFTELA-STEAML-002','Mendengarkan dan memahami cerita yang dibacakan, serta mampu memberikan tanggapan dan pendapat tentang isi cerita.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(234,'4c90f9b8-0934-11f0-87c8-0242ac140002',2,5,229,1,1,4,11,'Mendengarkan dan memahami cerita yang dibacakan, serta mampu memberikan tanggapan dan pendapat tentang isi cerita.','TKAB-SAFTELA-STEAML-002','Mendengarkan dan memahami cerita yang dibacakan, serta mampu memberikan tanggapan dan pendapat tentang isi cerita.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(235,'4c91841e-0934-11f0-8f39-0242ac140002',2,5,229,1,1,4,10,'Mendengarkan dan memahami cerita yang dibacakan, serta mampu memberikan tanggapan dan pendapat tentang isi cerita.','TKAB-SAFTELA-STEAML-002','Mendengarkan dan memahami cerita yang dibacakan, serta mampu memberikan tanggapan dan pendapat tentang isi cerita.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(236,'4c9229be-0934-11f0-b1db-0242ac140002',2,5,229,1,1,4,10,'Terampil menggunakan tangan kanan dan kiri serta koordinasi tangan dan mata','TKAB-SAFTELA-STEAML-003','Terampil menggunakan tangan kanan dan kiri serta koordinasi tangan dan mata','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(237,'4c92d6c0-0934-11f0-b2f5-0242ac140002',2,5,229,1,1,4,11,'Terampil menggunakan tangan kanan dan kiri serta koordinasi tangan dan mata','TKAB-SAFTELA-STEAML-003','Terampil menggunakan tangan kanan dan kiri serta koordinasi tangan dan mata','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(238,'4c9379ae-0934-11f0-a549-0242ac140002',2,5,229,1,1,4,12,'Terampil menggunakan tangan kanan dan kiri serta koordinasi tangan dan mata','TKAB-SAFTELA-STEAML-003','Terampil menggunakan tangan kanan dan kiri serta koordinasi tangan dan mata','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(239,'4c941bfc-0934-11f0-acf9-0242ac140002',2,4,NULL,1,1,4,5,'Dasar-Dasar Literasi Dan STEAM','STEAM-L','Peserta didik diharapkan mampu mengenali dan memahami berbagai informasi, mengkomunikasikan perasaan dan pikiran secara lisan, tulisan, atau berbagai media, serta membangun percakapan.Menujukkan minat, kegemaran, dan berpartisipasi dalam kegaitan Pra membaca dan pra menulis.Mengenali mengunakan konsep pra matematika untuk memecahkan masalah di dalam kehidupan sehari-hari. Menunjukkan kemampuan dasar berpikir Kritis, kreatif, dan kolaboratif. Menunjukkan rasa ingin tahu melalui observasi, eksplorasi, dan eksprimen dengan menggunakan lingkungan sekitar dan media sebagai sumber belajar, untuk mendapatkan gagasan mengenai fenomena alam dan sosial. Menunjukkan kemampuan awal menggunakan dan merakayasa teknologi sederhana, untuk mencari informasi, dan gagasan, dan keterampilan secara aman dan bertanggung jawab. Mengeksplorasi berbagai proses seni, mengekspresikannnya serta mengapresiasi.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(240,'4c94b6ac-0934-11f0-bfd4-0242ac140002',2,4,NULL,1,1,4,5,'Jati Diri','JT','Peserta didik diharapkan mampu mengenali, mengekspresikan, dan mengelola emosi diri serta membangun hubungan sosial secara sehat. Mengenal dan memiliki perilaku positif terhadap diri dan lingkungan (keluarga, sekolah, masyarakat, negara, dan dunia) serta rasa bangga sebagai anak Indonesia yang berlandaskan Pancasila. Menyesuaikan diri dengan lingkungan, aturan, dan norma yang berlaku.Menggunakan fungsi gerak (motorik kasar, halus, dan taktil) untuk mengeksplorasi dan memanipulasi berbagai objek dan lingkungan sekitar sebagai bentuk pengembangan diri.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(241,'4c954374-0934-11f0-8e8e-0242ac140002',2,4,NULL,1,1,4,10,'Jati Diri','JT','Peserta didik diharapkan mampu mengenali, mengekspresikan, dan mengelola emosi diri serta membangun hubungan sosial secara sehat. Mengenal dan memiliki perilaku positif terhadap diri dan lingkungan (keluarga, sekolah, masyarakat, negara, dan dunia) serta rasa bangga sebagai anak Indonesia yang berlandaskan Pancasila. Menyesuaikan diri dengan lingkungan, aturan, dan norma yang berlaku.Menggunakan fungsi gerak (motorik kasar, halus, dan taktil) untuk mengeksplorasi dan memanipulasi berbagai objek dan lingkungan sekitar sebagai bentuk pengembangan diri.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(242,'4c95c452-0934-11f0-bddc-0242ac140002',2,5,241,1,1,4,10,'Berkomunikasi yang baik, berbagi, dan menunjukkan empati terhadap perasaan orang lain.','TKAB-SAFTELA-JT-001','Berkomunikasi yang baik, berbagi, dan menunjukkan empati terhadap perasaan orang lain.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(243,'4c96618c-0934-11f0-80c8-0242ac140002',2,5,241,1,1,4,10,'Mengidentifikasi dan menyelesaikan masalah sederhana dalam situasi sehari-hari.','TKAB-SAFTELA-JT-002','Mengidentifikasi dan menyelesaikan masalah sederhana dalam situasi sehari-hari.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(244,'4c96f818-0934-11f0-9a29-0242ac140002',2,5,241,1,1,4,10,'Mengekspresikan diri melalui musik dan gerakan, serta berpartisipasi dalam aktivitas indvidual dengan penuh semangat.','TKAB-SAFTELA-JT-003','Mengekspresikan diri melalui musik dan gerakan, serta berpartisipasi dalam aktivitas indvidual dengan penuh semangat.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(245,'4c978a08-0934-11f0-a1ba-0242ac140002',2,5,241,1,1,4,11,'Berkomunikasi yang baik, berbagi, dan menunjukkan empati terhadap perasaan orang lain.','TKAB-SAFTELA-JT-001','Berkomunikasi yang baik, berbagi, dan menunjukkan empati terhadap perasaan orang lain.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(246,'4c9816b2-0934-11f0-84eb-0242ac140002',2,5,241,1,1,4,12,'Berkomunikasi yang baik, berbagi, dan menunjukkan empati terhadap perasaan orang lain.','TKAB-SAFTELA-JT-001','Berkomunikasi yang baik, berbagi, dan menunjukkan empati terhadap perasaan orang lain.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(247,'4c98936c-0934-11f0-96fc-0242ac140002',2,5,241,1,1,4,11,'Mengidentifikasi dan menyelesaikan masalah sederhana dalam situasi sehari-hari.','TKAB-SAFTELA-JT-002','Mengidentifikasi dan menyelesaikan masalah sederhana dalam situasi sehari-hari.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(248,'4c992548-0934-11f0-9f19-0242ac140002',2,5,241,1,1,4,12,'Mengidentifikasi dan menyelesaikan masalah sederhana dalam situasi sehari-hari.','TKAB-SAFTELA-JT-002','Mengidentifikasi dan menyelesaikan masalah sederhana dalam situasi sehari-hari.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(249,'4c99bb34-0934-11f0-8bdb-0242ac140002',2,5,241,1,1,4,12,'Mengekspresikan diri melalui musik dan gerakan, serta berpartisipasi dalam aktivitas indvidual dengan penuh semangat.','TKAB-SAFTELA-JT-003','Mengekspresikan diri melalui musik dan gerakan, serta berpartisipasi dalam aktivitas indvidual dengan penuh semangat.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(250,'4c9a4ebe-0934-11f0-8e2b-0242ac140002',2,5,241,1,1,4,11,'Mengekspresikan diri melalui musik dan gerakan, serta berpartisipasi dalam aktivitas indvidual dengan penuh semangat.','TKAB-SAFTELA-JT-003','Mengekspresikan diri melalui musik dan gerakan, serta berpartisipasi dalam aktivitas indvidual dengan penuh semangat.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(251,'4c9af260-0934-11f0-943b-0242ac140002',2,6,241,1,1,4,10,'Memperhatikan penjelasan guru','TKAB-SAFTELA-JT-001a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(252,'4c9b8504-0934-11f0-a5ae-0242ac140002',2,6,241,1,1,4,11,'Memperhatikan penjelasan guru','TKAB-SAFTELA-JT-001a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(253,'4c9c10f0-0934-11f0-8536-0242ac140002',2,6,241,1,1,4,12,'Memperhatikan penjelasan guru','TKAB-SAFTELA-JT-001a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(254,'4c9ca164-0934-11f0-b106-0242ac140002',2,6,241,1,1,4,12,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-JT-001b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(255,'4c9d2c4c-0934-11f0-b201-0242ac140002',2,6,241,1,1,4,11,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-JT-001b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(256,'4c9dd6f6-0934-11f0-9024-0242ac140002',2,6,241,1,1,4,10,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-JT-001b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(257,'4c9ed74a-0934-11f0-9f2b-0242ac140002',2,6,241,1,1,4,10,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-JT-001c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(258,'4c9f7416-0934-11f0-b089-0242ac140002',2,6,241,1,1,4,11,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-JT-001c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(259,'4ca0190c-0934-11f0-b294-0242ac140002',2,6,241,1,1,4,12,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-JT-001c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(260,'4ca0967a-0934-11f0-9e4a-0242ac140002',2,6,241,1,1,4,12,'Bermain dan bekerjasama','TKAB-SAFTELA-JT-001d','Bermain dan bekerjasama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(261,'4ca137ba-0934-11f0-9ec9-0242ac140002',2,6,241,1,1,4,11,'Bermain dan bekerjasama','TKAB-SAFTELA-JT-001d','Bermain dan bekerjasama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(262,'4ca26036-0934-11f0-9407-0242ac140002',2,6,241,1,1,4,10,'Bermain dan bekerjasama','TKAB-SAFTELA-JT-001d','Bermain dan bekerjasama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(263,'4ca2f7e4-0934-11f0-b787-0242ac140002',2,6,241,1,1,4,10,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-JT-001e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(264,'4ca38132-0934-11f0-97e0-0242ac140002',2,6,241,1,1,4,11,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-JT-001e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(265,'4ca41566-0934-11f0-bc40-0242ac140002',2,6,241,1,1,4,12,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-JT-001e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(266,'4ca4bcfa-0934-11f0-8418-0242ac140002',2,6,241,1,1,4,12,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-JT-001f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(267,'4ca5417a-0934-11f0-97f8-0242ac140002',2,6,241,1,1,4,11,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-JT-001f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(268,'4ca5d59a-0934-11f0-b662-0242ac140002',2,6,241,1,1,4,10,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-JT-001f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(269,'4ca67c48-0934-11f0-a12d-0242ac140002',2,6,241,1,1,4,10,'Memperhatikan penjelasan guru','TKAB-SAFTELA-JT-002a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(270,'4ca7032a-0934-11f0-98e1-0242ac140002',2,6,241,1,1,4,11,'Memperhatikan penjelasan guru','TKAB-SAFTELA-JT-002a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(271,'4ca784e4-0934-11f0-a6e5-0242ac140002',2,6,241,1,1,4,12,'Memperhatikan penjelasan guru','TKAB-SAFTELA-JT-002a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(272,'4ca81490-0934-11f0-a9e8-0242ac140002',2,6,241,1,1,4,12,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-JT-002b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(273,'4ca8c61a-0934-11f0-b5bc-0242ac140002',2,6,241,1,1,4,11,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-JT-002b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(274,'4ca9c772-0934-11f0-9b14-0242ac140002',2,6,241,1,1,4,10,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-JT-002b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(275,'4caa8176-0934-11f0-bc15-0242ac140002',2,6,241,1,1,4,10,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-JT-002c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(276,'4cab4af2-0934-11f0-89cb-0242ac140002',2,6,241,1,1,4,11,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-JT-002c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(277,'4cabf13c-0934-11f0-9fd6-0242ac140002',2,6,241,1,1,4,12,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-JT-002c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(278,'4cac792c-0934-11f0-959e-0242ac140002',2,6,241,1,1,4,12,'Bermain dan bekerjasama','TKAB-SAFTELA-JT-002d','Bermain dan bekerjasama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(279,'4cad0dba-0934-11f0-804e-0242ac140002',2,6,241,1,1,4,11,'Bermain dan bekerjasama','TKAB-SAFTELA-JT-002d','Bermain dan bekerjasama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(280,'4cad97da-0934-11f0-a3af-0242ac140002',2,6,241,1,1,4,10,'Bermain dan bekerjasama','TKAB-SAFTELA-JT-002d','Bermain dan bekerjasama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(281,'4cae365e-0934-11f0-a13f-0242ac140002',2,6,241,1,1,4,10,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-JT-002e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(282,'4caecefc-0934-11f0-a07f-0242ac140002',2,6,241,1,1,4,11,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-JT-002e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(283,'4caf4eae-0934-11f0-91cc-0242ac140002',2,6,241,1,1,4,12,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-JT-002e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(284,'4cafe4ea-0934-11f0-8cd8-0242ac140002',2,6,241,1,1,4,12,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-JT-002f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(285,'4cb098a4-0934-11f0-ac68-0242ac140002',2,6,241,1,1,4,11,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-JT-002f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(286,'4cb17c42-0934-11f0-ae27-0242ac140002',2,6,241,1,1,4,10,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-JT-002f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(287,'4cb2320e-0934-11f0-9165-0242ac140002',2,6,241,1,1,4,10,'Memperhatikan penjelasan guru','TKAB-SAFTELA-JT-003a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(288,'4cb2cc6e-0934-11f0-8395-0242ac140002',2,6,241,1,1,4,11,'Memperhatikan penjelasan guru','TKAB-SAFTELA-JT-003a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(289,'4cb3940a-0934-11f0-86c8-0242ac140002',2,6,241,1,1,4,12,'Memperhatikan penjelasan guru','TKAB-SAFTELA-JT-003a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(290,'4cb41f06-0934-11f0-b196-0242ac140002',2,6,241,1,1,4,12,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-JT-003b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(291,'4cb4b7c2-0934-11f0-86f7-0242ac140002',2,6,241,1,1,4,11,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-JT-003b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(292,'4cb5367a-0934-11f0-8fb5-0242ac140002',2,6,241,1,1,4,10,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-JT-003b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(293,'4cb5c78e-0934-11f0-b671-0242ac140002',2,6,241,1,1,4,10,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-JT-003c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(294,'4cb64e5c-0934-11f0-a1a3-0242ac140002',2,6,241,1,1,4,11,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-JT-003c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(295,'4cb702e8-0934-11f0-81e3-0242ac140002',2,6,241,1,1,4,12,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-JT-003c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(296,'4cb78da8-0934-11f0-996c-0242ac140002',2,6,241,1,1,4,12,'Bermain dan bekerjasama','TKAB-SAFTELA-JT-003d','Bermain dan bekerjasama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(297,'4cb8153e-0934-11f0-885a-0242ac140002',2,6,241,1,1,4,11,'Bermain dan bekerjasama','TKAB-SAFTELA-JT-003d','Bermain dan bekerjasama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(298,'4cb891c6-0934-11f0-84ac-0242ac140002',2,6,241,1,1,4,10,'Bermain dan bekerjasama','TKAB-SAFTELA-JT-003d','Bermain dan bekerjasama','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(299,'4cb906f6-0934-11f0-85fb-0242ac140002',2,6,241,1,1,4,10,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-JT-003e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(300,'4cb98946-0934-11f0-8596-0242ac140002',2,6,241,1,1,4,11,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-JT-003e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(301,'4cba494e-0934-11f0-96bf-0242ac140002',2,6,241,1,1,4,12,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-JT-003e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(302,'4cbb0b68-0934-11f0-be21-0242ac140002',2,6,241,1,1,4,12,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-JT-003f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(303,'4cbbce86-0934-11f0-a8e2-0242ac140002',2,6,241,1,1,4,11,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-JT-003f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(304,'4cbc87e0-0934-11f0-8b22-0242ac140002',2,6,241,1,1,4,10,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-JT-003f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(305,'4cbd35e6-0934-11f0-83b0-0242ac140002',2,4,NULL,1,1,4,12,'Jati Diri','JT','Peserta didik diharapkan mampu mengenali, mengekspresikan, dan mengelola emosi diri serta membangun hubungan sosial secara sehat. Mengenal dan memiliki perilaku positif terhadap diri dan lingkungan (keluarga, sekolah, masyarakat, negara, dan dunia) serta rasa bangga sebagai anak Indonesia yang berlandaskan Pancasila. Menyesuaikan diri dengan lingkungan, aturan, dan norma yang berlaku.Menggunakan fungsi gerak (motorik kasar, halus, dan taktil) untuk mengeksplorasi dan memanipulasi berbagai objek dan lingkungan sekitar sebagai bentuk pengembangan diri.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(306,'4cbdbc0a-0934-11f0-8ae9-0242ac140002',2,5,305,1,1,4,12,'Berkomunikasi yang baik, berbagi, dan menunjukkan empati terhadap perasaan orang lain.','TKAB-SAFTELA-JT-001','Berkomunikasi yang baik, berbagi, dan menunjukkan empati terhadap perasaan orang lain.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(307,'4cbe3fd6-0934-11f0-9559-0242ac140002',2,5,305,1,1,4,12,'Mengidentifikasi dan menyelesaikan masalah sederhana dalam situasi sehari-hari.','TKAB-SAFTELA-JT-002','Mengidentifikasi dan menyelesaikan masalah sederhana dalam situasi sehari-hari.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(308,'4cbed450-0934-11f0-8182-0242ac140002',2,5,305,1,1,4,12,'Mengekspresikan diri melalui musik dan gerakan, serta berpartisipasi dalam aktivitas indvidual dengan penuh semangat.','TKAB-SAFTELA-JT-003','Mengekspresikan diri melalui musik dan gerakan, serta berpartisipasi dalam aktivitas indvidual dengan penuh semangat.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(309,'4cbf5592-0934-11f0-9554-0242ac140002',2,4,NULL,1,1,4,12,'Nilai Agama Dan Budi Pekerti','NAMB','Peserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(310,'4cbfe192-0934-11f0-9a7a-0242ac140002',2,5,309,1,1,4,12,'Mengenali pentingnya menjaga kebersihan serta keamanan diri dan lingkungan serta mampu melakukannya secara mandiri.','TKAB-SAFTELA-NAMB-001','Mengenali pentingnya menjaga kebersihan serta keamanan diri dan lingkungan serta mampu melakukannya secara mandiri.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(311,'4cc07bf2-0934-11f0-8219-0242ac140002',2,5,309,1,1,4,12,'Memahami dan menerapkan nilai-nilai kerjasama dan tanggung jawab dalam kegiatan di dalam dan di luar ruangan, serta mengenal lingkungan sekitar.','TKAB-SAFTELA-NAMB-002','Memahami dan menerapkan nilai-nilai kerjasama dan tanggung jawab dalam kegiatan di dalam dan di luar ruangan, serta mengenal lingkungan sekitar.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(312,'4cc110ee-0934-11f0-847a-0242ac140002',2,5,309,1,1,4,12,'Mengajukan pertanyaan tentang tanaman, hewan, fenomena alam, hubungan sebab akibat yang ditemukan.','TKAB-SAFTELA-NAMB-003','Mengajukan pertanyaan tentang tanaman, hewan, fenomena alam, hubungan sebab akibat yang ditemukan.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(313,'4cc1a144-0934-11f0-8243-0242ac140002',2,5,309,1,1,4,12,'Menerapkan keterampilan dasar dalam menyiapkan makanan, termasuk kebersihan dan keamanan makanan.','TKAB-SAFTELA-NAMB-004','Menerapkan keterampilan dasar dalam menyiapkan makanan, termasuk kebersihan dan keamanan makanan.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(314,'4cc2472a-0934-11f0-b7e5-0242ac140002',2,5,309,1,1,4,11,'Menerapkan keterampilan dasar dalam menyiapkan makanan, termasuk kebersihan dan keamanan makanan.','TKAB-SAFTELA-NAMB-004','Menerapkan keterampilan dasar dalam menyiapkan makanan, termasuk kebersihan dan keamanan makanan.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(315,'4cc2f0da-0934-11f0-ac10-0242ac140002',2,5,309,1,1,4,11,'Mengajukan pertanyaan tentang tanaman, hewan, fenomena alam, hubungan sebab akibat yang ditemukan.','TKAB-SAFTELA-NAMB-003','Mengajukan pertanyaan tentang tanaman, hewan, fenomena alam, hubungan sebab akibat yang ditemukan.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(316,'4cc39012-0934-11f0-a062-0242ac140002',2,5,309,1,1,4,11,'Memahami dan menerapkan nilai-nilai kerjasama dan tanggung jawab dalam kegiatan di dalam dan di luar ruangan, serta mengenal lingkungan sekitar.','TKAB-SAFTELA-NAMB-002','Memahami dan menerapkan nilai-nilai kerjasama dan tanggung jawab dalam kegiatan di dalam dan di luar ruangan, serta mengenal lingkungan sekitar.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(317,'4cc49eee-0934-11f0-ba7b-0242ac140002',2,5,309,1,1,4,11,'Mengenali pentingnya menjaga kebersihan serta keamanan diri dan lingkungan serta mampu melakukannya secara mandiri.','TKAB-SAFTELA-NAMB-001','Mengenali pentingnya menjaga kebersihan serta keamanan diri dan lingkungan serta mampu melakukannya secara mandiri.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(318,'4cc53e8a-0934-11f0-b27d-0242ac140002',2,5,309,1,1,4,10,'Mengenali pentingnya menjaga kebersihan serta keamanan diri dan lingkungan serta mampu melakukannya secara mandiri.','TKAB-SAFTELA-NAMB-001','Mengenali pentingnya menjaga kebersihan serta keamanan diri dan lingkungan serta mampu melakukannya secara mandiri.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(319,'4cc5c3be-0934-11f0-a73f-0242ac140002',2,5,309,1,1,4,10,'Memahami dan menerapkan nilai-nilai kerjasama dan tanggung jawab dalam kegiatan di dalam dan di luar ruangan, serta mengenal lingkungan sekitar.','TKAB-SAFTELA-NAMB-002','Memahami dan menerapkan nilai-nilai kerjasama dan tanggung jawab dalam kegiatan di dalam dan di luar ruangan, serta mengenal lingkungan sekitar.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(320,'4cc65c70-0934-11f0-a94b-0242ac140002',2,5,309,1,1,4,10,'Mengajukan pertanyaan tentang tanaman, hewan, fenomena alam, hubungan sebab akibat yang ditemukan.','TKAB-SAFTELA-NAMB-003','Mengajukan pertanyaan tentang tanaman, hewan, fenomena alam, hubungan sebab akibat yang ditemukan.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(321,'4cc6fa54-0934-11f0-af03-0242ac140002',2,5,309,1,1,4,10,'Menerapkan keterampilan dasar dalam menyiapkan makanan, termasuk kebersihan dan keamanan makanan.','TKAB-SAFTELA-NAMB-004','Menerapkan keterampilan dasar dalam menyiapkan makanan, termasuk kebersihan dan keamanan makanan.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(322,'4cc79464-0934-11f0-bffb-0242ac140002',2,4,NULL,1,1,4,10,'Nilai Agama Dan Budi Pekerti','NAMB','Peserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(323,'4cc886f8-0934-11f0-824a-0242ac140002',2,5,322,1,1,4,10,'Mengenali pentingnya menjaga kebersihan serta keamanan diri dan lingkungan serta mampu melakukannya secara mandiri.','TKAB-SAFTELA-NAMB-001','Mengenali pentingnya menjaga kebersihan serta keamanan diri dan lingkungan serta mampu melakukannya secara mandiri.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(324,'4cc91168-0934-11f0-99dc-0242ac140002',2,5,322,1,1,4,10,'Memahami dan menerapkan nilai-nilai kerjasama dan tanggung jawab dalam kegiatan di dalam dan di luar ruangan, serta mengenal lingkungan sekitar.','TKAB-SAFTELA-NAMB-002','Memahami dan menerapkan nilai-nilai kerjasama dan tanggung jawab dalam kegiatan di dalam dan di luar ruangan, serta mengenal lingkungan sekitar.','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(325,'4cc9b2ee-0934-11f0-882f-0242ac140002',2,5,322,1,1,4,10,'Mengajukan pertanyaan tentang tanaman, hewan, fenomena alam, hubungan sebab akibat yang ditemukan. ','TKAB-SAFTELA-NAMB-003','Mengajukan pertanyaan tentang tanaman, hewan, fenomena alam, hubungan sebab akibat yang ditemukan. ','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(326,'4cca564a-0934-11f0-9208-0242ac140002',2,5,322,1,1,4,10,'Menerapkan keterampilan dasar dalam menyiapkan makanan, termasuk kebersihan dan keamanan makanan. ','TKAB-SAFTELA-NAMB-004','Menerapkan keterampilan dasar dalam menyiapkan makanan, termasuk kebersihan dan keamanan makanan. ','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(327,'4ccad71e-0934-11f0-9593-0242ac140002',2,6,322,1,1,4,10,'Memperhatikan penjelasan guru','TKAB-SAFTELA-NAMB-001a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(328,'4ccb5da6-0934-11f0-b8ff-0242ac140002',2,6,322,1,1,4,11,'Memperhatikan penjelasan guru','TKAB-SAFTELA-NAMB-001a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(329,'4ccbe6ea-0934-11f0-bbb1-0242ac140002',2,6,322,1,1,4,12,'Memperhatikan penjelasan guru','TKAB-SAFTELA-NAMB-001a','Memperhatikan penjelasan guru','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(330,'4ccc9bda-0934-11f0-939d-0242ac140002',2,6,322,1,1,4,12,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-NAMB-001b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(331,'4ccd348c-0934-11f0-b441-0242ac140002',2,6,322,1,1,4,11,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-NAMB-001b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(332,'4ccdcd48-0934-11f0-ad9e-0242ac140002',2,6,322,1,1,4,10,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-NAMB-001b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:47','2025-03-25 04:47:47',NULL),(333,'4cce57ea-0934-11f0-8092-0242ac140002',2,6,322,1,1,4,10,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-NAMB-001c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(334,'4ccee1ba-0934-11f0-a68c-0242ac140002',2,6,322,1,1,4,11,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-NAMB-001c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(335,'4ccf696e-0934-11f0-a464-0242ac140002',2,6,322,1,1,4,12,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-NAMB-001c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(336,'4ccfe434-0934-11f0-999c-0242ac140002',2,6,322,1,1,4,12,'Bermain dan bekerjasama','TKAB-SAFTELA-NAMB-001d','Bermain dan bekerjasama','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(337,'4cd0761a-0934-11f0-b877-0242ac140002',2,6,322,1,1,4,11,'Bermain dan bekerjasama','TKAB-SAFTELA-NAMB-001d','Bermain dan bekerjasama','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(338,'4cd14ef0-0934-11f0-806e-0242ac140002',2,6,322,1,1,4,10,'Bermain dan bekerjasama','TKAB-SAFTELA-NAMB-001d','Bermain dan bekerjasama','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(339,'4cd1ebee-0934-11f0-96b5-0242ac140002',2,6,322,1,1,4,10,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-NAMB-001e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(340,'4cd287e8-0934-11f0-9640-0242ac140002',2,6,322,1,1,4,11,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-NAMB-001e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(341,'4cd31686-0934-11f0-9641-0242ac140002',2,6,322,1,1,4,12,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-NAMB-001e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(342,'4cd3bc80-0934-11f0-8fd7-0242ac140002',2,6,322,1,1,4,12,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-NAMB-001f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(343,'4cd4501e-0934-11f0-92e1-0242ac140002',2,6,322,1,1,4,11,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-NAMB-001f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(344,'4cd4d08e-0934-11f0-84f5-0242ac140002',2,6,322,1,1,4,10,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-NAMB-001f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(345,'4cd56b5c-0934-11f0-9c82-0242ac140002',2,6,322,1,1,4,10,'Memperhatikan penjelasan guru','TKAB-SAFTELA-NAMB-002a','Memperhatikan penjelasan guru','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(346,'4cd5eef6-0934-11f0-8d42-0242ac140002',2,6,322,1,1,4,10,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-NAMB-002b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(347,'4cd68186-0934-11f0-8beb-0242ac140002',2,6,322,1,1,4,10,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-NAMB-002c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(348,'4cd71308-0934-11f0-a294-0242ac140002',2,6,322,1,1,4,10,'Bermain dan bekerjasama','TKAB-SAFTELA-NAMB-002d','Bermain dan bekerjasama','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(349,'4cd79878-0934-11f0-8287-0242ac140002',2,6,322,1,1,4,10,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-NAMB-002e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(350,'4cd82112-0934-11f0-9702-0242ac140002',2,6,322,1,1,4,10,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-NAMB-002f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(351,'4cd8a8a8-0934-11f0-9024-0242ac140002',2,6,322,1,1,4,10,'Memperhatikan penjelasan guru','TKAB-SAFTELA-NAMB-003a','Memperhatikan penjelasan guru','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(352,'4cd93bd8-0934-11f0-a41f-0242ac140002',2,6,322,1,1,4,10,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-NAMB-003b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(353,'4cd9e09c-0934-11f0-9217-0242ac140002',2,6,322,1,1,4,10,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-NAMB-003c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(354,'4cda8dda-0934-11f0-8af7-0242ac140002',2,6,322,1,1,4,10,'Bermain dan bekerjasama','TKAB-SAFTELA-NAMB-003d','Bermain dan bekerjasama','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(355,'4cdb25ce-0934-11f0-beeb-0242ac140002',2,6,322,1,1,4,10,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-NAMB-003e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(356,'4cdbb5c0-0934-11f0-9b70-0242ac140002',2,6,322,1,1,4,10,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-NAMB-003f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(357,'4cdc3b44-0934-11f0-bbc2-0242ac140002',2,6,322,1,1,4,10,'Memperhatikan penjelasan guru','TKAB-SAFTELA-NAMB-004a','Memperhatikan penjelasan guru','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(358,'4cdcb574-0934-11f0-9c11-0242ac140002',2,6,322,1,1,4,10,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-NAMB-004b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(359,'4cdd4368-0934-11f0-9fbd-0242ac140002',2,6,322,1,1,4,10,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-NAMB-004c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(360,'4cddc02c-0934-11f0-9229-0242ac140002',2,6,322,1,1,4,10,'Bermain dan bekerjasama','TKAB-SAFTELA-NAMB-004d','Bermain dan bekerjasama','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(361,'4cde7274-0934-11f0-a567-0242ac140002',2,6,322,1,1,4,10,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-NAMB-004e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(362,'4cdf432a-0934-11f0-a6f4-0242ac140002',2,6,322,1,1,4,10,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-NAMB-004f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(363,'4cdfe9c4-0934-11f0-a431-0242ac140002',2,6,322,1,1,4,11,'Memperhatikan penjelasan guru','TKAB-SAFTELA-NAMB-002a','Memperhatikan penjelasan guru','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(364,'4ce0a7f6-0934-11f0-a048-0242ac140002',2,6,322,1,1,4,12,'Memperhatikan penjelasan guru','TKAB-SAFTELA-NAMB-002a','Memperhatikan penjelasan guru','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(365,'4ce144c2-0934-11f0-b2df-0242ac140002',2,6,322,1,1,4,12,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-NAMB-002b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(366,'4ce1c5f0-0934-11f0-baa0-0242ac140002',2,6,322,1,1,4,11,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-NAMB-002b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(367,'4ce25556-0934-11f0-8249-0242ac140002',2,6,322,1,1,4,11,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-NAMB-002c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(368,'4ce2db0c-0934-11f0-b1ea-0242ac140002',2,6,322,1,1,4,12,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-NAMB-002c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(369,'4ce368e2-0934-11f0-a097-0242ac140002',2,6,322,1,1,4,12,'Bermain dan bekerjasama','TKAB-SAFTELA-NAMB-002d','Bermain dan bekerjasama','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(370,'4ce3f23a-0934-11f0-b779-0242ac140002',2,6,322,1,1,4,11,'Bermain dan bekerjasama','TKAB-SAFTELA-NAMB-002d','Bermain dan bekerjasama','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(371,'4ce473ea-0934-11f0-9821-0242ac140002',2,6,322,1,1,4,11,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-NAMB-002e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(372,'4ce501c0-0934-11f0-bd4b-0242ac140002',2,6,322,1,1,4,12,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-NAMB-002e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(373,'4ce59b80-0934-11f0-b892-0242ac140002',2,6,322,1,1,4,12,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-NAMB-002f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(374,'4ce6aa0c-0934-11f0-94fe-0242ac140002',2,6,322,1,1,4,11,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-NAMB-002f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(375,'4ce743d6-0934-11f0-a071-0242ac140002',2,6,322,1,1,4,11,'Memperhatikan penjelasan guru','TKAB-SAFTELA-NAMB-003a','Memperhatikan penjelasan guru','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(376,'4ce7cc02-0934-11f0-823c-0242ac140002',2,6,322,1,1,4,12,'Memperhatikan penjelasan guru','TKAB-SAFTELA-NAMB-003a','Memperhatikan penjelasan guru','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(377,'4ce8645a-0934-11f0-83fa-0242ac140002',2,6,322,1,1,4,12,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-NAMB-003b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(378,'4ce8ff78-0934-11f0-b1c3-0242ac140002',2,6,322,1,1,4,11,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-NAMB-003b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(379,'4ce9809c-0934-11f0-91ae-0242ac140002',2,6,322,1,1,4,11,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-NAMB-003c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(380,'4ce9fe50-0934-11f0-9709-0242ac140002',2,6,322,1,1,4,12,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-NAMB-003c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(381,'4cea899c-0934-11f0-81ed-0242ac140002',2,6,322,1,1,4,12,'Bermain dan bekerjasama','TKAB-SAFTELA-NAMB-003d','Bermain dan bekerjasama','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(382,'4ceb346e-0934-11f0-9d4c-0242ac140002',2,6,322,1,1,4,11,'Bermain dan bekerjasama','TKAB-SAFTELA-NAMB-003d','Bermain dan bekerjasama','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(383,'4cebc4b0-0934-11f0-bc33-0242ac140002',2,6,322,1,1,4,11,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-NAMB-003e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(384,'4cec51e6-0934-11f0-9338-0242ac140002',2,6,322,1,1,4,12,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-NAMB-003e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(385,'4cecf060-0934-11f0-bb5e-0242ac140002',2,6,322,1,1,4,12,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-NAMB-003f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(386,'4ced904c-0934-11f0-91f1-0242ac140002',2,6,322,1,1,4,11,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-NAMB-003f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(387,'4cee24da-0934-11f0-a7fe-0242ac140002',2,6,322,1,1,4,11,'Memperhatikan penjelasan guru','TKAB-SAFTELA-NAMB-004a','Memperhatikan penjelasan guru','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(388,'4ceea93c-0934-11f0-99b5-0242ac140002',2,6,322,1,1,4,12,'Memperhatikan penjelasan guru','TKAB-SAFTELA-NAMB-004a','Memperhatikan penjelasan guru','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(389,'4cef2f42-0934-11f0-b08d-0242ac140002',2,6,322,1,1,4,12,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-NAMB-004b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(390,'4cefc722-0934-11f0-b63c-0242ac140002',2,6,322,1,1,4,11,'Mengamati gambar / alat peraga / video terkait tema','TKAB-SAFTELA-NAMB-004b','Mengamati gambar / alat peraga / video terkait tema','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(391,'4cf04d0a-0934-11f0-a665-0242ac140002',2,6,322,1,1,4,11,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-NAMB-004c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(392,'4cf0f4b2-0934-11f0-b72b-0242ac140002',2,6,322,1,1,4,11,'Bermain dan bekerjasama','TKAB-SAFTELA-NAMB-004d','Bermain dan bekerjasama','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(393,'4cf1770c-0934-11f0-a1ff-0242ac140002',2,6,322,1,1,4,12,'Bermain dan bekerjasama','TKAB-SAFTELA-NAMB-004d','Bermain dan bekerjasama','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(394,'4cf1f65a-0934-11f0-ac6f-0242ac140002',2,6,322,1,1,4,12,'Mencoba kegiatan yang ditawarkan','TKAB-SAFTELA-NAMB-004c','Mencoba kegiatan yang ditawarkan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(395,'4cf28aca-0934-11f0-b938-0242ac140002',2,6,322,1,1,4,12,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-NAMB-004e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(396,'4cf31bc0-0934-11f0-b0f7-0242ac140002',2,6,322,1,1,4,11,'Merapikan bahan dan alat main setelah digunakan','TKAB-SAFTELA-NAMB-004e','Merapikan bahan dan alat main setelah digunakan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(397,'4cf3a50e-0934-11f0-9f57-0242ac140002',2,6,322,1,1,4,11,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-NAMB-004f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(398,'4cf43582-0934-11f0-ac93-0242ac140002',2,6,322,1,1,4,12,'Membuat kesimpulan dan perasaan dari kegiatan tersebut','TKAB-SAFTELA-NAMB-004f','Membuat kesimpulan dan perasaan dari kegiatan tersebut','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(399,'4cf4d9d8-0934-11f0-ba15-0242ac140002',2,4,NULL,1,1,4,5,'Nilai Agama Dan Budi Pekerti','NAMB','Peserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(400,'4cf559d0-0934-11f0-84fb-0242ac140002',2,4,NULL,1,1,4,2,'Jati Diri','JT','Peserta didik diharapkan mampu mengenali, mengekspresikan, dan mengelola emosi diri serta membangun hubungan sosial secara sehat. Mengenal dan memiliki perilaku positif terhadap diri dan lingkungan (keluarga, sekolah, masyarakat, negara, dan dunia) serta rasa bangga sebagai anak Indonesia yang berlandaskan Pancasila. Menyesuaikan diri dengan lingkungan, aturan, dan norma yang berlaku.Menggunakan fungsi gerak (motorik kasar, halus, dan taktil) untuk mengeksplorasi dan memanipulasi berbagai objek dan lingkungan sekitar sebagai bentuk pengembangan diri.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(401,'4cf5ee86-0934-11f0-a426-0242ac140002',2,4,NULL,1,1,4,8,'Jati Diri','JT','Peserta didik diharapkan mampu mengenali, mengekspresikan, dan mengelola emosi diri serta membangun hubungan sosial secara sehat. Mengenal dan memiliki perilaku positif terhadap diri dan lingkungan (keluarga, sekolah, masyarakat, negara, dan dunia) serta rasa bangga sebagai anak Indonesia yang berlandaskan Pancasila. Menyesuaikan diri dengan lingkungan, aturan, dan norma yang berlaku.Menggunakan fungsi gerak (motorik kasar, halus, dan taktil) untuk mengeksplorasi dan memanipulasi berbagai objek dan lingkungan sekitar sebagai bentuk pengembangan diri.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(402,'4cf66f46-0934-11f0-bcbf-0242ac140002',2,4,NULL,1,1,4,9,'Jati Diri','JT','Peserta didik diharapkan mampu mengenali, mengekspresikan, dan mengelola emosi diri serta membangun hubungan sosial secara sehat. Mengenal dan memiliki perilaku positif terhadap diri dan lingkungan (keluarga, sekolah, masyarakat, negara, dan dunia) serta rasa bangga sebagai anak Indonesia yang berlandaskan Pancasila. Menyesuaikan diri dengan lingkungan, aturan, dan norma yang berlaku.Menggunakan fungsi gerak (motorik kasar, halus, dan taktil) untuk mengeksplorasi dan memanipulasi berbagai objek dan lingkungan sekitar sebagai bentuk pengembangan diri.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(403,'4cf6f506-0934-11f0-b5d2-0242ac140002',2,4,NULL,1,1,4,2,'Dasar - Dasar Literasi Dan STEAM','STEAM-L','Peserta didik diharapkan mampu mengenali dan memahami berbagai informasi, mengkomunikasikan perasaan dan pikiran secara lisan, tulisan, atau berbagai media, serta membangun percakapan.Menujukkan minat, kegemaran, dan berpartisipasi dalam kegaitan Pra membaca dan pra menulis.Mengenali mengunakan konsep pra matematika untuk memecahkan masalah di dalam kehidupan sehari-hari. Menunjukkan kemampuan dasar berpikir Kritis, kreatif, dan kolaboratif. Menunjukkan rasa ingin tahu melalui observasi, eksplorasi, dan eksprimen dengan menggunakan lingkungan sekitar dan media sebagai sumber belajar, untuk mendapatkan gagasan mengenai fenomena alam dan sosial. Menunjukkan kemampuan awal menggunakan dan merakayasa teknologi sederhana, untuk mencari informasi, dan gagasan, dan keterampilan secara aman dan bertanggung jawab. Mengeksplorasi berbagai proses seni, mengekspresikannnya serta mengapresiasi.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(404,'4cf78fd4-0934-11f0-ba6d-0242ac140002',2,6,403,1,1,4,8,'Murid mencoba mengulangi ucapan dua silabel yang diucapkan oleh pengajar.','TKB-MBM-STEAML-002a','Murid mencoba mengulangi ucapan dua silabel yang diucapkan oleh pengajar.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(405,'4cf80b4e-0934-11f0-a6e8-0242ac140002',2,6,403,1,1,4,8,'Murid mencoba mengulangi kalimat pendek yang diucapkan oleh pengajar atau media ajar.','TKB-MBM-STEAML-002b','Murid mencoba mengulangi kalimat pendek yang diucapkan oleh pengajar atau media ajar.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(406,'4cf88ede-0934-11f0-999e-0242ac140002',2,6,403,1,1,4,9,'Menanyakan pengalaman anak terkait jenis kelamin.','TKB-SS-STEAML-001a','Menanyakan pengalaman anak terkait jenis kelamin.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(407,'4cf91976-0934-11f0-8bc0-0242ac140002',2,6,403,1,1,4,9,'Guru menunjukkan foto sekelompok orang dengan berbagai jenis kelamin dan meminta anak untuk menebak jenis kelamin dan nama panggilannya.','TKB-SS-STEAML-001b','Guru menunjukkan foto sekelompok orang dengan berbagai jenis kelamin dan meminta anak untuk menebak jenis kelamin dan nama panggilannya.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(408,'4cf9b7d2-0934-11f0-8291-0242ac140002',2,6,403,1,1,4,9,'Guru menunjukkan karya seni yang sudah jadi dan menunjukkan cara membuatnya.','TKB-SS-STEAML-001c','Guru menunjukkan karya seni yang sudah jadi dan menunjukkan cara membuatnya.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(409,'4cfa52f0-0934-11f0-999e-0242ac140002',2,6,403,1,1,4,9,'Anak menggambar gambar diri sesuai jenis kelaminnya, menggunting dan membuat wayang.','TKB-SS-STEAML-001d','Anak menggambar gambar diri sesuai jenis kelaminnya, menggunting dan membuat wayang.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(410,'4cfae972-0934-11f0-ad31-0242ac140002',2,6,403,1,1,4,9,'Anak membuat kartu nama berisi gambar diri, jenis kelamin dan usia.','TKB-SS-STEAML-001e','Anak membuat kartu nama berisi gambar diri, jenis kelamin dan usia.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(411,'4cfb78ce-0934-11f0-9c59-0242ac140002',2,6,403,1,1,4,9,'Anak dan guru melakukan refleksi akhir kegiatan tentang jenis kelamin dan nama panggilannya.','TKB-SS-STEAML-001f','Anak dan guru melakukan refleksi akhir kegiatan tentang jenis kelamin dan nama panggilannya.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(412,'4cfbff1a-0934-11f0-8e3f-0242ac140002',2,6,403,1,1,4,9,'Menanyakan pengalaman anak tentang fungsi anggota tubuh, dan meminta anak menebak nama anggota tubuh yang dimaksud.','TKB-SS-STEAML-002a','Menanyakan pengalaman anak tentang fungsi anggota tubuh, dan meminta anak menebak nama anggota tubuh yang dimaksud.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(413,'4cfca56e-0934-11f0-88ac-0242ac140002',2,6,403,1,1,4,9,'Bernyanyi kepala pundak lutut kaki.','TKB-SS-STEAML-002b','Bernyanyi kepala pundak lutut kaki.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(414,'4cfd2a7a-0934-11f0-ae62-0242ac140002',2,6,403,1,1,4,9,'Bernyanyi kepala pundak lutut kaki sambil menunjuk pada anggota tubuh yang tepat pada gambar tubuh manusia di proyektor yang ditampilkan.','TKB-SS-STEAML-002c','Bernyanyi kepala pundak lutut kaki sambil menunjuk pada anggota tubuh yang tepat pada gambar tubuh manusia di proyektor yang ditampilkan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(415,'4cfdaad6-0934-11f0-be66-0242ac140002',2,6,403,1,1,4,9,'Membuat mulut dari kertas cover dan kapas.','TKB-SS-STEAML-002d','Membuat mulut dari kertas cover dan kapas.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(416,'4cfe2cea-0934-11f0-9a2e-0242ac140002',2,6,403,1,1,4,9,'Membuat mata dari kertas.','TKB-SS-STEAML-002e','Membuat mata dari kertas.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(417,'4cfeb264-0934-11f0-9e50-0242ac140002',2,6,403,1,1,4,9,'Anak bernyanyi lagu \"kepala pundak lutut kaki\" dengan ketukan yang sesuai.','TKB-SS-STEAML-002f','Anak bernyanyi lagu \"kepala pundak lutut kaki\" dengan ketukan yang sesuai.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(418,'4cff4404-0934-11f0-90d3-0242ac140002',2,6,403,1,1,4,9,'Anak dan guru melakukan refleksi akhir kegiatan.','TKB-SS-STEAML-002g','Anak dan guru melakukan refleksi akhir kegiatan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(419,'4cffe198-0934-11f0-9a2a-0242ac140002',2,6,403,1,1,4,9,'Anak dan guru melakukan refleksi akhir kegiatan.','TKB-SS-STEAML-003a','Menanyakan pengalaman anak tentang rumah, bagian luar rumah serta fungsinya.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(420,'4d008652-0934-11f0-a2bf-0242ac140002',2,6,403,1,1,4,9,'Guru menunjukkan video tentang fungsi rumah.','TKB-SS-STEAML-003b','Guru menunjukkan video tentang fungsi rumah.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(421,'4d012ce2-0934-11f0-8c87-0242ac140002',2,6,403,1,1,4,9,'Anak melipat kertas membentuk pintu dengan 2 daun, lalu melukis bagian luarnya menyerupai rumah yang di tengahnya terbelah. Bagian dalamnya ditempelkan gambar ruangan-ruangan.','TKB-SS-STEAML-003c','Anak melipat kertas membentuk pintu dengan 2 daun, lalu melukis bagian luarnya menyerupai rumah yang di tengahnya terbelah. Bagian dalamnya ditempelkan gambar ruangan-ruangan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(422,'4d022bba-0934-11f0-8a5f-0242ac140002',2,6,403,1,1,4,9,'Anak membuat rumah dari paper cup, lem, gunting, dan kertas origami, dan membuat halamannya.','TKB-SS-STEAML-003d','Anak membuat rumah dari paper cup, lem, gunting, dan kertas origami, dan membuat halamannya.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(423,'4d02bac6-0934-11f0-bfd3-0242ac140002',2,6,403,1,1,4,9,'Anak dan guru melakukan refleksi akhir kegiatan.','TKB-SS-STEAML-003e','Anak dan guru melakukan refleksi akhir kegiatan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(424,'4d034ad6-0934-11f0-be2a-0242ac140002',2,6,403,1,1,4,9,'Menyanyi lagu tentang makanan dan mengajak anak-anak mengikuti iramanya.','TKB-SS-STEAML-004a','Menyanyi lagu tentang makanan dan mengajak anak-anak mengikuti iramanya.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(425,'4d03d302-0934-11f0-934b-0242ac140002',2,6,403,1,1,4,9,'Menanyakan pengalaman anak tentang berbagai macam makanan dan minuman sehat dan tidak sehat.','TKB-SS-STEAML-004b','Menanyakan pengalaman anak tentang berbagai macam makanan dan minuman sehat dan tidak sehat.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(426,'4d047532-0934-11f0-99c4-0242ac140002',2,6,403,1,1,4,9,'Guru menunjukkan contoh pekerjaan yang sudah jadi.','TKB-SS-STEAML-004c','Guru menunjukkan contoh pekerjaan yang sudah jadi.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(427,'4d05072c-0934-11f0-960e-0242ac140002',2,6,403,1,1,4,9,'Anak membuat nasi campur dari piring kertas, kapas dan kertas origami, lalu membuat paha ayam dari kertas cokelat.','TKB-SS-STEAML-004d','Anak membuat nasi campur dari piring kertas, kapas dan kertas origami, lalu membuat paha ayam dari kertas cokelat.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(428,'4d058ac6-0934-11f0-9512-0242ac140002',2,6,403,1,1,4,9,'Anak membuat lukisan nanas dengan jari.','TKB-SS-STEAML-004e','Anak membuat lukisan nanas dengan jari.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(429,'4d061928-0934-11f0-bdfa-0242ac140002',2,6,403,1,1,4,9,'Anak dan guru melakukan refleksi akhir kegiatan.','TKB-SS-STEAML-004f','Anak dan guru melakukan refleksi akhir kegiatan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(430,'4d06c2ce-0934-11f0-880a-0242ac140002',2,6,403,1,1,4,9,'Menanyakan pengalaman anak terhadap hewan yang pernah ia lihat di sekitar.','TKB-SS-STEAML-007a','Menanyakan pengalaman anak terhadap hewan yang pernah ia lihat di sekitar.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(431,'4d074a28-0934-11f0-b86a-0242ac140002',2,6,403,1,1,4,9,'Guru menunjukkan gambar-gambar tentang daur hidup hewan','TKB-SS-STEAML-007b','Guru menunjukkan gambar-gambar tentang daur hidup hewan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(432,'4d07e7ee-0934-11f0-9fec-0242ac140002',2,6,403,1,1,4,9,'Guru menerangkan cara dalam berkegiatan','TKB-SS-STEAML-007c','Guru menerangkan cara dalam berkegiatan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(433,'4d088776-0934-11f0-ac4d-0242ac140002',2,6,403,1,1,4,9,'Anak menggunakan jari tangannya untuk membuat lukisan gambar ulat.','TKB-SS-STEAML-007d','Anak menggunakan jari tangannya untuk membuat lukisan gambar ulat.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(434,'4d09215e-0934-11f0-98b2-0242ac140002',2,6,403,1,1,4,9,'Anak membuat dan menempelkan gambar kupu-kupu.','TKB-SS-STEAML-007e','Anak membuat dan menempelkan gambar kupu-kupu.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(435,'4d09c73a-0934-11f0-bedd-0242ac140002',2,6,403,1,1,4,9,'Anak dan guru melakukan refleksi akhir kegiatan.','TKB-SS-STEAML-007f','Anak dan guru melakukan refleksi akhir kegiatan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(436,'4d0a4f34-0934-11f0-b483-0242ac140002',2,4,NULL,1,1,4,8,'Dasar - Dasar Literasi Dan STEAM','STEAM-L','Peserta didik diharapkan mampu mengenali dan memahami berbagai informasi, mengkomunikasikan perasaan dan pikiran secara lisan, tulisan, atau berbagai media, serta membangun percakapan.Menujukkan minat, kegemaran, dan berpartisipasi dalam kegaitan Pra membaca dan pra menulis.Mengenali mengunakan konsep pra matematika untuk memecahkan masalah di dalam kehidupan sehari-hari. Menunjukkan kemampuan dasar berpikir Kritis, kreatif, dan kolaboratif. Menunjukkan rasa ingin tahu melalui observasi, eksplorasi, dan eksprimen dengan menggunakan lingkungan sekitar dan media sebagai sumber belajar, untuk mendapatkan gagasan mengenai fenomena alam dan sosial. Menunjukkan kemampuan awal menggunakan dan merakayasa teknologi sederhana, untuk mencari informasi, dan gagasan, dan keterampilan secara aman dan bertanggung jawab. Mengeksplorasi berbagai proses seni, mengekspresikannnya serta mengapresiasi.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(437,'4d0ad3dc-0934-11f0-a739-0242ac140002',2,5,436,1,1,4,8,'Murid mengenali huruf vokal dan konsonan dalam bahasa Mandarin','TKB-MBM-STEAML-001','Murid mengenali huruf vokal dan konsonan dalam bahasa Mandarin','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(438,'4d0b5f8c-0934-11f0-9e90-0242ac140002',2,5,436,1,1,4,8,'Murid menyebutkan bilangan 1-10 dalam bahasa Mandarin','TKB-MBM-STEAML-002','Murid menyebutkan bilangan 1-10 dalam bahasa Mandarin','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(439,'4d0be196-0934-11f0-a234-0242ac140002',2,5,436,1,1,4,8,'Murid mencocokkan lambang angka Arab dengan hanzi angka','TKB-MBM-STEAML-003','Murid mencocokkan lambang angka Arab dengan hanzi angka','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(440,'4d0c69c2-0934-11f0-a949-0242ac140002',2,5,436,1,1,4,8,'Murid menggunakan hanzi angka untuk berhitung','TKB-MBM-STEAML-004','Murid menggunakan hanzi angka untuk berhitung','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(441,'4d0cecf8-0934-11f0-9f09-0242ac140002',2,5,436,1,1,4,8,'Murid menggunakan alat tulis dan alat makan dengan cara yang benar','TKB-MBM-STEAML-005','Murid menggunakan alat tulis dan alat makan dengan cara yang benar','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(442,'4d0d85aa-0934-11f0-ab7c-0242ac140002',2,5,436,1,1,4,8,'Murid membaca nama sendiri secara mandiri','TKB-MBM-STEAML-006','Murid membaca nama sendiri secara mandiri','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(443,'4d0e1592-0934-11f0-ac25-0242ac140002',2,5,436,1,1,4,8,'Murid menuliskan nama sendiri secara mandiri','TKB-MBM-STEAML-007','Murid menuliskan nama sendiri secara mandiri','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(444,'4d0e9b0c-0934-11f0-860e-0242ac140002',2,5,436,1,1,4,8,'Murid mengenali kosakata benda yang ada di sekitarnya','TKB-MBM-STEAML-008','Murid mengenali kosakata benda yang ada di sekitarnya','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(445,'4d0f25cc-0934-11f0-a93e-0242ac140002',2,5,436,1,1,4,8,'Murid memahami hubungan antara bentuk hanzi dan artinya','TKB-MBM-STEAML-009','Murid memahami hubungan antara bentuk hanzi dan artinya','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(446,'4d0fa7a4-0934-11f0-ae95-0242ac140002',2,5,436,1,1,4,8,'Murid mengulangi kalimat kompleks','TKB-MBM-STEAML-010','Murid mengulangi kalimat kompleks','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(447,'4d1040ec-0934-11f0-80fd-0242ac140002',2,5,436,1,1,4,8,'Murid mengerti lebih dari satu perintah secara bersamaan dan meresponnya','TKB-MBM-STEAML-011','Murid mengerti lebih dari satu perintah secara bersamaan dan meresponnya','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(448,'4d10cba2-0934-11f0-8fe6-0242ac140002',2,5,436,1,1,4,8,'Murid memahami aturan permainan yang diberikan pengajar','TKB-MBM-STEAML-012','Murid memahami aturan permainan yang diberikan pengajar','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(449,'4d116210-0934-11f0-a398-0242ac140002',2,5,436,1,1,4,8,'Murid menunjukkan ulang benda-benda dalam bentuk gambar atau tulisan','TKB-MBM-STEAML-013','Murid menunjukkan ulang benda-benda dalam bentuk gambar atau tulisan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(450,'4d11e924-0934-11f0-acf2-0242ac140002',2,5,436,1,1,4,8,'Murid menyebutkan ulang hanzi yang telah dikenali','TKB-MBM-STEAML-014','Murid menyebutkan ulang hanzi yang telah dikenali','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(451,'4d127f88-0934-11f0-9129-0242ac140002',2,5,436,1,1,4,8,'Murid menyebut pinyin sama, tapi beda ton','TKB-MBM-STEAML-015','Murid menyebut pinyin sama, tapi beda ton','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(452,'4d131ae2-0934-11f0-a721-0242ac140002',2,5,436,1,1,4,8,'Murid menyebut pinyin yang konsonan depannya sama.','TKB-MBM-STEAML-016','Murid menyebut pinyin yang konsonan depannya sama.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(453,'4d13d8c4-0934-11f0-9213-0242ac140002',2,5,436,1,1,4,8,'Murid menikmati dan menghargai bacaan','TKB-MBM-STEAML-017','Murid menikmati dan menghargai bacaan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(454,'4d14761c-0934-11f0-91d0-0242ac140002',2,5,436,1,1,4,8,'Murid menyusun kalimat sederhana menggunakan struktur bahasa Mandarin (SKPO)','TKB-MBM-STEAML-018','Murid menyusun kalimat sederhana menggunakan struktur bahasa Mandarin (SKPO)','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(455,'4d150fb4-0934-11f0-b69b-0242ac140002',2,5,436,1,1,4,8,'Murid memperkaya kosakata untuk mengekspresikan ide pada orang lain','TKB-MBM-STEAML-019','Murid memperkaya kosakata untuk mengekspresikan ide pada orang lain','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(456,'4d15b838-0934-11f0-b26d-0242ac140002',2,5,436,1,1,4,8,'Murid berbicara bahasa Mandarin dengan pembendaharaan kata dan mengenal simbol yang berkaitan dengan bahasa Mandarin','TKB-MBM-STEAML-020','Murid berbicara bahasa Mandarin dengan pembendaharaan kata dan mengenal simbol yang berkaitan dengan bahasa Mandarin','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(457,'4d166472-0934-11f0-9427-0242ac140002',2,5,436,1,1,4,8,'Murid menikmati dan menghargai bacaan','TKB-MBM-STEAML-021','Murid menikmati dan menghargai bacaan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(458,'4d16ee2e-0934-11f0-aa54-0242ac140002',2,5,436,1,1,4,8,'Murid memahami konsep dalam cerita yang didengarkan','TKB-MBM-STEAML-022','Murid memahami konsep dalam cerita yang didengarkan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(459,'4d1782da-0934-11f0-9200-0242ac140002',2,5,436,1,1,4,8,'Murid memahami arti kata dalam cerita yang didengarkan sesuai konteks','TKB-MBM-STEAML-023','Murid memahami arti kata dalam cerita yang didengarkan sesuai konteks','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(460,'4d181c68-0934-11f0-937d-0242ac140002',2,5,436,1,1,4,8,'Murid tertarik meneruskan sebagian cerita/dongeng yang telah didengarkan','TKB-MBM-STEAML-024','Murid tertarik meneruskan sebagian cerita/dongeng yang telah didengarkan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(461,'4d18a7f0-0934-11f0-8463-0242ac140002',2,5,436,1,1,4,9,'Membuat karya seni dan menyebutkan jenis kelamin setiap anggota keluarga.','TKB-SS-STEAML-001','Membuat karya seni dan menyebutkan jenis kelamin setiap anggota keluarga.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(462,'4d192cac-0934-11f0-99e9-0242ac140002',2,5,436,1,1,4,9,'Menyanyikan lagu tentang anggota tubuh dengan ketukan yang tepat dan menyebutkan fungsi anggota-anggota tubuh.','TKB-SS-STEAML-002','Menyanyikan lagu tentang anggota tubuh dengan ketukan yang tepat dan menyebutkan fungsi anggota-anggota tubuh.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(463,'4d19c96e-0934-11f0-9142-0242ac140002',2,5,436,1,1,4,9,'Membuat rumah seperti bentuk sesungguhnya dan dapat menjelaskan fungsinya.','TKB-SS-STEAML-003','Membuat rumah seperti bentuk sesungguhnya dan dapat menjelaskan fungsinya.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(464,'4d1a663a-0934-11f0-9af2-0242ac140002',2,5,436,1,1,4,9,'Membuat karya berupa makanan sehat dengan cara meniru bentuk.','TKB-SS-STEAML-004','Membuat karya berupa makanan sehat dengan cara meniru bentuk.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(465,'4d1af65e-0934-11f0-9576-0242ac140002',2,5,436,1,1,4,9,'Menggunakan berbagai macam alat musik tradisional maupun alat musik lain untuk menirukan suatu irama atau lagu ampar-ampar pisangMenggunakan berbagai macam alat musik tradisional maupun alat musik lain untuk menirukan suatu irama atau lagu ampar-ampar pisang','TKB-SS-STEAML-005','Menggunakan berbagai macam alat musik tradisional maupun alat musik lain untuk menirukan suatu irama atau lagu ampar-ampar pisang','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(466,'4d1b94a6-0934-11f0-bfd9-0242ac140002',2,5,436,1,1,4,9,'Menggambar berbagai macam bentuk yang beragam dengan kreatifitas masing-masing','TKB-SS-STEAML-006','Menggambar berbagai macam bentuk yang beragam dengan kreatifitas masing-masing','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(467,'4d1c3172-0934-11f0-a4b4-0242ac140002',2,5,436,1,1,4,9,'Melukis dengan teknik cetak dengan korek kuping','TKB-SS-STEAML-007','Melukis dengan teknik cetak dengan korek kuping','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(468,'4d1cbe94-0934-11f0-a484-0242ac140002',2,5,436,1,1,4,9,'Membuat karya seperti bentuk keranjang buah dengan berbagai bahan plastisin','TKB-SS-STEAML-008','Membuat karya seperti bentuk keranjang buah dengan berbagai bahan plastisin','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(469,'4d1d7492-0934-11f0-abbc-0242ac140002',2,5,436,1,1,4,9,'Membuat karya seni dengan cara melukis dengan berbagai cara dan menghiasinya dengan gambar yang tepat.','TKB-SS-STEAML-009','Membuat karya seni dengan cara melukis dengan berbagai cara dan menghiasinya dengan gambar yang tepat.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(470,'4d1e0812-0934-11f0-9fac-0242ac140002',2,4,NULL,1,1,4,9,'Dasar - Dasar Literasi Dan STEAM','STEAM-L','Peserta didik diharapkan mampu mengenali dan memahami berbagai informasi, mengkomunikasikan perasaan dan pikiran secara lisan, tulisan, atau berbagai media, serta membangun percakapan.Menujukkan minat, kegemaran, dan berpartisipasi dalam kegaitan Pra membaca dan pra menulis.Mengenali mengunakan konsep pra matematika untuk memecahkan masalah di dalam kehidupan sehari-hari. Menunjukkan kemampuan dasar berpikir Kritis, kreatif, dan kolaboratif. Menunjukkan rasa ingin tahu melalui observasi, eksplorasi, dan eksprimen dengan menggunakan lingkungan sekitar dan media sebagai sumber belajar, untuk mendapatkan gagasan mengenai fenomena alam dan sosial. Menunjukkan kemampuan awal menggunakan dan merakayasa teknologi sederhana, untuk mencari informasi, dan gagasan, dan keterampilan secara aman dan bertanggung jawab. Mengeksplorasi berbagai proses seni, mengekspresikannnya serta mengapresiasi.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(471,'4d1f14be-0934-11f0-98a6-0242ac140002',2,4,NULL,1,1,4,9,'Nilai Agama Dan Budi Pekerti','NAMB','Peserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(472,'4d1faafa-0934-11f0-8f63-0242ac140002',2,4,NULL,1,1,4,8,'Nilai Agama Dan Budi Pekerti','NAMB','Peserta didik diharapkan mampu mempercayai Tuhan Yang Maha Esa, mulai mengenal dan mempraktikkan ajaran pokok sesuai dengan agama dan kepercayaanNya. Berpartisipasi aktif dalam menjaga kebersihan, kesehatan dan keselamatan diri sebagai bentuk rasa sayang terhadap dirinya dan rasa syukur pada Tuhan Yang Maha Esa. Menghargai sesama manusia dengan berbagai perbedaannya dan mempraktikkan perilaku baik dan berakhlak mulia. Menghargai alam dengan cara merawatnya dan menunjukkan rasa sayang terhadap makhluk hidup yang merupakan ciptaan Tuhan Yang Maha Esa.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(473,'4d205216-0934-11f0-b90f-0242ac140002',2,4,NULL,1,1,4,13,'Dimensi Beriman, Bertakwa Kepada Tuhan Yang Maha Esa, dan Berahlak Mulia','Bertakwa','Pelajar Indonesia yang beriman, bertakwa kepada Tuhan YME, dan berakhlak mulia \nadalah pelajar yang berakhlak dalam hubungannya dengan Tuhan Yang Maha Esa. \nIa memahami ajaran agama dan kepercayaannya serta menerapkan pemahaman \ntersebut dalam kehidupannya sehari-hari. Ada lima elemen kunci beriman, bertakwa \nDimensi, Elemen, dan Subelemen Profil Pelajar Pancasila pada Kurikulum Merdeka\n3\nkepada Tuhan YME, dan berakhlak mulia: (a) akhlak beragama; (b) akhlak pribadi; \n(c) akhlak kepada manusia; (d) akhlak kepada alam; dan (e) akhlak bernegara.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(474,'4d20da7e-0934-11f0-a014-0242ac140002',2,5,473,1,1,4,13,'Akhlak Beragama','DTW-Agama1','Mengenal dan Mencintai Tuhan Yang Maha Esa','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(475,'4d21644e-0934-11f0-8840-0242ac140002',2,5,473,1,1,4,13,'Akhlak Beragama','DTW-Agama2','Pemahaman Agama/ Kepercayaan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(476,'4d220e58-0934-11f0-b320-0242ac140002',2,5,473,1,1,4,13,'Akhlak Beragama','DTW-Agama3','Pelaksanaan Ritual Ibadah','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(477,'4d22a1d8-0934-11f0-ad82-0242ac140002',2,5,473,1,1,4,13,'Akhlak Pribadi','DTW-Pribadi1','Integritas','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(478,'4d232630-0934-11f0-93cf-0242ac140002',2,5,473,1,1,4,13,'Akhlak Pribadi','DTW-Pribadi2','Merawat Diri secara Fisik, Mental, dan Spiritual','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(479,'4d23d238-0934-11f0-a5c3-0242ac140002',2,5,473,1,1,4,13,'Akhlak Kepada Manusia','DTW-Kepada Manusia1','Mengutamakan persamaan dengan orang lain dan menghargai perbedaan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(480,'4d24706c-0934-11f0-adab-0242ac140002',2,5,473,1,1,4,13,'Akhlak Kepada Manusia','DTW-Kepada Manusia2','Berempati kepada orang lain.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(481,'4d251d6e-0934-11f0-b9b5-0242ac140002',2,5,473,1,1,4,13,'Akhlak Kepada Alam','DTW-Kepada Alam1','Memahami keterhubungan dengan alam di bumi','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(482,'4d25cc82-0934-11f0-bd75-0242ac140002',2,5,473,1,1,4,13,'Akhlak Kepada Alam','DTW-Kepada Alam2','Menjaga lingkungan Alam sekitarnya','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(483,'4d26d118-0934-11f0-8f3f-0242ac140002',2,5,473,1,1,4,13,'Akhlak Kepada Negara','DTW-Kepada Negara1','Melaksanakan Hak dan Kewajiban sebagai Warga Negara Indonesia','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(484,'4d275a02-0934-11f0-9453-0242ac140002',2,4,NULL,1,1,4,13,'Dimensi Berkebhinekaan Global','Berkebhinekaan Global','Pelajar Indonesia mempertahankan budaya luhur, lokalitas dan identitasnya, \ndan tetap berpikiran terbuka dalam berinteraksi dengan budaya lain, sehingga \nmenumbuhkan rasa saling menghargai dan kemungkinan terbentuknya budaya baru \nyang positif dan tidak bertentangan dengan budaya luhur bangsa. Elemen kunci \ndari berkebinekaan global meliputi mengenal dan menghargai budaya, kemampuan \nkomunikasi interkultural dalam berinteraksi dengan sesama, dan refleksi dan \ntanggung jawab terhadap pengalaman kebinekaan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(485,'4d27ee86-0934-11f0-899a-0242ac140002',2,5,484,1,1,4,13,'Mengenal dan Menghargai Budaya','DBG-Menghargai Budaya1','Mendalami dan menghargai budaya','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(486,'4d288260-0934-11f0-8f53-0242ac140002',2,5,484,1,1,4,13,'Mengenal dan Menghargai Budaya','DBG-Menghargai Budaya2','mengeksplorasi dan membandingkan pengetahuan budaya, kepercayaan, serta praktiknya','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(487,'4d290e7e-0934-11f0-84cb-0242ac140002',2,5,484,1,1,4,13,'Mengenal dan Menghargai Budaya','DBG-Menghargai Budaya3','Menumbuhkan rasa menghormati terhadap keragaman budaya','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(488,'4d2990ce-0934-11f0-8576-0242ac140002',2,4,NULL,1,1,4,13,'Dimensi Bergotong Royong','Gotong Royong','Pelajar Indonesia memiliki kemampuan bergotong-royong, yaitu kemampuan untuk \nmelakukan kegiatan secara bersama-sama dengan suka rela agar kegiatan yang \ndikerjakan dapat berjalan lancar, mudah dan ringan. Elemen-elemen dari bergotong \nroyong adalah kolaborasi, kepedulian, dan berbag','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(489,'4d2a34c0-0934-11f0-8033-0242ac140002',2,4,NULL,1,1,4,13,'Dimensi Mandiri','Mandiri','Pelajar Indonesia merupakan pelajar mandiri, yaitu pelajar yang bertanggung jawab \natas proses dan hasil belajarnya. Elemen kunci dari mandiri terdiri dari kesadaran \nakan diri dan situasi yang dihadapi serta regulasi diri','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(490,'4d2abec2-0934-11f0-a561-0242ac140002',2,4,NULL,1,1,4,13,'Dimensi Bernalar Kritis','Bernalar Kritis','Pelajar yang bernalar kritis mampu secara objektif memproses informasi baik \nkualitatif maupun kuantitatif, membangun keterkaitan antara berbagai informasi, \nmenganalisis informasi, mengevaluasi dan menyimpulkannya. Elemen-elemen \ndari bernalar kritis adalah memperoleh dan memproses informasi dan gagasan, \nmenganalisis dan mengevaluasi penalaran, merefleksi pemikiran dan proses berpikir \ndalam mengambilan keputusan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(491,'4d2b52b0-0934-11f0-8071-0242ac140002',2,4,NULL,1,1,4,13,'Dimensi Kreatif','Kreatif','Pelajar yang kreatif mampu memodifikasi dan menghasilkan sesuatu yang orisinal, \nbermakna, bermanfaat, dan berdampak. Elemen kunci dari kreatif terdiri dari \nmenghasilkan gagasan yang orisinal serta menghasilkan karya dan tindakan \nyang orisinal serta memiliki keluwesan berpikir dalam mencari alternatif solusi \npermasalahan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(492,'4d532c36-0934-11f0-afdc-0242ac140002',3,7,NULL,5,2,5,14,'Bilangan','BIL','Pada akhir fase A, peserta didik menunjukkan pemahaman dan memiliki intuisi bilangan (number sense) pada bilangan cacah sampai 100, mereka dapat membaca, menulis, menentukan nilai tempat, membandingkan, mengurutkan, serta melakukan komposisi (menyusun) dan dekomposisi (mengurai) bilangan. Peserta didik dapat melakukan operasi penjumlahan dan pengurangan menggunakan benda-benda konkret yang banyaknya sampai 20. Peserta didik menunjukkan pemahaman pecahan sebagai bagian dari keseluruhan melalui konteks membagi sebuah benda atau kumpulan benda sama banyak pecahan yang diperkenalkan adalah setengah dan seperempat.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(493,'4d53dc08-0934-11f0-a0f5-0242ac140002',3,8,492,5,2,5,14,'TP Bilangan 001','TP BIL 001','Menghitung perjumlahan 1 sampai dengan 10','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(494,'4d54b754-0934-11f0-b920-0242ac140002',3,8,492,5,2,5,14,'TP Bilangan 002','TP BIL 002','Menjelaskan penjumlahan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(495,'4d557590-0934-11f0-af04-0242ac140002',3,7,NULL,5,2,5,14,'Aljabar','AL','Pada akhir Fase A, peserta didik dapat menunjukan pemahaman makna simbol matematika \"=\" dalam suatu kalimat matematika yang terkait dengan penjumlahan dan pengurangan bilangan cacah sampai 20 menggunakan gambar. Contoh:   Peserta didik dapat mengenali, meniru, dan melanjutkan pola bukan bilangan (misalnya, gambar, warna, suara).','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(496,'4d5619c8-0934-11f0-a173-0242ac140002',3,7,NULL,1,2,5,26,'ALLAH BERKARYA','A-PAK-ELEMEN 1','Allah Pencipta:\nMemahami Allah menciptakan dirinya sebagai pribadi yang istimewa dalam hubungannya dengan keluarga, teman, guru sebagai orang- orang terdekat dan membangun interaksi yang baik melalui tindakan sederhana.\nAllah Pemelihara:\nMemahami pemeliharaan Allah pada dirinya melalui kehadiran orang tua, keluarga, teman, dan guru serta melakukan tindakan nyata sebagai wujud syukur.\nAllah Penyelamat:-\nAllah Pemersatu: -\nNilai-nilai Kristiani:\nBergaul dengan semua orang, menghargai perbedaan, menjaga kerukunan di rumah dan di sekolah.\nMasyarakat Majemuk:\nMensyukuri keragaman suku, budaya, bangsa, dan agama sebagai anugerah Allah.\nTanggung Jawab Manusia Terhadap Alam:\nMelakukan tindakan sederhana dalam upaya tanggung jawab terhadap alam dan lingkungan sekitarnya.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(497,'4d57269c-0934-11f0-a5cd-0242ac140002',3,8,496,1,2,5,26,'Menjelaskan arti keluarga.','1.1','Menjelaskan arti keluarga.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(498,'4d57ac34-0934-11f0-9a68-0242ac140002',3,8,496,1,2,5,26,'Menjelaskan bahwa keluarga adalah anugerah Tuhan.','1.2','Menjelaskan bahwa keluarga adalah anugerah Tuhan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(499,'4d583c80-0934-11f0-9dcf-0242ac140002',3,8,496,1,2,5,26,'Menjelaskan pentingnya saling menghormati di dalam keluarga.','1.3','Menjelaskan pentingnya saling menghormati di dalam keluarga.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(500,'4d58e586-0934-11f0-974b-0242ac140002',3,7,NULL,1,2,5,26,'MANUSIA DAN NILAI-NILAI KRISTIANI','A-PAK-ELEMEN 2','Hakikat Manusia:\nMemahami dirinya yang memiliki berbagai anggota tubuh dan bermanfaat untuk tujuan mulia, serta bersyukur pada Allah melalui tindakan nyata memelihara tubuhnya.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(501,'4d5988ec-0934-11f0-bdcb-0242ac140002',3,8,500,1,2,5,26,'Menjelaskan pentingnya menghormati guru.','2.1','Menjelaskan pentingnya menghormati guru','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(502,'4d5a1500-0934-11f0-ba30-0242ac140002',3,8,500,1,2,5,26,'Menyebutkan cara Allah memelihara melalui guru.','2.2','Menyebutkan cara Allah memelihara melalui guru.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(503,'4d5aa056-0934-11f0-833e-0242ac140002',3,7,NULL,1,2,5,26,'GEREJA DAN MASYARAKAT MAJEMUK','A-PAK-ELEMEN 3','Tugas Panggilan Gereja:\nMenerima tugas panggilan gereja untuk bersekutu, bersaksi, dan melayani.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(504,'4d5b3534-0934-11f0-b8fe-0242ac140002',3,7,NULL,1,2,5,26,'ALAM DAN LINGKUNGAN HIDUP','A-PAK-ELEMEN 4','Alam Ciptaan Allah:\nMensyukuri Allah hadir dalam seluruh alam ciptaan','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(505,'4d7cd89c-0934-11f0-bab5-0242ac140002',5,12,NULL,1,5,11,27,'Pemahaman Konsep','PK.01','Pada akhir fase ini, peserta didik mampu memahami dan memiliki kesadaran akan keberadaan diri serta mampu berinteraksi dengan lingkungan terdekatnya. Ia  mampu menganalisis hubungan antara kondisi geografis daerah dengan karakteristik masyarakat dan memahami potensi sumber daya alam serta kaitannya dengan mitigasi kebencanaan. Ia juga mampu menganalisis hubungan antara keragaman kondisi geografis nusantara terhadap pembentukan kemajemukan budaya. Ia mampu memahami bagaimana masyarakat saling berupaya untuk dapat memenuhi kebutuhan hidupnya. Ia mampu menganalisis peran pemerintah dan masyarakat dalam mendorong pertumbuhan perekonomian.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(506,'4d7db5d2-0934-11f0-b4ea-0242ac140002',5,12,NULL,1,5,11,27,'Pemahaman Konsep','PK.02','Peserta didik juga mampu memahami dan memiliki kesadaran terhadap perubahan sosial yang sedang terjadi di era kontemporer. Ia dapat menganalisis perkembangan ekonomi di era digital. Peserta didik memahami tantangan pembangunan dan potensi Indonesia menjadi negara maju. Ia menyadari perannya sebagai bagian dari masyarakat Indonesia dan dunia di tengah isu-isu regional dan global yang sedang terjadi dan ikut memberikan kontribusi yang positif.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(507,'4d7e5e60-0934-11f0-a871-0242ac140002',5,13,506,1,5,11,27,'Tujuan Pembelajaran Bab 1','TP.1','Peserta didik mendeskripsikan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(508,'4d7f0e82-0934-11f0-8ffe-0242ac140002',5,13,506,1,5,11,27,'Tujuan Pembelajaran Bab 1','TP.2','Peserta didik menjelaskan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(509,'4d7fac7a-0934-11f0-a634-0242ac140002',5,12,NULL,1,5,11,27,'Keterampilan Proses','KP.01','Pada akhir fase ini, Peserta didik mampu memahami dan menerapkan materi pembelajaran melalui pendekatan keterampilan proses dalam belajarnya, yaitu mengamati, menanya dengan rumus 5W 1H. Kemudian mampu memperkirakan apa yang akan terjadi berdasarkan jawaban-jawaban yang ditemukan. Peserta didik juga mampu mengumpulkan informasi melalui studi pustaka, studi dokumen, lapangan, wawancara, observasi, kuesioner, dan teknik pengumpulan informasi lainnya. merencanakan dan mengembangkan penyelidikan. Peserta didik mengorganisasikan informasi dengan memilih, mengolah dan menganalisis informasi yang diperoleh. Proses analisis informasi dilakukan dengan cara verifikasi, interpretasi, dan triangulasi informasi.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(510,'4d809d6a-0934-11f0-bc5b-0242ac140002',5,12,NULL,1,5,11,27,'Keterampilan Proses','KP.02','Peserta didik menarik kesimpulan, menjawab, mengukur dan mendeskripsikan serta menjelaskan permasalahan yang ada dengan memenuhi prosedur dan tahapan yang ditetapkan. Peserta didik mengungkapkan seluruh hasil tahapan di atas secara lisan dan tulisan dalam bentuk media digital dan non-digital. Peserta didik lalu mengomunikasikan hasil temuannya dengan mempublikasikan hasil laporan dalam bentuk presentasi digital dan atau non digital, dan sebagainya. Selain itu peserta didik mampu mengevaluasi pengalaman belajar yang telah dilalui dan diharapkan dapat merencanakan proyek lanjutan dengan melibatkan lintas mata pelajaran secara kolaboratif.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(511,'4d81166e-0934-11f0-ad9d-0242ac140002',5,12,NULL,1,5,11,30,'Pemahaman IPA','PI.01','Pada akhir fase D, peserta didik mampu melakukan klasifikasi makhluk hidup dan benda berdasarkan karakteristik yang diamati, mengidentifikasi sifat dan karakteristik zat, membedakan perubahan fisik dan kimia serta memisahkan campuran sederhana.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(512,'4d819206-0934-11f0-927e-0242ac140002',5,12,NULL,1,5,11,30,'Pemahaman IPA','PI.02','Peserta didik dapat mendeskripsikan atom dan senyawa sebagai unit terkecil penyusun materi serta sel sebagai unit terkecil penyusun makhluk hidup, mengidentifikasi sistem organisasi kehidupan serta melakukan analisis untuk menemukan keterkaitan sistem organ dengan fungsinya serta kelainan atau gangguan yang muncul pada sistem organ tertentu (sistem pencernaan, sistem peredaran darah, sistem pernafasan dan sistem reproduksi). Peserta didik mengidentifikasi interaksi antar makhluk hidup dan lingkungannya, serta dapat merancang upaya-upaya mencegah dan mengatasi pencemaran dan perubahan iklim. Peserta didik mengidentifikasi pewarisan sifat dan penerapan bioteknologi dalam kehidupan sehari-hari.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(513,'4d821a6e-0934-11f0-acc4-0242ac140002',5,12,NULL,1,5,11,30,'Pemahaman IPA','PI.03','Peserta didik mampu melakukan pengukuran terhadap aspek fisis yang mereka temui dan memanfaatkan ragam gerak dan gaya (force), memahami hubungan konsep usaha dan energi, mengukur besaran suhu yang diakibatkan oleh energi kalor yang diberikan, sekaligus dapat membedakan isolator dan konduktor kalor.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(514,'4d82acfe-0934-11f0-830b-0242ac140002',5,12,NULL,1,5,11,30,'Pemahaman IPA','PI.04','Peserta didik memahami gerak, gaya dan tekanan, termasuk pesawat sederhana. Peserta didik memahami getaran dan gelombang, pemantulan dan pembiasan cahaya termasuk alat- alat optik sederhana yang sering dimanfaatkan dalam kehidupan sehari-hari.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(515,'4d8ff09e-0934-11f0-9daa-0242ac140002',6,16,NULL,5,6,14,39,'Mendengarkan - Menyimak','MM','Beginilah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(516,'4d90b0f6-0934-11f0-a1b5-0242ac140002',6,17,515,5,6,14,39,'Menyimak','M1','Memahami percakapan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(517,'4d9144e4-0934-11f0-a3e3-0242ac140002',6,18,NULL,5,6,14,39,'Bab 1','B1','Makanan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(518,'4d960e02-0934-11f0-bf17-0242ac140002',7,19,NULL,5,6,14,39,'Menyimak - Berbicara (Listening - Speaking)','MI-BC 24','Peserta didik menggunakan bahasa Inggris untuk berkomunikasi dengan guru, teman sebaya, dan orang lain dalam berbagai macam situasi dan tujuan. Peserta didik menggunakan dan merespons pertanyaan serta menggunakan strategi untuk memulai dan mempertahankan percakapan dan diskusi. Peserta didik memahami dan mengidentifikasi ide utama dan detail dari teks lisan yang relevan dari diskusi atau presentasi mengenai topik yang terkait dengan kehidupan mereka. Peserta didik menggunakan bahasa Inggris untuk menyampaikan opini terhadap isu yang dekat dengan kehidupan mereka dan untuk membahas minat. Peserta didik memberikan pendapat dan membuat perbandingan. Peserta didik mulai menggunakan elemen nonverbal (gestur, kecepatan bicara dan/atau nada suara) untu dapat memperkuat/mendukung pesan/informasi yang ingin disampaikan.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(519,'4d96c91e-0934-11f0-8f7d-0242ac140002',7,19,NULL,5,6,14,39,'Membaca - Memirsa (Reading - Viewing)','MB-MR 24','Peserta didik membaca dan merespons berbagai jenis teks. Peserta didik membaca untuk mempelajari sesuatu atau untuk mendapatkan informasi. Peserta didik mencari dan mengevaluasi detil spesifik dan inti dari berbagai jenis teks. Teks ini dapat berbentuk cetak atau digital, termasuk di antaranya teks visual, multimodal atau interaktif. Pemahaman peserta didik terhadap ide pokok, isu-isu atau pengembangan plot dalam berbagai jenis teks mulai berkembang. Peserta didik mengidentifikasi tujuan penulis dan mengembangkan keterampilannya untuk melakukan inferensi sederhana dalam memahami informasi tersirat dalam teks.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(520,'4d976784-0934-11f0-a165-0242ac140002',7,19,NULL,5,6,14,39,'Menulis - Mempresentasikan (Writing - Presenting)','MN-MP 24','Peserta didik menulis berbagai jenis teks fiksi dan nonfiksi, melalui aktivitas yang dipandu, menunjukkan pemahaman mereka terhadap tujuan dan target pembaca/pemirsa. Peserta didik merencanakan, menulis, mengulas, dan merevisi teks dengan menunjukkan strategi koreksi diri dalam kaidah menulis. Peserta didik menyampaikan ide menggunakan kosakata dan kata kerja umum dalam tulisannya. Peserta didik menyajikan informasi menggunakan berbagai moda presentasi dalam bentuk cetak dan digital untuk menyesuaikan dengan target pembaca/pemirsa dan untuk mencapai tujuan yang berbeda-beda.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(521,'4d9804d2-0934-11f0-83de-0242ac140002',7,19,NULL,5,6,14,53,'Allah Berkarya - Allah Pencipta','AB-APC 24','Peserta didik memahami manusia diberi kemampuan untuk mengembangkan rasio dan kepekaan hati nurani.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(522,'4d98b102-0934-11f0-8211-0242ac140002',7,19,NULL,5,6,14,53,'Allah Berkarya - Allah Pemelihara','AB-APM 24','Peserta didik memahami bentuk-bentuk pemeliharaan Allah dalam setiap situasi kehidupan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(523,'4d99657a-0934-11f0-a843-0242ac140002',7,19,NULL,5,6,14,53,'Allah Berkarya - Allah Penyelamat','AB-APL 24','Peserta didik memahami karya penyelamatan Allah melalui peran keluarga dan orang tua sebagai pendidik pertama dan utama','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(524,'4d9a31ee-0934-11f0-b36b-0242ac140002',7,19,NULL,5,6,14,53,'Allah Berkarya - Allah Pembaru','AB-APB 24','Peserta didik memahami bahwa Roh Kudus membarui dan memulihkan kehidupan keluarga.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(525,'4d9ab466-0934-11f0-ae46-0242ac140002',7,19,NULL,5,6,14,53,'Manusia dan Nilai-Nilai Kristiani - Hakikat Manusia','MNK-HM 24','Peserta didik memahami peran dirinya sebagai remaja Kristen mengacu pada teks Alkitab dan tokoh-tokoh inspiratif','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(526,'4d9b39c2-0934-11f0-b423-0242ac140002',7,19,NULL,5,6,14,53,'Manusia dan Nilai-Nilai Kristiani - Nilai-Nilai Kristiani','MNK-NK 24','Peserta didik memahami prinsip kesetiaan, kasih dan keadilan dalam kehidupan sosial yang lebih luas','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(527,'4d9bcebe-0934-11f0-8a5c-0242ac140002',7,19,NULL,5,6,14,53,'Gereja dan Masyarakat Majemuk - Tugas Panggilan Gereja','GMM-TPG 24','Peserta didik memahami peran gereja dalam mewujudkan solidaritas dan kebersamaan dalam hubungan antarumat beragama dan internal umat beragama terkait dengan isu ras, etnis, serta gender di dalam masyarakat','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(528,'4d9c54ec-0934-11f0-abd0-0242ac140002',7,19,NULL,5,6,14,53,'Gereja dan Masyarakat Majemuk - Masyarakat Majemuk','GMM-MM 24','Peserta didik memahami peran keluarga dan sekolah sebagai lembaga pendidikan yang mendidik kemajemukan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(529,'4d9cd840-0934-11f0-8e8f-0242ac140002',7,19,NULL,5,6,14,53,'Alam dan Lingkungan Hidup - Alam Ciptaan Allah','ALH-ACA 24','Peserta didik memahami berbagai fakta kerusakan alam dan perubahan iklim serta pemanasan global yang mengancam hidup manusia dan alam','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(530,'4d9d6710-0934-11f0-bc13-0242ac140002',7,19,NULL,5,6,14,53,'Alam dan Lingkungan Hidup - Tanggung Jawab Manusia Terhadap Alam','ALH-AJMTA 24','Peserta didik memahami berbagai bentuk pencegahan dan pelestarian alam demi keberlanjutan hidup manusia dan alam','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(531,'4d9dfa04-0934-11f0-8121-0242ac140002',7,19,NULL,5,6,14,47,'Pancasila','PCL 24','Peserta didik menganalisis cara pandang para pendiri negara tentang dasar negara, pandangan hidup, ideologi negara; merumuskan gagasan solutif untuk mengatasi perilaku yang bertentangan dengan nilai Pancasila dalam kehidupan sehari-hari','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(532,'4d9e8884-0934-11f0-ad47-0242ac140002',7,19,NULL,5,6,14,47,'Undang-Undang Dasar Negara Republik Indonesia Tahun 1945','UUD 24','Peserta didik menerapkan perilaku taat hukum berdasarkan peraturan yang berlaku di masyarakat; menganalisis tata urutan peraturan perundang-undangan di Indonesia','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(533,'4d9f1f7e-0934-11f0-8298-0242ac140002',7,19,NULL,5,6,14,47,'Bhinneka Tunggal Ika','BTI 24','Peserta didik menyajikan asal usul dan makna semboyan Bhinneka Tunggal Ika sebagai modal sosial; membangun harmoni dalam keberagaman; dan mengenal gotong royong sebagai perwujudan sistem ekonomi Pancasila yang inklusif dan berkeadilan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(534,'4d9fb222-0934-11f0-a8fb-0242ac140002',7,19,NULL,5,6,14,47,'Negara Kesatuan Republik Indonesia','NKR 24','Peserta didik menerapkan perilaku sesuai dengan hak dan kewajiban sebagai warga sekolah, warga masyarakat dan warga negara; serta memahami peran dan kedudukannya sebagai Warga Negara Indonesia; memahami sistem pertahanan dan keamanan negara; menganalisis peran Indonesia dalam hubungan antarbangsa dan negara; serta menguraikan nilai-nilai Pancasila yang harus diwujudkan dalam pembangunan nasional','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(535,'4da03274-0934-11f0-84c2-0242ac140002',7,19,NULL,5,6,14,41,'Menyimak','MK 24','Peserta didik mampu mengevaluasi dan mengkreasi informasi berupa gagasan, pikiran, perasaan, pandangan, arahan atau pesan yang akurat dari menyimak berbagai tipe teks dalam bentuk monolog, dialog, dan gelar wicara','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(536,'4da0c3a6-0934-11f0-a8d4-0242ac140002',7,19,NULL,5,6,14,41,'Membaca dan Memirsa','MM 24','Peserta didik mampu mengevaluasi informasi berupa gagasan, pikiran, pandangan, arahan atau pesan dari berbagai tipe teks visual dan audiovisual untuk menemukan makna yang tersurat dan tersirat. Peserta didik mampu menginterpretasi informasi untuk mengungkapkan gagasan dan perasaan simpati, peduli, empati dan/atau pendapat pro/kontra dari teks visual dan audiovisual secara kreatif. Peserta didik mampu menggunakan sumber lain untuk menilai akurasi dan kualitas data serta membandingkan isi teks','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(537,'4da154e2-0934-11f0-9653-0242ac140002',7,19,NULL,5,6,14,41,'Berbicara dan Mempresentasikan','BM 24','Peserta didik mampu mengolah dan menyajikan gagasan, pikiran, pandangan, arahan atau pesan untuk tujuan pengajuan usul, perumusan masalah, dan solusi dalam bentuk monolog, dialog, dan gelar wicara secara logis, runtut, kritis, dan kreatif. Peserta didik mampu mengkreasi ungkapan sesuai dengan norma kesopanan dalam berkomunikasi. Peserta didik mampu berkontribusi lebih aktif dalam diskusi dengan mempersiapkan materi diskusi, melaksanakan tugas dan fungsi dalam diskusi. Peserta didik mampu mengungkapkan kepedulian secara kreatif dalam bentuk teks fiksi dan nonfiksi multimodal','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(538,'4da1d5f2-0934-11f0-928d-0242ac140002',7,19,NULL,5,6,14,41,'Menulis','MN 24','Peserta didik mampu menulis gagasan, pikiran, pandangan, arahan atau pesan tertulis untuk berbagai tujuan secara logis, kritis, dan kreatif dalam bentuk teks informasional dan/atau fiksi. Peserta didik mampu menulis teks eksposisi hasil penelitian dan teks fungsional dunia kerja. Peserta didik mampu mengalihwahanakan satu teks ke teks lainnya. Peserta didik mampu menerbitkan hasil tulisan di media cetak, elektronik, dan/atau digital','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(539,'4da26788-0934-11f0-ad47-0242ac140002',7,19,NULL,5,7,15,41,'Menyimak','MK 24','Peserta didik mampu mengevaluasi berbagai gagasan, pikiran, perasaan, pandangan, arahan atau pesan berdasarkan kaidah logika berpikir dari menyimak berbagai tipe teks dalam bentuk monolog, dialog, dan gelar wicara. Peserta didik mampu mengkreasi dan mengapresiasi gagasan dan pendapat untuk menanggapi teks yang disimak','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(540,'4da2f07c-0934-11f0-b77f-0242ac140002',7,19,NULL,5,7,16,41,'Menyimak','MK 24','Peserta didik mampu mengevaluasi berbagai gagasan, pikiran, perasaan, pandangan, arahan atau pesan berdasarkan kaidah logika berpikir dari menyimak berbagai tipe teks dalam bentuk monolog, dialog, dan gelar wicara. Peserta didik mampu mengkreasi dan mengapresiasi gagasan dan pendapat untuk menanggapi teks yang disimak','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(541,'4da39054-0934-11f0-be82-0242ac140002',7,19,NULL,5,7,15,41,'Membaca dan Memirsa','MM 24','Peserta didik mampu mengevaluasi informasi berupa gagasan, pikiran, perasaan, pandangan, arahan atau pesan berdasarkan kaidah logika berpikir dari membaca berbagai tipe teks di media cetak dan elektronik. Peserta didik mampu mengapresiasi teks fiksi dan nonfiksi. Peserta didik mampu mengevaluasi dan merefleksi gagasan dan pandangan berdasarkan kaidah logika berpikir dari membaca berbagai tipe teks di media cetak dan elektronik. Peserta didik mampu mengapresiasi berbagai tipe teks. Peserta didik mampu mengaitkan isi teks dengan hal lain di luar teks.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(542,'4da49742-0934-11f0-965a-0242ac140002',7,19,NULL,5,7,16,41,'Membaca dan Memirsa','MM 24','Peserta didik mampu mengevaluasi informasi berupa gagasan, pikiran, perasaan, pandangan, arahan atau pesan berdasarkan kaidah logika berpikir dari membaca berbagai tipe teks di media cetak dan elektronik. Peserta didik mampu mengapresiasi teks fiksi dan nonfiksi. Peserta didik mampu mengevaluasi dan merefleksi gagasan dan pandangan berdasarkan kaidah logika berpikir dari membaca berbagai tipe teks di media cetak dan elektronik. Peserta didik mampu mengapresiasi berbagai tipe teks. Peserta didik mampu mengaitkan isi teks dengan hal lain di luar teks.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(543,'4da524fa-0934-11f0-99cb-0242ac140002',7,19,NULL,5,7,15,41,'Berbicara dan Mempresentasikan','BM 24','Peserta didik mampu menyajikan gagasan, pikiran, perasaan, pandangan, arahan atau pesan dan kreativitas dalam berbahasa dalam bentuk monolog, dialog, dan gelar wicara secara logis, sistematis, kritis, dan kreatif. Peserta didik mampu menyajikan karya sastra secara kreatif dan\nmenarik. Peserta didik mampu mengkreasi teks sesuai dengan norma kesopanan dan budaya Indonesia. Peserta didik mampu menyajikan dan mempertahankan hasil penelitian, serta menyimpulkan masukan dari mitra diskusi','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(544,'4da5cf04-0934-11f0-ab18-0242ac140002',7,19,NULL,5,7,16,41,'Berbicara dan Mempresentasikan','BM 24','Peserta didik mampu menyajikan gagasan, pikiran, perasaan, pandangan, arahan atau pesan dan kreativitas dalam berbahasa dalam bentuk monolog, dialog, dan gelar wicara secara logis, sistematis, kritis, dan kreatif. Peserta didik mampu menyajikan karya sastra secara kreatif dan\nmenarik. Peserta didik mampu mengkreasi teks sesuai dengan norma kesopanan dan budaya Indonesia. Peserta didik mampu menyajikan dan mempertahankan hasil penelitian, serta menyimpulkan masukan dari mitra diskusi','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(545,'4da67ff8-0934-11f0-adac-0242ac140002',7,19,NULL,5,7,15,41,'Menulis','MN 24','Peserta didik mampu menulis gagasan, pikiran, pandangan, pengetahuan metakognisi untuk berbagai tujuan secara logis, kritis, dan kreatif. Peserta didik mampu menulis berbagai jenis karya sastra. Peserta didik mampu menulis teks refleksi diri. Peserta didik mampu menulis hasil penelitian, teks fungsional dunia kerja, dan pengembangan studi lanjut. Peserta didik mampu menerbitkan tulisan hasil karyanya di media cetak, elektronik, dan/atau digital','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(546,'4da714e0-0934-11f0-b7e2-0242ac140002',7,19,NULL,5,7,16,41,'Menulis','MN 24','Peserta didik mampu menulis gagasan, pikiran, pandangan, pengetahuan metakognisi untuk berbagai tujuan secara logis, kritis, dan kreatif. Peserta didik mampu menulis berbagai jenis karya sastra. Peserta didik mampu menulis teks refleksi diri. Peserta didik mampu menulis hasil penelitian, teks fungsional dunia kerja, dan pengembangan studi lanjut. Peserta didik mampu menerbitkan tulisan hasil karyanya di media cetak, elektronik, dan/atau digital','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(547,'4da794ba-0934-11f0-8010-0242ac140002',7,19,NULL,5,7,15,53,'Allah Berkarya - Allah Pencipta','AB-APC 24','Peserta didik memahami perkembangan kebudayaan, ilmu pengetahuan dan teknologi, serta demokrasi dan HAM sebagai anugerah Allah yang dijabarkan dalam praktik hidup sehari-hari','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(548,'4da8257e-0934-11f0-bf68-0242ac140002',7,19,NULL,5,7,16,53,'Allah Berkarya - Allah Pencipta','AB-APC 24','Peserta didik memahami perkembangan kebudayaan, ilmu pengetahuan dan teknologi, serta demokrasi dan HAM sebagai anugerah Allah yang dijabarkan dalam praktik hidup sehari-hari','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(549,'4da8b4e4-0934-11f0-bd60-0242ac140002',7,19,NULL,5,7,15,53,'Allah Berkarya - Allah Pemelihara','AB-APM 24','Peserta didik memahami talenta pemberian Allah serta menggunakannya untuk kepentingan gereja, bangsa dan negara','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(550,'4da94ad0-0934-11f0-a603-0242ac140002',7,19,NULL,5,7,16,53,'Allah Berkarya - Allah Pemelihara','AB-APM 24','Peserta didik memahami talenta pemberian Allah serta menggunakannya untuk kepentingan gereja, bangsa dan negara','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(551,'4daa1a00-0934-11f0-b08f-0242ac140002',7,19,NULL,5,7,15,53,'Allah Berkarya - Allah Penyelamat','AB-APL 24','Peserta didik memahami karya penyelamatan Allah melalui peran masyarakat dan bangsa untuk mewujudkan nilai-nilai demokrasi dan HAM','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(552,'4daac13a-0934-11f0-bf6c-0242ac140002',7,19,NULL,5,7,16,53,'Allah Berkarya - Allah Penyelamat','AB-APL 24','Peserta didik memahami karya penyelamatan Allah melalui peran masyarakat dan bangsa untuk mewujudkan nilai-nilai demokrasi dan HAM','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(553,'4dab81a6-0934-11f0-b62c-0242ac140002',7,19,NULL,5,7,15,53,'Allah Berkarya - Allah Pembaru','AB-APB 24','Peserta didik memahami bahwa Roh Kudus membarui dan memulihkan kehidupan gereja, bangsa, dan negara','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(554,'4dac5d1a-0934-11f0-b022-0242ac140002',7,19,NULL,5,7,16,53,'Allah Berkarya - Allah Pembaru','AB-APB 24','Peserta didik memahami bahwa Roh Kudus membarui dan memulihkan kehidupan gereja, bangsa, dan negara','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(555,'4dad2100-0934-11f0-b736-0242ac140002',7,19,NULL,5,7,15,53,'Manusia dan Nilai-Nilai Kristiani - Hakikat Manusia','MNK-HM 24','Peserta didik memahami pertumbuhan diri dan tanggung jawab sebagai pribadi dewasa serta keadilan sebagai dasar demokrasi dan HAM','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(556,'4dadbade-0934-11f0-b7dd-0242ac140002',7,19,NULL,5,7,15,53,'Manusia dan Nilai-Nilai Kristiani - Nilai-Nilai Kristiani','MNK-NK 24','Peserta didik memahami prinsip damai sejahtera sebagai landasan hidup berkeluarga dan bermasyarakat','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(557,'4dae5728-0934-11f0-bb1d-0242ac140002',7,19,NULL,5,7,16,53,'Manusia dan Nilai-Nilai Kristiani - Hakikat Manusia','MNK-HM 24','Peserta didik memahami pertumbuhan diri dan tanggung jawab sebagai pribadi dewasa serta keadilan sebagai dasar demokrasi dan HAM','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(558,'4daeea12-0934-11f0-b7f3-0242ac140002',7,19,NULL,5,7,16,53,'Manusia dan Nilai-Nilai Kristiani - Nilai-Nilai Kristiani','MNK-NK 24','Peserta didik memahami prinsip damai sejahtera sebagai landasan hidup berkeluarga dan bermasyarakat','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(559,'4dafac7c-0934-11f0-9f33-0242ac140002',7,19,NULL,5,7,15,53,'Gereja dan Masyarakat Majemuk - Tugas Panggilan Gereja','GMM-TPG 24','Peserta didik memahami keteladanan tokoh-tokoh agama yang mengabdikan hidupnya bagi persaudaraan dan solidaritas serta isu-isu ras, etnis, kesetaraan gender dalam rangka mewujudkan keadilan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(560,'4db0640a-0934-11f0-ab22-0242ac140002',7,19,NULL,5,7,16,53,'Gereja dan Masyarakat Majemuk - Tugas Panggilan Gereja','GMM-TPG 24','Peserta didik memahami keteladanan tokoh-tokoh agama yang mengabdikan hidupnya bagi persaudaraan dan solidaritas serta isu-isu ras, etnis, kesetaraan gender dalam rangka mewujudkan keadilan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(561,'4db11850-0934-11f0-af61-0242ac140002',7,19,NULL,5,7,15,53,'Gereja dan Masyarakat Majemuk - Masyarakat Majemuk','GMM-MM 24','Peserta didik memahami transformasi sosial pada lingkup masyarakat\nmajemuk dalam rangka penguatan moderasi beragama','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(562,'4db19b68-0934-11f0-bbdb-0242ac140002',7,19,NULL,5,7,16,53,'Gereja dan Masyarakat Majemuk - Masyarakat Majemuk','GMM-MM 24','Peserta didik memahami transformasi sosial pada lingkup masyarakat\nmajemuk dalam rangka penguatan moderasi beragama','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(563,'4db28230-0934-11f0-9045-0242ac140002',7,19,NULL,5,7,15,53,'Alam dan Lingkungan Hidup - Alam Ciptaan Allah','ALH - ACA 24','Peserta didik memahami prinsip pemeliharaan dan pelestarian alam serta keutuhan ciptaan Allah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(564,'4db3638a-0934-11f0-85cf-0242ac140002',7,19,NULL,5,7,16,53,'Alam dan Lingkungan Hidup - Alam Ciptaan Allah','ALH - ACA 24','Peserta didik memahami prinsip pemeliharaan dan pelestarian alam serta keutuhan ciptaan Allah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(565,'4db409fc-0934-11f0-9030-0242ac140002',7,19,NULL,5,7,15,53,'Alam dan Lingkungan Hidup - Tanggung Jawab Manusia Terhadap Alam','ALH - AJMTA 24','Peserta didik memahami sikap ugahari serta bijak dan adil dalam memanfaatkan dan melestarikan sumber daya alam demi kelestarian alam','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(566,'4db4a024-0934-11f0-8ba1-0242ac140002',7,19,NULL,5,7,16,53,'Alam dan Lingkungan Hidup - Tanggung Jawab Manusia Terhadap Alam','ALH - AJMTA 24','Peserta didik memahami sikap ugahari serta bijak dan adil dalam memanfaatkan dan melestarikan sumber daya alam demi kelestarian alam','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(567,'4db5573a-0934-11f0-a664-0242ac140002',7,19,NULL,5,7,15,47,'Pancasila','PCL 24','Peserta didik mendeskripsikan rumusan dan keterkaitan sila-sila dalam Pancasila; menganalisis kedudukan Pancasila sebagai ideologi negara serta peluang dan tantangan penerapan nilai-nilai Pancasila dalam kehidupan global dan membiasakan perilaku yang sesuai dengan nilai-nilai Pancasila sebagai identitas nasional dalam kehidupan sehari-hari','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(568,'4db60914-0934-11f0-9724-0242ac140002',7,19,NULL,5,7,16,47,'Pancasila','PCL 24','Peserta didik mendeskripsikan rumusan dan keterkaitan sila-sila dalam Pancasila; menganalisis kedudukan Pancasila sebagai ideologi negara serta peluang dan tantangan penerapan nilai-nilai Pancasila dalam kehidupan global dan membiasakan perilaku yang sesuai dengan nilai-nilai Pancasila sebagai identitas nasional dalam kehidupan sehari-hari','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(569,'4db68cea-0934-11f0-812b-0242ac140002',7,19,NULL,5,7,15,47,'Undang-Undang Dasar Negara Republik Indonesia Tahun 1945','UUD 24','Peserta didik menganalisis periodisasi pemberlakuan undang-undang dasar di Indonesia; menganalisis perubahan Undang-Undang Dasar Negara Republik Indonesia Tahun 1945; menunjukkan sikap demokratis berdasarkan Undang-Undang Dasar Negara Republik Indonesia Tahun 1945 dalam era keterbukaan informasi; menganalisis kasus pelanggaran hak dan pengingkaran kewajiban warga negara dan merumuskan solusi dari permasalahan tersebut','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(570,'4db753fa-0934-11f0-822f-0242ac140002',7,19,NULL,5,7,16,47,'Undang-Undang Dasar Negara Republik Indonesia Tahun 1945','UUD 24','Peserta didik menganalisis periodisasi pemberlakuan undang-undang dasar di Indonesia; menganalisis perubahan Undang-Undang Dasar Negara Republik Indonesia Tahun 1945; menunjukkan sikap demokratis berdasarkan Undang-Undang Dasar Negara Republik Indonesia Tahun 1945 dalam era keterbukaan informasi; menganalisis kasus pelanggaran hak dan pengingkaran kewajiban warga negara dan merumuskan solusi dari permasalahan tersebut','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(571,'4db8278a-0934-11f0-9471-0242ac140002',7,19,NULL,5,7,15,47,'Bhinneka Tunggal Ika','BTI 24','Peserta didik menganalisis potensi konflik dan bersama-sama memberi solusi yang berkeadilan terhadap permasalahan keberagaman di masyarakat; menginisiasi kegiatan bersama dengan prinsip gotong royong dalam praktik hidup sehari-hari','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(572,'4db8fa20-0934-11f0-8421-0242ac140002',7,19,NULL,5,7,16,47,'Bhinneka Tunggal Ika','BTI 24','Peserta didik menganalisis potensi konflik dan bersama-sama memberi solusi yang berkeadilan terhadap permasalahan keberagaman di masyarakat; menginisiasi kegiatan bersama dengan prinsip gotong royong dalam praktik hidup sehari-hari','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(573,'4db9964c-0934-11f0-b84e-0242ac140002',7,19,NULL,5,7,16,47,'Negara Kesatuan Republik Indonesia','NKR 24','Peserta didik mendemonstrasikan praktik demokrasi dalam kehidupan berbangsa dan bernegara; menganalisis dan merumuskan solusi terkait ancaman, tantangan, hambatan, dan gangguan (ATHG) yang dihadapi Indonesia; menganalisis bentuk negara, bentuk pemerintahan, sistem pemerintahan Indonesia, dan peran lembaga-lembaga negara dalam bidang politik, ekonomi, sosial, budaya, pertahanan dan keamanan.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(574,'4dba3c82-0934-11f0-9284-0242ac140002',7,19,NULL,5,7,15,47,'Negara Kesatuan Republik Indonesia','NKR 24','Peserta didik mendemonstrasikan praktik demokrasi dalam kehidupan berbangsa dan bernegara; menganalisis dan merumuskan solusi terkait ancaman, tantangan, hambatan, dan gangguan (ATHG) yang dihadapi Indonesia; menganalisis bentuk negara, bentuk pemerintahan, sistem pemerintahan Indonesia, dan peran lembaga-lembaga negara dalam bidang politik, ekonomi, sosial, budaya, pertahanan dan keamanan.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(575,'4dbad17e-0934-11f0-b943-0242ac140002',7,19,NULL,5,7,15,39,'Menyimak - Berbicara (Listening - Speaking)','MI-BC 24','Peserta didik menggunakan bahasa Inggris untuk berkomunikasi dengan guru, teman sebaya dan orang lain dalam berbagai macam situasi dan tujuan. Peserta didik menggunakan dan merespons pertanyaan terbuka dan menggunakan strategi untuk memulai, mempertahankan dan menyimpulkan percakapan, dan diskusi. Peserta didik memahami dan mengidentifikasi ide utama dan detail relevan dari teks lisan dalam diskusi atau presentasi mengenai berbagai macam topik. Peserta didik menggunakan bahasa Inggris untuk menyampaikan opini terhadap isu sosial dan untuk membahas minat, perilaku, dan nilai-nilai lintas konteks budaya yang dekat dengan kehidupan mereka. Peserta didik memberikan dan mempertahankan pendapatnya, membuat perbandingan dan mengevaluasi perspektifnya. Peserta didik menggunakan strategi koreksi dan perbaikan diri, dan menggunakan elemen nonverbal (gestur, kecepatan bicara dan/atau nada suara) untuk dapat memperkuat/mendukung pesan/informasi/pendapat yang ingin disampaikan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(576,'4dbb5914-0934-11f0-97b1-0242ac140002',7,19,NULL,5,7,16,39,'Menyimak - Berbicara (Listening - Speaking)','MI-BC 24','Peserta didik menggunakan bahasa Inggris untuk berkomunikasi dengan guru, teman sebaya dan orang lain dalam berbagai macam situasi dan tujuan. Peserta didik menggunakan dan merespons pertanyaan terbuka dan menggunakan strategi untuk memulai, mempertahankan dan menyimpulkan percakapan, dan diskusi. Peserta didik memahami dan mengidentifikasi ide utama dan detail relevan dari teks lisan dalam diskusi atau presentasi mengenai berbagai macam topik. Peserta didik menggunakan bahasa Inggris untuk menyampaikan opini terhadap isu sosial dan untuk membahas minat, perilaku, dan nilai-nilai lintas konteks budaya yang dekat dengan kehidupan mereka. Peserta didik memberikan dan mempertahankan pendapatnya, membuat perbandingan dan mengevaluasi perspektifnya. Peserta didik menggunakan strategi koreksi dan perbaikan diri, dan menggunakan elemen nonverbal (gestur, kecepatan bicara dan/atau nada suara) untuk dapat memperkuat/mendukung pesan/informasi/pendapat yang ingin disampaikan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(577,'4dbc9ba8-0934-11f0-924f-0242ac140002',7,19,NULL,5,7,16,39,'Membaca - Memirsa (Reading - Viewing)','MB-MR 24','Peserta didik membaca dan merespons berbagai jenis teks secara mandiri. Peserta didik membaca untuk mempelajari sesuatu dan membaca untuk hiburan. Peserta didik mencari, membuat sintesis dan mengevaluasi detil spesifik dan inti dari berbagai jenis teks. Teks ini dapat berbentuk cetak atau digital, termasuk di antaranya teks visual, multimodal atau interaktif. Peserta didik menunjukkan pemahaman terhadap ide pokok, isu-isu atau pengembangan plot dalam berbagai jenis teks. Peserta didik mengidentifikasi tujuan penulis dan melakukan inferensi untuk memahami informasi tersirat dalam teks','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(578,'4dbd26fe-0934-11f0-9447-0242ac140002',7,19,NULL,5,7,15,39,'Membaca - Memirsa (Reading - Viewing)','MB-MR 24','Peserta didik membaca dan merespons berbagai jenis teks secara mandiri. Peserta didik membaca untuk mempelajari sesuatu dan membaca untuk hiburan. Peserta didik mencari, membuat sintesis dan mengevaluasi detil spesifik dan inti dari berbagai jenis teks. Teks ini dapat berbentuk cetak atau digital, termasuk di antaranya teks visual, multimodal atau interaktif. Peserta didik menunjukkan pemahaman terhadap ide pokok, isu-isu atau pengembangan plot dalam berbagai jenis teks. Peserta didik mengidentifikasi tujuan penulis dan melakukan inferensi untuk memahami informasi tersirat dalam teks','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(579,'4dbdd630-0934-11f0-a624-0242ac140002',7,19,NULL,5,7,15,39,'Menulis - Mempresentasikan (Writing - Presenting)','MN-MP 24','Peserta didik menulis berbagai jenis teks fiksi dan faktual (nonfiksi) secara mandiri, menunjukkan pemahaman mereka terhadap tujuan dan target pembaca/pemirsa. Peserta didik merencanakan, menuliskan, mengulas, dan merevisi teks dengan menunjukkan strategi koreksi diri dalam kaidah menulis. Peserta didik menyampaikan ide kompleks dan menggunakan berbagai kosakata dan tata bahasa yang beragam dalam tulisannya. Peserta didik menyajikan informasi menggunakan berbagai moda presentasi dalam bentuk cetak dan digital untuk menyesuaikan dengan pemirsa dan untuk mencapai tujuan yang berbeda-beda.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(580,'4dbe5e7a-0934-11f0-add8-0242ac140002',7,19,NULL,5,7,16,39,'Menulis - Mempresentasikan (Writing - Presenting)','MN-MP 24','Peserta didik menulis berbagai jenis teks fiksi dan faktual (nonfiksi) secara mandiri, menunjukkan pemahaman mereka terhadap tujuan dan target pembaca/pemirsa. Peserta didik merencanakan, menuliskan, mengulas, dan merevisi teks dengan menunjukkan strategi koreksi diri dalam kaidah menulis. Peserta didik menyampaikan ide kompleks dan menggunakan berbagai kosakata dan tata bahasa yang beragam dalam tulisannya. Peserta didik menyajikan informasi menggunakan berbagai moda presentasi dalam bentuk cetak dan digital untuk menyesuaikan dengan pemirsa dan untuk mencapai tujuan yang berbeda-beda.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(581,'4dbef588-0934-11f0-aff3-0242ac140002',7,19,NULL,5,6,14,43,'Bilangan','BL 24','Peserta didik dapat menggeneralisasi sifat-sifat bilangan berpangkat (termasuk bilangan pangkat pecahan). Mereka dapat menerapkan barisan dan deret aritmetika dan geometri, termasuk masalah yang terkait bunga tunggal dan bunga majemuk','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(582,'4dbf8764-0934-11f0-b1d7-0242ac140002',7,19,NULL,5,6,14,43,'Aljabar dan Fungsi','AF 24','Peserta didik dapat menyelesaikan masalah yang berkaitan dengan sistem persamaan linear tiga variabel dan sistem pertidaksamaan linear dua variabel. Mereka dapat menyelesaikan masalah yang berkaitan dengan persamaan dan fungsi kuadrat (termasuk akar imajiner), serta persamaan eksponensial (berbasis/ bilangan pokok sama) dan fungsi eksponensial','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(583,'4dc01de6-0934-11f0-9a85-0242ac140002',7,19,NULL,5,6,14,43,'Geometri','GM 24','Peserta didik dapat menyelesaikan permasalahan segitiga siku-siku yang melibatkan perbandingan trigonometri dan aplikasinya','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(584,'4dc0a5f4-0934-11f0-90cd-0242ac140002',7,19,NULL,5,6,14,43,'Analisis Data dan Peluang','ADP 24','Peserta didik dapat merepresentasikan dan menginterpretasi data dengan cara menentukan jangkauan kuartil dan interkuartil. Mereka dapat membuat dan menginterpretasi diagram box plot (box-and whisker plot) dan menggunakannya untuk membandingkan himpunan data. Mereka dapat menentukan dan menggunakan dari box plot,\nhistogram dan dot plot sesuai dengan natur (karakteristik) data dan kebutuhan. Mereka dapat menggunakan diagram pencar untuk menyelidiki dan menjelaskan hubungan antara dua variabel numerik/ kuantitatif (termasuk salah satunya variabel bebas berupa waktu). Mereka\ndapat mengevaluasi laporan statistika di media berdasarkan tampilan, statistika dan representasi data. Peserta didik dapat menjelaskan peluang dan menentukan frekuensi harapan dari kejadian majemuk. Mereka menyelidiki konsep dari kejadian saling bebas dan saling lepas, dan menentukan peluangnya','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(585,'4dc140ea-0934-11f0-a235-0242ac140002',7,19,NULL,5,7,15,43,'Bilangan','BL 24','Peserta didik dapat memodelkan pinjaman dan investasi dengan bunga majemuk dan anuitas, serta menyelidiki (secara numerik atau grafis) pengaruh masing-masing parameter (suku bunga, periode pembayaran) dalam model tersebut','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(586,'4dc1e086-0934-11f0-97b6-0242ac140002',7,19,NULL,5,7,16,43,'Bilangan','BL 24','Peserta didik dapat memodelkan pinjaman dan investasi dengan bunga majemuk dan anuitas, serta menyelidiki (secara numerik atau grafis) pengaruh masing-masing parameter (suku bunga, periode pembayaran) dalam model tersebut','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(587,'4dc271c2-0934-11f0-8ae3-0242ac140002',7,19,NULL,5,7,15,43,'Aljabar dan Fungsi','AF 24','Peserta didik dapat menyatakan data dalam bentuk matriks. Mereka dapat menentukan fungsi invers, komposisi fungsi, dan transformasi fungsi untuk memodelkan situasi dunia nyata menggunakan fungsi yang sesuai (linear, kuadrat, eksponensial)','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(588,'4dc31cd0-0934-11f0-86b4-0242ac140002',7,19,NULL,5,7,16,43,'Aljabar dan Fungsi','AF 24','Peserta didik dapat menyatakan data dalam bentuk matriks. Mereka dapat menentukan fungsi invers, komposisi fungsi, dan transformasi fungsi untuk memodelkan situasi dunia nyata menggunakan fungsi yang sesuai (linear, kuadrat, eksponensial)','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(589,'4dc3ba0a-0934-11f0-bd66-0242ac140002',7,19,NULL,5,7,15,43,'Geometri','GM 24','Peserta didik dapat menerapkan teorema tentang lingkaran, dan menentukan panjang busur dan luas juring lingkaran untuk menyelesaikan masalah (termasuk menentukan lokasi posisi pada permukaan Bumi dan jarak antara dua tempat di Bumi)','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(590,'4dc46f86-0934-11f0-8dad-0242ac140002',7,19,NULL,5,7,16,43,'Geometri','GM 24','Peserta didik dapat menerapkan teorema tentang lingkaran, dan menentukan panjang busur dan luas juring lingkaran untuk menyelesaikan masalah (termasuk menentukan lokasi posisi pada permukaan Bumi dan jarak antara dua tempat di Bumi)','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(591,'4dc5028e-0934-11f0-a3aa-0242ac140002',7,19,NULL,5,7,16,43,'Analisis Data dan Peluang','ADP 24','Peserta didik dapat melakukan proses penyelidikan statistika untuk data bivariat. Mereka dapat mengidentifikasi dan menjelaskan asosiasi antara dua variabel kategorikal (kualitatif) dan antara dua variabel numerikal (kuantitatif). Mereka dapat memperkirakan model linear terbaik (best fit) pada data numerikal (kuantitatif). Mereka dapat membedakan hubungan asosiasi dan sebab-akibat. Peserta didik memahami konsep peluang bersyarat dan kejadian yang saling bebas menggunakan konsep permutasi dan kombinasi','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(592,'4dc59532-0934-11f0-abeb-0242ac140002',7,19,NULL,5,7,15,43,'Analisis Data dan Peluang','ADP 24','Peserta didik dapat melakukan proses penyelidikan statistika untuk data bivariat. Mereka dapat mengidentifikasi dan menjelaskan asosiasi antara dua variabel kategorikal (kualitatif) dan antara dua variabel numerikal (kuantitatif). Mereka dapat memperkirakan model linear terbaik (best fit) pada data numerikal (kuantitatif). Mereka dapat membedakan hubungan asosiasi dan sebab-akibat. Peserta didik memahami konsep peluang bersyarat dan kejadian yang saling bebas menggunakan konsep permutasi dan kombinasi','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(593,'4dc63834-0934-11f0-81c6-0242ac140002',7,19,NULL,5,6,14,38,'Pemahaman IPA','P-IPA 24','Peserta didik memahami proses klasifikasi makhluk hidup; peranan virus, bakteri, dan jamur dalam kehidupan; ekosistem dan interaksi antar komponen serta faktor yang mempengaruhi; dan pemanfaatan bioteknologi dalam berbagai bidang kehidupan. Peserta didik memahami sistem pengukuran dalam kerja ilmiah; energi alternatif dan pemanfaatannya untuk mengatasi permasalahan ketersediaan energi. Peserta didik memahami struktur atom dan kaitannya dengan sifat unsur dalam tabel periodik; serta memahami reaksi kimia, hukum-hukum dasar kimia, dan perannya dalam kehidupan sehari-hari. Peserta didik menerapkan pemahaman IPA untuk mengatasi permasalahan berkaitan dengan perubahan iklim','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(594,'4dc6d05a-0934-11f0-99c1-0242ac140002',7,19,NULL,5,6,14,38,'Keterampilan Proses - Mengamati','KP-M 24','Peserta didik mengamati fenomena ilmiah dan mencatat hasil pengamatannya dengan memperhatikan karakteristik dari objek yang diamati untuk memunculkan pertanyaan yang akan diselidiki','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(595,'4dc75d86-0934-11f0-9daf-0242ac140002',7,19,NULL,5,6,14,38,'Keterampilan Proses - Mempertanyakan dan Memprediksi','KP-MM 24','Peserta didik mengidentifikasi pertanyaan dan permasalahan yang dapat diselidiki secara ilmiah. Peserta didik menghubungkan pengetahuan\nyang telah dimiliki dengan pengetahuan baru untuk membuat prediksi','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(596,'4dc7f890-0934-11f0-ab94-0242ac140002',7,19,NULL,5,6,14,38,'Keterampilan Proses - Merencanakan dan Melakukan Penyelidikan','KP-MMP 24','Peserta didik merencanakan penyelidikan ilmiah dan melakukan langkah-langkah operasional berdasarkan referensi yang benar untuk menjawab pertanyaan. Peserta didik melakukan pengukuran atau membandingkan variabel terikat dengan menggunakan alat yang sesuai serta memperhatikan kaidah ilmiah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(597,'4dc88724-0934-11f0-81d8-0242ac140002',7,19,NULL,5,6,14,38,'Keterampilan Proses - Memproses, Menganalisis Data dan Informasi','KP-MMDI 24','Peserta didik menafsirkan informasi yang diperoleh dengan jujur dan bertanggung jawab. Peserta didik menganalisis menggunakan alat dan metode yang tepat berdasarkan data penyelidikan dengan menggunakan referensi rujukan yang sesuai, serta menyimpulkan hasil penyelidikan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(598,'4dc9182e-0934-11f0-a674-0242ac140002',7,19,NULL,5,6,14,38,'Keterampilan Proses - Mengevaluasi dan Refleksi','KP-MR 24','Peserta didik mengidentifikasi sumber ketidakpastian dan kemungkinan penjelasan alternatif dalam rangka mengevaluasi kesimpulan serta menjelaskan cara spesifik untuk meningkatkan kualitas data. Peserta didik menganalisis validitas informasi dan mengevaluasi pendekatan yang digunakan untuk menyelesaikan masalah dalam penyelidikan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(599,'4dc9c4d6-0934-11f0-87dc-0242ac140002',7,19,NULL,5,6,14,38,'Keterampilan Proses - Mengkomunikasikan Hasil','KP-MH 24','Peserta didik mengomunikasikan hasil penyelidikan secara sistematis dan utuh ditunjang dengan argumen ilmiah berdasarkan referensi sesuai konteks penyelidikan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(600,'4dca467c-0934-11f0-b74e-0242ac140002',7,19,NULL,5,7,15,50,'Pemahaman Fisika','P-FIS 24','Peserta didik mampu memahami konsep gerak, yaitu hubungan gaya dan gerak serta pemanfaatannya untuk menjelaskan fenomena alam, desain, atau rekayasa struktur; penerapan hukum fluida dalam kehidupan sehari-hari; konsep kalor dan termodinamika serta penerapannya untuk menganalisis dampak perubahan iklim; gejala gelombang dan penerapannya dalam kehidupan sehari-hari; rangkaian listrik dan fenomena elektromagnetik; teori dasar fisika modern dan pengaruhnya terhadap perkembangan teknologi; serta teori dasar digital dan penggunaannya dalam kehidupan sehari-hari','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(601,'4dcb12c8-0934-11f0-87e5-0242ac140002',7,19,NULL,5,7,15,50,'Keterampilan Proses - Mengamati','KP-M 24','Peserta didik mengamati fenomena ilmiah dan mencatat hasil pengamatannya dengan memperhatikan detail dari objek yang diamati untuk memunculkan pertanyaan yang akan diselidiki','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(602,'4dcbc9c0-0934-11f0-9e6d-0242ac140002',7,19,NULL,5,7,15,50,'Keterampilan Proses - Mempertanyakan dan Memprediksi','KP-MM 24','Peserta didik merumuskan pertanyaan ilmiah dan hipotesis yang dapat diselidiki secara ilmiah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(603,'4dcc6880-0934-11f0-94fe-0242ac140002',7,19,NULL,5,7,15,50,'Keterampilan Proses - Merencanakan dan Melakukan Penyelidikan','KP-MMP 24','Peserta didik merencanakan dan memilih metode yang sesuai berdasarkan referensi untuk mengumpulkan data yang dapat dipercaya. Peserta didik memilih dan menggunakan alat dan bahan, termasuk penggunaan teknologi digital yang sesuai untuk mengumpulkan serta mencatat data secara sistematis dan akurat','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(604,'4dcd03ee-0934-11f0-89f1-0242ac140002',7,19,NULL,5,7,15,50,'Keterampilan Proses - Memproses, Menganalisis Data dan Informasi','KP-MMDI 24','Peserta didik menafsirkan informasi yang didapatkan dengan jujur dan bertanggung jawab. Peserta didik menggunakan berbagai metode untuk menganalisis pola dan kecenderungan pada data. Peserta didik mendeskripsikan hubungan antar variabel serta mengidentifikasi inkonsistensi yang terjadi. Peserta didik menggunakan pengetahuan ilmiah untuk menarik kesimpulan yang konsisten dengan hasil penyelidikan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(605,'4dce33e0-0934-11f0-8759-0242ac140002',7,19,NULL,5,7,15,50,'Keterampilan Proses - Mengevaluasi dan Refleksi','KP-MR 24','Peserta didik mengidentifikasi sumber ketidakpastian dan kemungkinan penjelasan alternatif dalam rangka mengevaluasi kesimpulan, serta menjelaskan cara spesifik untuk meningkatkan kualitas data. Peserta didik menganalisis validitas informasi dari sumber primer dan sekunder dan mengevaluasi pendekatan yang digunakan untuk menyelesaikan masalah dalam penyelidikan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(606,'4dcec8f0-0934-11f0-bd13-0242ac140002',7,19,NULL,5,7,15,50,'Keterampilan Proses - Mengkomunikasikan Hasil','KP-MH 24','Peserta didik mengomunikasikan hasil penyelidikan secara sistematis dan utuh ditunjang dengan argumen ilmiah dan terbuka terhadap pendapat yang lebih relevan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(607,'4dcf491a-0934-11f0-b4f3-0242ac140002',7,19,NULL,5,7,16,50,'Pemahaman Fisika','P-FIS 24','Peserta didik mampu memahami konsep gerak, yaitu hubungan gaya dan gerak serta pemanfaatannya untuk menjelaskan fenomena alam, desain, atau rekayasa struktur; penerapan hukum fluida dalam kehidupan sehari-hari; konsep kalor dan termodinamika serta penerapannya untuk menganalisis dampak perubahan iklim; gejala gelombang dan penerapannya dalam kehidupan sehari-hari; rangkaian listrik dan fenomena elektromagnetik; teori dasar fisika modern dan pengaruhnya terhadap perkembangan teknologi; serta teori dasar digital dan penggunaannya dalam kehidupan sehari-hari','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(608,'4dcfd466-0934-11f0-a4c0-0242ac140002',7,19,NULL,5,7,16,50,'Keterampilan Proses - Mengamati','KP-M 24','Peserta didik mengamati fenomena ilmiah dan mencatat hasil pengamatannya dengan memperhatikan detail dari objek yang diamati untuk memunculkan pertanyaan yang akan diselidiki','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(609,'4dd06cdc-0934-11f0-909c-0242ac140002',7,19,NULL,5,7,16,50,'Keterampilan Proses - Mempertanyakan dan Memprediksi','KP-MM 24','Peserta didik merumuskan pertanyaan ilmiah dan hipotesis yang dapat diselidiki secara ilmiah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(610,'4dd101ec-0934-11f0-ac2d-0242ac140002',7,19,NULL,5,7,16,50,'Keterampilan Proses - Merencanakan dan Melakukan Penyelidikan','KP-MMP 24','Peserta didik merencanakan dan memilih metode yang sesuai berdasarkan referensi untuk mengumpulkan data yang dapat dipercaya. Peserta didik memilih dan menggunakan alat dan bahan, termasuk penggunaan teknologi digital yang sesuai untuk mengumpulkan serta mencatat data secara sistematis dan akurat','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(611,'4dd1a5c0-0934-11f0-be1f-0242ac140002',7,19,NULL,5,7,16,50,'Keterampilan Proses - Memproses, Menganalisis Data dan Informasi','KP-MMDI 24','Peserta didik menafsirkan informasi yang didapatkan dengan jujur dan bertanggung jawab. Peserta didik menggunakan berbagai metode untuk menganalisis pola dan kecenderungan pada data. Peserta didik mendeskripsikan hubungan antar variabel serta mengidentifikasi inkonsistensi yang terjadi. Peserta didik menggunakan pengetahuan ilmiah untuk menarik kesimpulan yang konsisten dengan hasil penyelidikan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(612,'4dd22b9e-0934-11f0-ad77-0242ac140002',7,19,NULL,5,7,16,50,'Keterampilan Proses - Mengevaluasi dan Refleksi','KP-MR 24','Peserta didik mengidentifikasi sumber ketidakpastian dan kemungkinan penjelasan alternatif dalam rangka mengevaluasi kesimpulan, serta menjelaskan cara spesifik untuk meningkatkan kualitas data. Peserta didik menganalisis validitas informasi dari sumber primer dan sekunder dan mengevaluasi pendekatan yang digunakan untuk menyelesaikan masalah dalam penyelidikan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(613,'4dd2dc10-0934-11f0-b3df-0242ac140002',7,19,NULL,5,7,16,50,'Keterampilan Proses - Mengkomunikasikan Hasil','KP-MH 24','Peserta didik mengomunikasikan hasil penyelidikan secara sistematis dan utuh ditunjang dengan argumen ilmiah dan terbuka terhadap pendapat yang lebih relevan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(614,'4dd38020-0934-11f0-ad23-0242ac140002',7,19,NULL,5,7,15,57,'Pemahaman Kimia','P-KIM 24','Peserta didik memiliki kemampuan memahami konsep mol dan stoikiometri dalam menyelesaikan perhitungan kimia; ikatan kimia dalam kaitannya dengan interaksi antar partikel materi dan sifat fisik materi; teori tumbukan antar partikel materi sebagai dasar konsep laju reaksi; kesetimbangan kimia untuk mengamati perilaku reaktan dan produk pada level mikroskopik; korelasi antara pH larutan asam, basa, garam dan larutan penyangga serta penerapannya dalam kehidupan sehari-hari; termokimia; konsep redoks dan sel elektrokimia sebagai implikasi perubahan materi dan energi yang menyertai reaksi kimia serta penerapannya dalam kehidupan sehari hari; serta senyawa karbon, hidrokarbon dan turunannya beserta pemanfaatannya dalam kehidupan sehari-hari','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(615,'4dd4025c-0934-11f0-a204-0242ac140002',7,19,NULL,5,7,15,57,'Keterampilan Proses - Mengamati','KP-M 24','Peserta didik mengamati fenomena ilmiah dan mencatat hasil pengamatannya dengan memperhatikan detail dari objek yang diamati untuk memunculkan pertanyaan yang akan diselidiki','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(616,'4dd49ba4-0934-11f0-bc5f-0242ac140002',7,19,NULL,5,7,15,57,'Keterampilan Proses - Mempertanyakan dan Memprediksi','KP-MM 24','Peserta didik merumuskan pertanyaan ilmiah tentang hubungan antar variabel dan hipotesis yang dapat diselidiki secara ilmiah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(617,'4dd5288a-0934-11f0-b02a-0242ac140002',7,19,NULL,5,7,15,57,'Keterampilan Proses - Merencanakan dan Melakukan Penyelidikan','KP-MMP 24','Peserta didik merencanakan dan memilih metode yang sesuai serta mengendalikan variabel berdasarkan referensi untuk mengumpulkan data yang dapat dipercaya. Peserta didik memilih dan menggunakan alat dan bahan, termasuk penggunaan teknologi digital yang sesuai untuk mengumpulkan serta mencatat data secara sistematis dan akurat','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(618,'4dd5c0a6-0934-11f0-9f8f-0242ac140002',7,19,NULL,5,7,15,57,'Keterampilan Proses - Memproses, Menganalisis Data dan Informasi','KP-MMDI 24','Peserta didik menafsirkan informasi yang diperoleh dengan jujur dan bertanggung jawab. Peserta didik menggunakan berbagai metode untuk menganalisis pola dan kecenderungan pada data. Peserta didik mendeskripsikan hubungan antar variabel serta mengidentifikasi inkonsistensi yang terjadi. Peserta didik menggunakan data dan rujukan untuk menarik kesimpulan yang konsisten dengan hasil penyelidikan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(619,'4dd678c0-0934-11f0-8303-0242ac140002',7,19,NULL,5,7,16,57,'Pemahaman Kimia','P-KIM 24','Peserta didik memiliki kemampuan memahami konsep mol dan stoikiometri dalam menyelesaikan perhitungan kimia; ikatan kimia dalam kaitannya dengan interaksi antar partikel materi dan sifat fisik materi; teori tumbukan antar partikel materi sebagai dasar konsep laju reaksi; kesetimbangan kimia untuk mengamati perilaku reaktan dan produk pada level mikroskopik; korelasi antara pH larutan asam, basa, garam dan larutan penyangga serta penerapannya dalam kehidupan sehari-hari; termokimia; konsep redoks dan sel elektrokimia sebagai implikasi perubahan materi dan energi yang menyertai reaksi kimia serta penerapannya dalam kehidupan sehari hari; serta senyawa karbon, hidrokarbon dan turunannya beserta pemanfaatannya dalam kehidupan sehari-hari','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(620,'4dd6f836-0934-11f0-8d95-0242ac140002',7,19,NULL,5,7,16,57,'Keterampilan Proses - Mengamati','KP-M 24','Peserta didik mengamati fenomena ilmiah dan mencatat hasil pengamatannya dengan memperhatikan detail dari objek yang diamati untuk memunculkan pertanyaan yang akan diselidiki','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(621,'4dd7bbcc-0934-11f0-a0c9-0242ac140002',7,19,NULL,5,7,16,57,'Keterampilan Proses - Mempertanyakan dan Memprediksi','KP-MM 24','Peserta didik merumuskan pertanyaan ilmiah tentang hubungan antar variabel dan hipotesis yang dapat diselidiki secara ilmiah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(622,'4dd891aa-0934-11f0-a216-0242ac140002',7,19,NULL,5,7,16,57,'Keterampilan Proses - Merencanakan dan Melakukan Penyelidikan','KP-MMP 24','Peserta didik merencanakan dan memilih metode yang sesuai serta mengendalikan variabel berdasarkan referensi untuk mengumpulkan data yang dapat dipercaya. Peserta didik memilih dan menggunakan alat dan bahan, termasuk penggunaan teknologi digital yang sesuai untuk mengumpulkan serta mencatat data secara sistematis dan akurat','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(623,'4dd954aa-0934-11f0-bf5a-0242ac140002',7,19,NULL,5,7,16,57,'Keterampilan Proses - Memproses, Menganalisis Data dan Informasi','KP-MMDI 24','Peserta didik menafsirkan informasi yang diperoleh dengan jujur dan bertanggung jawab. Peserta didik menggunakan berbagai metode untuk menganalisis pola dan kecenderungan pada data. Peserta didik mendeskripsikan hubungan antar variabel serta mengidentifikasi inkonsistensi yang terjadi. Peserta didik menggunakan data dan rujukan untuk menarik kesimpulan yang konsisten dengan hasil penyelidikan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(624,'4dd9e96a-0934-11f0-a6cf-0242ac140002',7,19,NULL,5,7,15,57,'Keterampilan Proses - Mengevaluasi dan Refleksi','KP-MR 24','Peserta didik mengidentifikasi sumber ketidakpastian dan kemungkinan penjelasan alternatif dalam rangka mengevaluasi kesimpulan serta menjelaskan cara spesifik untuk meningkatkan kualitas data. Peserta didik menganalisis validitas informasi dari sumber primer dan sekunder serta mengevaluasi pendekatan yang digunakan untuk menyelesaikan masalah dalam penyelidikan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(625,'4ddaa260-0934-11f0-8dfd-0242ac140002',7,19,NULL,5,7,16,57,'Keterampilan Proses - Mengevaluasi dan Refleksi','KP-MR 24','Peserta didik mengidentifikasi sumber ketidakpastian dan kemungkinan penjelasan alternatif dalam rangka mengevaluasi kesimpulan serta menjelaskan cara spesifik untuk meningkatkan kualitas data. Peserta didik menganalisis validitas informasi dari sumber primer dan sekunder serta mengevaluasi pendekatan yang digunakan untuk menyelesaikan masalah dalam penyelidikan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(626,'4ddb2fdc-0934-11f0-95ab-0242ac140002',7,19,NULL,5,7,15,57,'Keterampilan Proses - Mengkomunikasikan Hasil','KP-MH 24','Peserta didik mengomunikasikan hasil penyelidikan secara sistematis dan utuh ditunjang dengan argumen ilmiah dan terbuka terhadap pendapat yang lebih relevan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(627,'4ddbc49c-0934-11f0-9dad-0242ac140002',7,19,NULL,5,7,16,57,'Keterampilan Proses - Mengkomunikasikan Hasil','KP-MH 24','Peserta didik mengomunikasikan hasil penyelidikan secara sistematis dan utuh ditunjang dengan argumen ilmiah dan terbuka terhadap pendapat yang lebih relevan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(628,'4ddc4746-0934-11f0-b2f1-0242ac140002',7,19,NULL,5,7,15,48,'Pemahaman Biologi','P-BIO 24','Peserta didik memahami struktur sel; pembelahan sel; transpor pada membran; metabolisme dan sintesis protein; hukum Mendel dan pola hereditas; pertumbuhan dan perkembangan; teori evolusi dan mengaitkannya dengan biodiversitas di masa kini maupun pada masa lampau serta hubungannya dengan perubahan iklim; serta keterkaitan struktur organ pada sistem organ dengan fungsinya dalam merespons stimulus internal dan eksternal','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(629,'4ddce502-0934-11f0-a7f6-0242ac140002',7,19,NULL,5,7,16,48,'Pemahaman Biologi','P-BIO 24','Peserta didik memahami struktur sel; pembelahan sel; transpor pada membran; metabolisme dan sintesis protein; hukum Mendel dan pola hereditas; pertumbuhan dan perkembangan; teori evolusi dan mengaitkannya dengan biodiversitas di masa kini maupun pada masa lampau serta hubungannya dengan perubahan iklim; serta keterkaitan struktur organ pada sistem organ dengan fungsinya dalam merespons stimulus internal dan eksternal','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(630,'4ddd75bc-0934-11f0-b32f-0242ac140002',7,19,NULL,5,7,15,48,'Keterampilan Proses - Mengamati','KP-M 24','Peserta didik mengamati fenomena ilmiah dan mencatat hasil pengamatannya dengan memperhatikan detail dari objek yang diamati untuk memunculkan pertanyaan yang akan diselidiki','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(631,'4dddf01e-0934-11f0-913c-0242ac140002',7,19,NULL,5,7,15,48,'Keterampilan Proses - Mempertanyakan dan Memprediksi','KP-MM 24','Peserta didik merumuskan pertanyaan ilmiah dan hipotesis yang dapat diselidiki secara ilmiah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(632,'4dde960e-0934-11f0-9494-0242ac140002',7,19,NULL,5,7,15,48,'Keterampilan Proses - Merencanakan dan Melakukan Penyelidikan','KP-MMP 24','Peserta didik merencanakan dan memilih metode yang sesuai berdasarkan referensi untuk mengumpulkan data yang dapat dipercaya. Peserta didik memilih dan menggunakan alat dan bahan, termasuk penggunaan teknologi digital yang sesuai untuk mengumpulkan serta mencatat data secara sistematis dan akurat','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(633,'4ddf3a50-0934-11f0-bc31-0242ac140002',7,19,NULL,5,7,16,48,'Keterampilan Proses - Mengamati','KP-M 24','Peserta didik mengamati fenomena ilmiah dan mencatat hasil pengamatannya dengan memperhatikan detail dari objek yang diamati untuk memunculkan pertanyaan yang akan diselidiki','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(634,'4ddfc010-0934-11f0-b1dd-0242ac140002',7,19,NULL,5,7,16,48,'Keterampilan Proses - Mempertanyakan dan Memprediksi','KP-MM 24','Peserta didik merumuskan pertanyaan ilmiah dan hipotesis yang dapat diselidiki secara ilmiah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(635,'4de0611e-0934-11f0-a987-0242ac140002',7,19,NULL,5,7,16,48,'Keterampilan Proses - Merencanakan dan Melakukan Penyelidikan','KP-MMP 24','Peserta didik merencanakan dan memilih metode yang sesuai berdasarkan referensi untuk mengumpulkan data yang dapat dipercaya. Peserta didik memilih dan menggunakan alat dan bahan, termasuk penggunaan teknologi digital yang sesuai untuk mengumpulkan serta mencatat data secara sistematis dan akurat','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(636,'4de0e152-0934-11f0-a249-0242ac140002',7,19,NULL,5,7,16,48,'Keterampilan Proses - Memproses, Menganalisis Data dan Informasi','KP-MMDI 24','Peserta didik menafsirkan informasi yang diperoleh dengan jujur dan bertanggung jawab; menggunakan berbagai metode untuk menganalisis pola dan kecenderungan pada data; mendeskripsikan hubungan antar variabel dan mengidentifikasi inkonsistensi yang terjadi; serta menggunakan pengetahuan ilmiah untuk menarik kesimpulan yang konsisten dengan hasil penyelidikan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(637,'4de1eb06-0934-11f0-85ba-0242ac140002',7,19,NULL,5,7,16,48,'Keterampilan Proses - Mengevaluasi dan Refleksi','KP-MR 24','Peserta didik mengidentifikasi sumber ketidakpastian dan kemungkinan penjelasan alternatif dalam rangka mengevaluasi simpulan, serta menjelaskan cara spesifik untuk meningkatkan kualitas data. Peserta didik menganalisis validitas informasi dari sumber primer dan sekunder serta mengevaluasi pendekatan yang digunakan untuk menyelesaikan masalah dalam penyelidikan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(638,'4de283a4-0934-11f0-8cc9-0242ac140002',7,19,NULL,5,7,16,48,'Keterampilan Proses - Mengomunikasikan Hasil','KP-MH 24','Peserta didik mengomunikasikan hasil penyelidikan secara sistematis dan utuh ditunjang dengan argumen ilmiah dan terbuka terhadap pendapat yang lebih relevan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(639,'4de300f4-0934-11f0-921f-0242ac140002',7,19,NULL,5,7,15,48,'Keterampilan Proses - Memproses, Menganalisis Data dan Informasi','KP-MMDI 24','Peserta didik menafsirkan informasi yang diperoleh dengan jujur dan bertanggung jawab; menggunakan berbagai metode untuk menganalisis pola dan kecenderungan pada data; mendeskripsikan hubungan antar variabel dan mengidentifikasi inkonsistensi yang terjadi; serta menggunakan pengetahuan ilmiah untuk menarik kesimpulan yang konsisten dengan hasil penyelidikan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(640,'4de3a8ce-0934-11f0-b7af-0242ac140002',7,19,NULL,5,7,15,48,'Keterampilan Proses - Mengevaluasi dan Refleksi','KP-MR 24','Peserta didik mengidentifikasi sumber ketidakpastian dan kemungkinan penjelasan alternatif dalam rangka mengevaluasi simpulan, serta menjelaskan cara spesifik untuk meningkatkan kualitas data. Peserta didik menganalisis validitas informasi dari sumber primer dan sekunder serta mengevaluasi pendekatan yang digunakan untuk menyelesaikan masalah dalam penyelidikan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(641,'4de4405e-0934-11f0-bdba-0242ac140002',7,19,NULL,5,7,15,48,'Keterampilan Proses - Mengomunikasikan Hasil','KP-MH 24','Peserta didik mengomunikasikan hasil penyelidikan secara sistematis dan utuh ditunjang dengan argumen ilmiah dan terbuka terhadap pendapat yang lebih relevan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(642,'4de5154c-0934-11f0-ad8a-0242ac140002',7,19,NULL,5,6,14,42,'Berpikir Komputasional','BK 24','Peserta didik mampu memahami validitas sumber data; memahami konsep struktur data dan algoritma standar; menerapkan proses komputasi yang dilakukan manusia secara mandiri atau berkelompok untuk mendapatkan data yang bersih, benar, dan terpercaya; menerapkan struktur data dan algoritma standar untuk menghasilkan berbagai solusi dalam menyelesaikan persoalan yang mengandung himpunan data berstruktur kompleks dengan volume tidak kecil; serta menuliskan solusi rancangan program sederhana dalam format pseudocode yang dekat dengan bahasa komputer. Peserta didik mampu memahami model dan menyimulasikan dinamika Input-Proses-Output dalam sebuah komputer Von Neumann, serta memahami peran sistem operasi.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(643,'4de5a598-0934-11f0-ba12-0242ac140002',7,19,NULL,5,6,14,42,'Literasi Digital','LD 24','Peserta didik mampu memahami penggunaan mesin pencari dengan variabel yang lebih banyak; mengetahui ekosistem periksa fakta untuk memilah fakta dan bukan; menggunakan cara membaca lateral untuk mengevaluasi berbagai informasi digital; memahami pemanfaatan lebih beragam perkakas teknologi digital untuk membuat laporan, presentasi, serta analisis dan interpretasi data; memahami konsep dan penerapan serta konfigurasi keamanan dasar untuk konektivitas jaringan data lokal dan internet baik kabel maupun nirkabel; serta memahami pemanfaatan media digital untuk produksi dan diseminasi konten, partisipasi dan kolaborasi. Peserta didik mampu menghargai hak atas kekayaan intelektual, mengenal profesi bidang Informatika, memahami penerapan digitalisasi budaya Indonesia, menyaring konten\nnegatif di dunia digital, menerapkan pengelolaan kata sandi dengan manajer kata sandi, dan menerapkan autentikasi dua langkah secara sederhana, serta menerapkan konfigurasi privasi dan keamanan pada akun platform digital','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(644,'4de645c0-0934-11f0-b9dc-0242ac140002',7,19,NULL,5,7,15,42,'Berpikir Komputasional','BK 24','Peserta didik mampu memahami alur proses pengembangan program atau produk teknologi digital; menuliskan algoritma yang efisien, efektif, dan optimal; menganalisis persoalan dengan pemahamannya terhadap beberapa strategi algoritmik untuk menghasilkan beberapa alternatif solusi dari satu persoalan dengan memberikan justifikasi efisiensi, kelebihan, dan keterbatasan dari setiap alternatif solusi; kemudian mampu memilih dan menerapkan solusi terbaik, paling efisien, dan optimal dengan merancang struktur data yang lebih kompleks dan abstrak. Selain itu, peserta didik mampu mengenali berbagai model jaringan komputer serta mampu melakukan pengiriman data antarperangkat dalam jaringan komputer dan troubleshooting permasalahan jaringan komputer','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(645,'4de70a78-0934-11f0-b4c9-0242ac140002',7,19,NULL,5,7,15,42,'Literasi Digital','LD 24','Peserta didik mampu memahami penggunaan mesin pencari untuk melakukan riset; mengevaluasi kebenaran konten menggunakan verifikasi teks, gambar, dan video; menggunakan cara membaca lateral untuk mengevaluasi informasi digital yang kompleks; merancang kebutuhan sistem komputer sesuai kebutuhan pengguna; memahami konsep dan penerapan serta konfigurasi keamanan lanjut untuk konektivitas jaringan data lokal dan internet baik kabel maupun nirkabel; serta mengkreasi konten digital dengan peralatan dan metode yang bervariasi. Peserta didik mampu memahami hukum dan perundang-undangan terkait isu digital di Indonesia; memahami pemanfaatan teknologi digital dalam demokrasi; pengelolaan kata sandi dengan manajer kata sandi dan menerapkan autentikasi dua langkah dengan beragam moda; dan memahami pemanfaatan platform lokapasar, perbankan digital, dompet digital beserta aspek keamanannya','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(646,'4de7bf4a-0934-11f0-891a-0242ac140002',7,19,NULL,5,7,15,42,'Analisis Data','AD 24','Peserta didik mampu memanfaatkan sumber data yang terbuka, terpercaya, dan legal untuk mengolah data untuk pengambilan keputusan dan prediksi secara efektif, efisien, dan optimal tanpa atau dengan komputer','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(647,'4de87548-0934-11f0-88c0-0242ac140002',7,19,NULL,5,7,15,42,'Algoritma dan Pemrograman','AP 24','Peserta didik mampu memahami konsep strategi algoritmik, mengembangkan program komputer terstruktur dalam notasi algoritma atau notasi lain berdasarkan strategi algoritmik yang tepat. Selain itu, peserta didik mampu mengembangkan, melakukan pemeliharaan dan penyempurnaan algoritma standar ke dalam kode sumber program dengan memperhatikan kualitasnya. Peserta didik juga mampu merancang dan mengimplementasi sebuah program yang menggunakan struktur data kompleks dan tepat menggunakan library atau perangkat yang tersedia','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(648,'4de91cd2-0934-11f0-ac0d-0242ac140002',7,19,NULL,5,7,16,42,'Berpikir Komputasional','BK 24','Peserta didik mampu memahami alur proses pengembangan program atau produk teknologi digital; menuliskan algoritma yang efisien, efektif, dan optimal; menganalisis persoalan dengan pemahamannya terhadap beberapa strategi algoritmik untuk menghasilkan beberapa alternatif solusi dari satu persoalan dengan memberikan justifikasi efisiensi, kelebihan, dan keterbatasan dari setiap alternatif solusi; kemudian mampu memilih dan menerapkan solusi terbaik, paling efisien, dan optimal dengan merancang struktur data yang lebih kompleks dan abstrak. Selain itu, peserta didik mampu mengenali berbagai model jaringan komputer serta mampu melakukan pengiriman data antarperangkat dalam jaringan komputer dan troubleshooting permasalahan jaringan komputer','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(649,'4de9f18e-0934-11f0-9728-0242ac140002',7,19,NULL,5,7,16,42,'Literasi Digital','LD 24','Peserta didik mampu memahami penggunaan mesin pencari untuk melakukan riset; mengevaluasi kebenaran konten menggunakan verifikasi teks, gambar, dan video; menggunakan cara membaca lateral untuk mengevaluasi informasi digital yang kompleks; merancang kebutuhan sistem komputer sesuai kebutuhan pengguna; memahami konsep dan penerapan serta konfigurasi keamanan lanjut untuk konektivitas jaringan data lokal dan internet baik kabel maupun nirkabel; serta mengkreasi konten digital dengan peralatan dan metode yang bervariasi. Peserta didik mampu memahami hukum dan perundang-undangan terkait isu digital di Indonesia; memahami pemanfaatan teknologi digital dalam demokrasi; pengelolaan kata sandi dengan manajer kata sandi dan menerapkan autentikasi dua langkah dengan beragam moda; dan memahami pemanfaatan platform lokapasar, perbankan digital, dompet digital beserta aspek keamanannya','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(650,'4dea7be0-0934-11f0-b6dd-0242ac140002',7,19,NULL,5,7,16,42,'Analisis Data','AD 24','Peserta didik mampu memanfaatkan sumber data yang terbuka, terpercaya, dan legal untuk mengolah data untuk pengambilan keputusan dan prediksi secara efektif, efisien, dan optimal tanpa atau dengan komputer','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(651,'4deb077c-0934-11f0-bb44-0242ac140002',7,19,NULL,5,7,16,42,'Algoritma dan Pemrograman','AP 24','Peserta didik mampu memahami konsep strategi algoritmik, mengembangkan program komputer terstruktur dalam notasi algoritma atau notasi lain berdasarkan strategi algoritmik yang tepat. Selain itu, peserta didik mampu mengembangkan, melakukan pemeliharaan dan penyempurnaan algoritma standar ke dalam kode sumber program dengan memperhatikan kualitasnya. Peserta didik juga mampu merancang dan mengimplementasi sebuah program yang menggunakan struktur data kompleks dan tepat menggunakan library atau perangkat yang tersedia','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(652,'4debabc8-0934-11f0-9151-0242ac140002',7,19,NULL,5,6,14,37,'Pemahaman Konsep - Sosiologi','PK-SOS 24','Peserta didik mampu memahami fungsi sosiologi sebagai ilmu yang secara kritis, analitis, kreatif, dan solutif mengkaji masyarakat. Peserta didik mampu memahami status dan peran individu dalam kelompok sosial dan memahami berbagai ragam gejala sosial yang ada di dalam masyarakat. Peserta didik mampu memahami keragaman manusia dan budayanya sebagai bagian dari masyarakat multikultural','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(653,'4dec5aa0-0934-11f0-9b0f-0242ac140002',7,19,NULL,5,6,14,37,'Pemahaman Konsep - Ekonomi','PK-EKO 24','Peserta didik memahami hakikat ilmu ekonomi sebagai ilmu yang mempelajari upaya manusia dalam memenuhi kebutuhan hidupnya. Peserta didik memahami lembaga serta produk keuangan bank dan nonbank sebagai dasar dalam mengelola, menggunakan produk dan layanan, serta mengenali dan menghindari risiko keuangan kehidupannya dalam konteks mampu membuat laporan keuangan pribadi','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(654,'4decfdde-0934-11f0-be66-0242ac140002',7,19,NULL,5,6,14,37,'Pemahaman Konsep - Geografi','PK-GEO 24','Peserta didik memahami konsep dasar Geografi, peta, pengindraan jauh, Sistem Informasi Geografis (SIG), penelitian Geografi, dan fenomena geosfer fisik yaitu litosfer, atmosfer, dan hidrosfer sebagai ruang kehidupan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(655,'4deda3e2-0934-11f0-b13a-0242ac140002',7,19,NULL,5,6,14,37,'Pemahaman Konsep - Sejarah','PK-SEJ 24','Peserta didik memahami konsep dasar ilmu sejarah serta mengenali penelitian sejarah untuk menganalisis keterhubungan antara masa lampau, masa kini, dan masa yang akan datang ketika mempelajari berbagai peristiwa atau kejadian penting dalam lingkup lokal, nasional dan global mulai dari masa kerajaan Hindu-Budha hingga masa kerajaan Islam.','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(656,'4dee32bc-0934-11f0-acd4-0242ac140002',7,19,NULL,5,6,14,37,'Keterampilan Proses - Mengamati','KP-M 24','Peserta didik mengamati fenomena kehidupan manusia dalam dimensi ruang dan waktu secara sistematis serta menemukan persamaan dan perbedaannya dan potensinya','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(657,'4deee4e6-0934-11f0-a4e5-0242ac140002',7,19,NULL,5,6,14,37,'Keterampilan Proses - Membuat Pertanyaan','KP-MP 24','Peserta didik membuat pertanyaan secara mandiri untuk menggali informasi tentang fenomena kehidupan manusia dalam dimensi ruang dan waktu secara sistematis','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(658,'4def75aa-0934-11f0-8535-0242ac140002',7,19,NULL,5,6,14,37,'Keterampilan Proses - Mengumpulkan Informasi','KP-MI 24','Peserta didik mengumpulkan informasi dari sumber primer dan/atau sekunder, melakukan observasi, dan mendokumentasikannya','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(659,'4df00b3c-0934-11f0-b19b-0242ac140002',7,19,NULL,5,6,14,37,'Keterampilan Proses - Menarik Simpulan','KP-MS 24','Peserta didik menarik simpulan berdasarkan dari informasi yang diperoleh dari sumber primer dan/atau sekunder, hasil observasi dan hasil dokumentasi','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(660,'4df0ab8c-0934-11f0-8eac-0242ac140002',7,19,NULL,5,6,14,37,'Keterampilan Proses - Mengomunikasikan Hasil','KP-MH 24','Peserta didik mengomunikasikan hasil analisis informasi yang diperoleh dari sumber primer dan/atau sekunder, data hasil observasi, dan hasil dokumentasi dalam bentuk media digital dan/atau nondigital','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(661,'4df1535c-0934-11f0-82c6-0242ac140002',7,19,NULL,5,6,14,37,'Keterampilan Proses - Merefleksikan Hasil','KP-RH 24','Peserta didik merefleksikan hasil analisis informasi yang diperoleh dari sumber primer dan/atau sekunder, hasil observasi, dan hasil dokumentasi serta menyusun rencana tindak lanjut','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(662,'4df1e254-0934-11f0-ab76-0242ac140002',7,19,NULL,5,7,15,46,'Pemahaman Konsep','PK 24','Peserta didik menggunakan konsep dasar sejarah dan penelitian sejarah untuk menganalisis keterhubungan antara masa lampau, masa kini, dan masa yang akan datang, serta mengaitkan berbagai peristiwa sejarah di Indonesia dalam lingkup lokal, nasional, dan global mulai dari masa penjajahan bangsa Barat, perlawanan rakyat daerah terhadap penjajah, pergerakan kebangsaan Indonesia, pendudukan Jepang, proklamasi kemerdekaan Indonesia, mempertahankan kemerdekaan Indonesia, pemerintahan Sukarno, pemerintahanSuharto, dan reformasi','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(663,'4df2e172-0934-11f0-a28c-0242ac140002',7,19,NULL,5,7,15,46,'Keterampilan Proses - Mengamati','KP-MT 24','Peserta didik mencermati fenomena sejarah terkait materi pelajaran. Secara spesifik keterampilan proses belajar sejarah mencakup keterampilan berpikir diakronis (kronologis) dan sinkronis, pemahaman sejarah, analisis dan interpretasi sejarah, kemampuan riset sejarah, literasi sejarah, analisis isu kesejarahan serta pengambilan keputusan, dan kebermaknaan peristiwa sejarah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(664,'4df36a98-0934-11f0-b32d-0242ac140002',7,19,NULL,5,7,15,46,'Keterampilan Proses - Menanya','KP-MA 24','Peserta didik menyusun pertanyaan tentang hal yang ingin diketahui dan masalah yang sedang diselidiki dengan rumus 5W 1H (apa, siapa, kapan, di mana, mengapa, dan bagaimana) dan memperkirakan jawaban atas pertanyaan. Secara spesifik keterampilan proses belajar sejarah mencakup keterampilan berpikir diakronis (kronologis) dan sinkronis, pemahaman sejarah, analisis dan interpretasi sejarah, kemampuan riset sejarah, literasi sejarah, analisis isu kesejarahan serta pengambilan keputusan, dan kebermaknaan peristiwa sejarah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(665,'4df4193e-0934-11f0-9b0f-0242ac140002',7,19,NULL,5,7,15,46,'Keterampilan Proses - Mengumpulkan Informasi (Heuristik)','KP-MI(H) 24','Peserta didik mencari informasi dari sumber sejarah (sumber primer dan\nsekunder) melalui studi pustaka, studi dokumen/arsip, wawancara, observasi, kuesioner, dan lain-lain. Secara spesifik keterampilan proses belajar sejarah mencakup keterampilan berpikir diakronis (kronologis) dan sinkronis, pemahaman sejarah, analisis dan interpretasi sejarah, kemampuan riset sejarah, literasi sejarah, analisis isu kesejarahan serta pengambilan keputusan, dan kebermaknaan peristiwa sejarah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(666,'4df4a624-0934-11f0-8f5f-0242ac140002',7,19,NULL,5,7,15,46,'Keterampilan Proses - Mengumpulkan Informasi (Kritik Sumber)','KP-MI(KS) 24','Peserta didik menyeleksi sumber, memverifikasi, triangulasi/cek silang akurasi data dan fakta sejarah, menginterpretasi/menafsirkan data dan fakta sejarah. Secara spesifik keterampilan proses belajar sejarah mencakup keterampilan berpikir diakronis (kronologis) dan sinkronis, pemahaman sejarah, analisis dan interpretasi sejarah, kemampuan riset sejarah, literasi sejarah, analisis isu kesejarahan serta pengambilan keputusan, dan kebermaknaan peristiwa sejarah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(667,'4df5439a-0934-11f0-a93d-0242ac140002',7,19,NULL,5,7,15,46,'Keterampilan Proses - Menarik Kesimpulan','KP-MK 24','Peserta didik menarasikan temuan hasil investigasi terhadap permasalahan terkait materi pelajaran Sejarah. Secara spesifik keterampilan proses belajar sejarah mencakup keterampilan berpikir diakronis (kronologis) dan sinkronis, pemahaman sejarah, analisis dan interpretasi sejarah, kemampuan riset sejarah, literasi sejarah, analisis isu kesejarahan serta pengambilan keputusan, dan kebermaknaan peristiwa sejarah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(668,'4df5d15c-0934-11f0-9f7d-0242ac140002',7,19,NULL,5,7,15,46,'Keterampilan Proses - Mengomunikasikan','KP-MN 24','Peserta didik menyajikan informasi sejarah secara lisan, tulisan, dan/atau media lain, dalam bentuk digital atau nondigital. Secara spesifik keterampilan proses belajar sejarah mencakup keterampilan berpikir diakronis (kronologis) dan sinkronis, pemahaman sejarah, analisis dan interpretasi sejarah, kemampuan riset sejarah, literasi sejarah, analisis isu kesejarahan serta pengambilan keputusan, dan kebermaknaan peristiwa sejarah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(669,'4df6909c-0934-11f0-ac5c-0242ac140002',7,19,NULL,5,7,15,46,'Keterampilan Proses - Merefleksikan','KP-MR 24','Peserta didik merefleksikan dan merencanakan projek lanjutan secara kolaboratif: peserta didik mengevaluasi pengalaman belajar dan merencanakan projek lanjutan lintas mata pelajaran secara kolaboratif. Secara spesifik keterampilan proses belajar sejarah mencakup keterampilan berpikir diakronis (kronologis) dan sinkronis, pemahaman sejarah, analisis dan interpretasi sejarah, kemampuan riset sejarah, literasi sejarah, analisis isu kesejarahan serta pengambilan keputusan, dan kebermaknaan peristiwa sejarah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(670,'4df735a6-0934-11f0-8077-0242ac140002',7,19,NULL,5,7,16,46,'Pemahaman Konsep','PK 24','Peserta didik menggunakan konsep dasar sejarah dan penelitian sejarah untuk menganalisis keterhubungan antara masa lampau, masa kini, dan masa yang akan datang, serta mengaitkan berbagai peristiwa sejarah di Indonesia dalam lingkup lokal, nasional, dan global mulai dari masa penjajahan bangsa Barat, perlawanan rakyat daerah terhadap penjajah, pergerakan kebangsaan Indonesia, pendudukan Jepang, proklamasi kemerdekaan Indonesia, mempertahankan kemerdekaan Indonesia, pemerintahan Sukarno, pemerintahanSuharto, dan reformasi','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(671,'4df7b404-0934-11f0-af31-0242ac140002',7,19,NULL,5,7,16,46,'Keterampilan Proses - Mengamati','KP-MT 24','Peserta didik mencermati fenomena sejarah terkait materi pelajaran. Secara spesifik keterampilan proses belajar sejarah mencakup keterampilan berpikir diakronis (kronologis) dan sinkronis, pemahaman sejarah, analisis dan interpretasi sejarah, kemampuan riset sejarah, literasi sejarah, analisis isu kesejarahan serta pengambilan keputusan, dan kebermaknaan peristiwa sejarah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(672,'4df8595e-0934-11f0-8fa0-0242ac140002',7,19,NULL,5,7,16,46,'Keterampilan Proses - Menanya','KP-MA 24','Peserta didik menyusun pertanyaan tentang hal yang ingin diketahui dan masalah yang sedang diselidiki dengan rumus 5W 1H (apa, siapa, kapan, di mana, mengapa, dan bagaimana) dan memperkirakan jawaban atas pertanyaan. Secara spesifik keterampilan proses belajar sejarah mencakup keterampilan berpikir diakronis (kronologis) dan sinkronis, pemahaman sejarah, analisis dan interpretasi sejarah, kemampuan riset sejarah, literasi sejarah, analisis isu kesejarahan serta pengambilan keputusan, dan kebermaknaan peristiwa sejarah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(673,'4df9110a-0934-11f0-a277-0242ac140002',7,19,NULL,5,7,16,46,'Keterampilan Proses - Mengumpulkan Informasi (Heuristik)','KP-MI(H) 24','Peserta didik mencari informasi dari sumber sejarah (sumber primer dan\nsekunder) melalui studi pustaka, studi dokumen/arsip, wawancara, observasi, kuesioner, dan lain-lain. Secara spesifik keterampilan proses belajar sejarah mencakup keterampilan berpikir diakronis (kronologis) dan sinkronis, pemahaman sejarah, analisis dan interpretasi sejarah, kemampuan riset sejarah, literasi sejarah, analisis isu kesejarahan serta pengambilan keputusan, dan kebermaknaan peristiwa sejarah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(674,'4df98f5e-0934-11f0-aeff-0242ac140002',7,19,NULL,5,7,16,46,'Keterampilan Proses - Mengumpulkan Informasi (Kritik Sumber)','KP-MI(KS) 24','Peserta didik menyeleksi sumber, memverifikasi, triangulasi/cek silang akurasi data dan fakta sejarah, menginterpretasi/menafsirkan data dan fakta sejarah. Secara spesifik keterampilan proses belajar sejarah mencakup keterampilan berpikir diakronis (kronologis) dan sinkronis, pemahaman sejarah, analisis dan interpretasi sejarah, kemampuan riset sejarah, literasi sejarah, analisis isu kesejarahan serta pengambilan keputusan, dan kebermaknaan peristiwa sejarah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(675,'4dfa3378-0934-11f0-86c3-0242ac140002',7,19,NULL,5,7,16,46,'Keterampilan Proses - Menarik Kesimpulan','KP-MK 24','Peserta didik menarasikan temuan hasil investigasi terhadap permasalahan terkait materi pelajaran Sejarah. Secara spesifik keterampilan proses belajar sejarah mencakup keterampilan berpikir diakronis (kronologis) dan sinkronis, pemahaman sejarah, analisis dan interpretasi sejarah, kemampuan riset sejarah, literasi sejarah, analisis isu kesejarahan serta pengambilan keputusan, dan kebermaknaan peristiwa sejarah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(676,'4dfacc8e-0934-11f0-a9cb-0242ac140002',7,19,NULL,5,7,16,46,'Keterampilan Proses - Mengomunikasikan','KP-MN 24','Peserta didik menyajikan informasi sejarah secara lisan, tulisan, dan/atau media lain, dalam bentuk digital atau nondigital. Secara spesifik keterampilan proses belajar sejarah mencakup keterampilan berpikir diakronis (kronologis) dan sinkronis, pemahaman sejarah, analisis dan interpretasi sejarah, kemampuan riset sejarah, literasi sejarah, analisis isu kesejarahan serta pengambilan keputusan, dan kebermaknaan peristiwa sejarah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(677,'4dfb71de-0934-11f0-96e9-0242ac140002',7,19,NULL,5,7,16,46,'Keterampilan Proses - Merefleksikan','KP-MR 24','Peserta didik merefleksikan dan merencanakan projek lanjutan secara kolaboratif: peserta didik mengevaluasi pengalaman belajar dan merencanakan projek lanjutan lintas mata pelajaran secara kolaboratif. Secara spesifik keterampilan proses belajar sejarah mencakup keterampilan berpikir diakronis (kronologis) dan sinkronis, pemahaman sejarah, analisis dan interpretasi sejarah, kemampuan riset sejarah, literasi sejarah, analisis isu kesejarahan serta pengambilan keputusan, dan kebermaknaan peristiwa sejarah','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(678,'4dfc0e32-0934-11f0-baa8-0242ac140002',7,19,NULL,5,7,15,56,'Pemahaman Konsep','PK 24','Peserta didik mampu memahami secara keruangan tentang keuntungan posisi strategis wilayah Indonesia dan sumber daya alam; pola keanekaragaman hayati Indonesia dan dunia; kependudukan; lingkungan hidup, kebencanaan, serta perubahan iklim. Peserta didik memahami kewilayahan dan pembangunan serta kerja sama antar wilayah yang terjadi','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(679,'4dfc98fc-0934-11f0-9059-0242ac140002',7,19,NULL,5,7,15,56,'Keterampilan Proses - Mengamati','KP-M 24','Peserta didik mampu mengamati fenomena geosfer di Indonesia dan/atau dunia, membuat pertanyaan untuk menggali informasi secara mendalam tentang fenomena geosfer fisik atau sosial','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(680,'4dfd40b8-0934-11f0-8482-0242ac140002',7,19,NULL,5,7,15,56,'Keterampilan Proses - Mengumpulkan Informasi dan Mengomunikasikan','KP-MIM 24','Peserta didik mampu mengumpulkan informasi, melakukan observasi secara langsung atau studi literasi, mendokumentasikan, menganalisis dan menarik simpulan dari informasi yang diperoleh serta mengomunikasikannya dalam bentuk peta sederhana atau menggunakan aplikasi digital, grafik, infografis, dan/atau tabel','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(681,'4dfe0818-0934-11f0-a84b-0242ac140002',7,19,NULL,5,7,15,56,'Keterampilan Proses - Merefleksikan Informasi','KP-MRI 24','Peserta didik mampu merefleksikan informasi, hasil observasi, dan hasil dokumentasi yang diperoleh serta mengomunikasikannya ke media yang tersedia','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(682,'4dfe9846-0934-11f0-a225-0242ac140002',7,19,NULL,5,7,15,56,'Keterampilan Proses - Merencanakan Tindaklanjut','KP-MTK 24','Peserta didik merencanakan projek lanjutan secara kolaboratif dalam rangka meningkatkan pemahaman terhadap kerja sama antar wilayah di Indonesia','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(683,'4dff50a6-0934-11f0-8145-0242ac140002',7,19,NULL,5,7,16,56,'Pemahaman Konsep','PK 24','Peserta didik mampu memahami secara keruangan tentang keuntungan posisi strategis wilayah Indonesia dan sumber daya alam; pola keanekaragaman hayati Indonesia dan dunia; kependudukan; lingkungan hidup, kebencanaan, serta perubahan iklim. Peserta didik memahami kewilayahan dan pembangunan serta kerja sama antar wilayah yang terjadi','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(684,'4e00222e-0934-11f0-b832-0242ac140002',7,19,NULL,5,7,16,56,'Keterampilan Proses - Mengamati','KP-M 24','Peserta didik mampu mengamati fenomena geosfer di Indonesia dan/atau dunia, membuat pertanyaan untuk menggali informasi secara mendalam tentang fenomena geosfer fisik atau sosial','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(685,'4e00e844-0934-11f0-a281-0242ac140002',7,19,NULL,5,7,16,56,'Keterampilan Proses - Mengumpulkan Informasi dan Mengomunikasikan','KP-MIM 24','Peserta didik mampu mengumpulkan informasi, melakukan observasi secara langsung atau studi literasi, mendokumentasikan, menganalisis dan menarik simpulan dari informasi yang diperoleh serta mengomunikasikannya dalam bentuk peta sederhana atau menggunakan aplikasi digital, grafik, infografis, dan/atau tabel','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(686,'4e01716a-0934-11f0-8365-0242ac140002',7,19,NULL,5,7,16,56,'Keterampilan Proses - Merefleksikan Informasi','KP-MRI 24','Peserta didik mampu merefleksikan informasi, hasil observasi, dan hasil dokumentasi yang diperoleh serta mengomunikasikannya ke media yang tersedia','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(687,'4e020eb8-0934-11f0-bb76-0242ac140002',7,19,NULL,5,7,16,56,'Keterampilan Proses - Merencanakan Tindaklanjut','KP-MTK 24','Peserta didik merencanakan projek lanjutan secara kolaboratif dalam rangka meningkatkan pemahaman terhadap kerja sama antar wilayah di Indonesia','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(688,'4e029f40-0934-11f0-a389-0242ac140002',7,19,NULL,5,7,15,52,'Pemahaman Konsep','PK 24','Peserta didik memahami berbagai konsep dasar ekonomi. Peserta didik memahami peranan akuntansi sebagai alat bantu dalam pengambilan keputusan keuangan dan ekonomi. Peserta didik memahami berbagai permasalahan ekonomi dan keuangan yang terjadi di lingkungan sekitar serta memahami dampak dari permasalahan ekonomi dan keuangan yang sedang terjadi berdasarkan konsep yang sudah dipelajari. Konsep-konsep yang diharapkan dipahami peserta didik pada fase ini, yaitu pendapatan nasional dan pertumbuhan ekonomi serta kaitannya dengan kemiskinan, kesenjangan ekonomi, serta solusi untuk mengatasinya; konsep ketenagakerjaan dan masalahnya serta solusi untuk mengatasinya; konsep uang dan peredaran uang serta kaitannya dengan inflasi dan kebijakan moneter; konsep akuntansi keuangan dasar dalam konteks menilai kondisi keuangan unit usaha (persamaan dasar akuntansi dan laporan keuangan); konsep kebijakan fiskal, fungsi anggaran negara dan daerah, dan perpajakan; konsep ekonomi internasional dan masalahnya; serta konsep literasi ekonomi dan keuangan digital','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(689,'4e03a02a-0934-11f0-a8ed-0242ac140002',7,19,NULL,5,7,15,52,'Keterampilan Proses - Mengamati','KP-M 24','Peserta didik mengamati kondisi dan masalah ekonomi di lingkungan sekitar, regional, atau nasional','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(690,'4e04306c-0934-11f0-b3c2-0242ac140002',7,19,NULL,5,7,15,52,'Keterampilan Proses - Mempertanyakan dan Memprediksi','KP-MM 24','Peserta didik mempertanyakan dan memprediksi faktor penyebab, kondisi, dan masalah ekonomi di lingkungan sekitar, regional, atau nasional','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(691,'4e04c612-0934-11f0-bd68-0242ac140002',7,19,NULL,5,7,15,52,'Keterampilan Proses - Mengumpulkan Informasi','KP-MI 24','Peserta didik mengumpulkan informasi berkaitan dengan kondisi dan permasalahan ekonomi di lingkungan sekitar, regional, atau nasional','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(692,'4e056392-0934-11f0-b6d9-0242ac140002',7,19,NULL,5,7,15,52,'Keterampilan Proses - Memvalidasi dan Menganalisis Informasi','KP-MMI 24','Peserta didik memvalidasi dan menganalisis informasi yang telah dikumpulkan terkait dengan faktor penyebab kondisi dan permasalahan ekonomi di lingkungan sekitar, regional, atau nasional','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(693,'4e06307e-0934-11f0-95ed-0242ac140002',7,19,NULL,5,7,15,52,'Keterampilan Proses - Menarik Kesimpulan','KP-MK 24','Peserta didik menarik kesimpulan terkait faktor penyebab dan memberikan solusi atas kondisi dan permasalahan ekonomi di lingkungan sekitar, regional, atau nasional','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(694,'4e06e186-0934-11f0-a7ba-0242ac140002',7,19,NULL,5,7,15,52,'Keterampilan Proses - Mengomunikasikan Hasil','KP-MH 24','Peserta didik mengomunikasikan hasil pengamatan terkait penarikan kesimpulan atas kondisi dan permasalahan ekonomi serta solusi mengatasinya','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(695,'4e07aaee-0934-11f0-bcd2-0242ac140002',7,19,NULL,5,7,15,52,'Keterampilan Proses - Merencanakan Tindaklanjut','KP-MT 24','Peserta didik merencanakan projek lanjutan secara kolaboratif dalam rangka mengurangi permasalahan ekonomi di lingkungan sekitar','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(696,'4e0837b6-0934-11f0-9fe6-0242ac140002',7,19,NULL,5,7,16,52,'Pemahaman Konsep','PK 24','Peserta didik memahami berbagai konsep dasar ekonomi. Peserta didik memahami peranan akuntansi sebagai alat bantu dalam pengambilan keputusan keuangan dan ekonomi. Peserta didik memahami berbagai permasalahan ekonomi dan keuangan yang terjadi di lingkungan sekitar serta memahami dampak dari permasalahan ekonomi dan keuangan yang sedang terjadi berdasarkan konsep yang sudah dipelajari. Konsep-konsep yang diharapkan dipahami peserta didik pada fase ini, yaitu pendapatan nasional dan pertumbuhan ekonomi serta kaitannya dengan kemiskinan, kesenjangan ekonomi, serta solusi untuk mengatasinya; konsep ketenagakerjaan dan masalahnya serta solusi untuk mengatasinya; konsep uang dan peredaran uang serta kaitannya dengan inflasi dan kebijakan moneter; konsep akuntansi keuangan dasar dalam konteks menilai kondisi keuangan unit usaha (persamaan dasar akuntansi dan laporan keuangan); konsep kebijakan fiskal, fungsi anggaran negara dan daerah, dan perpajakan; konsep ekonomi internasional dan masalahnya; serta konsep literasi ekonomi dan keuangan digital','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(697,'4e08c6cc-0934-11f0-b20e-0242ac140002',7,19,NULL,5,7,16,52,'Keterampilan Proses - Mengamati','KP-M 24','Peserta didik mengamati kondisi dan masalah ekonomi di lingkungan sekitar, regional, atau nasional','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(698,'4e0952a4-0934-11f0-b509-0242ac140002',7,19,NULL,5,7,16,52,'Keterampilan Proses - Mempertanyakan dan Memprediksi','KP-MM 24','Peserta didik mempertanyakan dan memprediksi faktor penyebab, kondisi, dan masalah ekonomi di lingkungan sekitar, regional, atau nasional','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(699,'4e09f484-0934-11f0-8f8d-0242ac140002',7,19,NULL,5,7,16,52,'Keterampilan Proses - Mengumpulkan Informasi','KP-MI 24','Peserta didik mengumpulkan informasi berkaitan dengan kondisi dan permasalahan ekonomi di lingkungan sekitar, regional, atau nasional','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(700,'4e0a9d08-0934-11f0-a871-0242ac140002',7,19,NULL,5,7,16,52,'Keterampilan Proses - Memvalidasi dan Menganalisis Informasi','KP-MMI 24','Peserta didik memvalidasi dan menganalisis informasi yang telah dikumpulkan terkait dengan faktor penyebab kondisi dan permasalahan ekonomi di lingkungan sekitar, regional, atau nasional','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(701,'4e0b68c8-0934-11f0-b1c9-0242ac140002',7,19,NULL,5,7,16,52,'Keterampilan Proses - Menarik Kesimpulan','KP-MK 24','Peserta didik menarik kesimpulan terkait faktor penyebab dan memberikan solusi atas kondisi dan permasalahan ekonomi di lingkungan sekitar, regional, atau nasional','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(702,'4e0c0b16-0934-11f0-84e2-0242ac140002',7,19,NULL,5,7,16,52,'Keterampilan Proses - Mengomunikasikan Hasil','KP-MH 24','Peserta didik mengomunikasikan hasil pengamatan terkait penarikan kesimpulan atas kondisi dan permasalahan ekonomi serta solusi mengatasinya','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(703,'4e0c9ff4-0934-11f0-8c21-0242ac140002',7,19,NULL,5,7,16,52,'Keterampilan Proses - Merencanakan Tindaklanjut','KP-MT 24','Peserta didik merencanakan projek lanjutan secara kolaboratif dalam rangka mengurangi permasalahan ekonomi di lingkungan sekitar','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(704,'4e0d22e4-0934-11f0-a1e8-0242ac140002',7,19,NULL,5,7,15,54,'Pemahaman Konsep','PK 24','Peserta didik mampu memahami berbagai permasalahan sosial, konflik, dan kekerasan yang terjadi di masyarakat. Peserta didik mampu secara kritis, analitis, dan kreatif memberikan pemecahan masalah sosial yang solutif terhadap dinamika kehidupan sosial di tengah masyarakat digital saat ini. Penerapan prinsip kesetaraan dalam perbedaan sosial digunakan untuk mewujudkan masyarakat multikultural yang harmonis dan integratif. Peserta didik juga mampu memahami terjadinya perubahan sosial pada kelompok atau komunitas di tengah arus globalisasi dan mampu memberikan solusi terhadap dampak globalisasi dan perkembangan teknologi digital. Peserta didik juga mampu merancang strategi, melakukan dan mengevaluasi kegiatan/projek pemberdayaan komunitas berbasis kearifan lokal','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(705,'4e0dbb3c-0934-11f0-a02c-0242ac140002',7,19,NULL,5,7,15,54,'Keterampilan Proses - Mengamati','KP-M 24','Peserta didik mampu mengamati fenomena sosial di Indonesia dan/atau dunia, serta membuat pertanyaan untuk menggali informasi secara mendalam tentang fenomena sosial yang terjadi','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(706,'4e0e3dd2-0934-11f0-8043-0242ac140002',7,19,NULL,5,7,15,54,'Keterampilan Proses - Mengumpulkan Informasi dan Menganalisis','KP-MIM 24','Peserta didik mampu mengumpulkan informasi dari sumber primer dan sekunder, melakukan observasi partisipatif dan mendokumentasikan, menganalisis dan menguji keabsahan data, serta menarik simpulan dari informasi yang diperoleh','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(707,'4e0ec6a8-0934-11f0-90eb-0242ac140002',7,19,NULL,5,7,15,54,'Keterampilan Proses - Mengomunikasikan Hasil','KP-MH 24','Peserta didik mengomunikasikannya dalam bentuk grafik, infografis, dan/atau tabel','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(708,'4e0f4efc-0934-11f0-9fcc-0242ac140002',7,19,NULL,5,7,15,54,'Keterampilan Proses - Merefleksikan Hasil Informasi','KP-MHI 24','Peserta didik mampu merefleksikan hasil informasi, hasil observasi dan hasil dokumentasi yang diperoleh untuk ekspektasi di masa depan, serta merencanakan penelitian sosial lanjutan pada masyarakat yang lebih luas','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(709,'4e0fec36-0934-11f0-9924-0242ac140002',7,19,NULL,5,7,16,54,'Pemahaman Konsep','PK 24','Peserta didik mampu memahami berbagai permasalahan sosial, konflik, dan kekerasan yang terjadi di masyarakat. Peserta didik mampu secara kritis, analitis, dan kreatif memberikan pemecahan masalah sosial yang solutif terhadap dinamika kehidupan sosial di tengah masyarakat digital saat ini. Penerapan prinsip kesetaraan dalam perbedaan sosial digunakan untuk mewujudkan masyarakat multikultural yang harmonis dan integratif. Peserta didik juga mampu memahami terjadinya perubahan sosial pada kelompok atau komunitas di tengah arus globalisasi dan mampu memberikan solusi terhadap dampak globalisasi dan perkembangan teknologi digital. Peserta didik juga mampu merancang strategi, melakukan dan mengevaluasi kegiatan/projek pemberdayaan komunitas berbasis kearifan lokal','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(710,'4e107b56-0934-11f0-82e0-0242ac140002',7,19,NULL,5,7,16,54,'Keterampilan Proses - Mengamati','KP-M 24','Peserta didik mampu mengamati fenomena sosial di Indonesia dan/atau dunia, serta membuat pertanyaan untuk menggali informasi secara mendalam tentang fenomena sosial yang terjadi','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(711,'4e111624-0934-11f0-91a2-0242ac140002',7,19,NULL,5,7,16,54,'Keterampilan Proses - Mengumpulkan Informasi dan Menganalisis','KP-MIM 24','Peserta didik mampu mengumpulkan informasi dari sumber primer dan sekunder, melakukan observasi partisipatif dan mendokumentasikan, menganalisis dan menguji keabsahan data, serta menarik simpulan dari informasi yang diperoleh','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(712,'4e11bb6a-0934-11f0-a1d8-0242ac140002',7,19,NULL,5,7,16,54,'Keterampilan Proses - Mengomunikasikan Hasil','KP-MH 24','Peserta didik mengomunikasikannya dalam bentuk grafik, infografis, dan/atau tabel','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(713,'4e12520a-0934-11f0-8b2f-0242ac140002',7,19,NULL,5,7,16,54,'Keterampilan Proses - Merefleksikan Hasil Informasi','KP-MHI 24','Peserta didik mampu merefleksikan hasil informasi, hasil observasi dan hasil dokumentasi yang diperoleh untuk ekspektasi di masa depan, serta merencanakan penelitian sosial lanjutan pada masyarakat yang lebih luas','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(714,'4e12d658-0934-11f0-8771-0242ac140002',7,19,NULL,5,7,15,51,'Aljabar dan Fungsi','AF 24','Peserta didik dapat melakukan operasi aritmetika pada polinomial (suku banyak), menentukan faktor polinomial, dan menggunakan identitas polinomial untuk menyelesaikan masalah. Peserta didik dapat melakukan operasi aljabar pada matriks dan menerapkannya dalam transformasi geometri. Peserta didik dapat menyatakan fungsi trigonometri menggunakan lingkaran satuan, memodelkan fenomena periodik dengan fungsi trigonometri, dan membuktikan serta menerapkan identitas trigonometri dan aturan cosinus dan sinus. Peserta didik dapat mengenal berbagai fungsi (termasuk fungsi rasional, fungsi akar, fungsi eksponensial, fungsi logaritma, fungsi nilai mutlak, fungsi tangga, dan fungsi piecewise dan menggunakannya untuk memodelkan berbagai fenomena','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(715,'4e1352b8-0934-11f0-b799-0242ac140002',7,19,NULL,5,7,15,51,'Geometri','GO 24','Peserta didik dapat menyatakan vektor pada bidang datar, dan melakukan operasi aljabar pada vektor. Mereka dapat melakukan pembuktian geometris menggunakan vektor. Peserta didik dapat menyatakan sifat-sifat geometri dari persamaan lingkaran, elips, dan persamaan garis singgung','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(716,'4e13d8dc-0934-11f0-b9d1-0242ac140002',7,19,NULL,5,7,15,51,'Analisis Data dan Peluang','ADP 24','Peserta didik memahami variabel diskrit acak dan fungsi peluang, dan menggunakannya dalam memodelkan data. Mereka dapat menginterpretasi parameter distribusi data secara statistik (seragam, binomial dan normal), menghitung nilai harapan distribusi binomial dan normal, dan menggunakannya dalam penyelesaian masalah','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(717,'4e148f48-0934-11f0-b8ed-0242ac140002',7,19,NULL,5,7,15,51,'Kalkulus','KS 24','Peserta didik dapat memahami laju perubahan dan laju perubahan rata-rata,serta laju perubahan sesaat sebagai konsep kunci derivatif (turunan), baik secara geometris maupun aljabar. Mereka dapat menentukan turunan dari fungsi polinomial, eksponensial, dan trigonometri, dan menerapkan derivatif untuk membuat sketsa kurva, menghitung gradien dan menentukan persamaan garis singgung, enentukan kecepatan sesaat dan menyelesaikan soal optimasi. Mereka dapat memahami integral, baik sebagai proses yang merupakan kebalikan dari derivatif dan juga sebagai cara menghitung luas. Mereka memahami teorema dasar kalkulus sebagai penghubung antara derivatif dan integral','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(718,'4e152976-0934-11f0-8373-0242ac140002',7,19,NULL,5,7,16,51,'Aljabar dan Fungsi','AF 24','Peserta didik dapat melakukan operasi aritmetika pada polinomial (suku banyak), menentukan faktor polinomial, dan menggunakan identitas polinomial untuk menyelesaikan masalah. Peserta didik dapat melakukan operasi aljabar pada matriks dan menerapkannya dalam transformasi geometri. Peserta didik dapat menyatakan fungsi trigonometri menggunakan lingkaran satuan, memodelkan fenomena periodik dengan fungsi trigonometri, dan membuktikan serta menerapkan identitas trigonometri dan aturan cosinus dan sinus. Peserta didik dapat mengenal berbagai fungsi (termasuk fungsi rasional, fungsi akar, fungsi eksponensial, fungsi logaritma, fungsi nilai mutlak, fungsi tangga, dan fungsi piecewise dan menggunakannya untuk memodelkan berbagai fenomena','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(719,'4e15cfa2-0934-11f0-8b58-0242ac140002',7,19,NULL,5,7,16,51,'Geometri','GO 24','Peserta didik dapat menyatakan vektor pada bidang datar, dan melakukan operasi aljabar pada vektor. Mereka dapat melakukan pembuktian geometris menggunakan vektor. Peserta didik dapat menyatakan sifat-sifat geometri dari persamaan lingkaran, elips, dan persamaan garis singgung','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(720,'4e171ed4-0934-11f0-9d96-0242ac140002',7,19,NULL,5,7,16,51,'Analisis Data dan Peluang','ADP 24','Peserta didik memahami variabel diskrit acak dan fungsi peluang, dan menggunakannya dalam memodelkan data. Mereka dapat menginterpretasi parameter distribusi data secara statistik (seragam, binomial dan normal), menghitung nilai harapan distribusi binomial dan normal, dan menggunakannya dalam penyelesaian masalah','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(721,'4e17d626-0934-11f0-97a0-0242ac140002',7,19,NULL,5,7,16,51,'Kalkulus','KS 24','Peserta didik dapat memahami laju perubahan dan laju perubahan rata-rata,serta laju perubahan sesaat sebagai konsep kunci derivatif (turunan), baik secara geometris maupun aljabar. Mereka dapat menentukan turunan dari fungsi polinomial, eksponensial, dan trigonometri, dan menerapkan derivatif untuk membuat sketsa kurva, menghitung gradien dan menentukan persamaan garis singgung, enentukan kecepatan sesaat dan menyelesaikan soal optimasi. Mereka dapat memahami integral, baik sebagai proses yang merupakan kebalikan dari derivatif dan juga sebagai cara menghitung luas. Mereka memahami teorema dasar kalkulus sebagai penghubung antara derivatif dan integral','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(722,'4e186082-0934-11f0-bf3e-0242ac140002',7,19,NULL,5,7,15,40,'Menyimak','ME 24','Peserta didik dapat memahami informasi umum, selektif, dan terperinci dari teks lisan sederhana tentang kehidupan sehari-hari, lingkungan sekitar, dan lintas budaya','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(723,'4e18fb5a-0934-11f0-9259-0242ac140002',7,19,NULL,5,7,15,40,'Berbicara','BC 24','Peserta didik dapat memproduksi teks lisan sederhana dalam bentuk dialog dan monolog tentang kehidupan sehari-hari, lingkungan sekitar, dan lintas budaya.','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(724,'4e1b0f3a-0934-11f0-9331-0242ac140002',7,19,NULL,5,7,15,40,'Membaca','MC 24','Peserta didik dapat memahami informasi umum, selektif, dan terperinci dari berbagai jenis teks tulis sederhana tentang kehidupan sehari-hari, lingkungan sekitar, dan lintas budaya','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(725,'4e1bada0-0934-11f0-b33f-0242ac140002',7,19,NULL,5,7,15,40,'Menulis','MN 24','Peserta didik dapat menyusun teks tulis sederhana dalam bentuk dialog, formulir isian, pos-el (email), dan teks sederhana lainnya tentang kehidupan sehari-hari, lingkungan sekitar, dan lintas budaya','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(726,'4e1c672c-0934-11f0-84b4-0242ac140002',7,19,NULL,5,7,16,40,'Menyimak','ME 24','Peserta didik dapat memahami informasi umum, selektif, dan terperinci dari teks lisan sederhana tentang kehidupan sehari-hari, lingkungan sekitar, dan lintas budaya','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(727,'4e1ce7e2-0934-11f0-979b-0242ac140002',7,19,NULL,5,7,16,40,'Berbicara','BC 24','Peserta didik dapat memproduksi teks lisan sederhana dalam bentuk dialog dan monolog tentang kehidupan sehari-hari, lingkungan sekitar, dan lintas budaya.','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(728,'4e1d773e-0934-11f0-9600-0242ac140002',7,19,NULL,5,7,16,40,'Membaca','MC 24','Peserta didik dapat memahami informasi umum, selektif, dan terperinci dari berbagai jenis teks tulis sederhana tentang kehidupan sehari-hari, lingkungan sekitar, dan lintas budaya','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(729,'4e1e28be-0934-11f0-ab67-0242ac140002',7,19,NULL,5,7,16,40,'Menulis','MN 24','Peserta didik dapat menyusun teks tulis sederhana dalam bentuk dialog, formulir isian, pos-el (email), dan teks sederhana lainnya tentang kehidupan sehari-hari, lingkungan sekitar, dan lintas budaya','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL);
/*!40000 ALTER TABLE `learning_objectives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_rubric_scales`
--

DROP TABLE IF EXISTS `learning_rubric_scales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `learning_rubric_scales` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rubric_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` decimal(8,2) NOT NULL,
  `narrative` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `learning_rubric_scales_uuid_unique` (`uuid`),
  KEY `learning_rubric_scales_rubric_id_foreign` (`rubric_id`),
  CONSTRAINT `learning_rubric_scales_rubric_id_foreign` FOREIGN KEY (`rubric_id`) REFERENCES `learning_rubrics` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_rubric_scales`
--

LOCK TABLES `learning_rubric_scales` WRITE;
/*!40000 ALTER TABLE `learning_rubric_scales` DISABLE KEYS */;
INSERT INTO `learning_rubric_scales` VALUES (1,'4bf895e2-0934-11f0-9851-0242ac140002',1,'A',5.00,'A','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(2,'4bf8d07a-0934-11f0-8896-0242ac140002',1,'B',4.00,'B','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(3,'4bf90310-0934-11f0-bc24-0242ac140002',1,'C',3.00,'C','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(4,'4bf935a6-0934-11f0-9bd1-0242ac140002',1,'D',2.00,'D','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(5,'4bf963dc-0934-11f0-84f6-0242ac140002',1,'E',1.00,'E','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(6,'4bf9db78-0934-11f0-8fdc-0242ac140002',2,'Perfect',5.00,'Perfect','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(7,'4bfa59a4-0934-11f0-957b-0242ac140002',2,'Excellent',4.00,'Excellent','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(8,'4bfa846a-0934-11f0-b38d-0242ac140002',2,'Good',3.00,'Good','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(9,'4bfaa922-0934-11f0-8fb4-0242ac140002',2,'Not Bad',2.00,'Not Bad','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(10,'4bfaceac-0934-11f0-a31a-0242ac140002',2,'Foolish',1.00,'Foolish','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(11,'4bfb29b0-0934-11f0-b4f8-0242ac140002',3,'A',5.00,'A','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(12,'4bfb5f34-0934-11f0-93bd-0242ac140002',3,'B',4.00,'B','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(13,'4bfb8af4-0934-11f0-9c6d-0242ac140002',3,'C',3.00,'C','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(14,'4bfbadd6-0934-11f0-9dd4-0242ac140002',3,'D',2.00,'D','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(15,'4bfbcfbe-0934-11f0-abec-0242ac140002',3,'E',1.00,'E','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(16,'4d2bbbd8-0934-11f0-942e-0242ac140002',4,'MB',1.00,'Ananda mulai berkembang dalam melakukan kegiatan sentra atau muatan lokal,  Ananda masih perlu dibimbing oleh guru dalam mengerjakan desitas main yang ditawarkan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(17,'4d2be504-0934-11f0-9772-0242ac140002',4,'SB',2.00,'Ananda sedang berkembang dalam melakukan kegiatan sentra/mulok dengan bantuan/arahan dari guru atau masih perlu diingatkan sesekali.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(18,'4d2c093a-0934-11f0-b228-0242ac140002',4,'BSH',3.00,'Ananda berkembang sesuai harapan dalam melakukan kegiatan sentra /mulok, Ananda dapat melakukan kegiatan secara mandiri dan konsisten tanpa harus diingatkan atau dicontohkan oleh guru.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(19,'4d2c495e-0934-11f0-bcab-0242ac140002',4,'BSB',4.00,'Ananda berkembang sangat baik, Ananda sudah dapat melakukan kegiatan secara mandiri, bahkan mampu menolong temannya untuk berkegiatan bersama.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(20,'4d2ca17e-0934-11f0-9265-0242ac140002',5,'1',1.00,'Peserta Didik mulai berkembang dalam proses mempersiapan hingga menyelesaikan proyek P5','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(21,'4d2cca46-0934-11f0-8cf0-0242ac140002',5,'2',2.00,'Peserta Didik sedang berkembang dan membutuhkan bimbingan dalam memulai proyek hingga menyelesaikan proyek P5/.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(22,'4d2cf39a-0934-11f0-9175-0242ac140002',5,'3',3.00,'Peserta Didik sudah mandiri dan dapat memulai proyek hingga menyelesaikannya tanpa bantuan dari guru.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(23,'4d2d23d8-0934-11f0-8b56-0242ac140002',5,'4',4.00,'Peserta Didik sudah mampu memulai proyek hingga menyelesaikan proyek dengan sangat baik, dan dapat berkolaborasi dengan temannya untuk menyelesaikan proyek bersama.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(24,'4d6ff21c-0934-11f0-b93e-0242ac140002',6,'A',5.00,'A','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(25,'4d7108e6-0934-11f0-9a34-0242ac140002',6,'B',4.00,'B','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(26,'4d71b232-0934-11f0-9744-0242ac140002',6,'C',3.00,'C','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(27,'4d7252aa-0934-11f0-8ed7-0242ac140002',6,'D',2.00,'D','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(28,'4d7317a8-0934-11f0-a90d-0242ac140002',6,'E',1.00,'E','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(29,'4d750e14-0934-11f0-bb14-0242ac140002',7,'Perfect',5.00,'Perfect','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(30,'4d760e7c-0934-11f0-85eb-0242ac140002',7,'Excellent',4.00,'Excellent','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(31,'4d768df2-0934-11f0-b81d-0242ac140002',7,'Good',3.00,'Good','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(32,'4d76fe7c-0934-11f0-a91c-0242ac140002',7,'Not Bad',2.00,'Not Bad','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(33,'4d775106-0934-11f0-80e7-0242ac140002',7,'Foolish',1.00,'Foolish','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(34,'4d780498-0934-11f0-ae5f-0242ac140002',8,'A',5.00,'A','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(35,'4d787266-0934-11f0-ad77-0242ac140002',8,'B',4.00,'B','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(36,'4d78df1c-0934-11f0-8fad-0242ac140002',8,'C',3.00,'C','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(37,'4d793e3a-0934-11f0-a964-0242ac140002',8,'D',2.00,'D','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(38,'4d799718-0934-11f0-8238-0242ac140002',8,'E',1.00,'E','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(39,'4d91a01a-0934-11f0-a66e-0242ac140002',9,'A',5.00,'A','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(40,'4d91cad6-0934-11f0-ab29-0242ac140002',9,'B',4.00,'B','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(41,'4d91fb0a-0934-11f0-ae16-0242ac140002',9,'C',3.00,'C','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(42,'4d921f18-0934-11f0-9485-0242ac140002',9,'D',2.00,'D','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(43,'4d924b96-0934-11f0-8461-0242ac140002',9,'E',1.00,'E','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(44,'4d92a122-0934-11f0-be01-0242ac140002',10,'Perfect',5.00,'Perfect','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(45,'4d92c72e-0934-11f0-a471-0242ac140002',10,'Excellent',4.00,'Excellent','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(46,'4d92e9d4-0934-11f0-b4cd-0242ac140002',10,'Good',3.00,'Good','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(47,'4d931774-0934-11f0-a552-0242ac140002',10,'Not Bad',2.00,'Not Bad','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(48,'4d93640e-0934-11f0-9c25-0242ac140002',10,'Foolish',1.00,'Foolish','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(49,'4d93d876-0934-11f0-92e0-0242ac140002',11,'A',5.00,'A','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(50,'4d941732-0934-11f0-b2b6-0242ac140002',11,'B',4.00,'B','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(51,'4d944824-0934-11f0-a8aa-0242ac140002',11,'C',3.00,'C','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(52,'4d948884-0934-11f0-a0a8-0242ac140002',11,'D',2.00,'D','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(53,'4d94b566-0934-11f0-8490-0242ac140002',11,'E',1.00,'E','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL);
/*!40000 ALTER TABLE `learning_rubric_scales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_rubrics`
--

DROP TABLE IF EXISTS `learning_rubrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `learning_rubrics` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_curriculum_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `learning_rubrics_uuid_unique` (`uuid`),
  KEY `learning_rubrics_school_curriculum_id_foreign` (`school_curriculum_id`),
  CONSTRAINT `learning_rubrics_school_curriculum_id_foreign` FOREIGN KEY (`school_curriculum_id`) REFERENCES `school_curriculums` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_rubrics`
--

LOCK TABLES `learning_rubrics` WRITE;
/*!40000 ALTER TABLE `learning_rubrics` DISABLE KEYS */;
INSERT INTO `learning_rubrics` VALUES (1,'4bf81d38-0934-11f0-9575-0242ac140002',1,'Cognitive','learning-rubric-1','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(2,'4bf9a608-0934-11f0-bbbf-0242ac140002',1,'Confident','learning-rubric-2','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(3,'4bfafa30-0934-11f0-be73-0242ac140002',1,'Spiritual','learning-rubric-3','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(4,'4d2b8b04-0934-11f0-80f6-0242ac140002',2,'Asesmen Ceklis Sentra/Mulok','CEKLIS','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(5,'4d2c7820-0934-11f0-9dca-0242ac140002',2,'P5','P5','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(6,'4d6f2d64-0934-11f0-aeab-0242ac140002',4,'Cognitive','learning-rubric-1','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(7,'4d7479cc-0934-11f0-a0c9-0242ac140002',4,'Confident','learning-rubric-2','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(8,'4d77b25e-0934-11f0-94cc-0242ac140002',4,'Spiritual','learning-rubric-3','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(9,'4d917a0e-0934-11f0-9fa7-0242ac140002',6,'Cognitive','learning-rubric-1','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(10,'4d927bc0-0934-11f0-ad74-0242ac140002',6,'Confident','learning-rubric-2','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(11,'4d93a126-0934-11f0-82aa-0242ac140002',6,'Spiritual','learning-rubric-3','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL);
/*!40000 ALTER TABLE `learning_rubrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_auth_tables',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2025_01_29_135255_create_permission_tables',1),(5,'2025_01_29_135713_create_chats_table',1),(6,'2025_01_30_030137_create_information_tables',1),(7,'2025_01_30_030237_create_entity_tables',1),(8,'2025_01_30_030338_create_organization_tables',1),(9,'2025_01_30_035311_create_submission_tables',1),(10,'2025_01_30_055317_create_publication_tables',1),(11,'2025_01_30_071832_create_transaction_tables',1),(12,'2025_01_30_073808_create_admission_tables',1),(13,'2025_03_03_090847_create_school_tables',2),(14,'2025_01_30_030338_create_office_tables',3),(15,'2025_01_30_030339_create_school_tables',3),(16,'2025_03_05_061740_update_columns_families_table',3),(17,'2025_03_15_064140_update_columns_publication_tables',4),(18,'2025_03_15_131000_add_column_thumbnail_events_table',4),(19,'2025_03_17_045944_create_product_discount_usages_table',4),(20,'2025_03_17_215531_add_column_student_id_admission_students_table',4),(21,'2025_03_23_085953_create_teaching_program_tables',4),(22,'2025_03_25_021159_create_school_academic_programs_table',4);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES (1,'App\\Models\\User',1),(2,'App\\Models\\User',2),(3,'App\\Models\\User',3),(3,'App\\Models\\User',4),(3,'App\\Models\\User',5),(3,'App\\Models\\User',6),(3,'App\\Models\\User',7),(3,'App\\Models\\User',8),(3,'App\\Models\\User',9),(3,'App\\Models\\User',10),(3,'App\\Models\\User',11),(3,'App\\Models\\User',12),(3,'App\\Models\\User',13),(3,'App\\Models\\User',14),(3,'App\\Models\\User',15),(3,'App\\Models\\User',16),(3,'App\\Models\\User',17),(3,'App\\Models\\User',18),(3,'App\\Models\\User',19),(3,'App\\Models\\User',20),(3,'App\\Models\\User',21),(3,'App\\Models\\User',22),(3,'App\\Models\\User',23),(3,'App\\Models\\User',24),(3,'App\\Models\\User',25),(3,'App\\Models\\User',26),(3,'App\\Models\\User',27),(3,'App\\Models\\User',28),(3,'App\\Models\\User',29),(3,'App\\Models\\User',30),(3,'App\\Models\\User',31),(3,'App\\Models\\User',32),(3,'App\\Models\\User',33),(3,'App\\Models\\User',34),(3,'App\\Models\\User',35),(3,'App\\Models\\User',36),(3,'App\\Models\\User',37),(3,'App\\Models\\User',38),(3,'App\\Models\\User',39),(3,'App\\Models\\User',40),(3,'App\\Models\\User',41),(3,'App\\Models\\User',42),(3,'App\\Models\\User',43),(3,'App\\Models\\User',44),(3,'App\\Models\\User',45),(3,'App\\Models\\User',46),(3,'App\\Models\\User',47),(3,'App\\Models\\User',48),(3,'App\\Models\\User',49),(3,'App\\Models\\User',50),(3,'App\\Models\\User',51),(3,'App\\Models\\User',52),(3,'App\\Models\\User',53),(3,'App\\Models\\User',54),(3,'App\\Models\\User',55),(3,'App\\Models\\User',56),(3,'App\\Models\\User',57),(3,'App\\Models\\User',58),(3,'App\\Models\\User',59),(3,'App\\Models\\User',60),(3,'App\\Models\\User',61),(3,'App\\Models\\User',62),(3,'App\\Models\\User',63),(3,'App\\Models\\User',64),(3,'App\\Models\\User',65),(3,'App\\Models\\User',66),(3,'App\\Models\\User',67),(3,'App\\Models\\User',68),(3,'App\\Models\\User',69),(3,'App\\Models\\User',70),(3,'App\\Models\\User',71),(3,'App\\Models\\User',72),(3,'App\\Models\\User',73),(3,'App\\Models\\User',74),(3,'App\\Models\\User',75),(3,'App\\Models\\User',76),(3,'App\\Models\\User',77),(3,'App\\Models\\User',78),(3,'App\\Models\\User',79),(3,'App\\Models\\User',80),(3,'App\\Models\\User',81),(3,'App\\Models\\User',82),(3,'App\\Models\\User',83),(3,'App\\Models\\User',84),(3,'App\\Models\\User',85),(3,'App\\Models\\User',86),(3,'App\\Models\\User',87),(3,'App\\Models\\User',88),(3,'App\\Models\\User',89),(3,'App\\Models\\User',90),(3,'App\\Models\\User',91),(3,'App\\Models\\User',92),(3,'App\\Models\\User',93),(3,'App\\Models\\User',94),(3,'App\\Models\\User',95),(3,'App\\Models\\User',96),(3,'App\\Models\\User',97),(3,'App\\Models\\User',98),(3,'App\\Models\\User',99),(3,'App\\Models\\User',100),(3,'App\\Models\\User',101),(3,'App\\Models\\User',102),(3,'App\\Models\\User',103),(3,'App\\Models\\User',104),(3,'App\\Models\\User',105),(3,'App\\Models\\User',106),(3,'App\\Models\\User',107),(3,'App\\Models\\User',108),(3,'App\\Models\\User',109),(3,'App\\Models\\User',110),(3,'App\\Models\\User',111),(3,'App\\Models\\User',112),(3,'App\\Models\\User',113),(3,'App\\Models\\User',114),(3,'App\\Models\\User',115);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offices`
--

DROP TABLE IF EXISTS `offices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `offices_uuid_unique` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offices`
--

LOCK TABLES `offices` WRITE;
/*!40000 ALTER TABLE `offices` DISABLE KEYS */;
INSERT INTO `offices` VALUES (1,'bcc9a206-f594-11ef-8a6e-0200a013a61c','HCM','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(2,'bcca3e32-f594-11ef-9bb0-0200a013a61c','QRD','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(3,'bccadf54-f594-11ef-8dad-0200a013a61c','FA','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(4,'bccb69b0-f594-11ef-a756-0200a013a61c','ICC','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(5,'bccbf8d0-f594-11ef-9325-0200a013a61c','GA','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(6,'bccc8336-f594-11ef-87dc-0200a013a61c','Management','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL);
/*!40000 ALTER TABLE `offices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operational_areas`
--

DROP TABLE IF EXISTS `operational_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operational_areas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `operational_areas_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operational_areas`
--

LOCK TABLES `operational_areas` WRITE;
/*!40000 ALTER TABLE `operational_areas` DISABLE KEYS */;
/*!40000 ALTER TABLE `operational_areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operational_hours`
--

DROP TABLE IF EXISTS `operational_hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operational_hours` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `operational_area_id` bigint(20) unsigned NOT NULL,
  `day` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `open_time` time NOT NULL,
  `closed_time` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `operational_hours_uuid_unique` (`uuid`),
  KEY `operational_hours_operational_area_id_foreign` (`operational_area_id`),
  CONSTRAINT `operational_hours_operational_area_id_foreign` FOREIGN KEY (`operational_area_id`) REFERENCES `operational_areas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operational_hours`
--

LOCK TABLES `operational_hours` WRITE;
/*!40000 ALTER TABLE `operational_hours` DISABLE KEYS */;
/*!40000 ALTER TABLE `operational_hours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pages_uuid_unique` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,'5bad03aa-0935-11f0-9ce9-0242ac140002','VISION_MISSION','Visi & Misi','Menjadi sekolah terbaik dalam layanan, maksimal mencerdaskan generasi berkarakter Kristus yang menghasilkan karya unggul bagi Indonesia. Membangun karakter mulia berlandaskan nilai-nilai Kristus,Mengarahkan peserta didik memiliki tujuan hidup yang benar sejak dini, Menggali, menemukan dan mengembangkan potensi peserta didik secara maksimal, Memfasilitasi dan mendorong peserta didik untuk berinovasi dan berkarya, Memberikan layanan prima kepada seluruh pemangku kepentingan sekolah','2025-03-25 04:55:22','2025-03-25 04:55:22',NULL),(2,'5bae7596-0935-11f0-adb1-0242ac140002','HISTORY','Sejarah','Sekolah Kristen Harapan Bangsa pertama kali didirikan pada tahun 2008 untuk melanjutkan program Taman Kanak-kanak Happy Holy Kids. Kedua sekolah tersebut berafiliasi di bawah Yayasan Tunas Cahaya Bangsa dan didirikan oleh 4 pengurus yaitu Bapak Ronny Runtukahu, Bapak Doni Prasetyo, Bapak Daniel Henson, dan mendiang Ibu Lenny Priskila Tan yang merupakan kepala sekolah pertama di kedua sekolah tersebut. Menjadi sekolah terbaik dalam layanan, maksimal mencerdaskan generasi berkarakter Kristus yang menghasilkan karya unggul bagi Indonesia. “Sekolah K.A.R.Y.A” merupakan filosofi dan arah pendidikan terbaru yang ditetapkan oleh segenap jajaran kepemimpinan Yayasan Tunas Cahaya Bangsa untuk diterapkan di lingkungan KB-TK Happy Holy Kids dan SD Kristen – SMA Kristen Harapan Bangsa Balikpapan sejak bulan Maret 2020. ','2025-03-25 04:55:22','2025-03-25 04:55:22',NULL);
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `positions`
--

DROP TABLE IF EXISTS `positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `positions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `area_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `positions_uuid_unique` (`uuid`),
  KEY `positions_area_id_foreign` (`area_id`),
  CONSTRAINT `positions_area_id_foreign` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `positions`
--

LOCK TABLES `positions` WRITE;
/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
INSERT INTO `positions` VALUES (1,'bccd5f36-f594-11ef-b61b-0200a013a61c',3,'Administrator School','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(2,'bccde712-f594-11ef-8a72-0200a013a61c',1,'Teacher','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(3,'bcce850a-f594-11ef-9726-0200a013a61c',1,'Principal School','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(4,'bccef364-f594-11ef-b094-0200a013a61c',7,'Manager','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(5,'bccf7870-f594-11ef-868c-0200a013a61c',1,'Vice Principal School','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(6,'bccff84a-f594-11ef-904a-0200a013a61c',1,'Vice Principal Curriculum','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(7,'bcd07414-f594-11ef-9702-0200a013a61c',1,'Character Coordinator','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(8,'bcd0e7be-f594-11ef-8bf4-0200a013a61c',1,'Extracurricular Coordinator','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(9,'bcd15e9c-f594-11ef-b366-0200a013a61c',1,'Equipment Coordinator','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(10,'bcd1f1cc-f594-11ef-ab29-0200a013a61c',1,'Administrator School','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(11,'bcd28fa6-f594-11ef-b92e-0200a013a61c',1,'Worship Coordinator','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(12,'bcd31f20-f594-11ef-8c98-0200a013a61c',2,'Principal School','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(13,'bcd3b2c8-f594-11ef-81eb-0200a013a61c',2,'Vice Principal Curriculum','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(14,'bcd457f0-f594-11ef-9797-0200a013a61c',2,'Vice Principal Student Affairs','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(15,'bcd4e60c-f594-11ef-9cc4-0200a013a61c',2,'Teacher','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(16,'bcd5806c-f594-11ef-8066-0200a013a61c',2,'Equipment Coordinator','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(17,'bcd61630-f594-11ef-a65e-0200a013a61c',2,'Facilities Coordinator','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(18,'bcd6a71c-f594-11ef-9da4-0200a013a61c',10,'Staff','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(19,'bcd732ae-f594-11ef-8fb5-0200a013a61c',2,'Extracurricular Coordinator','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(20,'bcd7baee-f594-11ef-a497-0200a013a61c',2,'Worship Coordinator','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(21,'bcd8475c-f594-11ef-9f38-0200a013a61c',2,'Curriculum Coordinator','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(22,'bcd8d74e-f594-11ef-a691-0200a013a61c',2,'Administration Staff','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(23,'bcd974f6-f594-11ef-8472-0200a013a61c',4,'Teacher','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(24,'bcd9e5ee-f594-11ef-b896-0200a013a61c',6,'Staff','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(25,'bcda82b0-f594-11ef-ad68-0200a013a61c',4,'Principal School','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(26,'bcdaf0f6-f594-11ef-a957-0200a013a61c',4,'Vice Principal School','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(27,'bcdba79e-f594-11ef-a2f2-0200a013a61c',3,'Teacher','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(28,'bcdc21d8-f594-11ef-a23c-0200a013a61c',3,'Character Coordinator','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(29,'bcdca338-f594-11ef-a6ed-0200a013a61c',4,'Coordinator School','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(30,'bcdd198a-f594-11ef-b5ce-0200a013a61c',4,'Curriculum Coordinator','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(31,'bcdd8636-f594-11ef-b4de-0200a013a61c',3,'Extracurricular Coordinator','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(32,'bcddf530-f594-11ef-b6e5-0200a013a61c',4,'Character Coordinator','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(33,'bcde6024-f594-11ef-8a7e-0200a013a61c',3,'Administration Staff','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(34,'bcdecda2-f594-11ef-81b7-0200a013a61c',3,'Curriculum Coordinator','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(35,'bcdf504c-f594-11ef-9004-0200a013a61c',7,'Staff','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(36,'bcdfc694-f594-11ef-9877-0200a013a61c',9,'Manager','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(37,'bce0376e-f594-11ef-868d-0200a013a61c',5,'Assistant Manager','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(38,'bce0c274-f594-11ef-b0ac-0200a013a61c',9,'Maintenance Staff','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(39,'bce12d36-f594-11ef-9dc2-0200a013a61c',9,'Maintenance Coordinator','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(40,'bce1dcea-f594-11ef-8b22-0200a013a61c',9,'Driver','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(41,'bce2512a-f594-11ef-8726-0200a013a61c',5,'Staff','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(42,'bce34ff8-f594-11ef-b30b-0200a013a61c',9,'Staff','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(43,'bce409e8-f594-11ef-b569-0200a013a61c',9,'ICT Staff','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(44,'bce48ea4-f594-11ef-8cee-0200a013a61c',6,'Manager','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(45,'bce546f0-f594-11ef-9bdf-0200a013a61c',8,'Staff','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(46,'bce5bde2-f594-11ef-ad0a-0200a013a61c',6,'Supervisor','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(47,'bce63344-f594-11ef-b060-0200a013a61c',5,'Manager','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(48,'bce6e032-f594-11ef-94c8-0200a013a61c',2,'Administrator School','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL);
/*!40000 ALTER TABLE `positions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_categories`
--

DROP TABLE IF EXISTS `post_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `post_categories_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_categories`
--

LOCK TABLES `post_categories` WRITE;
/*!40000 ALTER TABLE `post_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author_id` bigint(20) unsigned NOT NULL,
  `category_id` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `published_at` datetime NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_uuid_unique` (`uuid`),
  UNIQUE KEY `posts_slug_unique` (`slug`),
  KEY `posts_author_id_foreign` (`author_id`),
  KEY `posts_category_id_foreign` (`category_id`),
  CONSTRAINT `posts_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  CONSTRAINT `posts_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `post_categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `area_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_uuid_unique` (`uuid`),
  KEY `products_area_id_foreign` (`area_id`),
  CONSTRAINT `products_area_id_foreign` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'bd38d22a-f594-11ef-b9de-0200a013a61c','Formulir Pendaftaran Siswa Baru','ADMISSION_STUDENT_FORM','SYSTEM',300000.00,0,'2025-02-28 05:27:45','2025-03-03 02:33:09',NULL,NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `national_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birth_place` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blood_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `religion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `marital_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `postal_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profiles_uuid_unique` (`uuid`),
  UNIQUE KEY `profiles_national_id_unique` (`national_id`),
  UNIQUE KEY `profiles_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,'bce80ae8-f594-11ef-8746-0200a013a61c',NULL,'SAFFix',NULL,NULL,NULL,NULL,NULL,NULL,'admin@saffix.id',NULL,NULL,NULL,NULL,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(2,'bd110380-f594-11ef-a9ae-0200a013a61c',NULL,'HBICS',NULL,NULL,NULL,NULL,NULL,NULL,'admin@hbics.sch.id',NULL,NULL,NULL,NULL,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(3,'bd465cce-f594-11ef-bd00-0200a013a61c','000000000','Developer Saffix',NULL,NULL,NULL,NULL,NULL,NULL,'developer@saffix.id',NULL,NULL,NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(4,'bd48383c-f594-11ef-9f47-0200a013a61c','16255.891002771.90','Yacobus S','Balikpapan','1989-07-12','MALE','AB','JEWISH','WIDOWED','yacobus.s@hbics.sch.id',NULL,'I dont know my address',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(5,'bd499880-f594-11ef-af35-0200a013a61c','6471044412890002','Dina Adesthy Njoo','Balikpapan','1989-12-04','FEMALE',NULL,'CHRISTIAN','MARRIED','dinaadesthy.hhk@hbics.sch.id',NULL,'Komp BB Mediterania pos 11 Blok U1/36',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(6,'bd4aee6a-f594-11ef-815e-0200a013a61c','3571015705880002','Dyah Anggarini','Kediri','1988-05-17','FEMALE',NULL,'CHRISTIAN','MARRIED','dyah.ytcb@hbics.sch.id',NULL,'Perumahan Graha Mulawarman Blok C No 32, Balikpapan',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(7,'bd4c4526-f594-11ef-8f65-0200a013a61c','61.221.2220033.2111','ICC_akun_test','Balikpapan','1970-02-05','MALE','O','HINDU','SINGLE','yacobus.setiawan@hotmail.com',NULL,'Jalan Telaga Sari No 28',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(8,'bd4d77fc-f594-11ef-a14c-0200a013a61c','6471055412830008','Natalia Heriati','Kediri','1983-12-14','FEMALE',NULL,'CHRISTIAN','MARRIED','nataliaheriati.hhk@hbics.sch.id',NULL,'Jl Wonorejo III Rt 51 Blok C  No 16',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(9,'bd4ed41c-f594-11ef-825f-0200a013a61c','6471046704780007','Masye Polla','Manado','1978-04-27','FEMALE',NULL,'CHRISTIAN','MARRIED','masyepolla.hhk@hbics.sch.id',NULL,'Perumahan Pesona Alam Permai Block CC 10 Batu Ampar',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(10,'bd50362c-f594-11ef-b9db-0200a013a61c','1212034307870005','Elprida simanjuntak','Ombur','1987-07-03','FEMALE',NULL,'CHRISTIAN','SINGLE','elpridasimanjuntak.hhk@hbics.sch.id',NULL,'Jl. Swadaya No 29 Rt 2',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(11,'bd5177b2-f594-11ef-bece-0200a013a61c','1218156104910003','Enita Sitinjak S.PD','Sei belutu','1991-04-21','FEMALE',NULL,'CHRISTIAN','SINGLE','enitasitinjak.hhk@hbics.sch.id',NULL,'Jl. Swadaya No 29 Rt 2',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(12,'bd52d8fa-f594-11ef-8116-0200a013a61c','6371014202910016','Eva Grace Sumasa S.Pd','Muara Teweh','1991-02-02','FEMALE',NULL,'CHRISTIAN','MARRIED','evasumasa.hhk@hbics.sch.id',NULL,'Jl. Rhein No 118 Perum Griya Permata Asri',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(13,'bd5433e4-f594-11ef-bd4d-0200a013a61c','6471056609010003','Grace Charity Tehilla Harjanto','Magelang','2001-09-26','FEMALE',NULL,'CHRISTIAN','SINGLE','gracecharity.hhk@hbics.sch.id',NULL,'Balikpapan Baru Orlando DA-01',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(14,'bd558730-f594-11ef-9a33-0200a013a61c','6471024804800003','Ivana M. Kawung','Kawangkoan','1980-04-08','FEMALE',NULL,'CHRISTIAN','MARRIED','ivanakawung.hhk@hbics.sch.id',NULL,'Jl Syarifudin Yoes jln Terang Blok A No 2',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(15,'bd56de50-f594-11ef-aac2-0200a013a61c','6474034706850002','Juika Sobon','Balikpapan','1985-06-07','FEMALE',NULL,'CHRISTIAN','MARRIED','juikasobon.hhk@hbics.sch.id',NULL,'Jln Letjen S Parman No 24 Rt 29',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(16,'bd582bf2-f594-11ef-9d2a-0200a013a61c','3171064608970001','Loed Devina Abigail','Jakarta','1997-08-06','FEMALE',NULL,'CHRISTIAN','MARRIED','loeddevina.hhk@hbics.sch.id',NULL,'Jln Aup No 6 Rt 006',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(17,'bd5973b8-f594-11ef-83e4-0200a013a61c','7171075909830001','Maya Cyntia Sigar','Langowan','1983-09-09','FEMALE',NULL,'CHRISTIAN','MARRIED','mayasigar.hhk@hbics.sch.id',NULL,'Jl. Tiga RT 2 Kampung timur',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(18,'bd5ac222-f594-11ef-9612-0200a013a61c','6471054505890005','Priscilla Tirsa Sulangi','Balikpapan','1989-05-05','FEMALE',NULL,'CHRISTIAN','MARRIED','priscillasulangi.hhk@hbics.sch.id',NULL,'Jln Kintamani XIV V17 Balikpapan Regency',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(19,'bd5c2234-f594-11ef-97c9-0200a013a61c','6471045103860004','Ryen Mart Purba','Balikpapan','1986-03-11','FEMALE',NULL,'CHRISTIAN','MARRIED','ryenpurba.hhk@hbics.sch.id',NULL,'Syarifuddin yoes Rt 45 No 82 Gg Duatan Sakai Kel. Sepinggan baru',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(20,'bd5d6e82-f594-11ef-beef-0200a013a61c','7326146707000001','Salvira Limbong','Baruppu','2000-07-27','FEMALE',NULL,'CHRISTIAN','SINGLE','salviralimbong.hhk@hbics.sch.id',NULL,'Balikpapan Baru blok U2 No 5',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(21,'bd5eccbe-f594-11ef-a803-0200a013a61c','3373036402010002','Tasya Maria Febrianti','Jakarta','2001-02-24','FEMALE',NULL,'CHRISTIAN','SINGLE','tasyamf.hhk@hbics.sch.id',NULL,'R E Martadinata No 43 RT 22',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(22,'bd60267c-f594-11ef-9486-0200a013a61c','3507084902870006','Yoise Merine Seitte','Situbondo','1987-02-09','FEMALE',NULL,'CHRISTIAN','MARRIED','yoiseseitte.hhk@hbics.sch.id',NULL,'Perum Griya Permata Asri Blok H-35 Rt 29 No F145',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(23,'bd619f0c-f594-11ef-8d97-0200a013a61c','3314014702890001','Febiyoga Alit Pawestri','Klaten','1989-02-07','FEMALE',NULL,'CHRISTIAN','MARRIED','febiyoga.hhk@hbics.sch.id',NULL,'Jln Telaga sari II No 28',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(24,'bd630702-f594-11ef-a55e-0200a013a61c','1204055406000001','Meniria Laoli','Ombolata Saloo','2000-03-27','FEMALE',NULL,'CHRISTIAN','SINGLE','menirialaoli.hhk@hbics.sch.id',NULL,'Ombolata Saloo',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(25,'bd647498-f594-11ef-aef6-0200a013a61c','6471056110810006','Wildah Edrostina Nababan','Medan','1981-10-21','FEMALE',NULL,'CHRISTIAN','MARRIED','wildah.hhk@hbics.sch.id',NULL,'Palm Hills, Blok AA 2 No. 15',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(26,'bd65e35a-f594-11ef-8c26-0200a013a61c','6408046101880001','Hana Flowerens Sitorus','Bontang','1988-01-21','FEMALE',NULL,'CHRISTIAN','MARRIED','hana.sitorus@hbics.sch.id',NULL,'Jl. Musi No 33A Perum GPA',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(27,'bd67611c-f594-11ef-bac5-0200a013a61c','6471036403830004','Chelsia Sumendap','Tondano','1983-03-24','FEMALE',NULL,'CHRISTIAN','MARRIED','chelsia.sumendap@hbics.sch.id',NULL,'Minangkabau RT 04 No 40A, Batu Ampar',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(28,'bd68dbe6-f594-11ef-ae2f-0200a013a61c','6472051609810003','Mangapul Silalahi','Motung','1981-09-16','MALE',NULL,'CHRISTIAN','MARRIED','mangapulsilalahi.hb-primary@hbics.sch.id',NULL,'Perum Graha Indah PGRI Blok B2 No 10',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(29,'bd6a516a-f594-11ef-8e16-0200a013a61c','6471024402890002','Amelia Sondang Febriyanti','Jakarta','1989-02-04','FEMALE',NULL,'CHRISTIAN','MARRIED','amelia.sondang@hbics.sch.id',NULL,'Perum Bumi Nirwana Indah Blok I/1A',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(30,'bd6bc176-f594-11ef-800c-0200a013a61c','6409014308910005','Anjelyn Susanti Purba','Balikpapan','1991-08-03','FEMALE',NULL,'CHRISTIAN','MARRIED','anjelynpurba.hb-primary@hbics.sch.id',NULL,'Jln Perintis Penajam Utara',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(31,'bd6d6508-f594-11ef-94fd-0200a013a61c','6472034105930005','Brigita Rosari','Palu','1993-05-01','FEMALE',NULL,'CHRISTIAN','MARRIED','brigitarosari.hb-primary@hbics.sch.id',NULL,'Jln Pattimura Perum Batu Ampar Lestari Blok C3B No 10 Rt 60',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(32,'bd6f1b96-f594-11ef-b11e-0200a013a61c','1207056609940001','Christina Carolyna Bakara','Panyabungan','1994-09-26','FEMALE',NULL,'CHRISTIAN','SINGLE','christinabakara.hb-primary@hbics.sch.id',NULL,'Jl. Kembang Kencana no 9p RT 07 RW 02, Jakarta',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(33,'bd70f98e-f594-11ef-af9e-0200a013a61c','1204015112960005','Desmin Berliani Harefa','Gunungsitoli','1996-12-11','FEMALE',NULL,'CHRISTIAN','SINGLE','desmin.hb-primary@hbics.sch.id',NULL,'Jl Tirta No 5 GG Panti Asuhan B',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(34,'bd728222-f594-11ef-b472-0200a013a61c','6471021009910001','Erik Gunena','Balikpapan','1991-09-10','MALE',NULL,'CHRISTIAN','MARRIED','erik.gunena@hbics.sch.id',NULL,'Jln Adil Makmur No 12 Rt 20 Balikpapan',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(35,'bd741a92-f594-11ef-9737-0200a013a61c','1272055508910006','Friska Yanti Tobing','Pematangsiantar','1991-08-15','FEMALE',NULL,'CHRISTIAN','MARRIED','friskayanti.hb-primary@hbics.sch.id',NULL,'Balikpapan Regency Blok JB3 No 32',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(36,'bd75a4c0-f594-11ef-97ec-0200a013a61c','6471034504840001','Gloria Siahaan','Bontang','1984-04-05','FEMALE',NULL,'CHRISTIAN','MARRIED','gloriasiahaan.hb-primary@hbics.sch.id',NULL,'Kutai Hills 8 No 12 Perum Wika',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(37,'bd772e1c-f594-11ef-a663-0200a013a61c','6471035410820002','Hellen Christina','Jakarta','1982-10-14','FEMALE',NULL,'CHRISTIAN','MARRIED','hellenchristina.hb-primary@hbics.sch.id',NULL,'Jl. Tepo KM  10 Rt 007 Karang Joang Perum Bumi , Karang joang',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(38,'bd78fa76-f594-11ef-978b-0200a013a61c','1275055705980004','Indriani Ginting','Binjai','1998-05-17','FEMALE',NULL,'CHRISTIAN','SINGLE','indrianiginting.hb-primary@hbics.sch.id',NULL,'Jln Sei Bangkatan Kota Binjai',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(39,'bd7a980e-f594-11ef-a6ef-0200a013a61c','1207231411930003','Kristian Adinata P','Sei Semayang','1993-11-14','MALE',NULL,'CHRISTIAN','SINGLE','kristianpangaribuan.hb-primary@hbics.sch.id',NULL,'Dusun XI Jln Binjai KM 13, 1 GG. Horas No 102',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(40,'bd7c0414-f594-11ef-9a7f-0200a013a61c','6471054401920006','Lougi Virgi Priscilla Posumah','Balikpapan','1992-01-04','FEMALE',NULL,'CHRISTIAN','MARRIED','lougi.hb-primary@hbics.sch.id',NULL,'Jl Telaga Sari 3 No 3',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(41,'bd7dd460-f594-11ef-b1bb-0200a013a61c','6471056608990002','Mega Ningrum Suwarno Putri','Balikpapan','1999-08-26','FEMALE',NULL,'CHRISTIAN','SINGLE','meganingrum.hb-primary@hbics.sch.id',NULL,'Perum Sepinggan Asri',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(42,'bd7f59a2-f594-11ef-8026-0200a013a61c','6112016305960008','Meini Fiana Fransiska','Sanggau','1996-05-23','FEMALE',NULL,'CHRISTIAN','SINGLE','meinifiana.hb-primary@hbics.sch.id',NULL,'BTN Teluk Mulus Rt 004',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(43,'bd80e574-f594-11ef-bf3a-0200a013a61c','6472036605830002','Meity Varyda Dene Saragih','Samarinda','1983-05-26','FEMALE',NULL,'CHRISTIAN','MARRIED','meitysaragih.hb-primary@hbics.sch.id',NULL,'Perum Blue Sapphire blok C No.4',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(44,'bd8273c6-f594-11ef-83ac-0200a013a61c','6403096304990001','Monica','Tanjung Redeb','1999-04-23','FEMALE',NULL,'BUDDHIST','SINGLE','monica.hb-primary@hbics.sch.id',NULL,'Jln Pasar Batu Rt 006 Teluk Bayur',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(45,'bd84234c-f594-11ef-a231-0200a013a61c','1207284208910002','Nora Agustina Silalahi','Lubuk Pakam','1991-08-02','FEMALE',NULL,'CHRISTIAN','SINGLE','noraagustina@hbics.sch.id',NULL,'Gg. Budi Cawang III Rt 012',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(46,'bd8619a4-f594-11ef-afb3-0200a013a61c','6402035411960001','Novilina Veronica Inu Dhei','Samarinda','1996-11-14','FEMALE',NULL,'CHRISTIAN','SINGLE','novilinadhei.hb-primary@hbics.sch.id',NULL,'Manunggal II Street, Durian Alley No 47',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(47,'bd881e2a-f594-11ef-af31-0200a013a61c','6471055107900001','Novita Permata Sari Tambunan','Balikpapan','1990-07-11','FEMALE',NULL,'CHRISTIAN','MARRIED','novi.tambunan@hbics.sch.id',NULL,'Jalan Dua No 18 Gn Samarinda',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(48,'bd89c77a-f594-11ef-baab-0200a013a61c','1271112001850003','Rados Fremiro Sembiring','Medan','1985-01-20','MALE',NULL,'CHRISTIAN','MARRIED','rados.fsembiring@hbics.sch.id',NULL,'Jl Melati III Tanah Tinggi',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(49,'bd8c0666-f594-11ef-b678-0200a013a61c','6406084102950001','Rahmadianti','Tarakan','1993-02-01','FEMALE',NULL,'CHRISTIAN','SINGLE','rahmadianti.hb-primary@hbics.sch.id',NULL,'Long Bila kec Malinau Barat',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(50,'bd8e0e70-f594-11ef-88b7-0200a013a61c','1407101011930006','Rimson Marusaha Sinaga','Sei Meranti','1993-11-10','MALE',NULL,'CHRISTIAN','SINGLE','matthew.sinaga@hbics.sch.id',NULL,'Jln. Lingkar Danau Buatan Rt 01',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(51,'bd8fb0ae-f594-11ef-809c-0200a013a61c','3275024504850030','Ruth Magdalena Simanjuntak','Jakarta','1985-04-05','FEMALE',NULL,'CHRISTIAN','MARRIED','lena@hbics.sch.id',NULL,'Jln S Parman Perumahan Pesona Azarya Blok A 77 Rt 30',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(52,'bd911520-f594-11ef-a4e3-0200a013a61c','6471056709920004','Tirsa Ester Amanda Koroh','Balikpapan','1992-09-27','FEMALE',NULL,'CHRISTIAN','MARRIED','tirsakoroh.hb-primary@hbics.sch.id',NULL,'Jl. Bubut No 99',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(53,'bd927e4c-f594-11ef-8016-0200a013a61c','1204015209950004','Vestin Putri Telaumbanua','Padang','1995-09-12','FEMALE',NULL,'CHRISTIAN','SINGLE','vestinputri.hb-primary@hbics.sch.id',NULL,'Jl. Ki Hajar Dewantara Karang Balik Tarakan',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(54,'bd9459e2-f594-11ef-85a0-0200a013a61c','6408044404020009','Vania Ananda Massangka','Balikpapan','2000-04-04','FEMALE',NULL,'CHRISTIAN','SINGLE','vaniaananda.hb-primary@hbics.sch.id',NULL,'Jln Timur Raya Rt 46 No 388',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(55,'bd9717ae-f594-11ef-b9d1-0200a013a61c','3277022910990008','Yonatan Alhas Wijaya','Cimahi','1999-10-29','MALE',NULL,'CHRISTIAN','SINGLE','yonatan.awijaya@hbics.sch.id',NULL,'Babakan Sari 009',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(56,'bd988b70-f594-11ef-81f9-0200a013a61c','1216076310940001','Elisabet Simanjuntak','Bonan Dolok','1994-10-23','FEMALE',NULL,'CHRISTIAN','MARRIED','elisabethsimanjuntak.hb-primary@hbics.sch.id',NULL,'Regency Cluster Castarica Blok JA1 No 38',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(57,'bd99fb5e-f594-11ef-bab7-0200a013a61c','5301184108960002','Elisabeth Agnes Tnunay','Buraen','1996-08-01','FEMALE',NULL,'CHRISTIAN','SINGLE','agnes.tnunay@hbics.sch.id',NULL,'Buraen, Rt 007',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(58,'bd9b6c14-f594-11ef-ab28-0200a013a61c','6471054705960005','Angela Merlyn Primatika','Balikpapan','1996-05-07','FEMALE',NULL,'CHRISTIAN','SINGLE','angelamryln.hb-primary@hbics.sch.id',NULL,'Jl Prapatan Dalam No 07',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(59,'bd9cfd54-f594-11ef-98d0-0200a013a61c','1271044209880005','Dita Primalani Nainggolan','Padang','1988-09-02','FEMALE',NULL,'CHRISTIAN','SINGLE','ditaprimalani.hb-primary@hbics.sch.id',NULL,'Jl Menteng VII Gg Swasembada',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(60,'bd9e6f40-f594-11ef-accd-0200a013a61c','1271134909900004','Laura A.D Sihombing','Medan','1990-09-09','FEMALE',NULL,'CHRISTIAN','MARRIED','lauraad.sihombing@hbics.sch.id',NULL,'Rukem Jaya III/ 41',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(61,'bd9ff036-f594-11ef-8f87-0200a013a61c','6472034606980003','Tracey Sheilla Asia','Samarinda','1998-06-06','FEMALE',NULL,'CHRISTIAN','MARRIED','traceys.asia@hbics.sch.id',NULL,'Komp Wika Blok CB5 nomor 12A',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(62,'bda16768-f594-11ef-a104-0200a013a61c','6471055502890003','Rika Febriyanti Lamtiur Panjaitan','Pekanbaru','1989-02-15','FEMALE',NULL,'CHRISTIAN','MARRIED','rika.panjaitan@hbics.sch.id',NULL,'Perum Melati Bintang Residence Blok no 3',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(63,'bda2db3e-f594-11ef-a913-0200a013a61c','1272016407980004','Kristina Habeahan','Pematangsiantar','1998-07-24','FEMALE',NULL,'CHRISTIAN','SINGLE','kristina.habeahan@hbics.sch.id',NULL,'Permosi No 6B',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(64,'bda44938-f594-11ef-9968-0200a013a61c','1272054611910001','Betty Sianturi','Marihat tapian nauli','1991-11-06','FEMALE',NULL,'CHRISTIAN','SINGLE','bettysianturi.hb-primary@hbics.sch.id',NULL,'Jl Melanthon Siregar 01/02 Siantar',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(65,'bda5c024-f594-11ef-a013-0200a013a61c','6471046604780004','Ruth Murwani Dumasthary. S.Sos., M.Pd','Pontianak','1978-04-26','FEMALE','A','CHRISTIAN','MARRIED',NULL,NULL,'Pelangi Pesona Residence I-6',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(66,'bda699ae-f594-11ef-8f25-0200a013a61c','3518066003880001','Margaretha Dwi Cahyani','Nganjuk','1988-03-20','FEMALE',NULL,'CHRISTIAN','MARRIED','margarethacahyani.hb-high@hbics.sch.id',NULL,'Pelangi Metro Residence Blok M No 23',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(67,'bda7ed5e-f594-11ef-8fc9-0200a013a61c','6471031303850003','Angelis Andreas Gama','Balikpapan','1985-03-13','MALE',NULL,'CHRISTIAN','MARRIED','aandreasgama.hb-secondary@hbics.sch.id',NULL,'Jl. Bubut No 99',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(68,'bda94cda-f594-11ef-a9ac-0200a013a61c','6471054706970006','Anita Simamora','Balikpapan','1997-06-07','FEMALE',NULL,'CHRISTIAN','SINGLE','anitasimamora.hb-secondary@hbics.sch.id',NULL,'Jln Jokotole No 126 Rt 14',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(69,'bdaaf1ca-f594-11ef-9fac-0200a013a61c','3273026704820011','Arianti','Bogor','1982-04-27','FEMALE',NULL,'CHRISTIAN','SINGLE','arianti.hb-high@hbics.sch.id',NULL,'Jl Ciheulang II No 11',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(70,'bdacbe9c-f594-11ef-9158-0200a013a61c','3471036712870002','Ayu Estiyanti Widiyantari Kiswanto','Yogyakarta','1987-12-27','FEMALE',NULL,'CHRISTIAN','MARRIED','ayuestiyanti.hb-secondary@hbics.sch.id',NULL,'Klitren Lor GK 3/378',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(71,'bdae53b0-f594-11ef-956c-0200a013a61c','3312126810920001','Bunga Ratnasari Hadipitoyo','Surakarta','1992-10-28','FEMALE',NULL,'CHRISTIAN','MARRIED','bungaratnasari.hb-secondary@hbics.sch.id',NULL,'Sepinggan Pratama Blok J7 No 2',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(72,'bdafe130-f594-11ef-9eb4-0200a013a61c','6471045311810002','Chatrilitha Laurine Nouviana','Balikpapan','1981-11-13','FEMALE',NULL,'CHRISTIAN','MARRIED','cnouviana.hb-high@hbics.sch.id',NULL,'Jl. Prapatan No 14 Rt 29',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(73,'bdb15cb8-f594-11ef-8800-0200a013a61c','3175065011890021','Christine Novita Mandasari','Jakarta','1989-11-10','FEMALE','O','CHRISTIAN','SINGLE',NULL,NULL,'Jalan Indrakila No. 9 Gunung Samarinda, Balikpapan Utara',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(74,'bdb252f8-f594-11ef-ab24-0200a013a61c','6474026002930002','Fertunata Monica Darsono','Bontang','1993-02-20','FEMALE',NULL,'CHRISTIAN','SINGLE','fertunatadarsono.hb-high@hbics.sch.id',NULL,'Batu ampar lestari Blok C-4 No 05 Balikpapan',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(75,'bdb3dc54-f594-11ef-acf2-0200a013a61c','7102135701930001','Jeisica Lumy','Manado','1993-01-17','FEMALE',NULL,'CHRISTIAN','SINGLE','jeisicalumy.hb-seniorhigh@hbics.sch.id',NULL,'Jaga III Sea Mitra',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(76,'bdb55976-f594-11ef-87f3-0200a013a61c','5171044412910003','Jessie BulurDitty','Ambon','1991-12-04','FEMALE',NULL,'CHRISTIAN','MARRIED','jessie.hb-secondary@hbics.sch.id',NULL,'Jl. Prona III Gg Perjuangan No. 12B',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(77,'bdb6dcd8-f594-11ef-888c-0200a013a61c','6471026109980002','Maria Josebia Pangestuti','Balikpapan','1998-09-21','FEMALE',NULL,'CHRISTIAN','SINGLE','mariajosebia.hb-secondary@hbics.sch.id',NULL,'Jl Hasanuddin No 107',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(78,'bdb85e78-f594-11ef-b461-0200a013a61c','1471115307950041','Mesianna Simbolon','Pekanbaru','1995-07-13','FEMALE','AB','CHRISTIAN','SINGLE',NULL,NULL,'Jl.Sidomukti No 6 Sigunggung Pekanbaru',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(79,'bdbbd116-f594-11ef-8ec3-0200a013a61c','7371126105970003','Meylodra Wilhelmina P','Ujung Pandang','1997-05-21','FEMALE',NULL,'CHRISTIAN','SINGLE','meylodra.hb-secondary@hbics.sch.id',NULL,'Jl Tagari Rt 002',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(80,'bdbd8b14-f594-11ef-817a-0200a013a61c','6471054601820005','Pingkan Patricia Ishwari','Jakarta','1982-01-06','FEMALE',NULL,'CHRISTIAN','MARRIED','pingkanishwari.hb-high@hbics.sch.id',NULL,'Perum Her 2 blok K2 No 7 jln Rinjani Sepinggan',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(81,'bdbf9b0c-f594-11ef-aaf4-0200a013a61c','1208043007970002','Riswandi Sinurat','Sirpang Sigodang','1997-07-30','MALE',NULL,'CHRISTIAN','SINGLE','riswandisinurat.hb-secondary@hbics.sch.id',NULL,'Simpang Sigodang, Panei',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(82,'bdc13ea8-f594-11ef-bee6-0200a013a61c','1208207101980001','Sari Fitri Dewi Debora Sinaga','Nagori','1999-01-31','FEMALE',NULL,'CHRISTIAN','SINGLE','sarifitri.hb-secondary@hbics.sch.id',NULL,'Desa Sibuntuon, Kec Dolok Pardamean',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(83,'bdc2e3fc-f594-11ef-96f2-0200a013a61c','3277034801930017','Stella Fanny Gerina','Cimahi','1993-01-08','FEMALE',NULL,'CHRISTIAN','MARRIED','stella.hb-secondary@hbics.sch.id',NULL,'Sungai Ampal No 15 Rt 43',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(84,'bdc4a994-f594-11ef-b9f0-0200a013a61c','1271096610920003','Suci Florence Night Ingeale S','Medan','1992-10-26','FEMALE',NULL,'CHRISTIAN','SINGLE','suciflorence.hb-secondary@hbics.sch.id',NULL,'Jl.Aman Bagansiapiapi, Kec.Bangko',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(85,'bdc6993e-f594-11ef-b99d-0200a013a61c','1206014109970001','Vina Meliyana BR Perangin angin','Kabanjahe','1997-09-01','FEMALE',NULL,'CHRISTIAN','SINGLE','vinameliyana.hb-seniorhigh@hbics.sch.id',NULL,'Gang Naga Bonar, Kabanjahe',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(86,'bdc8498c-f594-11ef-a40c-0200a013a61c','5206022810971004','Sukarman','Nggembe','1997-10-28','MALE',NULL,'ISLAM','SINGLE','sukarman.hb-seniorhigh@hbics.sch.id',NULL,'Dusun Oi Wontu',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(87,'bdca79a0-f594-11ef-8da4-0200a013a61c','1306091704960002','Rizky Kurniawan','Bukit tinggi','1996-04-17','MALE',NULL,'ISLAM','SINGLE','rizkykurniawan.hb-seniorhigh@hbics.sch.id',NULL,'Kampung Baru Pelipit',NULL,NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(88,'bdcc6026-f594-11ef-b974-0200a013a61c','6472065006990004','Eryka Mayang Pamungkas','Samarinda','1999-06-10','FEMALE',NULL,'CHRISTIAN','SINGLE','eryka.hb-secondary@hbics.sch.id',NULL,'Simpang Raya, RT 001',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(89,'bdce2514-f594-11ef-af32-0200a013a61c','3507090806920002','Andreas Lukita','Malang','1992-06-08','MALE',NULL,'CHRISTIAN','SINGLE','andreaslukita.hb-seniorhigh@hbics.sch.id',NULL,'Jln Raya Kedok RT 017',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(90,'bdcfe502-f594-11ef-b2af-0200a013a61c','3372036911960005','Azalia Herma','Surakarta','1996-11-29','FEMALE',NULL,'CHRISTIAN','SINGLE','azaliaherma.hb-seniorhigh@hbics.sch.id',NULL,'Jl May. Jend Sutoyo 14',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(91,'bdd1bec2-f594-11ef-896c-0200a013a61c','3172050304900003','Hans Gouw','Jakarta','1990-04-03','FEMALE',NULL,'BUDDHIST','SINGLE','hans.gouw@hbics.sch.id',NULL,'Taman Hidup Baru I /26',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(92,'bdd37bcc-f594-11ef-a831-0200a013a61c','8101144402980001','Febriyanti Menasetiabudi','Ambon','1998-02-04','FEMALE',NULL,'CHRISTIAN','SINGLE','febriyantimenasetiabudi.hb-secondary@hbics.sch.id',NULL,'BTN Waitatiri Blok CI No 12',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(93,'bdd4f52e-f594-11ef-ab18-0200a013a61c','6474036506970002','Roosye Carolina','Bontang','1997-06-25','FEMALE',NULL,'CHRISTIAN','SINGLE','roosyecarolina.hb-primary@hbics.sch.id',NULL,'Jln S Parman No 28 Bontang',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(94,'bdd6633c-f594-11ef-b0ae-0200a013a61c','6471055607910004','Eristiannponglangi','Bittuang','1991-07-16','FEMALE',NULL,'ISLAM','MARRIED','eristiannponglangi.ytcb@hbics.sch.id',NULL,'Jln Wolter Monginsidi No 17',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(95,'bdd7f288-f594-11ef-9b8f-0200a013a61c','6471044512040002','Olivia Deti Duta','Makassar','2004-12-05','FEMALE',NULL,'CHRISTIAN','SINGLE','olivia.ytcb@hbics.sch.id',NULL,'Jln Pemuda Batakan Rt 66',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(96,'bdd9b500-f594-11ef-807b-0200a013a61c','7326144505950003','Tresia Tiku Lele','Baruppu','1995-05-05','FEMALE',NULL,'CHRISTIAN','SINGLE','tere.ytcb@hbics.sch.id',NULL,'Balikpapan Baru blok U2 No 5',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(97,'bddb9320-f594-11ef-9ee5-0200a013a61c','6471024712000004','Vivi Natalia','Balikpapan','2000-12-07','FEMALE',NULL,'CHRISTIAN','SINGLE','vivinatalia.ytcb@hbics.sch.id',NULL,'Jl Adil Makmur No 08',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(98,'bddd4184-f594-11ef-aa59-0200a013a61c','6471046310770009','Mely','Jambi','1977-10-23','FEMALE',NULL,'CHRISTIAN','MARRIED','mely.ytcb@hbics.sch.id',NULL,'Jl. Sungai Ampal No 20, Sumber Rejo Balikpapan',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(99,'bdded864-f594-11ef-93d1-0200a013a61c','6471036505810004','Yenny Elmira Siahaan','Pangkalan Berandan','1981-05-25','FEMALE',NULL,'CHRISTIAN','MARRIED','yeni.ytcb@hbics.sch.id',NULL,'Perumahan Pesona Azarya Blok B71',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(100,'bde09564-f594-11ef-9dee-0200a013a61c','6402131608900003','Alek Sander Agung','Balikpapan','1990-08-16','MALE',NULL,'ISLAM','MARRIED','aleksander.ytcb@hbics.sch.id',NULL,'Jln Batu Ratna Km 11 Perum Atlantic Village',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(101,'bde26a92-f594-11ef-8834-0200a013a61c','6471051108800006','Ariadi','Balikpapan','1980-08-11','MALE',NULL,'ISLAM','MARRIED','ardi.ytcb@hbics.sch.id',NULL,'Jl. Prapatan No 14 Rt 29',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(102,'bde3fe66-f594-11ef-b3ef-0200a013a61c','6471032709820002','Barlevi Sharon','Balikpapan','1982-09-27','FEMALE',NULL,'CHRISTIAN','SINGLE','levi.ytcb@hbics.sch.id',NULL,'Per Villa Kita D-5 KM 8,5',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(103,'bde5b5c6-f594-11ef-a45d-0200a013a61c','3507164512900003','Devi Novita Sari, S.H','Malang','1990-12-05','FEMALE',NULL,'CHRISTIAN','SINGLE','devi.ytcb@hbics.sch.id',NULL,'Bukit Batakan Permai II F5 Blok 8',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(104,'bde79206-f594-11ef-9848-0200a013a61c','6471055909000005','Jessica Prisicilia Sarajar','Balikpapan','2000-09-19','FEMALE',NULL,'CHRISTIAN','SINGLE','jessica.ytcb@hbics.sch.id',NULL,'Jln Jend Sudirman No 52 Rt 25',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(105,'bde956fe-f594-11ef-8e38-0200a013a61c','6471042805740005','Kerestian Naihonam','Wahai','1974-05-28','MALE',NULL,'CHRISTIAN','MARRIED','keristian.ytcb@hbics.sch.id',NULL,'Per Villa Kita D-5 KM 8,5',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(106,'bdeb341a-f594-11ef-9b34-0200a013a61c','6471022204610001','Muchtar RM','Balikpapan','1961-04-22','FEMALE',NULL,'ISLAM','MARRIED','muchtar.ytcb@hbics.sch.id',NULL,'Jln Giri Rejo No 43 Rt 28 Kel Karang Joang',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(107,'bdecfe9e-f594-11ef-a2dd-0200a013a61c','6471040911870004','Nofry G Mangindaan','Rerer','1987-11-09','MALE',NULL,'CHRISTIAN','MARRIED','novry.ytcb@hbics.sch.id',NULL,'Jl Riko RT 18 Baru olo',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(108,'bdee984e-f594-11ef-b92e-0200a013a61c','6474011304870005','Sugeng Suriyadi','Bontang','1987-04-13','MALE',NULL,'ISLAM','WIDOWED','sugeng.ytcb@hbics.sch.id',NULL,'Jln Syarifudin Yoes Rt 41',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(109,'bdf04266-f594-11ef-8a34-0200a013a61c','7304020911630002','Suwigyo','tulung agung','1963-11-09','MALE',NULL,'ISLAM','MARRIED',NULL,NULL,'Jln Indra Kila',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(110,'bdf13306-f594-11ef-b498-0200a013a61c','6471055907020004','Tasya Gloria Wowor','Balikpapan','2002-07-19','FEMALE',NULL,'CHRISTIAN','SINGLE','tasyagloria.ytcb@hbics.sch.id',NULL,'Jl. Bantimurung No 232 Gn. Bahagia',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(111,'bdf2df9e-f594-11ef-b0f9-0200a013a61c','3171044301870002','Agnes Puspa Indah','Jakarta','1987-01-03','FEMALE',NULL,'CHRISTIAN','MARRIED','agnes.indah@hbics.sch.id',NULL,'Jl Komp Balikpapan Permai K1 No 18',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(112,'bdf472aa-f594-11ef-a327-0200a013a61c','6471052409940001','Adytya Lambang Nugraha','Balikpapan','1994-09-24','MALE',NULL,'ISLAM','MARRIED','adytya.ytcb@hbics.sch.id',NULL,'Jln PJHI Perum CGS Blok AB No 37',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(113,'bdf6101a-f594-11ef-99aa-0200a013a61c','3275033007950027','Andre Witarsa','Bekasi','1995-07-30','MALE',NULL,'CHRISTIAN','SINGLE','andre.ytcb@hbics.sch.id',NULL,'Permata Hijau Permai Blok H 3 No 18',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(114,'bdf793fe-f594-11ef-a99e-0200a013a61c','6471045408950001','Ingrit Agustin Wullur','Banjarmasin','1995-08-14','FEMALE',NULL,'CHRISTIAN','SINGLE','ingritaw.ytcb@hbics.sch.id',NULL,'Jln Banjar No 37 Rt 06 Gn Sari',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(115,'bdf92bb0-f594-11ef-a085-0200a013a61c','3603170612040002','Natanael Ferdinand','Tangerang','2004-12-06','MALE',NULL,'CHRISTIAN','SINGLE','natanael.ytcb@hbics.sch.id',NULL,'Jln Mulawarman Gang Telaga Mas',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(116,'bdfae662-f594-11ef-97a9-0200a013a61c','3174105612850008','Widya Disriyati Simatupang','Jakarta','1985-12-16','FEMALE',NULL,'CHRISTIAN','MARRIED','widya.ytcb@hbics.sch.id',NULL,'Perum sepinggan',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(117,'bdfc9f0c-f594-11ef-a59c-0200a013a61c','6471032609020001','Jo Kevin Nathaniel','Balikpapan','2002-09-26','MALE','O','CHRISTIAN','SINGLE',NULL,NULL,'Jl Soekarno Hatta Km 1 No 15',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(118,'bdfdbba8-f594-11ef-9715-0200a013a61c','6472036511880001','Ireyne Nopiana Sinaga','Padang Sidempuan','1988-11-25','FEMALE','B','CHRISTIAN','MARRIED','ireyne.hb-primary@hbics.sch.id',NULL,'Perum Batakan Mas Blok HH No 7',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(119,'bdff8848-f594-11ef-8970-0200a013a61c','3275121209980003','Mario Septianto Nugroho','Jakarta','1998-09-12','MALE','A','CHRISTIAN','SINGLE','marioseptianto.hb-seniorhigh@hbics.sch.id',NULL,'Kampung Sawah Rt 005',NULL,NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(120,'4123dae0-f7bf-11ef-aabd-0200a013a61c','6471026207060002','Lesyel Jovana','Balikpapan','2006-07-22','FEMALE',NULL,'ISLAM','SINGLE','lesyeljovana.edcon@hbics.sch.id','+62 815-4922-7735','Jl. Gunung Empat  RT 46 no 49',NULL,NULL,'2025-03-02 23:37:07','2025-03-02 23:38:25',NULL),(121,'d7e2bc56-fe1a-11ef-84ea-0200a013a61c',NULL,'Raina Erezia Sunaryo','Balikpapan','2020-03-27','FEMALE','A','CHRISTIAN',NULL,'rainaerezia.s.hhk@hbics.sch.id','08115424819','Komp. Mediterania BB, Pos 11 Blok U1 No.36 Balikpapan','17125',NULL,'2025-03-11 01:47:51','2025-03-12 02:32:55',NULL),(125,'e10cc608-fee9-11ef-a43b-0200a013a61c',NULL,'Anak coba','Balikpapan','2025-03-05','FEMALE','A','ISLAM',NULL,NULL,'085753328641','-','-',NULL,'2025-03-12 02:29:52','2025-03-17 01:34:17',NULL),(126,'e10e5da6-fee9-11ef-92c5-0200a013a61c',NULL,'Nathan','Balikpapan','2025-03-05','FEMALE','A','ISLAM',NULL,NULL,NULL,'-','-',NULL,'2025-03-12 02:29:52','2025-03-12 02:29:52',NULL),(129,'4bc7dbdc-0934-11f0-b7cf-0242ac140002',NULL,'RAINA EREZIA SUNARYO','BALIKPAPAN','2020-03-27','FEMALE',NULL,'CHRISTIAN',NULL,NULL,'08115424819','Bb, Kalimantan Timur','76124',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(130,'4bc9f2aa-0934-11f0-b405-0242ac140002',NULL,'ALVARO GEVRIEL PUNU','BALIKPAPAN','2018-09-17','MALE',NULL,'CHRISTIAN',NULL,NULL,'0812545273','Perumahan balikpapan regency, Kec. Balikpapan Selatan, Kota Balikpapan, Kalimantan Timur','76115',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(131,'4bcaa344-0934-11f0-96b8-0242ac140002',NULL,'AZIEL ELISEO','JAKARTA','2019-10-30','MALE',NULL,'CHRISTIAN',NULL,NULL,'08118428208','Perumahan pondok karya agung, Kec. Balikpapan Selatan, Kota Balikpapan, Kalimantan Timur','76115',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(132,'4bcb79b8-0934-11f0-b46f-0242ac140002',NULL,'BRYAN DEARDO PARLINDUNGAN SIMARMATA','BALIKPAPAN','2019-01-06','MALE',NULL,'CHRISTIAN',NULL,NULL,'081348299333','Perum batu ampar lestari, Kec. Balikpapan Utara, Kota Balikpapan, Kalimantan Timur','76136',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(133,'4bcc35ce-0934-11f0-8bf9-0242ac140002',NULL,'CHRISTIAN EDGAR GARCIA TANDERYUS','BALIKPAPAN','2018-11-01','MALE',NULL,'CHRISTIAN',NULL,NULL,'08115425177','Jl. taman gardenia blok t1 no.07, Kec. Balikpapan Utara, Kota Balikpapan, Kalimantan Timur','76125',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(134,'4bcce104-0934-11f0-b43a-0242ac140002',NULL,'ELENA LEIVA ZHANG','SAMARINDA','2019-01-18','FEMALE',NULL,'BUDDHIST',NULL,NULL,'081347725555','Perum pelangi grand residence blok d/32, Kec. Balikpapan Selatan, Kota Balikpapan, Kalimantan Timur','76115',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(135,'4bcd8c1c-0934-11f0-ba0e-0242ac140002',NULL,'GERALD ANDERSON CHUNG','BALIKPAPAN','2019-02-01','MALE',NULL,'CHRISTIAN',NULL,NULL,'085754789023','Perum bdi blok h.57, Kec. Balikpapan Selatan, Kota Balikpapan, Kalimantan Timur','76115',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(136,'4bce5ba6-0934-11f0-b046-0242ac140002',NULL,'JASMINE SHAMIRA BOMBANG','BALIKPAPAN','2018-12-30','FEMALE',NULL,'CHRISTIAN',NULL,NULL,'081219443310','Perum pelangi metro residence blok i no.15, Kec. Balikpapan Utara, Kota Balikpapan, Kalimantan Timur','76125',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(137,'4bcf354e-0934-11f0-82c9-0242ac140002',NULL,'KEN ALEXANDER','BALIKPAPAN','2018-10-05','MALE',NULL,'BUDDHIST',NULL,NULL,'082156661984','Jl. soekarno hatta km 10 rt 09, Kec. Balikpapan Utara, Kota Balikpapan, Kalimantan Timur','76125',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(138,'4bd03eda-0934-11f0-808c-0242ac140002',NULL,'KENRIC ZIONATHAN SOMALINGGI','BALIKPAPAN','2018-12-08','MALE',NULL,'CHRISTIAN',NULL,NULL,'08122183340','Balikpapan regency cluster castarica, Kec. Balikpapan Utara, Kota Balikpapan, Kalimantan Timur','76128',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(139,'4bd0fc9e-0934-11f0-8c76-0242ac140002',NULL,'LARASATI ADONAI WIBOWO','BALIKPAPAN','2018-10-10','FEMALE',NULL,'CHRISTIAN',NULL,NULL,'082251608899','Pesona pelangi residence blok i no.6, Kec. Balikpapan Utara, Kota Balikpapan, Kalimantan Timur','76125',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(140,'4bd1c872-0934-11f0-a117-0242ac140002',NULL,'MARIA PATRISHIELA AGNI PUTRI','BALIKPAPAN','2018-11-06','FEMALE',NULL,'CATHOLIC',NULL,NULL,'08113430450','Daun village b-12 gunung bahagia, Kec. Balikpapan Selatan, Kota Balikpapan, Kalimantan Timur','76115',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(141,'4bd293e2-0934-11f0-a773-0242ac140002',NULL,'MARIA ZIVANNA ROSE CHRISTANTO','BALIKPAPAN','2018-11-19','FEMALE',NULL,'CATHOLIC',NULL,NULL,'082150224040','Perumahan pesona azarya blok a no. 39, Kec. Balikpapan Tengah, Kota Balikpapan, Kalimantan Timur','76122',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(142,'4bd35b06-0934-11f0-917c-0242ac140002',NULL,'PRINCESS ELORA ROULI HUTABARAT','BALIKPAPAN','2019-06-24','FEMALE',NULL,'CHRISTIAN',NULL,NULL,'085298695500','Perum taman sari wika kh 8 no. 12.a, Kec. Balikpapan Utara, Kota Balikpapan, Kalimantan Timur','76128',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(143,'4bd43ada-0934-11f0-92af-0242ac140002',NULL,'SHILOH GAVRIEL IMMANUEL PURBA','BALIKPAPAN','2019-02-12','MALE',NULL,'CHRISTIAN',NULL,NULL,'08115444947','Apartemen pertamina unit 2609 kelurahan baru ilir, Kec. Balikpapan Kota, Kota Balikpapan, Kalimantan Timur','76111',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(144,'4bd6cfd4-0934-11f0-a271-0242ac140002',NULL,'Jason Setiawan','Samarinda','2009-01-12','MALE','A','CHRISTIAN',NULL,NULL,'99188288','Indrakila no.99g, Kec. Balikpapan Barat, Kota Balikpapan, Kalimantan Timur','782881',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(145,'4bd7adaa-0934-11f0-a362-0242ac140002',NULL,'Brielle Zephani Salim','Balikpapan','2021-11-11','FEMALE','A','CHRISTIAN',NULL,NULL,NULL,'Kyoto bc no.3, Kel. Klandasan Ulu, Kec. Balikpapan Kota, Kota Balikpapan, Kalimantan Timur','555555',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(146,'4bd873ca-0934-11f0-b06d-0242ac140002',NULL,'Elaine Claretta Chandra','Balikpapan','2022-05-15','FEMALE',NULL,'BUDDHIST',NULL,NULL,NULL,'Perumahan balikpapan baru cluster kyoto bc 02, Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(147,'4bd93102-0934-11f0-b8bf-0242ac140002',NULL,'Eulogius Gavin Arga','Kendari','2022-02-20','MALE',NULL,'CATHOLIC',NULL,NULL,NULL,'Perumahan pelangi pesona residence blok 6 no. 5, Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(148,'4bd9e660-0934-11f0-8316-0242ac140002',NULL,'Gwen Carlissa Lauw','Balikpapan','2021-12-17','FEMALE',NULL,'CHRISTIAN',NULL,NULL,NULL,'Bdi blok l no. 2, Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(149,'4bda8ca0-0934-11f0-bdb7-0242ac140002',NULL,'Madeleine Patricia Halim','Balikpapan','2021-12-23','FEMALE',NULL,'BUDDHIST',NULL,NULL,NULL,'Jl. mayor pol zainalarifin no. 36 rt.38, Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(150,'4bdb5838-0934-11f0-9a3c-0242ac140002',NULL,'Zahira Audrey Sirait','Balikpapan','2021-09-27','FEMALE',NULL,'CHRISTIAN',NULL,NULL,NULL,'Jl. mt haryono perumahanalzer residence (gang pln) blok g no. 9, Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(151,'4bdc5ada-0934-11f0-929e-0242ac140002',NULL,'Jericho Ezequiel Gama','Balikpapan','2021-10-16','MALE',NULL,'CHRISTIAN',NULL,NULL,NULL,'Caladium residence 2 blok dii rt. 27, Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(152,'4bddb97a-0934-11f0-b5ec-0242ac140002',NULL,'Alxio Pratama Titu','Balikpapan','2021-11-22','MALE',NULL,'CHRISTIAN',NULL,NULL,NULL,'Jl. d i panjaitan, gg binaraga no. 20 rt. 47, Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(153,'4bde9638-0934-11f0-bbe7-0242ac140002',NULL,'Diajeng Narasyah Putri Adi','Balikpapan','2022-05-05','FEMALE',NULL,'ISLAM',NULL,NULL,NULL,'Grand city cluster forestville blok k17 no. 5 balikpapan, Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(154,'4bdf7d0a-0934-11f0-be69-0242ac140002',NULL,'Zoe Hagia Suwasa','Balikpapan','2021-09-01','FEMALE',NULL,'CHRISTIAN',NULL,NULL,NULL,'Balikpapan baru t2 no.11, Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(155,'4be0582e-0934-11f0-babe-0242ac140002',NULL,'Dareen Oliver Jap','Balikpapan','2021-10-05','MALE',NULL,'BUDDHIST',NULL,NULL,NULL,'Pesona alam residence blok a-5 rt 41 sungai nangka, balikpapan  selatan, Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(156,'4be108d2-0934-11f0-a275-0242ac140002',NULL,'Gracelyn Felisa Klesia','Balikpapan','2022-01-25','FEMALE',NULL,'CATHOLIC',NULL,NULL,NULL,'Wika, kutai hill kh 15/9, Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(157,'4be1dc30-0934-11f0-99ad-0242ac140002',NULL,'James Christopher Hartady','Balikpapan','2022-02-12','MALE',NULL,'CHRISTIAN',NULL,NULL,NULL,'Beverly hills ca8, balikpapan baru, Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(158,'4be2a1ce-0934-11f0-9c6b-0242ac140002',NULL,'Samuel Yosafat Wijaya','Balikpapan','2021-12-10','MALE',NULL,'CHRISTIAN',NULL,NULL,NULL,'Perum batu ampar lestari tahap iv blok c 1-2 , Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(159,'4be35704-0934-11f0-82b2-0242ac140002',NULL,'Sharren Sondang Ruth Angelica Panjaitan','Balikpapan','2022-07-15','FEMALE',NULL,'CATHOLIC',NULL,NULL,NULL,'Jl. sumber rejo 3 no. 107, Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(160,'4be42b20-0934-11f0-8a91-0242ac140002',NULL,'Quinna Velove Dean Pardede','Balikpapan','2022-04-15','FEMALE',NULL,'CHRISTIAN',NULL,NULL,NULL,'Pelangi metro residence blok c no. 7, Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(161,'4be4d4f8-0934-11f0-89e9-0242ac140002',NULL,'Jessen Kai Nolan Raja Gukguk','Balikpapan','2022-04-06','MALE',NULL,'CHRISTIAN',NULL,NULL,NULL,'Perum sepinggan pratama cluster royal garden blok e2 no. 10, Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(162,'4be59a32-0934-11f0-bdd9-0242ac140002',NULL,'Bintang Dion Eka Wijaya','Balikpapan','2021-08-17','MALE',NULL,'CHRISTIAN',NULL,NULL,NULL,'Perum sepinggan pratama cluster royal garden blok e2 no. 10, Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(163,'4be650b2-0934-11f0-bd56-0242ac140002',NULL,'Bentley Morris Wibiesono','Balikpapan','2021-12-15','MALE',NULL,'CHRISTIAN',NULL,NULL,NULL,'Jl. soekarno hatta no. 15, Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(164,'4be6fad0-0934-11f0-bba3-0242ac140002',NULL,'Michelle Michaiah Sengkey','Manado','2021-11-26','FEMALE',NULL,'CHRISTIAN',NULL,NULL,NULL,'Balikpapan baru cluster vancouver blok hj no. 19, Kalimantan Timur',NULL,NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(165,'4bec77d0-0934-11f0-9012-0242ac140002',NULL,'Adriell Fidelis Gracio Keni','Balikpapan','2018-06-03','MALE',NULL,'CHRISTIAN',NULL,NULL,'000','Jl. klamono no. 768 rt. 58, Kel. Margo Mulyo, Kec. Balikpapan Barat, Kota Balikpapan, Kalimantan Timur','76131',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(166,'4bed4930-0934-11f0-9cae-0242ac140002',NULL,'Claudia Beverly Wijaya','Jakartta','2018-05-04','MALE',NULL,'CHRISTIAN',NULL,NULL,'000','Balikpapan baru cluster kyoto bc-5, Kel. Gunung Bahagia, Kec. Balikpapan Selatan, Kota Balikpapan, Kalimantan Timur','76115',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(167,'4bee32fa-0934-11f0-a3e9-0242ac140002',NULL,'Wilson Chandra Tjan','Balikpapan','2017-09-27','MALE',NULL,'BUDDHIST',NULL,NULL,'000','Balikpapan baru blok f4/4, Kel. Sepinggan Baru, Kec. Balikpapan Selatan, Kota Balikpapan, Kalimantan Timur','76115',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(168,'4bef1850-0934-11f0-b040-0242ac140002',NULL,'Ruth Marisca Haulian Sinurat','Balikpapan','2017-12-23','FEMALE',NULL,'CHRISTIAN',NULL,NULL,'000','Jl. jend. sudirman no.39, Kel. Sepinggan, Kec. Balikpapan Selatan, Kota Balikpapan, Kalimantan Timur','76112',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(169,'4bf0067a-0934-11f0-ba40-0242ac140002',NULL,'Ahmad Daffa Alfarizi','Balikpapan','2018-03-07','MALE',NULL,'ISLAM',NULL,NULL,'08115353053','Jl. karang jati dalam rt.22 no.61, Kel. Mekar Sari, Kec. Balikpapan Tengah, Kota Balikpapan, Kalimantan Timur','76123',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(170,'4bf0cf60-0934-11f0-b4a5-0242ac140002',NULL,'Cinta Aura Adia Nova','Balikpapan','2018-04-13','FEMALE',NULL,'ISLAM',NULL,NULL,'000','Balikpapan baru vancoucer hs 12, Kel. Damai Baru, Kec. Balikpapan Selatan, Kota Balikpapan, Kalimantan Timur','76114',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(171,'4bf18612-0934-11f0-9348-0242ac140002',NULL,'Danilo Nathaniel Pakpahan','Balikpapan','2018-05-09','MALE',NULL,'CATHOLIC',NULL,NULL,'000','Perum mawija b4/4 sumber rejo, Kel. Sumber Rejo, Kec. Balikpapan Tengah, Kota Balikpapan, Kalimantan Timur','76124',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(172,'4bf26960-0934-11f0-b221-0242ac140002',NULL,'Daphne Chiara Gwen Lawansuka','Balikpapan','2018-02-19','FEMALE',NULL,'CHRISTIAN',NULL,NULL,'000','Balikpapan regency cluster castarica, blok jb5 no.60g, Kel. Damai Baru, Kec. Balikpapan Selatan, Kota Balikpapan, Kalimantan Timur','76115',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(173,'4bf33016-0934-11f0-90cf-0242ac140002',NULL,'Enders Yonatan','Surabaya','2018-01-20','MALE',NULL,'CHRISTIAN',NULL,NULL,'0000','Jl. r.e. martadinata rt. 25 no.7, Kel. Gunung Sari Ulu, Kec. Balikpapan Tengah, Kota Balikpapan, Kalimantan Timur','76122',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(174,'4bf3f104-0934-11f0-a2e3-0242ac140002',NULL,'Gevariel Hasiholan Sinaga','Balikpapan','2017-09-04','MALE',NULL,'CHRISTIAN',NULL,NULL,'000','Telindung baru 1 rt. 29 no. 4, Kel. Muara Rapak, Kec. Balikpapan Utara, Kota Balikpapan, Kalimantan Timur','76113',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(175,'4bf4eb90-0934-11f0-97ac-0242ac140002',NULL,'Alyssia Renata Kanaeila Susanto','Samarinda','2009-03-25','FEMALE',NULL,'CHRISTIAN',NULL,NULL,'00000','Balikpapan baru cluster den haag v2/23, Kec. Balikpapan Selatan, Kota Balikpapan, Kalimantan Timur','76115',NULL,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `public_feedbacks`
--

DROP TABLE IF EXISTS `public_feedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `public_feedbacks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `readed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `public_feedbacks_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `public_feedbacks`
--

LOCK TABLES `public_feedbacks` WRITE;
/*!40000 ALTER TABLE `public_feedbacks` DISABLE KEYS */;
/*!40000 ALTER TABLE `public_feedbacks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'System Admin','web','2025-02-28 05:27:44','2025-02-28 05:27:44'),(2,'Site Admin','web','2025-02-28 05:27:44','2025-02-28 05:27:44'),(3,'Employee','web','2025-02-28 05:27:44','2025-02-28 05:27:44'),(4,'Student','web','2025-02-28 05:27:44','2025-02-28 05:27:44'),(5,'Guardian','web','2025-02-28 05:27:44','2025-02-28 05:27:44'),(6,'Member','web','2025-02-28 05:27:44','2025-02-28 05:27:44');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_academic_programs`
--

DROP TABLE IF EXISTS `school_academic_programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_academic_programs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` bigint(20) unsigned NOT NULL,
  `school_year_id` bigint(20) unsigned NOT NULL,
  `school_curriculum_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_academic_programs_uuid_unique` (`uuid`),
  KEY `school_academic_programs_school_id_foreign` (`school_id`),
  KEY `school_academic_programs_school_year_id_foreign` (`school_year_id`),
  KEY `school_academic_programs_school_curriculum_id_foreign` (`school_curriculum_id`),
  CONSTRAINT `school_academic_programs_school_curriculum_id_foreign` FOREIGN KEY (`school_curriculum_id`) REFERENCES `school_curriculums` (`id`),
  CONSTRAINT `school_academic_programs_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`),
  CONSTRAINT `school_academic_programs_school_year_id_foreign` FOREIGN KEY (`school_year_id`) REFERENCES `school_years` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_academic_programs`
--

LOCK TABLES `school_academic_programs` WRITE;
/*!40000 ALTER TABLE `school_academic_programs` DISABLE KEYS */;
INSERT INTO `school_academic_programs` VALUES (1,'4d51d6b0-0934-11f0-9706-0242ac140002',1,1,2,'Program Ajaran 2024 / 2025',1,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(2,'4d68c65e-0934-11f0-abe1-0242ac140002',2,1,3,'Program Ajaran 2024 / 2025',1,'2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(3,'4d8d8818-0934-11f0-a0bc-0242ac140002',3,1,5,'Program Ajaran 2024 / 2025',1,'2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(4,'4e72acea-0934-11f0-99b4-0242ac140002',4,5,7,'Program Ajaran 2023 - 2024',1,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL);
/*!40000 ALTER TABLE `school_academic_programs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_classroom_members`
--

DROP TABLE IF EXISTS `school_classroom_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_classroom_members` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_classroom_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_classroom_members_uuid_unique` (`uuid`),
  KEY `school_classroom_members_school_classroom_id_foreign` (`school_classroom_id`),
  KEY `school_classroom_members_student_id_foreign` (`student_id`),
  CONSTRAINT `school_classroom_members_school_classroom_id_foreign` FOREIGN KEY (`school_classroom_id`) REFERENCES `school_classrooms` (`id`),
  CONSTRAINT `school_classroom_members_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_classroom_members`
--

LOCK TABLES `school_classroom_members` WRITE;
/*!40000 ALTER TABLE `school_classroom_members` DISABLE KEYS */;
INSERT INTO `school_classroom_members` VALUES (1,'4be8167c-0934-11f0-b65a-0242ac140002',12,7,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(2,'4be85fc4-0934-11f0-b052-0242ac140002',12,12,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(3,'4be8c702-0934-11f0-a10b-0242ac140002',12,14,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(4,'4be933ae-0934-11f0-9064-0242ac140002',12,8,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(5,'4be98476-0934-11f0-92db-0242ac140002',12,9,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(6,'4be9cbde-0934-11f0-a274-0242ac140002',12,16,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(7,'4bea1120-0934-11f0-bf5f-0242ac140002',12,18,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL);
/*!40000 ALTER TABLE `school_classroom_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_classrooms`
--

DROP TABLE IF EXISTS `school_classrooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_classrooms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` bigint(20) unsigned NOT NULL,
  `school_grade_id` bigint(20) unsigned NOT NULL,
  `school_major_id` bigint(20) unsigned DEFAULT NULL,
  `homeroom_teacher_id` bigint(20) unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacity` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_classrooms_uuid_unique` (`uuid`),
  KEY `school_classrooms_school_id_foreign` (`school_id`),
  KEY `school_classrooms_school_grade_id_foreign` (`school_grade_id`),
  KEY `school_classrooms_school_major_id_foreign` (`school_major_id`),
  KEY `school_classrooms_homeroom_teacher_id_foreign` (`homeroom_teacher_id`),
  CONSTRAINT `school_classrooms_homeroom_teacher_id_foreign` FOREIGN KEY (`homeroom_teacher_id`) REFERENCES `employees` (`id`),
  CONSTRAINT `school_classrooms_school_grade_id_foreign` FOREIGN KEY (`school_grade_id`) REFERENCES `school_grades` (`id`),
  CONSTRAINT `school_classrooms_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`),
  CONSTRAINT `school_classrooms_school_major_id_foreign` FOREIGN KEY (`school_major_id`) REFERENCES `school_majors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_classrooms`
--

LOCK TABLES `school_classrooms` WRITE;
/*!40000 ALTER TABLE `school_classrooms` DISABLE KEYS */;
INSERT INTO `school_classrooms` VALUES (1,'4ba5a738-0934-11f0-8ddc-0242ac140002',1,3,NULL,23,'Ezrah 2 - TK A',15,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(2,'4ba609e4-0934-11f0-ac30-0242ac140002',1,3,NULL,7,'Ezrah 3 - TK A',15,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(3,'4ba67956-0934-11f0-be6f-0242ac140002',1,3,NULL,13,'Ezrah 4 - TK A',15,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(4,'4ba6d946-0934-11f0-81dd-0242ac140002',1,3,NULL,16,'Ezrah 5 - TK A',15,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(5,'4ba72d06-0934-11f0-96d6-0242ac140002',1,2,NULL,17,'Tirza 1 - PG B',13,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(6,'4ba7964c-0934-11f0-afa7-0242ac140002',1,2,NULL,17,'Tirza 2 - PG B',13,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(7,'4ba7f344-0934-11f0-8df7-0242ac140002',1,2,NULL,12,'Tirza 3 - PG B',13,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(8,'4ba84a2e-0934-11f0-ac81-0242ac140002',1,2,NULL,12,'Tirza 4 - PG B',13,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(9,'4ba89d76-0934-11f0-984a-0242ac140002',1,1,NULL,20,'Erez 1 - PG A',10,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(10,'4ba8f3d4-0934-11f0-8e8f-0242ac140002',1,1,NULL,19,'Erez 2 - PG A',10,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(11,'4ba95824-0934-11f0-bda5-0242ac140002',1,3,NULL,8,'Ezrah 1 - TK A',13,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(12,'4ba9ace8-0934-11f0-bebc-0242ac140002',1,4,NULL,10,'Teenah 1 - TK B',15,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(13,'4baa1606-0934-11f0-ae0b-0242ac140002',1,4,NULL,9,'Teenah 2 - TK B',15,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(14,'4baa71e6-0934-11f0-b6a1-0242ac140002',1,4,NULL,21,'Teenah 3 - TK B',15,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(15,'4baac682-0934-11f0-8543-0242ac140002',1,4,NULL,NULL,'Teenah 4 - TK B',15,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(16,'4bb34d70-0934-11f0-bd33-0242ac140002',2,5,NULL,25,'KELAS 1A',27,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(17,'4bb3b148-0934-11f0-b26e-0242ac140002',2,5,NULL,NULL,'KELAS 1B',27,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(18,'4bb40120-0934-11f0-8692-0242ac140002',2,5,NULL,NULL,'KELAS 1C',27,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(19,'4bb4626e-0934-11f0-9453-0242ac140002',2,6,NULL,NULL,'KELAS 2A',27,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(20,'4bb4b08e-0934-11f0-b7ed-0242ac140002',2,6,NULL,NULL,'KELAS 2B',27,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(21,'4bb99b76-0934-11f0-8a6e-0242ac140002',3,11,NULL,NULL,'7A',25,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(22,'4bba1056-0934-11f0-82e3-0242ac140002',3,11,NULL,NULL,'7B',25,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(23,'4bc43a54-0934-11f0-a6f7-0242ac140002',4,14,1,NULL,'10.1',25,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL);
/*!40000 ALTER TABLE `school_classrooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_club_members`
--

DROP TABLE IF EXISTS `school_club_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_club_members` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_club_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `school_classroom_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_club_members_uuid_unique` (`uuid`),
  KEY `school_club_members_school_club_id_foreign` (`school_club_id`),
  KEY `school_club_members_student_id_foreign` (`student_id`),
  KEY `school_club_members_school_classroom_id_foreign` (`school_classroom_id`),
  CONSTRAINT `school_club_members_school_classroom_id_foreign` FOREIGN KEY (`school_classroom_id`) REFERENCES `school_classrooms` (`id`),
  CONSTRAINT `school_club_members_school_club_id_foreign` FOREIGN KEY (`school_club_id`) REFERENCES `school_clubs` (`id`),
  CONSTRAINT `school_club_members_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_club_members`
--

LOCK TABLES `school_club_members` WRITE;
/*!40000 ALTER TABLE `school_club_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `school_club_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_clubs`
--

DROP TABLE IF EXISTS `school_clubs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_clubs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` bigint(20) unsigned NOT NULL,
  `mentor_id` bigint(20) unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_clubs_uuid_unique` (`uuid`),
  KEY `school_clubs_school_id_foreign` (`school_id`),
  KEY `school_clubs_mentor_id_foreign` (`mentor_id`),
  CONSTRAINT `school_clubs_mentor_id_foreign` FOREIGN KEY (`mentor_id`) REFERENCES `employees` (`id`),
  CONSTRAINT `school_clubs_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_clubs`
--

LOCK TABLES `school_clubs` WRITE;
/*!40000 ALTER TABLE `school_clubs` DISABLE KEYS */;
INSERT INTO `school_clubs` VALUES (1,'4bbb64e2-0934-11f0-b182-0242ac140002',3,NULL,'Matematika (7,8)','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(2,'4bbb9f66-0934-11f0-9a58-0242ac140002',3,NULL,'Science (7,8)','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(3,'4bbbed4a-0934-11f0-b3f4-0242ac140002',3,NULL,'Matematika (9)','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(4,'4bc61356-0934-11f0-902c-0242ac140002',4,NULL,'Matematika','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(5,'4bc64682-0934-11f0-ac39-0242ac140002',4,NULL,'Fisika','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(6,'4bc67508-0934-11f0-ab19-0242ac140002',4,NULL,'Biologi','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(7,'4bc6b0d6-0934-11f0-a40b-0242ac140002',4,NULL,'Astronomi','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL);
/*!40000 ALTER TABLE `school_clubs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_curriculums`
--

DROP TABLE IF EXISTS `school_curriculums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_curriculums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_curriculums_uuid_unique` (`uuid`),
  KEY `school_curriculums_school_id_foreign` (`school_id`),
  CONSTRAINT `school_curriculums_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_curriculums`
--

LOCK TABLES `school_curriculums` WRITE;
/*!40000 ALTER TABLE `school_curriculums` DISABLE KEYS */;
INSERT INTO `school_curriculums` VALUES (1,'4bf6aa20-0934-11f0-ba9e-0242ac140002',1,'Kurikulum Merdeka','KM','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(2,'4bfbf368-0934-11f0-a378-0242ac140002',1,'Kurikulum K.A.R.Y.A Merdeka HHK','KM-HHK','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(3,'4d5225de-0934-11f0-8b66-0242ac140002',2,'KURIKULUM SDK HARAPAN BANGSA','K-SDK-HB','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(4,'4d69996c-0934-11f0-a303-0242ac140002',3,'Kurikulum Merdeka','KM','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(5,'4d79f636-0934-11f0-8a36-0242ac140002',3,'Kurikulum Karya','Karya.01','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(6,'4d8e1b3e-0934-11f0-b099-0242ac140002',4,'Kurikulum Merdeka','KM','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(7,'4d94deec-0934-11f0-b3ac-0242ac140002',4,'Kurikulum KARYA','KARYA-01','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL);
/*!40000 ALTER TABLE `school_curriculums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_extracurricular_members`
--

DROP TABLE IF EXISTS `school_extracurricular_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_extracurricular_members` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_extracurricular_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `school_classroom_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_extracurricular_members_uuid_unique` (`uuid`),
  KEY `school_extracurricular_members_school_extracurricular_id_foreign` (`school_extracurricular_id`),
  KEY `school_extracurricular_members_student_id_foreign` (`student_id`),
  KEY `school_extracurricular_members_school_classroom_id_foreign` (`school_classroom_id`),
  CONSTRAINT `school_extracurricular_members_school_classroom_id_foreign` FOREIGN KEY (`school_classroom_id`) REFERENCES `school_classrooms` (`id`),
  CONSTRAINT `school_extracurricular_members_school_extracurricular_id_foreign` FOREIGN KEY (`school_extracurricular_id`) REFERENCES `school_extracurriculars` (`id`),
  CONSTRAINT `school_extracurricular_members_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_extracurricular_members`
--

LOCK TABLES `school_extracurricular_members` WRITE;
/*!40000 ALTER TABLE `school_extracurricular_members` DISABLE KEYS */;
INSERT INTO `school_extracurricular_members` VALUES (1,'4beb2d26-0934-11f0-8c04-0242ac140002',11,8,12,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(2,'4beba0f8-0934-11f0-a0a0-0242ac140002',9,14,12,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(3,'4bec080e-0934-11f0-81ff-0242ac140002',7,9,12,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL);
/*!40000 ALTER TABLE `school_extracurricular_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_extracurriculars`
--

DROP TABLE IF EXISTS `school_extracurriculars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_extracurriculars` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` bigint(20) unsigned NOT NULL,
  `mentor_id` bigint(20) unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_extracurriculars_uuid_unique` (`uuid`),
  KEY `school_extracurriculars_school_id_foreign` (`school_id`),
  KEY `school_extracurriculars_mentor_id_foreign` (`mentor_id`),
  CONSTRAINT `school_extracurriculars_mentor_id_foreign` FOREIGN KEY (`mentor_id`) REFERENCES `employees` (`id`),
  CONSTRAINT `school_extracurriculars_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_extracurriculars`
--

LOCK TABLES `school_extracurriculars` WRITE;
/*!40000 ALTER TABLE `school_extracurriculars` DISABLE KEYS */;
INSERT INTO `school_extracurriculars` VALUES (1,'4bab280c-0934-11f0-836f-0242ac140002',1,12,'Art and Craft','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(2,'4bab78ca-0934-11f0-9ea1-0242ac140002',1,NULL,'Drawing and Coloring','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(3,'4babcc80-0934-11f0-b727-0242ac140002',1,9,'Obatacles 1','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(4,'4bac6294-0934-11f0-b45f-0242ac140002',1,16,'English','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(5,'4baca114-0934-11f0-8c2a-0242ac140002',1,NULL,'Dance','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(6,'4bad0758-0934-11f0-ade0-0242ac140002',1,74,'Vocal','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(7,'4bad4eb6-0934-11f0-9500-0242ac140002',1,11,'English 2','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(8,'4bad95ec-0934-11f0-8a74-0242ac140002',1,NULL,'Basket','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(9,'4badd6ce-0934-11f0-9294-0242ac140002',1,NULL,'Robotic','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(10,'4bae1260-0934-11f0-844c-0242ac140002',1,9,'Obstacles 2','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(11,'4bae5752-0934-11f0-b031-0242ac140002',1,13,'Obstacles 3','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(12,'4bb50110-0934-11f0-a892-0242ac140002',2,NULL,'English kelas 1-3','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(13,'4bb55890-0934-11f0-9a38-0242ac140002',2,NULL,'English kelas 2-3','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(14,'4bb59dc8-0934-11f0-98be-0242ac140002',2,NULL,'Dance','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(15,'4bb5cf50-0934-11f0-a464-0242ac140002',2,NULL,'English kelas 4-6','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(16,'4bba552a-0934-11f0-a268-0242ac140002',3,NULL,'Basket','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(17,'4bba8d06-0934-11f0-92fd-0242ac140002',3,NULL,'Band','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(18,'4bbabf6a-0934-11f0-9920-0242ac140002',3,NULL,'Badminton','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(19,'4bbaee5e-0934-11f0-afbc-0242ac140002',3,NULL,'Archery','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(20,'4bc4a6e2-0934-11f0-b7be-0242ac140002',4,NULL,'Futsal','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(21,'4bc4df04-0934-11f0-bc46-0242ac140002',4,NULL,'Basket','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(22,'4bc5126c-0934-11f0-bd96-0242ac140002',4,NULL,'Cooking','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(23,'4bc54606-0934-11f0-a3ee-0242ac140002',4,NULL,'Band','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(24,'4bc58f4e-0934-11f0-a49c-0242ac140002',4,NULL,'Archery','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(25,'4bc5da4e-0934-11f0-9e37-0242ac140002',4,NULL,'Golf','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL);
/*!40000 ALTER TABLE `school_extracurriculars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_grades`
--

DROP TABLE IF EXISTS `school_grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_grades` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_level_id` bigint(20) unsigned NOT NULL,
  `school_phase_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_number` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_grades_uuid_unique` (`uuid`),
  KEY `school_grades_school_level_id_foreign` (`school_level_id`),
  KEY `school_grades_school_phase_id_foreign` (`school_phase_id`),
  CONSTRAINT `school_grades_school_level_id_foreign` FOREIGN KEY (`school_level_id`) REFERENCES `school_levels` (`id`),
  CONSTRAINT `school_grades_school_phase_id_foreign` FOREIGN KEY (`school_phase_id`) REFERENCES `school_phases` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_grades`
--

LOCK TABLES `school_grades` WRITE;
/*!40000 ALTER TABLE `school_grades` DISABLE KEYS */;
INSERT INTO `school_grades` VALUES (1,'bcbf225e-f594-11ef-88ce-0200a013a61c',1,1,'1',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(2,'bcbf59b8-f594-11ef-ab89-0200a013a61c',1,1,'2',2,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(3,'bcbf8e10-f594-11ef-9f3f-0200a013a61c',1,1,'3',3,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(4,'bcbfc2fe-f594-11ef-8d72-0200a013a61c',1,1,'4',4,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(5,'bcc0d946-f594-11ef-937d-0200a013a61c',2,2,'1',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(6,'bcc10e20-f594-11ef-b398-0200a013a61c',2,2,'2',2,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(7,'bcc17d9c-f594-11ef-a7b9-0200a013a61c',2,3,'3',3,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(8,'bcc1b05a-f594-11ef-97fb-0200a013a61c',2,3,'4',4,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(9,'bcc219dc-f594-11ef-9529-0200a013a61c',2,4,'5',5,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(10,'bcc249b6-f594-11ef-9b48-0200a013a61c',2,4,'6',6,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(11,'bcc31b8e-f594-11ef-875a-0200a013a61c',3,5,'7',7,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(12,'bcc3536a-f594-11ef-b56c-0200a013a61c',3,5,'8',8,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(13,'bcc38786-f594-11ef-8039-0200a013a61c',3,5,'9',9,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(14,'bcc46bba-f594-11ef-ae89-0200a013a61c',4,6,'10',10,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(15,'bcc4d4ba-f594-11ef-bf3a-0200a013a61c',4,7,'11',11,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(16,'bcc50976-f594-11ef-ae64-0200a013a61c',4,7,'12',12,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL);
/*!40000 ALTER TABLE `school_grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_levels`
--

DROP TABLE IF EXISTS `school_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_levels` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_number` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_levels_uuid_unique` (`uuid`),
  UNIQUE KEY `school_levels_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_levels`
--

LOCK TABLES `school_levels` WRITE;
/*!40000 ALTER TABLE `school_levels` DISABLE KEYS */;
INSERT INTO `school_levels` VALUES (1,'bcbe28d6-f594-11ef-9a54-0200a013a61c','Kindergarten','KINDERGARTEN',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(2,'bcc05b10-f594-11ef-bd65-0200a013a61c','Elementary','ELEMENTARY',2,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(3,'bcc2b5c2-f594-11ef-b6d3-0200a013a61c','Middle','MIDDLE',3,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(4,'bcc40080-f594-11ef-bad8-0200a013a61c','High','HIGH',4,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL);
/*!40000 ALTER TABLE `school_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_majors`
--

DROP TABLE IF EXISTS `school_majors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_majors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_majors_uuid_unique` (`uuid`),
  KEY `school_majors_school_id_foreign` (`school_id`),
  CONSTRAINT `school_majors_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_majors`
--

LOCK TABLES `school_majors` WRITE;
/*!40000 ALTER TABLE `school_majors` DISABLE KEYS */;
INSERT INTO `school_majors` VALUES (1,'4bbcdbe2-0934-11f0-a821-0242ac140002',4,'IPA','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(2,'4bbd0c7a-0934-11f0-8a45-0242ac140002',4,'IPS','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(3,'4bbd3fe2-0934-11f0-8193-0242ac140002',4,'NON JURUSAN','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL);
/*!40000 ALTER TABLE `school_majors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_phases`
--

DROP TABLE IF EXISTS `school_phases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_phases` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_level_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_number` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_phases_uuid_unique` (`uuid`),
  KEY `school_phases_school_level_id_foreign` (`school_level_id`),
  CONSTRAINT `school_phases_school_level_id_foreign` FOREIGN KEY (`school_level_id`) REFERENCES `school_levels` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_phases`
--

LOCK TABLES `school_phases` WRITE;
/*!40000 ALTER TABLE `school_phases` DISABLE KEYS */;
INSERT INTO `school_phases` VALUES (1,'bcbecf2a-f594-11ef-b9cf-0200a013a61c',1,'Foundation Phase',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(2,'bcc09d82-f594-11ef-be0d-0200a013a61c',2,'Phase A',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(3,'bcc147b4-f594-11ef-8985-0200a013a61c',2,'Phase B',2,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(4,'bcc1e336-f594-11ef-9b6c-0200a013a61c',2,'Phase C',3,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(5,'bcc2e934-f594-11ef-b506-0200a013a61c',3,'Phase D',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(6,'bcc4347e-f594-11ef-8c2a-0200a013a61c',4,'Phase E',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(7,'bcc49d9c-f594-11ef-a599-0200a013a61c',4,'Phase F',2,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL);
/*!40000 ALTER TABLE `school_phases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_subject_groups`
--

DROP TABLE IF EXISTS `school_subject_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_subject_groups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_subject_groups_uuid_unique` (`uuid`),
  KEY `school_subject_groups_school_id_foreign` (`school_id`),
  CONSTRAINT `school_subject_groups_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_subject_groups`
--

LOCK TABLES `school_subject_groups` WRITE;
/*!40000 ALTER TABLE `school_subject_groups` DISABLE KEYS */;
INSERT INTO `school_subject_groups` VALUES (2,'4ba06912-0934-11f0-8e09-0242ac140002',1,'Sentra Wajib','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(3,'4ba23026-0934-11f0-a2f3-0242ac140002',1,'Sentra Pilihan','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(4,'4ba2b17c-0934-11f0-9466-0242ac140002',1,'Muatan Lokal','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(5,'4ba497a8-0934-11f0-a7fb-0242ac140002',1,'P5','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(6,'4baf1372-0934-11f0-ba60-0242ac140002',2,'Mata Pelajaran Wajib','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(7,'4bb205a0-0934-11f0-b597-0242ac140002',2,'Mata Pelajaran Muatan Lokal','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(8,'4bb66154-0934-11f0-8fa4-0242ac140002',3,'Kurikulum Merdeka','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(9,'4bb713ce-0934-11f0-a8c5-0242ac140002',3,'Check Point','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(10,'4bbdb314-0934-11f0-a266-0242ac140002',4,'KURMER','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL);
/*!40000 ALTER TABLE `school_subject_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_subjects`
--

DROP TABLE IF EXISTS `school_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_subjects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` bigint(20) unsigned NOT NULL,
  `school_subject_group_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_subjects_uuid_unique` (`uuid`),
  KEY `school_subjects_school_id_foreign` (`school_id`),
  KEY `school_subjects_school_subject_group_id_foreign` (`school_subject_group_id`),
  CONSTRAINT `school_subjects_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`),
  CONSTRAINT `school_subjects_school_subject_group_id_foreign` FOREIGN KEY (`school_subject_group_id`) REFERENCES `school_subject_groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_subjects`
--

LOCK TABLES `school_subjects` WRITE;
/*!40000 ALTER TABLE `school_subjects` DISABLE KEYS */;
INSERT INTO `school_subjects` VALUES (2,'4ba13e78-0934-11f0-ae84-0242ac140002',1,2,'Sentra Imtak','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(3,'4ba1857c-0934-11f0-bdd3-0242ac140002',1,2,'Sentra Bahan Alam','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(4,'4ba1dd7e-0934-11f0-80d9-0242ac140002',1,2,'Sentra Bermain Peran','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(5,'4ba2685c-0934-11f0-91f1-0242ac140002',1,3,'Kelas Klasikal','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(6,'4ba2dfd0-0934-11f0-ba9c-0242ac140002',1,4,'Mulok Bahasa Inggris','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(7,'4ba323aa-0934-11f0-bed6-0242ac140002',1,2,'Sentra Persiapan','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(8,'4ba36bbc-0934-11f0-9e87-0242ac140002',1,4,'Mulok Bahasa Mandarin','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(9,'4ba3b158-0934-11f0-95d8-0242ac140002',1,2,'Sentra Seni','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(10,'4ba3e736-0934-11f0-9e4c-0242ac140002',1,2,'Kegiatan Khusus','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(11,'4ba425ca-0934-11f0-b41c-0242ac140002',1,2,'Kegiatan Kunjungan','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(12,'4ba46a3a-0934-11f0-840b-0242ac140002',1,2,'Kegiatan Pembelajaran Eksperimen','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(13,'4ba4c05c-0934-11f0-829e-0242ac140002',1,5,'Proyek Penguatan Profil Pelajar Pancasila','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(14,'4baf493c-0934-11f0-9f12-0242ac140002',2,6,'Matematika','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(15,'4baf9220-0934-11f0-b7bb-0242ac140002',2,6,'Bahasa Inggris','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(16,'4bafd7b2-0934-11f0-b171-0242ac140002',2,6,'Ilmu Pengetahuan Alam dan Sosial','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(17,'4bb014c0-0934-11f0-a12c-0242ac140002',2,6,'Bahasa Indonesia','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(18,'4bb0866c-0934-11f0-8468-0242ac140002',2,6,'Pendidikan Kewarganegaraan','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(19,'4bb0f9f8-0934-11f0-b328-0242ac140002',2,6,'Seni Tari','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(20,'4bb14520-0934-11f0-a6cc-0242ac140002',2,6,'Seni Rupa','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(21,'4bb189ea-0934-11f0-87a9-0242ac140002',2,6,'Seni Musik','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(22,'4bb1d3f0-0934-11f0-8b00-0242ac140002',2,6,'Pendidikan Jasmani, Olahraga dan Kesehatan','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(23,'4bb234ee-0934-11f0-aad9-0242ac140002',2,7,'Pendidikan Kebersihan dan Lingkungan Hidup','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(24,'4bb27b98-0934-11f0-8470-0242ac140002',2,7,'Teknologi Informasi dan Komunikasi','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(25,'4bb2ba68-0934-11f0-ae6e-0242ac140002',2,7,'Mandarin','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(26,'4bb2ef4c-0934-11f0-b606-0242ac140002',2,6,'Pendidikan Agama Kristen','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(27,'4bb69980-0934-11f0-9c94-0242ac140002',3,8,'IPS','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(28,'4bb6e322-0934-11f0-93d3-0242ac140002',3,8,'PKn','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(29,'4bb7457e-0934-11f0-aed1-0242ac140002',3,9,'Matematika','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(30,'4bb79c5e-0934-11f0-8666-0242ac140002',3,9,'Science','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(31,'4bb7d868-0934-11f0-b948-0242ac140002',3,8,'PJOK','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(32,'4bb80dc4-0934-11f0-b78b-0242ac140002',3,8,'Seni Musik','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(33,'4bb85fc2-0934-11f0-a249-0242ac140002',3,8,'Agama','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(34,'4bb8ac02-0934-11f0-94a1-0242ac140002',3,9,'English as a Second Language','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(35,'4bb8f6a8-0934-11f0-914d-0242ac140002',3,8,'ICT','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(36,'4bb93d7a-0934-11f0-8060-0242ac140002',3,8,'P5','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(37,'4bbdec3a-0934-11f0-b078-0242ac140002',4,10,'IPS','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(38,'4bbe53dc-0934-11f0-8f1e-0242ac140002',4,10,'IPA','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(39,'4bbe9130-0934-11f0-8db5-0242ac140002',4,10,'Bahasa Inggris','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(40,'4bbecca4-0934-11f0-823f-0242ac140002',4,10,'Bahasa Jerman','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(41,'4bbf10f6-0934-11f0-89cd-0242ac140002',4,10,'Bahasa Indonesia','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(42,'4bbf4a76-0934-11f0-bfd0-0242ac140002',4,10,'Informatika','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(43,'4bbf9314-0934-11f0-a3c8-0242ac140002',4,10,'Matematika','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(44,'4bc0449e-0934-11f0-8383-0242ac140002',4,10,'Sastra Inggris','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(45,'4bc08012-0934-11f0-bd5f-0242ac140002',4,10,'ICT','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(46,'4bc0c806-0934-11f0-b77c-0242ac140002',4,10,'Sejarah Indonesia','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(47,'4bc11298-0934-11f0-8025-0242ac140002',4,10,'Pendidikan Pancasila','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(48,'4bc159c4-0934-11f0-be15-0242ac140002',4,10,'Biologi','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(49,'4bc19754-0934-11f0-bb89-0242ac140002',4,10,'Seni Budaya','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(50,'4bc1dd18-0934-11f0-9ef8-0242ac140002',4,10,'Fisika','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(51,'4bc2285e-0934-11f0-9ec8-0242ac140002',4,10,'Matematika Lanjut','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(52,'4bc26a76-0934-11f0-8a8b-0242ac140002',4,10,'Ekonomi','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(53,'4bc2b530-0934-11f0-8a6c-0242ac140002',4,10,'Pendidikan Agama Kristen','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(54,'4bc2f7e8-0934-11f0-99b8-0242ac140002',4,10,'Sosiologi','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(55,'4bc340ae-0934-11f0-b641-0242ac140002',4,10,'Pendidikan Jasmani dan Kesehatan','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(56,'4bc381ae-0934-11f0-84f8-0242ac140002',4,10,'Geografi','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(57,'4bc3d636-0934-11f0-9ede-0242ac140002',4,10,'Kimia','-','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL);
/*!40000 ALTER TABLE `school_subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_years`
--

DROP TABLE IF EXISTS `school_years`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_years` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_year` year(4) NOT NULL,
  `end_year` year(4) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_years_uuid_unique` (`uuid`),
  UNIQUE KEY `school_years_name_unique` (`name`),
  UNIQUE KEY `school_years_start_year_unique` (`start_year`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_years`
--

LOCK TABLES `school_years` WRITE;
/*!40000 ALTER TABLE `school_years` DISABLE KEYS */;
INSERT INTO `school_years` VALUES (1,'e0bcedb6-f7ca-11ef-bdd1-0200a013a61c','2024 / 2025',2024,2025,1,'2025-03-03 01:00:19','2025-03-03 02:32:48',NULL),(2,'fb06f572-f7ca-11ef-9a39-0200a013a61c','2025 / 2026',2025,2026,1,'2025-03-03 01:01:03','2025-03-03 01:01:39',NULL),(3,'c6e2732c-f7d7-11ef-aea8-0200a013a61c','2026 / 2027',2026,2027,1,'2025-03-03 02:32:39','2025-03-03 02:32:39',NULL),(4,'05f0c052-f7fe-11ef-bbce-0200a013a61c','2027/ 2028',2027,2028,1,'2025-03-03 07:06:26','2025-03-03 07:06:26',NULL),(5,'4baec304-0934-11f0-ba4b-0242ac140002','2023 - 2024',2023,2024,0,'2025-03-25 04:47:46','2025-03-25 04:47:46',NULL);
/*!40000 ALTER TABLE `school_years` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schools`
--

DROP TABLE IF EXISTS `schools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schools` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_level_id` bigint(20) unsigned NOT NULL,
  `headmaster_id` bigint(20) unsigned DEFAULT NULL,
  `use_major` tinyint(1) NOT NULL DEFAULT '0',
  `use_subject` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `schools_uuid_unique` (`uuid`),
  KEY `schools_school_level_id_foreign` (`school_level_id`),
  KEY `schools_headmaster_id_foreign` (`headmaster_id`),
  CONSTRAINT `schools_headmaster_id_foreign` FOREIGN KEY (`headmaster_id`) REFERENCES `employees` (`id`),
  CONSTRAINT `schools_school_level_id_foreign` FOREIGN KEY (`school_level_id`) REFERENCES `school_levels` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schools`
--

LOCK TABLES `schools` WRITE;
/*!40000 ALTER TABLE `schools` DISABLE KEYS */;
INSERT INTO `schools` VALUES (1,'bcc631e8-f594-11ef-bd65-0200a013a61c',1,NULL,0,0,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(2,'bcc72aa8-f594-11ef-9286-0200a013a61c',2,NULL,0,1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(3,'bcc7e3bc-f594-11ef-bcf9-0200a013a61c',3,NULL,0,1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(4,'bcc8b09e-f594-11ef-9b63-0200a013a61c',4,NULL,1,1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL);
/*!40000 ALTER TABLE `schools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('u5V5fMxNCLwzjQ64a4YfclQDVf0hNIwgbVkAQOff',NULL,'172.20.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiWTU0T3AyVWlGb3hiZzNzTWdyYmVncjFEVEUwb2pGVlIxSkRJNTRPOSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0MzoiaHR0cDovL2FwcC50ZXN0OjgwMDAvc2Nob29sL3NldHRpbmcvcHJvZmlsZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjI2OiJodHRwOi8vYXBwLnRlc3Q6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1742878058);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specializations`
--

DROP TABLE IF EXISTS `specializations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `specializations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint(20) unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `major` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `minor` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `specializations_uuid_unique` (`uuid`),
  KEY `specializations_profile_id_foreign` (`profile_id`),
  CONSTRAINT `specializations_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specializations`
--

LOCK TABLES `specializations` WRITE;
/*!40000 ALTER TABLE `specializations` DISABLE KEYS */;
/*!40000 ALTER TABLE `specializations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_guardians`
--

DROP TABLE IF EXISTS `student_guardians`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_guardians` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `guardian_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_guardians_uuid_unique` (`uuid`),
  KEY `student_guardians_student_id_foreign` (`student_id`),
  KEY `student_guardians_guardian_id_foreign` (`guardian_id`),
  CONSTRAINT `student_guardians_guardian_id_foreign` FOREIGN KEY (`guardian_id`) REFERENCES `users` (`id`),
  CONSTRAINT `student_guardians_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_guardians`
--

LOCK TABLES `student_guardians` WRITE;
/*!40000 ALTER TABLE `student_guardians` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_guardians` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_schools`
--

DROP TABLE IF EXISTS `student_schools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_schools` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` bigint(20) unsigned NOT NULL,
  `school_classroom_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_schools_uuid_unique` (`uuid`),
  KEY `student_schools_school_id_foreign` (`school_id`),
  KEY `student_schools_school_classroom_id_foreign` (`school_classroom_id`),
  KEY `student_schools_student_id_foreign` (`student_id`),
  CONSTRAINT `student_schools_school_classroom_id_foreign` FOREIGN KEY (`school_classroom_id`) REFERENCES `school_classrooms` (`id`),
  CONSTRAINT `student_schools_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`),
  CONSTRAINT `student_schools_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_schools`
--

LOCK TABLES `student_schools` WRITE;
/*!40000 ALTER TABLE `student_schools` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_schools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint(20) unsigned NOT NULL,
  `school_id` bigint(20) unsigned NOT NULL,
  `school_grade_id` bigint(20) unsigned NOT NULL,
  `school_national_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `students_uuid_unique` (`uuid`),
  UNIQUE KEY `students_school_national_id_unique` (`school_national_id`),
  KEY `students_profile_id_foreign` (`profile_id`),
  KEY `students_school_id_foreign` (`school_id`),
  KEY `students_school_grade_id_foreign` (`school_grade_id`),
  CONSTRAINT `students_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`),
  CONSTRAINT `students_school_grade_id_foreign` FOREIGN KEY (`school_grade_id`) REFERENCES `school_grades` (`id`),
  CONSTRAINT `students_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'d7e3099a-fe1a-11ef-b127-0200a013a61c',121,1,1,'183/PG/22','2025-03-11 01:47:51','2025-03-11 02:51:53',NULL),(2,'e10cf5d8-fee9-11ef-9364-0200a013a61c',125,1,1,'900/KB/HH/2025','2025-03-12 02:29:52','2025-03-17 01:34:17',NULL),(3,'e10e7eee-fee9-11ef-9830-0200a013a61c',126,1,1,'2','2025-03-12 02:29:52','2025-03-12 02:30:14',NULL),(6,'4bc93176-0934-11f0-a1c5-0242ac140002',129,1,1,'RAINA EREZIA SUNARYO','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(7,'4bca5fd8-0934-11f0-8254-0242ac140002',130,1,1,'3182332751','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(8,'4bcb4150-0934-11f0-8e8b-0242ac140002',131,1,4,'3198237359','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(9,'4bcbea56-0934-11f0-ac46-0242ac140002',132,1,4,'3190723356','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(10,'4bcc95e6-0934-11f0-9456-0242ac140002',133,1,1,'3189279184','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(11,'4bcd50c6-0934-11f0-9bf0-0242ac140002',134,1,1,'3194574495','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(12,'4bce120e-0934-11f0-b2cc-0242ac140002',135,1,4,'3192465564','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(13,'4bceefa8-0934-11f0-91cc-0242ac140002',136,1,1,'3189423210','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(14,'4bcfd814-0934-11f0-a07e-0242ac140002',137,1,4,'3181884547','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(15,'4bd0b9c8-0934-11f0-8bbf-0242ac140002',138,1,1,'3189841236','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(16,'4bd1748a-0934-11f0-8322-0242ac140002',139,1,4,'3183585437','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(17,'4bd24b30-0934-11f0-8edd-0242ac140002',140,1,1,'3180247419','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(18,'4bd316d2-0934-11f0-b566-0242ac140002',141,1,4,'3186237259','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(19,'4bd3db80-0934-11f0-8f24-0242ac140002',142,1,1,'3190678047','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(20,'4bd67336-0934-11f0-bb47-0242ac140002',143,1,1,'3173124016','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(21,'4bd74cfc-0934-11f0-ba89-0242ac140002',144,1,1,'12312381989','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(22,'4bd81754-0934-11f0-aa66-0242ac140002',145,1,1,'3212871090','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(23,'4bd8dff4-0934-11f0-91c3-0242ac140002',146,1,1,'3229271806','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(24,'4bd99e6c-0934-11f0-94bc-0242ac140002',147,1,1,'3224620534','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(25,'4bda472c-0934-11f0-968b-0242ac140002',148,1,1,'3216907881','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(26,'4bdb0bee-0934-11f0-a678-0242ac140002',149,1,1,'3219119006','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(27,'4bdbd13c-0934-11f0-871d-0242ac140002',150,1,1,'3210248225','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(28,'4bdd4d00-0934-11f0-981d-0242ac140002',151,1,1,'3214928399','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(29,'4bde45de-0934-11f0-ad7c-0242ac140002',152,1,1,'3215169943','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(30,'4bdf2224-0934-11f0-8999-0242ac140002',153,1,1,'3228645061','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(31,'4be00d9c-0934-11f0-9aaf-0242ac140002',154,1,1,'3214333670','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(32,'4be0c5de-0934-11f0-8ac2-0242ac140002',155,1,1,'3211393485','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(33,'4be181a4-0934-11f0-a748-0242ac140002',156,1,1,'3223302319','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(34,'4be251b0-0934-11f0-87da-0242ac140002',157,1,1,'3221693311','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(35,'4be30aa6-0934-11f0-937b-0242ac140002',158,1,1,'3213571904','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(36,'4be3e20a-0934-11f0-9c6b-0242ac140002',159,1,1,'3229832787','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(37,'4be498c6-0934-11f0-9a97-0242ac140002',160,1,1,'3228782392','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(38,'4be54672-0934-11f0-8884-0242ac140002',161,1,1,'3221215512','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(39,'4be60774-0934-11f0-9bd7-0242ac140002',162,1,1,'3213722730','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(40,'4be6ba2a-0934-11f0-b82f-0242ac140002',163,1,1,'3210837524','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(41,'4be77262-0934-11f0-a23a-0242ac140002',164,1,1,'3210712776','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(42,'4becfb2e-0934-11f0-9421-0242ac140002',165,2,5,'3186410364','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(43,'4bedda08-0934-11f0-ab71-0242ac140002',166,2,5,'3185472563','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(44,'4beebcca-0934-11f0-a411-0242ac140002',167,2,5,'3171817724','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(45,'4befbbc0-0934-11f0-ba2a-0242ac140002',168,2,5,'3173835809','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(46,'4bf088e8-0934-11f0-be0d-0242ac140002',169,2,5,'3186261662','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(47,'4bf1331a-0934-11f0-995a-0242ac140002',170,2,5,'3180024532','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(48,'4bf21334-0934-11f0-8846-0242ac140002',171,2,5,'3185949737','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(49,'4bf2e480-0934-11f0-94a2-0242ac140002',172,2,5,'000','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(50,'4bf3a780-0934-11f0-9232-0242ac140002',173,2,5,'3183454359','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(51,'4bf4677e-0934-11f0-8100-0242ac140002',174,2,5,'3172139507','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL),(52,'4bf574fc-0934-11f0-a430-0242ac140002',175,4,14,'0098585615','2025-03-25 04:47:46','2025-03-25 04:47:46',NULL);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_attendances`
--

DROP TABLE IF EXISTS `sub_attendances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_attendances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint(20) unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_attendances_uuid_unique` (`uuid`),
  KEY `sub_attendances_submission_id_foreign` (`submission_id`),
  CONSTRAINT `sub_attendances_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_attendances`
--

LOCK TABLES `sub_attendances` WRITE;
/*!40000 ALTER TABLE `sub_attendances` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_attendances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_broadcasts`
--

DROP TABLE IF EXISTS `sub_broadcasts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_broadcasts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint(20) unsigned NOT NULL,
  `date_schedule` date DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_broadcasts_uuid_unique` (`uuid`),
  KEY `sub_broadcasts_submission_id_foreign` (`submission_id`),
  CONSTRAINT `sub_broadcasts_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_broadcasts`
--

LOCK TABLES `sub_broadcasts` WRITE;
/*!40000 ALTER TABLE `sub_broadcasts` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_broadcasts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_cards`
--

DROP TABLE IF EXISTS `sub_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_cards` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint(20) unsigned NOT NULL,
  `due_date` date DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_cards_uuid_unique` (`uuid`),
  KEY `sub_cards_submission_id_foreign` (`submission_id`),
  CONSTRAINT `sub_cards_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_cards`
--

LOCK TABLES `sub_cards` WRITE;
/*!40000 ALTER TABLE `sub_cards` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_design_items`
--

DROP TABLE IF EXISTS `sub_design_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_design_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_design_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `due_date` date DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_design_items_uuid_unique` (`uuid`),
  KEY `sub_design_items_sub_design_id_foreign` (`sub_design_id`),
  CONSTRAINT `sub_design_items_sub_design_id_foreign` FOREIGN KEY (`sub_design_id`) REFERENCES `sub_designs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_design_items`
--

LOCK TABLES `sub_design_items` WRITE;
/*!40000 ALTER TABLE `sub_design_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_design_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_designs`
--

DROP TABLE IF EXISTS `sub_designs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_designs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_designs_uuid_unique` (`uuid`),
  KEY `sub_designs_submission_id_foreign` (`submission_id`),
  CONSTRAINT `sub_designs_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_designs`
--

LOCK TABLES `sub_designs` WRITE;
/*!40000 ALTER TABLE `sub_designs` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_designs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_documentations`
--

DROP TABLE IF EXISTS `sub_documentations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_documentations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `place` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_documentations_uuid_unique` (`uuid`),
  KEY `sub_documentations_submission_id_foreign` (`submission_id`),
  CONSTRAINT `sub_documentations_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_documentations`
--

LOCK TABLES `sub_documentations` WRITE;
/*!40000 ALTER TABLE `sub_documentations` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_documentations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_equipment_items`
--

DROP TABLE IF EXISTS `sub_equipment_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_equipment_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_equipment_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '0',
  `due_date` date DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_equipment_items_uuid_unique` (`uuid`),
  KEY `sub_equipment_items_sub_equipment_id_foreign` (`sub_equipment_id`),
  CONSTRAINT `sub_equipment_items_sub_equipment_id_foreign` FOREIGN KEY (`sub_equipment_id`) REFERENCES `sub_equipments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_equipment_items`
--

LOCK TABLES `sub_equipment_items` WRITE;
/*!40000 ALTER TABLE `sub_equipment_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_equipment_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_equipments`
--

DROP TABLE IF EXISTS `sub_equipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_equipments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint(20) unsigned NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_equipments_uuid_unique` (`uuid`),
  KEY `sub_equipments_submission_id_foreign` (`submission_id`),
  CONSTRAINT `sub_equipments_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_equipments`
--

LOCK TABLES `sub_equipments` WRITE;
/*!40000 ALTER TABLE `sub_equipments` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_equipments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_event_items`
--

DROP TABLE IF EXISTS `sub_event_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_event_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_event_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '0',
  `unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `bill_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_event_items_uuid_unique` (`uuid`),
  KEY `sub_event_items_sub_event_id_foreign` (`sub_event_id`),
  CONSTRAINT `sub_event_items_sub_event_id_foreign` FOREIGN KEY (`sub_event_id`) REFERENCES `sub_events` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_event_items`
--

LOCK TABLES `sub_event_items` WRITE;
/*!40000 ALTER TABLE `sub_event_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_event_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_events`
--

DROP TABLE IF EXISTS `sub_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `place` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `use_date` date NOT NULL,
  `bill_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_events_uuid_unique` (`uuid`),
  KEY `sub_events_submission_id_foreign` (`submission_id`),
  CONSTRAINT `sub_events_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_events`
--

LOCK TABLES `sub_events` WRITE;
/*!40000 ALTER TABLE `sub_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_install_repair_items`
--

DROP TABLE IF EXISTS `sub_install_repair_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_install_repair_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_install_repair_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '0',
  `unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_install_repair_items_uuid_unique` (`uuid`),
  KEY `sub_install_repair_items_sub_install_repair_id_foreign` (`sub_install_repair_id`),
  CONSTRAINT `sub_install_repair_items_sub_install_repair_id_foreign` FOREIGN KEY (`sub_install_repair_id`) REFERENCES `sub_install_repairs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_install_repair_items`
--

LOCK TABLES `sub_install_repair_items` WRITE;
/*!40000 ALTER TABLE `sub_install_repair_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_install_repair_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_install_repairs`
--

DROP TABLE IF EXISTS `sub_install_repairs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_install_repairs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint(20) unsigned NOT NULL,
  `assigned_id` bigint(20) unsigned DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_install_repairs_uuid_unique` (`uuid`),
  KEY `sub_install_repairs_submission_id_foreign` (`submission_id`),
  KEY `sub_install_repairs_assigned_id_foreign` (`assigned_id`),
  CONSTRAINT `sub_install_repairs_assigned_id_foreign` FOREIGN KEY (`assigned_id`) REFERENCES `employees` (`id`),
  CONSTRAINT `sub_install_repairs_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_install_repairs`
--

LOCK TABLES `sub_install_repairs` WRITE;
/*!40000 ALTER TABLE `sub_install_repairs` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_install_repairs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_leaves`
--

DROP TABLE IF EXISTS `sub_leaves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_leaves` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint(20) unsigned NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_leaves_uuid_unique` (`uuid`),
  KEY `sub_leaves_submission_id_foreign` (`submission_id`),
  CONSTRAINT `sub_leaves_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_leaves`
--

LOCK TABLES `sub_leaves` WRITE;
/*!40000 ALTER TABLE `sub_leaves` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_leaves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_material_items`
--

DROP TABLE IF EXISTS `sub_material_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_material_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_material_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '1',
  `unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `bill_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `due_date` date DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_material_items_uuid_unique` (`uuid`),
  KEY `sub_material_items_sub_material_id_foreign` (`sub_material_id`),
  CONSTRAINT `sub_material_items_sub_material_id_foreign` FOREIGN KEY (`sub_material_id`) REFERENCES `sub_materials` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=997 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_material_items`
--

LOCK TABLES `sub_material_items` WRITE;
/*!40000 ALTER TABLE `sub_material_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_material_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_materials`
--

DROP TABLE IF EXISTS `sub_materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_materials` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint(20) unsigned NOT NULL,
  `bill_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_materials_uuid_unique` (`uuid`),
  KEY `sub_materials_submission_id_foreign` (`submission_id`),
  CONSTRAINT `sub_materials_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=997 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_materials`
--

LOCK TABLES `sub_materials` WRITE;
/*!40000 ALTER TABLE `sub_materials` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_media_posts`
--

DROP TABLE IF EXISTS `sub_media_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_media_posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_media_posts_uuid_unique` (`uuid`),
  KEY `sub_media_posts_submission_id_foreign` (`submission_id`),
  CONSTRAINT `sub_media_posts_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_media_posts`
--

LOCK TABLES `sub_media_posts` WRITE;
/*!40000 ALTER TABLE `sub_media_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_media_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_outstations`
--

DROP TABLE IF EXISTS `sub_outstations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_outstations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint(20) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_outstations_uuid_unique` (`uuid`),
  KEY `sub_outstations_submission_id_foreign` (`submission_id`),
  CONSTRAINT `sub_outstations_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_outstations`
--

LOCK TABLES `sub_outstations` WRITE;
/*!40000 ALTER TABLE `sub_outstations` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_outstations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_resignation_items`
--

DROP TABLE IF EXISTS `sub_resignation_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_resignation_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_resignation_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `checker_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_resignation_items_uuid_unique` (`uuid`),
  KEY `sub_resignation_items_sub_resignation_id_foreign` (`sub_resignation_id`),
  KEY `sub_resignation_items_checker_id_foreign` (`checker_id`),
  CONSTRAINT `sub_resignation_items_checker_id_foreign` FOREIGN KEY (`checker_id`) REFERENCES `employees` (`id`),
  CONSTRAINT `sub_resignation_items_sub_resignation_id_foreign` FOREIGN KEY (`sub_resignation_id`) REFERENCES `sub_resignations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_resignation_items`
--

LOCK TABLES `sub_resignation_items` WRITE;
/*!40000 ALTER TABLE `sub_resignation_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_resignation_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_resignations`
--

DROP TABLE IF EXISTS `sub_resignations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_resignations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint(20) unsigned NOT NULL,
  `entry_date` date NOT NULL,
  `out_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_resignations_uuid_unique` (`uuid`),
  KEY `sub_resignations_submission_id_foreign` (`submission_id`),
  CONSTRAINT `sub_resignations_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_resignations`
--

LOCK TABLES `sub_resignations` WRITE;
/*!40000 ALTER TABLE `sub_resignations` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_resignations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_vehicles`
--

DROP TABLE IF EXISTS `sub_vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_vehicles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `use_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_vehicles_uuid_unique` (`uuid`),
  KEY `sub_vehicles_submission_id_foreign` (`submission_id`),
  CONSTRAINT `sub_vehicles_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_vehicles`
--

LOCK TABLES `sub_vehicles` WRITE;
/*!40000 ALTER TABLE `sub_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_vehicles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject_threshold_narratives`
--

DROP TABLE IF EXISTS `subject_threshold_narratives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subject_threshold_narratives` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `threshold_id` bigint(20) unsigned NOT NULL,
  `value` decimal(8,2) NOT NULL,
  `narrative` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subject_threshold_narratives_uuid_unique` (`uuid`),
  KEY `subject_threshold_narratives_threshold_id_foreign` (`threshold_id`),
  CONSTRAINT `subject_threshold_narratives_threshold_id_foreign` FOREIGN KEY (`threshold_id`) REFERENCES `subject_thresholds` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject_threshold_narratives`
--

LOCK TABLES `subject_threshold_narratives` WRITE;
/*!40000 ALTER TABLE `subject_threshold_narratives` DISABLE KEYS */;
INSERT INTO `subject_threshold_narratives` VALUES (1,'4d3065e8-0934-11f0-be4e-0242ac140002',4,0.00,'Peserta didik sedang tidak dapat berpartisipasi dalam kegiatan ini.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(2,'4d3293b8-0934-11f0-9ffe-0242ac140002',8,0.00,'Peserta didik sedang tidak dapat berpartisipasi dalam kegiatan ini.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(3,'4d366880-0934-11f0-8d77-0242ac140002',12,0.00,'Peserta didik sedang tidak dapat berpartisipasi dalam kegiatan ini.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(4,'4d38e600-0934-11f0-a065-0242ac140002',16,0.00,'Peserta didik sedang tidak dapat berpartisipasi dalam kegiatan ini.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(5,'4d3b1f24-0934-11f0-bf54-0242ac140002',20,0.00,'Peserta didik sedang tidak dapat berpartisipasi dalam kegiatan ini.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(6,'4d3dab04-0934-11f0-b7c7-0242ac140002',24,0.00,'Peserta didik sedang tidak dapat berpartisipasi dalam kegiatan ini.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(7,'4d3fdb68-0934-11f0-afc3-0242ac140002',28,0.00,'Peserta didik sedang tidak dapat berpartisipasi dalam kegiatan ini.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(8,'4d44418a-0934-11f0-89ee-0242ac140002',32,0.00,'Peserta didik sedang tidak dapat berpartisipasi dalam kegiatan ini.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(9,'4d491584-0934-11f0-85e7-0242ac140002',36,0.00,'Peserta didik sedang tidak dapat berpartisipasi dalam kegiatan ini.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(10,'4d4dca20-0934-11f0-8217-0242ac140002',40,0.00,'Peserta didik sedang tidak dapat berpartisipasi dalam kegiatan ini.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(11,'4d4e577e-0934-11f0-8e60-0242ac140002',41,0.00,'Peserta didik sedang tidak dapat berpartisipasi dalam kegiatan ini.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(12,'4d50ce5a-0934-11f0-9b67-0242ac140002',42,0.00,'Peserta didik sedang tidak dapat berkontribusi dalam kegiatan P5.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(13,'4d5c0310-0934-11f0-85f8-0242ac140002',43,60.00,'Siswa perlu bimbingan lebih dalam untuk','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(14,'4d5d1246-0934-11f0-8455-0242ac140002',44,60.00,'Siswa perlu bimbingan lebih dalam untuk','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(15,'4d5f754a-0934-11f0-9b96-0242ac140002',45,60.00,'Siswa perlu bimbingan lebih dalam untuk','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(16,'4d625562-0934-11f0-9af8-0242ac140002',46,60.00,'Siswa perlu bimbingan lebih dalam untuk','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(17,'4d655b2c-0934-11f0-a155-0242ac140002',47,60.00,'Siswa perlu bimbingan lebih dalam untuk','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(18,'4d67ec20-0934-11f0-bf63-0242ac140002',48,60.00,'Siswa perlu bimbingan lebih dalam untuk','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(19,'4d83b78e-0934-11f0-bc2e-0242ac140002',49,70.00,'Siswa menunjukan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(20,'4d849e10-0934-11f0-a729-0242ac140002',50,70.00,'Siswa menunjukan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(21,'4d85d726-0934-11f0-9092-0242ac140002',51,70.00,'Siswa menunjukan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(22,'4d86de46-0934-11f0-9445-0242ac140002',52,70.00,'Siswa menunjukan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(23,'4d87deea-0934-11f0-93a4-0242ac140002',53,70.00,'Siswa menunjukan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(24,'4d88e614-0934-11f0-a754-0242ac140002',54,70.00,'Siswa menunjukan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(25,'4d8a0b34-0934-11f0-9820-0242ac140002',55,70.00,'Siswa menunjukan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(26,'4d8b0b7e-0934-11f0-91e5-0242ac140002',56,70.00,'Siswa menunjukan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(27,'4d8c0eca-0934-11f0-8e84-0242ac140002',57,70.00,'Siswa menunjukan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(28,'4d8d328c-0934-11f0-8d8a-0242ac140002',58,70.00,'Siswa menunjukan','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(29,'4e1fe05a-0934-11f0-890f-0242ac140002',59,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(30,'4e215f20-0934-11f0-ae13-0242ac140002',60,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(31,'4e227ff4-0934-11f0-b61a-0242ac140002',61,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(32,'4e23cc88-0934-11f0-87f6-0242ac140002',62,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(33,'4e24f806-0934-11f0-b961-0242ac140002',63,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(34,'4e269b5c-0934-11f0-b0ec-0242ac140002',64,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(35,'4e27fe66-0934-11f0-8d67-0242ac140002',65,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(36,'4e29ce3a-0934-11f0-a63c-0242ac140002',66,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(37,'4e2b41f2-0934-11f0-afdf-0242ac140002',67,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(38,'4e2c5f7e-0934-11f0-b358-0242ac140002',68,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(39,'4e2db0ea-0934-11f0-9f5b-0242ac140002',69,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(40,'4e2f48e2-0934-11f0-b6ea-0242ac140002',70,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(41,'4e3096c0-0934-11f0-9972-0242ac140002',71,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(42,'4e31fbd2-0934-11f0-a372-0242ac140002',72,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(43,'4e338e20-0934-11f0-8ee9-0242ac140002',73,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(44,'4e34f3a0-0934-11f0-8f1c-0242ac140002',74,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(45,'4e364818-0934-11f0-91ed-0242ac140002',75,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(46,'4e378822-0934-11f0-8b46-0242ac140002',76,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(47,'4e38f4a0-0934-11f0-bffe-0242ac140002',77,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(48,'4e3a53c2-0934-11f0-b1e7-0242ac140002',78,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(49,'4e3c0f28-0934-11f0-bf60-0242ac140002',79,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(50,'4e3d71c4-0934-11f0-834f-0242ac140002',80,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(51,'4e3eb700-0934-11f0-ac5f-0242ac140002',81,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(52,'4e402eaa-0934-11f0-9ff2-0242ac140002',82,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(53,'4e417008-0934-11f0-9a5c-0242ac140002',83,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(54,'4e42c480-0934-11f0-a9a8-0242ac140002',84,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(55,'4e4405de-0934-11f0-b7f4-0242ac140002',85,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(56,'4e45755e-0934-11f0-9987-0242ac140002',86,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(57,'4e46d6ba-0934-11f0-a7c4-0242ac140002',87,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(58,'4e481dcc-0934-11f0-8ced-0242ac140002',88,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(59,'4e497514-0934-11f0-8490-0242ac140002',89,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(60,'4e4acf9a-0934-11f0-be9f-0242ac140002',90,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(61,'4e4c0b8a-0934-11f0-910d-0242ac140002',91,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(62,'4e4d5698-0934-11f0-adc3-0242ac140002',92,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(63,'4e4e7b40-0934-11f0-8098-0242ac140002',93,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(64,'4e4fcd9c-0934-11f0-b363-0242ac140002',94,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(65,'4e5118aa-0934-11f0-97fb-0242ac140002',95,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(66,'4e52450e-0934-11f0-80d0-0242ac140002',96,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(67,'4e53a142-0934-11f0-a548-0242ac140002',97,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(68,'4e54beb0-0934-11f0-a3c8-0242ac140002',98,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(69,'4e563254-0934-11f0-a186-0242ac140002',99,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(70,'4e57830c-0934-11f0-9560-0242ac140002',100,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(71,'4e58e80a-0934-11f0-abbf-0242ac140002',101,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(72,'4e5a6f36-0934-11f0-bf54-0242ac140002',102,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(73,'4e5bfc0c-0934-11f0-8370-0242ac140002',103,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(74,'4e5da4bc-0934-11f0-87a4-0242ac140002',104,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(75,'4e5edc88-0934-11f0-8004-0242ac140002',105,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(76,'4e6059b4-0934-11f0-825b-0242ac140002',106,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(77,'4e61f0f8-0934-11f0-ab04-0242ac140002',107,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(78,'4e63bfa0-0934-11f0-b109-0242ac140002',108,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(79,'4e64ebb4-0934-11f0-b14b-0242ac140002',109,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(80,'4e66387a-0934-11f0-845f-0242ac140002',110,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(81,'4e67b42a-0934-11f0-94e9-0242ac140002',111,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(82,'4e697b34-0934-11f0-8f9b-0242ac140002',112,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(83,'4e6ae4d8-0934-11f0-b0f0-0242ac140002',113,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(84,'4e6c5372-0934-11f0-870b-0242ac140002',114,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(85,'4e6de566-0934-11f0-ba90-0242ac140002',115,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(86,'4e6f753e-0934-11f0-bd72-0242ac140002',116,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(87,'4e70e18a-0934-11f0-b00f-0242ac140002',117,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(88,'4e724c6e-0934-11f0-ab69-0242ac140002',118,70.00,'Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL);
/*!40000 ALTER TABLE `subject_threshold_narratives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject_threshold_scales`
--

DROP TABLE IF EXISTS `subject_threshold_scales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subject_threshold_scales` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `threshold_id` bigint(20) unsigned NOT NULL,
  `value` decimal(8,2) NOT NULL,
  `predicate` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `narrative` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subject_threshold_scales_uuid_unique` (`uuid`),
  KEY `subject_threshold_scales_threshold_id_foreign` (`threshold_id`),
  CONSTRAINT `subject_threshold_scales_threshold_id_foreign` FOREIGN KEY (`threshold_id`) REFERENCES `subject_thresholds` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=363 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject_threshold_scales`
--

LOCK TABLES `subject_threshold_scales` WRITE;
/*!40000 ALTER TABLE `subject_threshold_scales` DISABLE KEYS */;
INSERT INTO `subject_threshold_scales` VALUES (1,'4d2f0c2a-0934-11f0-9bf6-0242ac140002',4,1.00,'MB','Peserta didik belum menunjukkan pemahaman dasar tentang konsep keimanan dan ketakwaan.   Belum mengikuti kegiatan pembelajaran meskipun dengan bantuan intensif dari guru.   Partisipasi dalam kegiatan keagamaan terbatas, tanpa upaya untuk berpartisipasi.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(2,'4d2f3aba-0934-11f0-88c9-0242ac140002',4,2.00,'SB','Peserta didik mulai menunjukkan pemahaman dasar tentang konsep keimanan dan ketakwaan.   Mau mengikuti kegiatan pembelajaran dengan bantuan intensif dari guru.   Partisipasi dalam kegiatan keagamaan masih terbatas, tetapi ada upaya untuk berpartisipasi.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(3,'4d2f6bfc-0934-11f0-9ea6-0242ac140002',4,3.00,'BSH','Peserta didik memahami dengan baik ajaran-ajaran keimanan dan ketakwaan.   Mampu melaksanakan ibadah dan kegiatan keagamaan secara mandiri.   Menunjukkan tanggung jawab dalam melaksanakan nilai-nilai keagamaan di sekolah.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(4,'4d302150-0934-11f0-a7d0-0242ac140002',4,4.00,'BSB','Peserta didik menunjukkan penguasaan yang sangat baik terhadap materi keimanan dan ketakwaan.   Aktif dalam berbagai kegiatan keagamaan di sekolah.   Menginspirasi teman-teman lain dengan mengajak dan menjadi contoh yang baik dalam perilaku sehari-hari sesuai dengan nilai-nilai keimanan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(5,'4d32084e-0934-11f0-beba-0242ac140002',8,1.00,'MB','Peserta didik belum menunjukkan pemahaman dasar tentang konsep bermain peran.   Belum terlibat dalam kegiatan bermain peran meskipun dengan bantuan dari guru.   Partisipasi dalam aktivitas terbatas, tanpa inisiatif untuk berkontribusi.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(6,'4d322cac-0934-11f0-9059-0242ac140002',8,2.00,'SB','Peserta didik mulai menunjukkan pemahaman dasar tentang konsep bermain peran.   Mau mengikuti kegiatan bermain peran dengan bimbingan dari guru.   Partisipasi dalam aktivitas meningkat, meskipun masih memerlukan dorongan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(7,'4d324e94-0934-11f0-b5a2-0242ac140002',8,3.00,'BSH','Peserta didik memahami dengan baik berbagai peran dan skenario yang dimainkan.   Mampu berkontribusi secara mandiri dalam kegiatan bermain peran.   Menunjukkan kreativitas dan tanggung jawab dalam berperilaku sesuai peran yang diambil.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(8,'4d326f5a-0934-11f0-8dfe-0242ac140002',8,4.00,'BSB','Peserta didik menunjukkan penguasaan yang sangat baik terhadap konsep bermain peran.   Aktif dan inovatif dalam berbagai kegiatan bermain peran, serta mampu memimpin aktivitas.   Menginspirasi teman-teman dengan kreativitas dan kemampuan berkolaborasi dalam permainan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(9,'4d354950-0934-11f0-b536-0242ac140002',12,1.00,'MB','Peserta didik belum menunjukkan pemahaman dasar tentang bahan alam dan penggunaannya.   Belum terlibat dalam kegiatan eksplorasi bahan alam meskipun dengan bantuan dari guru.   Partisipasi dalam aktivitas terbatas, tanpa upaya untuk berkontribusi.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(10,'4d358514-0934-11f0-99b6-0242ac140002',12,2.00,'SB','Peserta didik mulai menunjukkan pemahaman dasar tentang bahan alam dan fungsinya.   Mau mengikuti kegiatan eksplorasi bahan alam dengan bimbingan dari guru.   Partisipasi dalam aktivitas meningkat, meskipun masih memerlukan dorongan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(11,'4d35b58e-0934-11f0-b222-0242ac140002',12,3.00,'BSH','Peserta didik memahami dengan baik berbagai jenis bahan alam dan aplikasinya.   Mampu berkontribusi secara mandiri dalam kegiatan eksplorasi dan penggunaan bahan alam.   Menunjukkan tanggung jawab dan kreativitas dalam penggunaan bahan alam di proyek.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(12,'4d35e5f4-0934-11f0-92b6-0242ac140002',12,4.00,'BSB','Peserta didik menunjukkan penguasaan yang sangat baik terhadap konsep bahan alam dan aplikasinya.   Aktif dan inovatif dalam berbagai kegiatan eksplorasi bahan alam, serta mampu memimpin proyek.   Menginspirasi teman-teman dengan pengetahuan dan kemampuan dalam memanfaatkan bahan alam secara kreatif.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(13,'4d382d14-0934-11f0-9478-0242ac140002',16,1.00,'MB','Peserta didik belum menunjukkan pemahaman dasar tentang kosakata dan struktur dasar dalam Bahasa Inggris.   Belum terlibat aktif dalam kegiatan pembelajaran meskipun dengan bantuan dari guru.   Partisipasi dalam aktivitas terbatas, tanpa upaya untuk berbicara atau menulis dalam Bahasa Inggris.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(14,'4d3856a4-0934-11f0-b6bd-0242ac140002',16,2.00,'SB','Peserta didik mulai menunjukkan pemahaman dasar tentang kosakata dan struktur kalimat dalam Bahasa Inggris.   Mau mengikuti kegiatan pembelajaran dengan bimbingan dari guru.   Partisipasi dalam aktivitas meningkat, meskipun masih memerlukan dorongan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(15,'4d3887fa-0934-11f0-8bb4-0242ac140002',16,3.00,'BSH','Peserta didik memahami dengan baik kosakata dan struktur kalimat dalam Bahasa Inggris.   Mampu berbicara dalam Bahasa Inggris secara mandiri dalam konteks sederhana.   Menunjukkan tanggung jawab dalam melaksanakan tugas dan berpartisipasi aktif dalam pembelajaran.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(16,'4d38ae60-0934-11f0-b8ee-0242ac140002',16,4.00,'BSB','Peserta didik menunjukkan penguasaan yang sangat baik terhadap kosakata, tata bahasa, dan keterampilan berbicara dalam Bahasa Inggris.   Aktif dalam berbagai kegiatan menggunakan Bahasa Inggris, baik lisan maupun tulisan.   Menginspirasi teman-teman lain dengan kemampuan dan keberanian dalam berkomunikasi menggunakan Bahasa Inggris.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(17,'4d3a9216-0934-11f0-8625-0242ac140002',20,1.00,'MB','Peserta didik belum menunjukkan pemahaman dasar tentang kosakata dan tata bahasa dalam Bahasa Mandarin.   Belum terlibat aktif dalam kegiatan pembelajaran meskipun dengan bantuan dari guru.   Partisipasi dalam aktivitas terbatas, tanpa inisiatif untuk berlatih berbicara dalam Bahasa Mandarin.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(18,'4d3ab7aa-0934-11f0-8014-0242ac140002',20,2.00,'SB','Peserta didik mulai menunjukkan pemahaman dasar tentang kosakata dan struktur kalimat dalam Bahasa Mandarin.   Mau mengikuti kegiatan pembelajaran dengan bimbingan dari guru.   Partisipasi dalam aktivitas meningkat, meskipun masih memerlukan dorongan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(19,'4d3adb68-0934-11f0-975a-0242ac140002',20,3.00,'BSH','Peserta didik memahami dengan baik kosakata, tata bahasa, dan pengucapan dalam Bahasa Mandarin.   Mampu berbicara dalam Bahasa Mandarin secara mandiri dalam konteks sederhana.   Menunjukkan tanggung jawab dalam melaksanakan tugas dan berpartisipasi aktif dalam pembelajaran.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(20,'4d3afd78-0934-11f0-8a53-0242ac140002',20,4.00,'BSB','Peserta didik menunjukkan penguasaan yang sangat baik terhadap kosakata, tata bahasa, dan keterampilan berbicara dalam Bahasa Mandarin.   Aktif dalam berbagai kegiatan menggunakan Bahasa Mandarin.   Menginspirasi teman-teman lain dengan kemampuan dan keberanian dalam berkomunikasi menggunakan Bahasa Mandarin.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(21,'4d3d07da-0934-11f0-a935-0242ac140002',24,1.00,'MB','Peserta didik belum menunjukkan pemahaman dasar tentang berbagai bentuk seni dan teknik dasar.   Belum terlibat aktif dalam kegiatan seni meskipun dengan bantuan dari guru.   Partisipasi dalam aktivitas seni terbatas, tanpa inisiatif untuk berkontribusi.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(22,'4d3d2cf6-0934-11f0-bd60-0242ac140002',24,2.00,'SB','Peserta didik mulai menunjukkan pemahaman dasar tentang bentuk seni dan teknik dasar yang diajarkan.   Mau mengikuti kegiatan seni dengan bimbingan dari guru.   Partisipasi dalam aktivitas seni meningkat, meskipun masih memerlukan dorongan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(23,'4d3d602c-0934-11f0-9a43-0242ac140002',24,3.00,'BSH','Peserta didik memahami dengan baik berbagai bentuk seni dan teknik yang digunakan.   Mampu berkontribusi secara mandiri dalam kegiatan seni dan menghasilkan karya yang menunjukkan kreativitas.   Menunjukkan tanggung jawab dan komitmen dalam melaksanakan proyek seni.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(24,'4d3d880e-0934-11f0-9de5-0242ac140002',24,4.00,'BSB','Peserta didik menunjukkan penguasaan yang sangat baik terhadap berbagai bentuk seni dan teknik yang diajarkan.   Aktif dan inovatif dalam berbagai kegiatan seni, serta mampu memimpin proyek seni.   Menginspirasi teman-teman dengan karya seni dan kemampuan untuk berkolaborasi dalam menciptakan karya bersama.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(25,'4d3f4478-0934-11f0-811a-0242ac140002',28,1.00,'MB','Peserta didik belum menunjukkan pemahaman dasar tentang keterampilan dan konsep yang diperlukan untuk persiapan pra menulis, pra membaca dan pra menghitung.   Belum terlibat aktif dalam kegiatan persiapan meskipun dengan bantuan dari guru.   Partisipasi dalam aktivitas terbatas, tanpa inisiatif untuk berkontribusi.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(26,'4d3f7178-0934-11f0-b7f0-0242ac140002',28,2.00,'SB','Peserta didik mulai menunjukkan pemahaman dasar tentang keterampilan dan konsep persiapan pra menulis, pra membaca dan pra menghitung yang diajarkan.   Mau mengikuti kegiatan persiapan dengan bimbingan dari guru.   Partisipasi dalam aktivitas meningkat, meskipun masih memerlukan dorongan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(27,'4d3f9702-0934-11f0-a3bc-0242ac140002',28,3.00,'BSH','Peserta didik memahami dengan baik keterampilan dan konsep yang diperlukan untuk persiapan pra menulis, pra membaca dan pra menghitung.   Mampu berkontribusi secara mandiri dalam kegiatan persiapan pra menulis, pra membaca dan pra menghitung dan menunjukkan hasil yang baik.   Menunjukkan tanggung jawab dan komitmen dalam melaksanakan tugas persiapan pra menulis, pra membaca dan pra menghitung.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(28,'4d3fb9ee-0934-11f0-b444-0242ac140002',28,4.00,'BSB','Peserta didik menunjukkan penguasaan yang sangat baik terhadap keterampilan dan konsep persiapan pra menulis, pra membaca dan pra menghitung yang diajarkan.   Aktif dan inovatif dalam berbagai kegiatan persiapan pra menulis, pra membaca dan pra menghitung, serta mampu memimpin proyek.   Menginspirasi teman-teman dengan pendekatan yang kreatif dan efektif dalam melakukan persiapan pra menulis, pra membaca dan pra menghitung.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(29,'4d404f8a-0934-11f0-98c6-0242ac140002',29,1.00,'MB','Siswa menunjukkan minat yang rendah terhadap kegiatan khusus. Partisipasi mereka terbatas, dan mereka membutuhkan dorongan ekstra untuk terlibat.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(30,'4d408f54-0934-11f0-b5ef-0242ac140002',29,2.00,'SB','Siswa mulai menunjukkan minat dan keterlibatan dalam kegiatan khusus, meskipun masih tergantung pada bimbingan guru. Mereka berusaha mengikuti aktivitas tetapi belum sepenuhnya percaya diri.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(31,'4d40bc9a-0934-11f0-8c6f-0242ac140002',29,3.00,'BSH','Siswa aktif berpartisipasi dalam kegiatan khusus dengan semangat. Mereka dapat mengikuti instruksi dengan baik dan menunjukkan kreativitas dalam berkontribusi.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(32,'4d40e1e8-0934-11f0-a6a9-0242ac140002',29,4.00,'BSB','Siswa menunjukkan antusiasme yang tinggi dalam kegiatan khusus. Mereka tidak hanya berpartisipasi, tetapi juga memimpin teman-temannya, berinovasi, dan menunjukkan kemampuan luar biasa dalam mengekspresikan diri.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(33,'4d415b96-0934-11f0-8372-0242ac140002',30,1.00,'MB','Siswa menunjukkan minat yang rendah terhadap kegiatan khusus. Partisipasi mereka terbatas, dan mereka membutuhkan dorongan ekstra untuk terlibat.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(34,'4d418aee-0934-11f0-b2ec-0242ac140002',30,2.00,'SB','Siswa mulai menunjukkan minat dan keterlibatan dalam kegiatan khusus, meskipun masih tergantung pada bimbingan guru. Mereka berusaha mengikuti aktivitas tetapi belum sepenuhnya percaya diri.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(35,'4d41bb18-0934-11f0-bc03-0242ac140002',30,3.00,'BSH','Siswa aktif berpartisipasi dalam kegiatan khusus dengan semangat. Mereka dapat mengikuti instruksi dengan baik dan menunjukkan kreativitas dalam berkontribusi.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(36,'4d41e61a-0934-11f0-b93a-0242ac140002',30,4.00,'BSB','Siswa menunjukkan antusiasme yang tinggi dalam kegiatan khusus. Mereka tidak hanya berpartisipasi, tetapi juga memimpin teman-temannya, berinovasi, dan menunjukkan kemampuan luar biasa dalam mengekspresikan diri.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(37,'4d427a80-0934-11f0-a2cd-0242ac140002',31,1.00,'MB','Siswa menunjukkan minat yang rendah terhadap kegiatan khusus. Partisipasi mereka terbatas, dan mereka membutuhkan dorongan ekstra untuk terlibat.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(38,'4d42a262-0934-11f0-9b3c-0242ac140002',31,2.00,'SB','Siswa mulai menunjukkan minat dan keterlibatan dalam kegiatan khusus, meskipun masih tergantung pada bimbingan guru. Mereka berusaha mengikuti aktivitas tetapi belum sepenuhnya percaya diri.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(39,'4d42c616-0934-11f0-8891-0242ac140002',31,3.00,'BSH','Siswa aktif berpartisipasi dalam kegiatan khusus dengan semangat. Mereka dapat mengikuti instruksi dengan baik dan menunjukkan kreativitas dalam berkontribusi.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(40,'4d430504-0934-11f0-9fa2-0242ac140002',31,4.00,'BSB','Siswa menunjukkan antusiasme yang tinggi dalam kegiatan khusus. Mereka tidak hanya berpartisipasi, tetapi juga memimpin teman-temannya, berinovasi, dan menunjukkan kemampuan luar biasa dalam mengekspresikan diri.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(41,'4d439bae-0934-11f0-9565-0242ac140002',32,1.00,'MB','Siswa menunjukkan minat yang rendah terhadap kegiatan khusus. Partisipasi mereka terbatas, dan mereka membutuhkan dorongan ekstra untuk terlibat.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(42,'4d43c4f8-0934-11f0-abb4-0242ac140002',32,2.00,'SB','Siswa mulai menunjukkan minat dan keterlibatan dalam kegiatan khusus, meskipun masih tergantung pada bimbingan guru. Mereka berusaha mengikuti aktivitas tetapi belum sepenuhnya percaya diri.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(43,'4d43f806-0934-11f0-b07b-0242ac140002',32,3.00,'BSH','Siswa aktif berpartisipasi dalam kegiatan khusus dengan semangat. Mereka dapat mengikuti instruksi dengan baik dan menunjukkan kreativitas dalam berkontribusi.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(44,'4d441dfe-0934-11f0-850f-0242ac140002',32,4.00,'BSB','Siswa menunjukkan antusiasme yang tinggi dalam kegiatan khusus. Mereka tidak hanya berpartisipasi, tetapi juga memimpin teman-temannya, berinovasi, dan menunjukkan kemampuan luar biasa dalam mengekspresikan diri.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(45,'4d44cc72-0934-11f0-bb0f-0242ac140002',33,1.00,'MB','Siswa tampak bingung dan tidak tertarik selama kunjungan lapangan. Mereka sulit memahami tujuan kegiatan dan menunjukkan kurangnya keterlibatan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(46,'4d44efae-0934-11f0-a54c-0242ac140002',33,2.00,'SB','Siswa mulai memahami tujuan kunjungan lapangan, meskipun mereka masih membutuhkan bimbingan. Beberapa siswa menunjukkan rasa ingin tahu, tetapi tidak semua berpartisipasi aktif.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(47,'4d4511c8-0934-11f0-ba68-0242ac140002',33,3.00,'BSH','Siswa aktif bertanya dan menjelajahi informasi selama kunjungan lapangan. Mereka menunjukkan ketertarikan yang baik dan berinteraksi dengan lingkungan sekitarnya.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(48,'4d4582f2-0934-11f0-b65f-0242ac140002',33,4.00,'BSB','Siswa sangat antusias selama kunjungan lapangan, menunjukkan inisiatif untuk bertanya dan berinteraksi. Mereka mampu menceritakan kembali pengalaman mereka dengan jelas dan mendalam.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(49,'4d462c5c-0934-11f0-9b35-0242ac140002',34,1.00,'MB','Siswa tampak bingung dan tidak tertarik selama kunjungan lapangan. Mereka sulit memahami tujuan kegiatan dan menunjukkan kurangnya keterlibatan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(50,'4d465f88-0934-11f0-94f3-0242ac140002',34,2.00,'SB','Siswa mulai memahami tujuan kunjungan lapangan, meskipun mereka masih membutuhkan bimbingan. Beberapa siswa menunjukkan rasa ingin tahu, tetapi tidak semua berpartisipasi aktif.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(51,'4d46831e-0934-11f0-9e55-0242ac140002',34,3.00,'BSH','Siswa aktif bertanya dan menjelajahi informasi selama kunjungan lapangan. Mereka menunjukkan ketertarikan yang baik dan berinteraksi dengan lingkungan sekitarnya.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(52,'4d46a5a6-0934-11f0-91eb-0242ac140002',34,4.00,'BSB','Siswa sangat antusias selama kunjungan lapangan, menunjukkan inisiatif untuk bertanya dan berinteraksi. Mereka mampu menceritakan kembali pengalaman mereka dengan jelas dan mendalam.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(53,'4d473b2e-0934-11f0-a78f-0242ac140002',35,1.00,'MB','Siswa tampak bingung dan tidak tertarik selama kunjungan lapangan. Mereka sulit memahami tujuan kegiatan dan menunjukkan kurangnya keterlibatan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(54,'4d476a5e-0934-11f0-a83a-0242ac140002',35,2.00,'SB','Siswa mulai memahami tujuan kunjungan lapangan, meskipun mereka masih membutuhkan bimbingan. Beberapa siswa menunjukkan rasa ingin tahu, tetapi tidak semua berpartisipasi aktif.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(55,'4d479272-0934-11f0-ac7d-0242ac140002',35,3.00,'BSH','Siswa aktif bertanya dan menjelajahi informasi selama kunjungan lapangan. Mereka menunjukkan ketertarikan yang baik dan berinteraksi dengan lingkungan sekitarnya.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(56,'4d47b8b0-0934-11f0-afdb-0242ac140002',35,4.00,'BSB','Siswa sangat antusias selama kunjungan lapangan, menunjukkan inisiatif untuk bertanya dan berinteraksi. Mereka mampu menceritakan kembali pengalaman mereka dengan jelas dan mendalam.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(57,'4d484bc2-0934-11f0-9e4f-0242ac140002',36,1.00,'MB','Siswa tampak bingung dan tidak tertarik selama kunjungan lapangan. Mereka sulit memahami tujuan kegiatan dan menunjukkan kurangnya keterlibatan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(58,'4d487fa2-0934-11f0-ae31-0242ac140002',36,2.00,'SB','Siswa mulai memahami tujuan kunjungan lapangan, meskipun mereka masih membutuhkan bimbingan. Beberapa siswa menunjukkan rasa ingin tahu, tetapi tidak semua berpartisipasi aktif.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(59,'4d48b684-0934-11f0-b2f7-0242ac140002',36,3.00,'BSH','Siswa aktif bertanya dan menjelajahi informasi selama kunjungan lapangan. Mereka menunjukkan ketertarikan yang baik dan berinteraksi dengan lingkungan sekitarnya.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(60,'4d48eaa0-0934-11f0-8bba-0242ac140002',36,4.00,'BSB','Siswa sangat antusias selama kunjungan lapangan, menunjukkan inisiatif untuk bertanya dan berinteraksi. Mereka mampu menceritakan kembali pengalaman mereka dengan jelas dan mendalam.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(61,'4d49abde-0934-11f0-b3f4-0242ac140002',37,1.00,'MB','Siswa tampak ragu dan tidak menunjukkan minat dalam pembelajaran eksplorasi. Mereka sulit beradaptasi dengan kegiatan yang diberikan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(62,'4d49d320-0934-11f0-aeeb-0242ac140002',37,2.00,'SB','Siswa mulai menunjukkan ketertarikan dalam eksplorasi, tetapi masih membutuhkan bimbingan untuk menjelajahi lebih jauh. Mereka mencoba mengikuti aktivitas tetapi dengan rasa percaya diri yang rendah.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(63,'4d49f77e-0934-11f0-bdba-0242ac140002',37,3.00,'BSH','Siswa aktif berpartisipasi dalam pembelajaran eksplorasi. Mereka menunjukkan rasa ingin tahu yang tinggi, mampu mengeksplorasi ide-ide baru, dan berkolaborasi dengan teman-temannya.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(64,'4d4a1998-0934-11f0-9968-0242ac140002',37,4.00,'BSB','Siswa menunjukkan sikap eksploratif yang sangat baik, mengajukan pertanyaan yang mendalam, dan mampu membuat hubungan antara berbagai konsep. Mereka berinovasi dan berbagi hasil eksplorasi mereka dengan percaya diri.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(65,'4d4ad108-0934-11f0-94e2-0242ac140002',38,1.00,'MB','Siswa tampak ragu dan tidak menunjukkan minat dalam pembelajaran eksplorasi. Mereka sulit beradaptasi dengan kegiatan yang diberikan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(66,'4d4aff48-0934-11f0-a34c-0242ac140002',38,2.00,'SB','Siswa mulai menunjukkan ketertarikan dalam eksplorasi, tetapi masih membutuhkan bimbingan untuk menjelajahi lebih jauh. Mereka mencoba mengikuti aktivitas tetapi dengan rasa percaya diri yang rendah.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(67,'4d4b2810-0934-11f0-8a95-0242ac140002',38,3.00,'BSH','Siswa aktif berpartisipasi dalam pembelajaran eksplorasi. Mereka menunjukkan rasa ingin tahu yang tinggi, mampu mengeksplorasi ide-ide baru, dan berkolaborasi dengan teman-temannya.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(68,'4d4b5916-0934-11f0-af18-0242ac140002',38,4.00,'BSB','Siswa menunjukkan sikap eksploratif yang sangat baik, mengajukan pertanyaan yang mendalam, dan mampu membuat hubungan antara berbagai konsep. Mereka berinovasi dan berbagi hasil eksplorasi mereka dengan percaya diri.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(69,'4d4c0f6e-0934-11f0-87ee-0242ac140002',39,1.00,'MB','Siswa tampak ragu dan tidak menunjukkan minat dalam pembelajaran eksplorasi. Mereka sulit beradaptasi dengan kegiatan yang diberikan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(70,'4d4c3e4e-0934-11f0-8ee1-0242ac140002',39,2.00,'SB','Siswa mulai menunjukkan ketertarikan dalam eksplorasi, tetapi masih membutuhkan bimbingan untuk menjelajahi lebih jauh. Mereka mencoba mengikuti aktivitas tetapi dengan rasa percaya diri yang rendah.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(71,'4d4c681a-0934-11f0-a867-0242ac140002',39,3.00,'BSH','Siswa aktif berpartisipasi dalam pembelajaran eksplorasi. Mereka menunjukkan rasa ingin tahu yang tinggi, mampu mengeksplorasi ide-ide baru, dan berkolaborasi dengan teman-temannya.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(72,'4d4c99a2-0934-11f0-a059-0242ac140002',39,4.00,'BSB','Siswa menunjukkan sikap eksploratif yang sangat baik, mengajukan pertanyaan yang mendalam, dan mampu membuat hubungan antara berbagai konsep. Mereka berinovasi dan berbagi hasil eksplorasi mereka dengan percaya diri.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(73,'4d4d1fa8-0934-11f0-a28a-0242ac140002',40,1.00,'MB','Siswa tampak ragu dan tidak menunjukkan minat dalam pembelajaran eksplorasi. Mereka sulit beradaptasi dengan kegiatan yang diberikan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(74,'4d4d49ce-0934-11f0-b446-0242ac140002',40,2.00,'SB','Siswa mulai menunjukkan ketertarikan dalam eksplorasi, tetapi masih membutuhkan bimbingan untuk menjelajahi lebih jauh. Mereka mencoba mengikuti aktivitas tetapi dengan rasa percaya diri yang rendah.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(75,'4d4d6fb2-0934-11f0-840b-0242ac140002',40,3.00,'BSH','Siswa aktif berpartisipasi dalam pembelajaran eksplorasi. Mereka menunjukkan rasa ingin tahu yang tinggi, mampu mengeksplorasi ide-ide baru, dan berkolaborasi dengan teman-temannya.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(76,'4d4da400-0934-11f0-af6e-0242ac140002',40,4.00,'BSB','Siswa menunjukkan sikap eksploratif yang sangat baik, mengajukan pertanyaan yang mendalam, dan mampu membuat hubungan antara berbagai konsep. Mereka berinovasi dan berbagi hasil eksplorasi mereka dengan percaya diri.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(77,'4d4fa174-0934-11f0-97c7-0242ac140002',42,1.00,'MB','Peserta didik masih membutuhkan bimbingan / arahan untuk memunculkan inisiatif, rasa tanggung jawab, bergotong royong, mengenal kebhinekaan global, dan berfikir kritis dalam memulai proyek ini.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(78,'4d4fd6f8-0934-11f0-9ff4-0242ac140002',42,2.00,'SB','Peserta didik sedang berkembang dalam mengamati, menganalisa sederhana, menguji ide yang diutarakan, menciptakan produk, hingga merefelksikan kegiatan. Peserta didik perlu diberi pertanyaan pemantik yang membantu mengarahkannya kepada kesimpulan yang ia ciptakan.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(79,'4d5079a0-0934-11f0-ae57-0242ac140002',42,3.00,'BSH','Peserta didik berkembang sesuai harapan dalam mengamati, menganalisa, mengutarakan pendapat, menciptakan produk, mengujinya dan merefleksikan kembali proyek tersebut secara mandiri dan tanpa arahan/bimbingan dari guru.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(80,'4d509ef8-0934-11f0-99c5-0242ac140002',42,4.00,'BSB','Peserta didik berkembang sangat baik dalam menyelesaikan rangkaian proyek ini, dan ananda melakukannya secara mandiri, inisiatif, dan bertanggung jawab. Mampu memcerminkan dimensi Profil Pelajar Pancasila yang sedang dipelajari.','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(81,'4d5bb130-0934-11f0-9a10-0242ac140002',43,80.00,'BSB','Siswa berkembang sangat baik dalam','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(82,'4d5bd44e-0934-11f0-8bfb-0242ac140002',43,70.00,'SB','Siswa sangat berkembang dalam','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(83,'4d5ca478-0934-11f0-80e3-0242ac140002',44,80.00,'BSB','Siswa berkembang sangat baik dalam','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(84,'4d5cdc22-0934-11f0-af0f-0242ac140002',44,70.00,'SB','Siswa sangat berkembang dalam','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(85,'4d5e17ae-0934-11f0-bccc-0242ac140002',45,80.00,'BSB','Siswa berkembang sangat baik dalam','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(86,'4d5ecad2-0934-11f0-8052-0242ac140002',45,70.00,'SB','Siswa sangat berkembang dalam','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(87,'4d612a98-0934-11f0-8b90-0242ac140002',46,80.00,'BSB','Siswa berkembang sangat baik dalam','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(88,'4d61d416-0934-11f0-8150-0242ac140002',46,70.00,'SB','Siswa sangat berkembang dalam','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(89,'4d643cce-0934-11f0-8f89-0242ac140002',47,80.00,'BSB','Siswa berkembang sangat baik dalam','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(90,'4d64e3d6-0934-11f0-8b7d-0242ac140002',47,70.00,'SB','Siswa sangat berkembang dalam','2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(91,'4d6731ae-0934-11f0-9046-0242ac140002',48,80.00,'BSB','Siswa berkembang sangat baik dalam','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(92,'4d6783de-0934-11f0-b919-0242ac140002',48,70.00,'SB','Siswa sangat berkembang dalam','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(93,'4d833dc2-0934-11f0-a7f9-0242ac140002',49,92.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(94,'4d8365ae-0934-11f0-8b1f-0242ac140002',49,82.00,'B','Siswa dengan baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(95,'4d8393a8-0934-11f0-a752-0242ac140002',49,75.00,'C','Siswa cukup baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(96,'4d842c64-0934-11f0-9476-0242ac140002',50,92.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(97,'4d844d70-0934-11f0-a9bc-0242ac140002',50,82.00,'B','Siswa dengan baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(98,'4d84769c-0934-11f0-97c2-0242ac140002',50,75.00,'C','Siswa cukup baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(99,'4d8551de-0934-11f0-99ec-0242ac140002',51,92.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(100,'4d858bc2-0934-11f0-a3f2-0242ac140002',51,82.00,'B','Siswa dengan baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(101,'4d85b124-0934-11f0-a84a-0242ac140002',51,75.00,'C','Siswa cukup baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(102,'4d8664a2-0934-11f0-80b1-0242ac140002',52,92.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(103,'4d8696de-0934-11f0-bb1f-0242ac140002',52,82.00,'B','Siswa dengan baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(104,'4d86bb32-0934-11f0-be42-0242ac140002',52,75.00,'C','Siswa cukup baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(105,'4d876d02-0934-11f0-beab-0242ac140002',53,92.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(106,'4d879250-0934-11f0-94d5-0242ac140002',53,82.00,'B','Siswa dengan baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(107,'4d87b4c4-0934-11f0-a97e-0242ac140002',53,75.00,'C','Siswa cukup baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(108,'4d887e72-0934-11f0-952b-0242ac140002',54,92.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(109,'4d88a24e-0934-11f0-baa5-0242ac140002',54,82.00,'B','Siswa dengan baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(110,'4d88c47c-0934-11f0-998e-0242ac140002',54,75.00,'C','Siswa cukup baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(111,'4d897336-0934-11f0-9c6e-0242ac140002',55,92.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(112,'4d89ae82-0934-11f0-9899-0242ac140002',55,82.00,'B','Siswa dengan baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(113,'4d89dfce-0934-11f0-978f-0242ac140002',55,75.00,'C','Siswa cukup baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(114,'4d8a93e2-0934-11f0-8dcd-0242ac140002',56,92.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(115,'4d8abd7c-0934-11f0-bb68-0242ac140002',56,82.00,'B','Siswa dengan baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(116,'4d8ae22a-0934-11f0-96f9-0242ac140002',56,75.00,'C','Siswa cukup baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(117,'4d8b9da0-0934-11f0-b141-0242ac140002',57,92.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(118,'4d8bc2c6-0934-11f0-a950-0242ac140002',57,82.00,'B','Siswa dengan baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(119,'4d8beca6-0934-11f0-afe8-0242ac140002',57,75.00,'C','Siswa cukup baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(120,'4d8cb190-0934-11f0-8098-0242ac140002',58,92.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(121,'4d8cd83c-0934-11f0-826b-0242ac140002',58,82.00,'B','Siswa dengan baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(122,'4d8d0582-0934-11f0-b8f6-0242ac140002',58,75.00,'C','Siswa cukup baik','2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(123,'4e1ef99c-0934-11f0-927f-0242ac140002',59,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(124,'4e1f3ccc-0934-11f0-8e9d-0242ac140002',59,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(125,'4e1f73b8-0934-11f0-b1ad-0242ac140002',59,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(126,'4e1fa716-0934-11f0-96cd-0242ac140002',59,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(127,'4e2086ae-0934-11f0-a9ee-0242ac140002',60,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(128,'4e20b174-0934-11f0-aa83-0242ac140002',60,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(129,'4e20d4ba-0934-11f0-9ea2-0242ac140002',60,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(130,'4e212dd4-0934-11f0-bf48-0242ac140002',60,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(131,'4e21dac2-0934-11f0-b9eb-0242ac140002',61,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(132,'4e21fe30-0934-11f0-93cb-0242ac140002',61,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(133,'4e223062-0934-11f0-8851-0242ac140002',61,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(134,'4e225aba-0934-11f0-b508-0242ac140002',61,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(135,'4e231888-0934-11f0-83e0-0242ac140002',62,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(136,'4e2341b4-0934-11f0-9db5-0242ac140002',62,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(137,'4e23749a-0934-11f0-bbcc-0242ac140002',62,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(138,'4e23a794-0934-11f0-80dd-0242ac140002',62,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(139,'4e2459e6-0934-11f0-b031-0242ac140002',63,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(140,'4e248a42-0934-11f0-bb1f-0242ac140002',63,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(141,'4e24afae-0934-11f0-a423-0242ac140002',63,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(142,'4e24d3da-0934-11f0-9a31-0242ac140002',63,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(143,'4e25ab3e-0934-11f0-9464-0242ac140002',64,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(144,'4e25d0aa-0934-11f0-abf3-0242ac140002',64,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(145,'4e262046-0934-11f0-91a5-0242ac140002',64,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(146,'4e26575a-0934-11f0-9b01-0242ac140002',64,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(147,'4e274c78-0934-11f0-b04c-0242ac140002',65,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(148,'4e277072-0934-11f0-bc32-0242ac140002',65,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(149,'4e279b1a-0934-11f0-90e0-0242ac140002',65,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(150,'4e27cf72-0934-11f0-b751-0242ac140002',65,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(151,'4e28a866-0934-11f0-8f3a-0242ac140002',66,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(152,'4e295be4-0934-11f0-9757-0242ac140002',66,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(153,'4e298254-0934-11f0-b824-0242ac140002',66,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(154,'4e29a716-0934-11f0-a25f-0242ac140002',66,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(155,'4e2a7f2e-0934-11f0-b777-0242ac140002',67,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(156,'4e2aa40e-0934-11f0-b113-0242ac140002',67,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(157,'4e2ac808-0934-11f0-b667-0242ac140002',67,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(158,'4e2b11aa-0934-11f0-94e1-0242ac140002',67,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(159,'4e2bbc9a-0934-11f0-9ee8-0242ac140002',68,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(160,'4e2bdf54-0934-11f0-986c-0242ac140002',68,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(161,'4e2c146a-0934-11f0-a81c-0242ac140002',68,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(162,'4e2c3c74-0934-11f0-b71b-0242ac140002',68,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(163,'4e2cffe2-0934-11f0-9acd-0242ac140002',69,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(164,'4e2d29d6-0934-11f0-bd33-0242ac140002',69,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(165,'4e2d5988-0934-11f0-aff7-0242ac140002',69,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(166,'4e2d7d78-0934-11f0-8d59-0242ac140002',69,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(167,'4e2e53ec-0934-11f0-b938-0242ac140002',70,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(168,'4e2e7eee-0934-11f0-858d-0242ac140002',70,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(169,'4e2ebda0-0934-11f0-bb0c-0242ac140002',70,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(170,'4e2f23d0-0934-11f0-8188-0242ac140002',70,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(171,'4e2fd5fa-0934-11f0-a9b3-0242ac140002',71,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(172,'4e300c14-0934-11f0-af76-0242ac140002',71,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(173,'4e30410c-0934-11f0-9dd1-0242ac140002',71,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(174,'4e3070a0-0934-11f0-ae1b-0242ac140002',71,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(175,'4e3135a8-0934-11f0-b115-0242ac140002',72,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(176,'4e31707c-0934-11f0-bc2b-0242ac140002',72,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(177,'4e319aac-0934-11f0-9115-0242ac140002',72,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(178,'4e31c586-0934-11f0-8d6c-0242ac140002',72,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(179,'4e32b162-0934-11f0-adf9-0242ac140002',73,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(180,'4e32f618-0934-11f0-a1c5-0242ac140002',73,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(181,'4e332dae-0934-11f0-b45c-0242ac140002',73,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(182,'4e3361c0-0934-11f0-8b8d-0242ac140002',73,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(183,'4e343514-0934-11f0-86f4-0242ac140002',74,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(184,'4e345ddc-0934-11f0-af9a-0242ac140002',74,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(185,'4e3482c6-0934-11f0-821e-0242ac140002',74,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(186,'4e34c3a8-0934-11f0-96c4-0242ac140002',74,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(187,'4e359120-0934-11f0-b048-0242ac140002',75,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(188,'4e35b98e-0934-11f0-a06e-0242ac140002',75,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(189,'4e35eb5c-0934-11f0-b199-0242ac140002',75,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(190,'4e36141a-0934-11f0-b459-0242ac140002',75,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(191,'4e36e7d2-0934-11f0-b4f6-0242ac140002',76,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(192,'4e370fdc-0934-11f0-abfc-0242ac140002',76,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(193,'4e3733b8-0934-11f0-872e-0242ac140002',76,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(194,'4e376130-0934-11f0-a3ea-0242ac140002',76,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(195,'4e383b3c-0934-11f0-9b08-0242ac140002',77,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(196,'4e386b66-0934-11f0-8c36-0242ac140002',77,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(197,'4e38912c-0934-11f0-9d4e-0242ac140002',77,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(198,'4e38b4b8-0934-11f0-b0c8-0242ac140002',77,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(199,'4e399cf2-0934-11f0-91c3-0242ac140002',78,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(200,'4e39c722-0934-11f0-97bd-0242ac140002',78,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(201,'4e39fec2-0934-11f0-8bde-0242ac140002',78,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(202,'4e3a2672-0934-11f0-a0dd-0242ac140002',78,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(203,'4e3af660-0934-11f0-aac4-0242ac140002',79,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(204,'4e3b2e5a-0934-11f0-a413-0242ac140002',79,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(205,'4e3b57d6-0934-11f0-8dfc-0242ac140002',79,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(206,'4e3b7c84-0934-11f0-9430-0242ac140002',79,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(207,'4e3c995c-0934-11f0-b850-0242ac140002',80,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(208,'4e3cd282-0934-11f0-8216-0242ac140002',80,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(209,'4e3d1896-0934-11f0-8941-0242ac140002',80,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(210,'4e3d4528-0934-11f0-a888-0242ac140002',80,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(211,'4e3e038c-0934-11f0-91e9-0242ac140002',81,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(212,'4e3e317c-0934-11f0-bc4a-0242ac140002',81,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(213,'4e3e5e22-0934-11f0-b279-0242ac140002',81,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(214,'4e3e8c94-0934-11f0-8e61-0242ac140002',81,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(215,'4e3f41fc-0934-11f0-904f-0242ac140002',82,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(216,'4e3f721c-0934-11f0-9fc0-0242ac140002',82,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(217,'4e3fae62-0934-11f0-b4ba-0242ac140002',82,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(218,'4e3ff052-0934-11f0-82e3-0242ac140002',82,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(219,'4e40c806-0934-11f0-a67c-0242ac140002',83,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(220,'4e40f894-0934-11f0-948f-0242ac140002',83,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(221,'4e41268e-0934-11f0-ae33-0242ac140002',83,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(222,'4e414cfe-0934-11f0-b538-0242ac140002',83,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(223,'4e421be8-0934-11f0-8f9e-0242ac140002',84,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(224,'4e4248f2-0934-11f0-afe0-0242ac140002',84,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(225,'4e426de6-0934-11f0-902c-0242ac140002',84,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(226,'4e429636-0934-11f0-adb3-0242ac140002',84,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(227,'4e4361ec-0934-11f0-a89a-0242ac140002',85,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(228,'4e4388fc-0934-11f0-9e78-0242ac140002',85,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(229,'4e43bb60-0934-11f0-b9d3-0242ac140002',85,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(230,'4e43e202-0934-11f0-a41e-0242ac140002',85,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(231,'4e44bb6e-0934-11f0-b0ed-0242ac140002',86,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(232,'4e44f7be-0934-11f0-8446-0242ac140002',86,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(233,'4e4528ec-0934-11f0-8cc6-0242ac140002',86,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(234,'4e45502e-0934-11f0-8ffa-0242ac140002',86,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(235,'4e461e5a-0934-11f0-9f76-0242ac140002',87,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(236,'4e464628-0934-11f0-9f4c-0242ac140002',87,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(237,'4e466a2c-0934-11f0-9ee3-0242ac140002',87,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(238,'4e46a46a-0934-11f0-881e-0242ac140002',87,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(239,'4e4764e0-0934-11f0-ab6d-0242ac140002',88,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(240,'4e479302-0934-11f0-8260-0242ac140002',88,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(241,'4e47c674-0934-11f0-8516-0242ac140002',88,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(242,'4e47f6c6-0934-11f0-95b2-0242ac140002',88,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(243,'4e48b430-0934-11f0-b463-0242ac140002',89,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(244,'4e48e6bc-0934-11f0-9aa7-0242ac140002',89,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(245,'4e4914fc-0934-11f0-9b70-0242ac140002',89,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(246,'4e493dce-0934-11f0-86da-0242ac140002',89,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(247,'4e4a24fa-0934-11f0-8d6a-0242ac140002',90,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(248,'4e4a4f3e-0934-11f0-addd-0242ac140002',90,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(249,'4e4a72de-0934-11f0-ab99-0242ac140002',90,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(250,'4e4aa092-0934-11f0-b081-0242ac140002',90,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(251,'4e4b4d6c-0934-11f0-862f-0242ac140002',91,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(252,'4e4b7d5a-0934-11f0-b7c6-0242ac140002',91,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(253,'4e4bb2f2-0934-11f0-acc3-0242ac140002',91,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(254,'4e4bddea-0934-11f0-a9d9-0242ac140002',91,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(255,'4e4c9ece-0934-11f0-b276-0242ac140002',92,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(256,'4e4cd308-0934-11f0-a3ac-0242ac140002',92,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(257,'4e4cff5e-0934-11f0-8351-0242ac140002',92,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(258,'4e4d30aa-0934-11f0-97ce-0242ac140002',92,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(259,'4e4de1d0-0934-11f0-88ad-0242ac140002',93,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(260,'4e4e0570-0934-11f0-8701-0242ac140002',93,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(261,'4e4e2aa0-0934-11f0-b7f8-0242ac140002',93,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(262,'4e4e4dd2-0934-11f0-910e-0242ac140002',93,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(263,'4e4f1b40-0934-11f0-ad20-0242ac140002',94,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(264,'4e4f435e-0934-11f0-86b3-0242ac140002',94,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(265,'4e4f674e-0934-11f0-b556-0242ac140002',94,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(266,'4e4f9cf0-0934-11f0-947f-0242ac140002',94,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(267,'4e507846-0934-11f0-941a-0242ac140002',95,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(268,'4e50a3a2-0934-11f0-9233-0242ac140002',95,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(269,'4e50c9b8-0934-11f0-a343-0242ac140002',95,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(270,'4e50ed6c-0934-11f0-9346-0242ac140002',95,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(271,'4e51a126-0934-11f0-b166-0242ac140002',96,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(272,'4e51c52a-0934-11f0-8145-0242ac140002',96,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(273,'4e51faea-0934-11f0-ae86-0242ac140002',96,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(274,'4e522146-0934-11f0-9c2d-0242ac140002',96,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(275,'4e52e356-0934-11f0-a8cb-0242ac140002',97,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(276,'4e530976-0934-11f0-a3b4-0242ac140002',97,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(277,'4e533bc6-0934-11f0-ba0c-0242ac140002',97,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(278,'4e536998-0934-11f0-8507-0242ac140002',97,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(279,'4e542504-0934-11f0-812b-0242ac140002',98,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(280,'4e5449b2-0934-11f0-b7f9-0242ac140002',98,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(281,'4e54750e-0934-11f0-85cd-0242ac140002',98,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(282,'4e549a2a-0934-11f0-ad6c-0242ac140002',98,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(283,'4e5571e8-0934-11f0-8acf-0242ac140002',99,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(284,'4e55a172-0934-11f0-a4fc-0242ac140002',99,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(285,'4e55c76a-0934-11f0-87df-0242ac140002',99,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(286,'4e55ec36-0934-11f0-864f-0242ac140002',99,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(287,'4e56dd08-0934-11f0-856d-0242ac140002',100,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(288,'4e570396-0934-11f0-a073-0242ac140002',100,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(289,'4e57290c-0934-11f0-870c-0242ac140002',100,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(290,'4e574e96-0934-11f0-9aca-0242ac140002',100,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(291,'4e580b24-0934-11f0-9253-0242ac140002',101,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(292,'4e583a36-0934-11f0-9f77-0242ac140002',101,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(293,'4e5881ee-0934-11f0-b26b-0242ac140002',101,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(294,'4e58bcc2-0934-11f0-b28b-0242ac140002',101,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(295,'4e59a920-0934-11f0-b629-0242ac140002',102,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(296,'4e59d1f2-0934-11f0-aab6-0242ac140002',102,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(297,'4e5a02bc-0934-11f0-84dd-0242ac140002',102,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(298,'4e5a35fc-0934-11f0-98eb-0242ac140002',102,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(299,'4e5b27b4-0934-11f0-a393-0242ac140002',103,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(300,'4e5b5b08-0934-11f0-b53d-0242ac140002',103,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(301,'4e5b84d4-0934-11f0-8529-0242ac140002',103,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(302,'4e5bbe40-0934-11f0-a18b-0242ac140002',103,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(303,'4e5cab16-0934-11f0-9207-0242ac140002',104,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(304,'4e5ce766-0934-11f0-b116-0242ac140002',104,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(305,'4e5d1ed4-0934-11f0-82f3-0242ac140002',104,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(306,'4e5d5bf6-0934-11f0-a817-0242ac140002',104,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(307,'4e5e26b2-0934-11f0-99ab-0242ac140002',105,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(308,'4e5e5ed4-0934-11f0-9c94-0242ac140002',105,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(309,'4e5e897c-0934-11f0-95dd-0242ac140002',105,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(310,'4e5eb58c-0934-11f0-9dcf-0242ac140002',105,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(311,'4e5f7d00-0934-11f0-81da-0242ac140002',106,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(312,'4e5fa08c-0934-11f0-8702-0242ac140002',106,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(313,'4e5fc512-0934-11f0-ac78-0242ac140002',106,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(314,'4e5ff9c4-0934-11f0-aff6-0242ac140002',106,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(315,'4e613500-0934-11f0-b73a-0242ac140002',107,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(316,'4e616976-0934-11f0-8a83-0242ac140002',107,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(317,'4e61a288-0934-11f0-a9f5-0242ac140002',107,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(318,'4e61ccd6-0934-11f0-b67b-0242ac140002',107,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(319,'4e628da6-0934-11f0-8104-0242ac140002',108,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(320,'4e62ceb0-0934-11f0-9f62-0242ac140002',108,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(321,'4e62faf2-0934-11f0-8fae-0242ac140002',108,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(322,'4e632284-0934-11f0-814d-0242ac140002',108,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(323,'4e64596a-0934-11f0-839d-0242ac140002',109,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(324,'4e647f6c-0934-11f0-b762-0242ac140002',109,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(325,'4e64a302-0934-11f0-864f-0242ac140002',109,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(326,'4e64c6ac-0934-11f0-9461-0242ac140002',109,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(327,'4e659032-0934-11f0-89b2-0242ac140002',110,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(328,'4e65b634-0934-11f0-b229-0242ac140002',110,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(329,'4e65ddb2-0934-11f0-9882-0242ac140002',110,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(330,'4e660a44-0934-11f0-ad77-0242ac140002',110,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(331,'4e66d3fc-0934-11f0-b569-0242ac140002',111,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(332,'4e670c78-0934-11f0-acd6-0242ac140002',111,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(333,'4e675804-0934-11f0-85e7-0242ac140002',111,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(334,'4e678cca-0934-11f0-a1a8-0242ac140002',111,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(335,'4e6868fc-0934-11f0-a4cf-0242ac140002',112,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(336,'4e68966a-0934-11f0-ad5f-0242ac140002',112,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(337,'4e68cab8-0934-11f0-a425-0242ac140002',112,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(338,'4e68f20e-0934-11f0-91e3-0242ac140002',112,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(339,'4e6a153a-0934-11f0-ade5-0242ac140002',113,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(340,'4e6a5ca2-0934-11f0-bffe-0242ac140002',113,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(341,'4e6a8b46-0934-11f0-afbd-0242ac140002',113,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(342,'4e6ab012-0934-11f0-97d8-0242ac140002',113,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(343,'4e6b7b96-0934-11f0-82b2-0242ac140002',114,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(344,'4e6bb1ec-0934-11f0-9e13-0242ac140002',114,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(345,'4e6beb4e-0934-11f0-bb16-0242ac140002',114,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(346,'4e6c2208-0934-11f0-9361-0242ac140002',114,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(347,'4e6d19ce-0934-11f0-a263-0242ac140002',115,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(348,'4e6d5434-0934-11f0-8271-0242ac140002',115,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(349,'4e6d8490-0934-11f0-8453-0242ac140002',115,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(350,'4e6db352-0934-11f0-beb0-0242ac140002',115,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(351,'4e6e9de4-0934-11f0-9245-0242ac140002',116,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(352,'4e6ed368-0934-11f0-9738-0242ac140002',116,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(353,'4e6f0ae0-0934-11f0-8d2e-0242ac140002',116,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(354,'4e6f432a-0934-11f0-a778-0242ac140002',116,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(355,'4e7028b2-0934-11f0-b120-0242ac140002',117,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(356,'4e705a62-0934-11f0-98b9-0242ac140002',117,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(357,'4e708528-0934-11f0-bd28-0242ac140002',117,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(358,'4e70acba-0934-11f0-ae71-0242ac140002',117,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(359,'4e717f8c-0934-11f0-aeef-0242ac140002',118,80.00,'A','Siswa sangat baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(360,'4e71b196-0934-11f0-8d53-0242ac140002',118,75.00,'B','Siswa baik dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(361,'4e71e828-0934-11f0-8452-0242ac140002',118,70.00,'C','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(362,'4e721e10-0934-11f0-b026-0242ac140002',118,60.00,'D','Siswa menunjukkan perkembangan dalam','2025-03-25 04:47:50','2025-03-25 04:47:50',NULL);
/*!40000 ALTER TABLE `subject_threshold_scales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject_thresholds`
--

DROP TABLE IF EXISTS `subject_thresholds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subject_thresholds` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_subject_id` bigint(20) unsigned NOT NULL,
  `school_year_id` bigint(20) unsigned DEFAULT NULL,
  `school_grade_id` bigint(20) unsigned DEFAULT NULL,
  `minimum_value` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subject_thresholds_uuid_unique` (`uuid`),
  KEY `subject_thresholds_school_subject_id_foreign` (`school_subject_id`),
  KEY `subject_thresholds_school_year_id_foreign` (`school_year_id`),
  KEY `subject_thresholds_school_grade_id_foreign` (`school_grade_id`),
  CONSTRAINT `subject_thresholds_school_grade_id_foreign` FOREIGN KEY (`school_grade_id`) REFERENCES `school_grades` (`id`),
  CONSTRAINT `subject_thresholds_school_subject_id_foreign` FOREIGN KEY (`school_subject_id`) REFERENCES `school_subjects` (`id`),
  CONSTRAINT `subject_thresholds_school_year_id_foreign` FOREIGN KEY (`school_year_id`) REFERENCES `school_years` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject_thresholds`
--

LOCK TABLES `subject_thresholds` WRITE;
/*!40000 ALTER TABLE `subject_thresholds` DISABLE KEYS */;
INSERT INTO `subject_thresholds` VALUES (1,'4d2d9796-0934-11f0-8a20-0242ac140002',2,1,1,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(2,'4d2dff38-0934-11f0-95bd-0242ac140002',2,1,2,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(3,'4d2e5d84-0934-11f0-b07b-0242ac140002',2,1,3,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(4,'4d2ec256-0934-11f0-bccd-0242ac140002',2,1,4,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(5,'4d30cad8-0934-11f0-aeb0-0242ac140002',4,1,1,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(6,'4d312ae6-0934-11f0-9363-0242ac140002',4,1,2,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(7,'4d318266-0934-11f0-8e8a-0242ac140002',4,1,3,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(8,'4d31d630-0934-11f0-bb5b-0242ac140002',4,1,4,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(9,'4d3301f4-0934-11f0-9880-0242ac140002',3,1,1,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(10,'4d3366bc-0934-11f0-a072-0242ac140002',3,1,2,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(11,'4d3447f8-0934-11f0-a142-0242ac140002',3,1,3,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(12,'4d350152-0934-11f0-b171-0242ac140002',3,1,4,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(13,'4d36f4e4-0934-11f0-b4c5-0242ac140002',6,1,1,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(14,'4d375704-0934-11f0-aab7-0242ac140002',6,1,2,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(15,'4d37afb0-0934-11f0-92f0-0242ac140002',6,1,3,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(16,'4d3803ac-0934-11f0-8e5a-0242ac140002',6,1,4,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(17,'4d393f92-0934-11f0-a7e6-0242ac140002',8,1,1,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(18,'4d39a0e0-0934-11f0-a932-0242ac140002',8,1,2,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(19,'4d39f7de-0934-11f0-b748-0242ac140002',8,1,3,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(20,'4d3a6070-0934-11f0-8521-0242ac140002',8,1,4,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(21,'4d3b8e8c-0934-11f0-a9e7-0242ac140002',9,1,1,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(22,'4d3c129e-0934-11f0-9bdd-0242ac140002',9,1,2,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(23,'4d3c7626-0934-11f0-b560-0242ac140002',9,1,3,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(24,'4d3cde0e-0934-11f0-9226-0242ac140002',9,1,4,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(25,'4d3e0f54-0934-11f0-87c5-0242ac140002',7,1,1,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(26,'4d3e633c-0934-11f0-afde-0242ac140002',7,1,2,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(27,'4d3ebe9a-0934-11f0-a71f-0242ac140002',7,1,3,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(28,'4d3f2074-0934-11f0-8421-0242ac140002',7,1,4,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(29,'4d402c94-0934-11f0-b498-0242ac140002',10,1,1,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(30,'4d413738-0934-11f0-bd8b-0242ac140002',10,1,2,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(31,'4d424a56-0934-11f0-8dcb-0242ac140002',10,1,3,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(32,'4d43758e-0934-11f0-b29f-0242ac140002',10,1,4,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(33,'4d44a7e2-0934-11f0-b3da-0242ac140002',11,1,1,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(34,'4d460466-0934-11f0-ab41-0242ac140002',11,1,2,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(35,'4d46fcfe-0934-11f0-ad8c-0242ac140002',11,1,3,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(36,'4d481f94-0934-11f0-89c3-0242ac140002',11,1,4,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(37,'4d4986ae-0934-11f0-8e8e-0242ac140002',12,1,1,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(38,'4d4aa17e-0934-11f0-abbf-0242ac140002',12,1,2,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(39,'4d4bcaf4-0934-11f0-ae7d-0242ac140002',12,1,3,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(40,'4d4cfafa-0934-11f0-bab4-0242ac140002',12,1,4,1.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(41,'4d4e26c8-0934-11f0-b3b7-0242ac140002',5,1,4,0.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(42,'4d4f7064-0934-11f0-963b-0242ac140002',13,1,4,0.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(43,'4d5b8ac0-0934-11f0-8329-0242ac140002',14,5,5,60.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(44,'4d5c77c8-0934-11f0-ac98-0242ac140002',14,5,6,60.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(45,'4d5d9b3a-0934-11f0-a2cb-0242ac140002',14,5,7,60.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(46,'4d60cc06-0934-11f0-84e8-0242ac140002',14,5,8,60.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(47,'4d639b70-0934-11f0-b95a-0242ac140002',14,5,9,60.00,'2025-03-25 04:47:48','2025-03-25 04:47:48',NULL),(48,'4d669924-0934-11f0-bbe6-0242ac140002',14,5,10,60.00,'2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(49,'4d831040-0934-11f0-96b1-0242ac140002',27,1,11,75.00,'2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(50,'4d840950-0934-11f0-a100-0242ac140002',28,1,11,75.00,'2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(51,'4d850f62-0934-11f0-9dfc-0242ac140002',29,1,11,75.00,'2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(52,'4d8633ce-0934-11f0-89a8-0242ac140002',30,1,11,75.00,'2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(53,'4d873008-0934-11f0-84c6-0242ac140002',31,1,11,75.00,'2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(54,'4d88579e-0934-11f0-a2cd-0242ac140002',32,1,11,75.00,'2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(55,'4d894082-0934-11f0-87d1-0242ac140002',33,1,11,75.00,'2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(56,'4d8a68e0-0934-11f0-992a-0242ac140002',34,1,11,75.00,'2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(57,'4d8b764a-0934-11f0-83d7-0242ac140002',35,1,11,75.00,'2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(58,'4d8c7e32-0934-11f0-9898-0242ac140002',36,1,11,75.00,'2025-03-25 04:47:49','2025-03-25 04:47:49',NULL),(59,'4e1eb7de-0934-11f0-aad0-0242ac140002',37,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(60,'4e205d8c-0934-11f0-9034-0242ac140002',37,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(61,'4e21b5b0-0934-11f0-9d2f-0242ac140002',37,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(62,'4e22ee76-0934-11f0-870b-0242ac140002',38,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(63,'4e242926-0934-11f0-b07f-0242ac140002',38,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(64,'4e257506-0934-11f0-b8d0-0242ac140002',38,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(65,'4e2724fa-0934-11f0-b1b2-0242ac140002',39,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(66,'4e286bee-0934-11f0-bbc1-0242ac140002',39,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(67,'4e2a5918-0934-11f0-9986-0242ac140002',39,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(68,'4e2b97ba-0934-11f0-8cbc-0242ac140002',40,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(69,'4e2ccf9a-0934-11f0-809c-0242ac140002',40,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(70,'4e2e1be8-0934-11f0-b53b-0242ac140002',40,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(71,'4e2f9d6a-0934-11f0-b1bf-0242ac140002',41,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(72,'4e310a74-0934-11f0-b15b-0242ac140002',41,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(73,'4e328250-0934-11f0-9634-0242ac140002',41,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(74,'4e340468-0934-11f0-a48c-0242ac140002',42,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(75,'4e35697a-0934-11f0-a9e9-0242ac140002',42,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(76,'4e36b3ca-0934-11f0-8688-0242ac140002',42,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(77,'4e380ce8-0934-11f0-8336-0242ac140002',43,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(78,'4e396156-0934-11f0-8eec-0242ac140002',43,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(79,'4e3aca8c-0934-11f0-988a-0242ac140002',43,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(80,'4e3c69fa-0934-11f0-b4c5-0242ac140002',44,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(81,'4e3ddaba-0934-11f0-b4f9-0242ac140002',44,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(82,'4e3f1c36-0934-11f0-a2df-0242ac140002',44,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(83,'4e4094c6-0934-11f0-a0f2-0242ac140002',45,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(84,'4e41f208-0934-11f0-b82c-0242ac140002',45,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(85,'4e432538-0934-11f0-997f-0242ac140002',45,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(86,'4e447636-0934-11f0-88de-0242ac140002',46,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(87,'4e45f7a4-0934-11f0-8ad9-0242ac140002',46,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(88,'4e473f88-0934-11f0-824c-0242ac140002',46,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(89,'4e488118-0934-11f0-9d45-0242ac140002',47,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(90,'4e49f660-0934-11f0-aa6b-0242ac140002',47,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(91,'4e4b27e2-0934-11f0-aa67-0242ac140002',47,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(92,'4e4c63be-0934-11f0-a8d8-0242ac140002',48,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(93,'4e4dbad4-0934-11f0-9f11-0242ac140002',48,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(94,'4e4ef066-0934-11f0-8988-0242ac140002',48,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(95,'4e504704-0934-11f0-8385-0242ac140002',49,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(96,'4e5178ae-0934-11f0-9e0a-0242ac140002',49,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(97,'4e52b926-0934-11f0-9828-0242ac140002',49,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(98,'4e53ffde-0934-11f0-9af0-0242ac140002',50,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(99,'4e5538b8-0934-11f0-9e53-0242ac140002',50,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(100,'4e56a22a-0934-11f0-928f-0242ac140002',50,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(101,'4e57e608-0934-11f0-956d-0242ac140002',51,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(102,'4e59754a-0934-11f0-980f-0242ac140002',51,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(103,'4e5aef24-0934-11f0-bcdb-0242ac140002',51,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(104,'4e5c6c5a-0934-11f0-bcca-0242ac140002',52,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(105,'4e5e0182-0934-11f0-a738-0242ac140002',52,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(106,'4e5f567c-0934-11f0-963b-0242ac140002',52,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(107,'4e60f75c-0934-11f0-a3b1-0242ac140002',53,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(108,'4e625dea-0934-11f0-9460-0242ac140002',53,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(109,'4e642d8c-0934-11f0-b4cb-0242ac140002',53,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(110,'4e6561ca-0934-11f0-ba24-0242ac140002',54,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(111,'4e669888-0934-11f0-88be-0242ac140002',54,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(112,'4e682a54-0934-11f0-99b0-0242ac140002',54,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(113,'4e69d48a-0934-11f0-abc3-0242ac140002',55,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(114,'4e6b512a-0934-11f0-a950-0242ac140002',55,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(115,'4e6cd04a-0934-11f0-b0b5-0242ac140002',55,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(116,'4e6e632e-0934-11f0-9f4a-0242ac140002',56,5,14,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(117,'4e6fee24-0934-11f0-b492-0242ac140002',56,5,15,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL),(118,'4e714dbe-0934-11f0-9ac5-0242ac140002',56,5,16,70.00,'2025-03-25 04:47:50','2025-03-25 04:47:50',NULL);
/*!40000 ALTER TABLE `subject_thresholds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_approval_delegates`
--

DROP TABLE IF EXISTS `submission_approval_delegates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submission_approval_delegates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_approver_id` bigint(20) unsigned NOT NULL,
  `delegate_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `submission_approval_delegates_uuid_unique` (`uuid`),
  KEY `submission_approval_delegates_submission_approver_id_foreign` (`submission_approver_id`),
  KEY `submission_approval_delegates_delegate_id_foreign` (`delegate_id`),
  CONSTRAINT `submission_approval_delegates_delegate_id_foreign` FOREIGN KEY (`delegate_id`) REFERENCES `employees` (`id`),
  CONSTRAINT `submission_approval_delegates_submission_approver_id_foreign` FOREIGN KEY (`submission_approver_id`) REFERENCES `submission_approvers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1299 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_approval_delegates`
--

LOCK TABLES `submission_approval_delegates` WRITE;
/*!40000 ALTER TABLE `submission_approval_delegates` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_approval_delegates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_approvals`
--

DROP TABLE IF EXISTS `submission_approvals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submission_approvals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint(20) unsigned NOT NULL,
  `approver_id` bigint(20) unsigned NOT NULL,
  `delegate_id` bigint(20) unsigned DEFAULT NULL,
  `is_delegated` tinyint(1) NOT NULL DEFAULT '0',
  `sort_number` int(11) NOT NULL,
  `datetime` datetime DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `submission_approvals_uuid_unique` (`uuid`),
  KEY `submission_approvals_submission_id_foreign` (`submission_id`),
  KEY `submission_approvals_approver_id_foreign` (`approver_id`),
  KEY `submission_approvals_delegate_id_foreign` (`delegate_id`),
  CONSTRAINT `submission_approvals_approver_id_foreign` FOREIGN KEY (`approver_id`) REFERENCES `employees` (`id`),
  CONSTRAINT `submission_approvals_delegate_id_foreign` FOREIGN KEY (`delegate_id`) REFERENCES `employees` (`id`),
  CONSTRAINT `submission_approvals_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_approvals`
--

LOCK TABLES `submission_approvals` WRITE;
/*!40000 ALTER TABLE `submission_approvals` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_approvals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_approvers`
--

DROP TABLE IF EXISTS `submission_approvers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submission_approvers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_group_id` bigint(20) unsigned NOT NULL,
  `area_id` bigint(20) unsigned NOT NULL,
  `approver_id` bigint(20) unsigned NOT NULL,
  `sort_number` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `submission_approvers_uuid_unique` (`uuid`),
  KEY `submission_approvers_submission_group_id_foreign` (`submission_group_id`),
  KEY `submission_approvers_area_id_foreign` (`area_id`),
  KEY `submission_approvers_approver_id_foreign` (`approver_id`),
  CONSTRAINT `submission_approvers_approver_id_foreign` FOREIGN KEY (`approver_id`) REFERENCES `employees` (`id`),
  CONSTRAINT `submission_approvers_area_id_foreign` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  CONSTRAINT `submission_approvers_submission_group_id_foreign` FOREIGN KEY (`submission_group_id`) REFERENCES `submission_groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_approvers`
--

LOCK TABLES `submission_approvers` WRITE;
/*!40000 ALTER TABLE `submission_approvers` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_approvers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_groups`
--

DROP TABLE IF EXISTS `submission_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submission_groups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_number` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `submission_groups_uuid_unique` (`uuid`),
  UNIQUE KEY `submission_groups_name_unique` (`name`),
  UNIQUE KEY `submission_groups_code_unique` (`code`),
  UNIQUE KEY `submission_groups_reference_code_unique` (`reference_code`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_groups`
--

LOCK TABLES `submission_groups` WRITE;
/*!40000 ALTER TABLE `submission_groups` DISABLE KEYS */;
INSERT INTO `submission_groups` VALUES (1,'bcb6224e-f594-11ef-8317-0200a013a61c','Install & Repair','INSTALL_REPAIR','IRP',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(2,'bcb6dd4c-f594-11ef-aaa5-0200a013a61c','Design','DESIGN','DSN',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(3,'bcb77928-f594-11ef-8a70-0200a013a61c','Documentation','DOCUMENTATION','DOC',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(4,'bcb7f254-f594-11ef-a4a0-0200a013a61c','Broadcast','BROADCAST','BRC',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(5,'bcb84f7e-f594-11ef-aa50-0200a013a61c','Media Post','MEDIA_POST','MDP',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(6,'bcb8e0a6-f594-11ef-b1a9-0200a013a61c','Card','CARD','CRD',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(7,'bcb94c80-f594-11ef-8ae3-0200a013a61c','Vehicle','VEHICLE','VHC',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(8,'bcb9b7ce-f594-11ef-b767-0200a013a61c','Material','MATERIAL','MTL',997,'2025-02-28 05:27:44','2025-03-16 06:09:35',NULL),(9,'bcba0f76-f594-11ef-a33d-0200a013a61c','Event','EVENT','EVT',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(10,'bcba7d9e-f594-11ef-b743-0200a013a61c','Attendance','ATTENDANCE','ATD',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(11,'bcbad294-f594-11ef-ad78-0200a013a61c','Equipment','EQUIPMENT','EQP',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(12,'bcbb2ca8-f594-11ef-aee4-0200a013a61c','Outstation','OUTSTATION','OTS',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(13,'bcbbba9c-f594-11ef-a731-0200a013a61c','Leave','LEAVE','LEV',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(14,'bcbc18de-f594-11ef-a2df-0200a013a61c','Training','TRAINING','TRN',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(15,'bcbd3700-f594-11ef-9ce4-0200a013a61c','Resignation','RESIGNATION','RSN',1,'2025-02-28 05:27:44','2025-02-28 05:27:44',NULL);
/*!40000 ALTER TABLE `submission_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submissions`
--

DROP TABLE IF EXISTS `submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_group_id` bigint(20) unsigned NOT NULL,
  `area_id` bigint(20) unsigned NOT NULL,
  `submitter_id` bigint(20) unsigned NOT NULL,
  `reference_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `datetime` datetime NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `submissions_uuid_unique` (`uuid`),
  UNIQUE KEY `submissions_reference_number_unique` (`reference_number`),
  KEY `submissions_submission_group_id_foreign` (`submission_group_id`),
  KEY `submissions_area_id_foreign` (`area_id`),
  KEY `submissions_submitter_id_foreign` (`submitter_id`),
  CONSTRAINT `submissions_area_id_foreign` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  CONSTRAINT `submissions_submission_group_id_foreign` FOREIGN KEY (`submission_group_id`) REFERENCES `submission_groups` (`id`),
  CONSTRAINT `submissions_submitter_id_foreign` FOREIGN KEY (`submitter_id`) REFERENCES `employees` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=997 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submissions`
--

LOCK TABLES `submissions` WRITE;
/*!40000 ALTER TABLE `submissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `submissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testimonials`
--

DROP TABLE IF EXISTS `testimonials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testimonials` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `relation` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `testimonials_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testimonials`
--

LOCK TABLES `testimonials` WRITE;
/*!40000 ALTER TABLE `testimonials` DISABLE KEYS */;
/*!40000 ALTER TABLE `testimonials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_records`
--

DROP TABLE IF EXISTS `training_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `training_records` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `institution` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `completion_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `training_records_uuid_unique` (`uuid`),
  KEY `training_records_profile_id_foreign` (`profile_id`),
  CONSTRAINT `training_records_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_records`
--

LOCK TABLES `training_records` WRITE;
/*!40000 ALTER TABLE `training_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `training_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_discounts`
--

DROP TABLE IF EXISTS `transaction_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_discounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_id` bigint(20) unsigned NOT NULL,
  `discount_id` bigint(20) unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_discounts_uuid_unique` (`uuid`),
  KEY `transaction_discounts_transaction_id_foreign` (`transaction_id`),
  KEY `transaction_discounts_discount_id_foreign` (`discount_id`),
  CONSTRAINT `transaction_discounts_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`),
  CONSTRAINT `transaction_discounts_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_discounts`
--

LOCK TABLES `transaction_discounts` WRITE;
/*!40000 ALTER TABLE `transaction_discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_items`
--

DROP TABLE IF EXISTS `transaction_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `quantity` int(11) NOT NULL DEFAULT '0',
  `total_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `bill_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `options` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_items_uuid_unique` (`uuid`),
  KEY `transaction_items_transaction_id_foreign` (`transaction_id`),
  KEY `transaction_items_product_id_foreign` (`product_id`),
  CONSTRAINT `transaction_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `transaction_items_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_items`
--

LOCK TABLES `transaction_items` WRITE;
/*!40000 ALTER TABLE `transaction_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_payments`
--

DROP TABLE IF EXISTS `transaction_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_payments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_id` bigint(20) unsigned NOT NULL,
  `reference_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `options` json DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_payments_uuid_unique` (`uuid`),
  UNIQUE KEY `transaction_payments_reference_number_unique` (`reference_number`),
  KEY `transaction_payments_transaction_id_foreign` (`transaction_id`),
  CONSTRAINT `transaction_payments_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_payments`
--

LOCK TABLES `transaction_payments` WRITE;
/*!40000 ALTER TABLE `transaction_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint(20) unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `due_date` datetime NOT NULL,
  `total_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `discount_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `bill_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `paid_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactions_uuid_unique` (`uuid`),
  UNIQUE KEY `transactions_reference_number_unique` (`reference_number`),
  KEY `transactions_customer_id_foreign` (`customer_id`),
  CONSTRAINT `transactions_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_uuid_unique` (`uuid`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_profile_id_foreign` (`profile_id`),
  CONSTRAINT `users_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'bd0fb5de-f594-11ef-937f-0200a013a61c',1,'SAFFix','admin@saffix.id',NULL,'2025-02-28 05:27:44','$2y$12$hxDmGDPG6YGzsu1YnYjHpOIJAjwQkwE2EEw/gzJTOM/jqAnESJD5C','SkF0o8zGon','2025-02-28 05:27:44','2025-02-28 05:27:44',NULL),(2,'bd3745ae-f594-11ef-8351-0200a013a61c',2,'HBICS','admin@hbics.sch.id',NULL,'2025-02-28 05:27:44','$2y$12$PvO7ApYRGdOm3cReV0MqmOgIcD849xrTy6rlDu1VKOAIq9pIvabaW','BU8sFP1R7RoFIioLnhWTpP6QLpUtSX861RBaryFOPcKIozy4ckMl8PHhMbDF','2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(3,'bd476970-f594-11ef-8b3c-0200a013a61c',3,'Developer Saffix','developer@saffix.id',NULL,'2025-02-28 05:27:45','$2y$12$0NImtbCrBA6G4VtiTUvcMe7HLGJa/Rfqv8XWyo8D54RDyDtzGzQPG',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(4,'bd48f65a-f594-11ef-8ee4-0200a013a61c',4,'Yacobus S','yacobus.s@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$12$HwxXAUnoQSOzYs1AC2ZNXu5u22s1UDwS3nBO2BgS8TcXmfJ374QzK',NULL,'2025-02-28 05:27:45','2025-03-09 07:48:18',NULL),(5,'bd4a4dd4-f594-11ef-ae5b-0200a013a61c',5,'Dina Adesthy Njoo','dinaadesthy.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$12$oUrjSqng9bL/9FuMUnExmua1nhC0/0QRbD7NZIpLx6cFKmj3QPw/W','jEBjvOyuXlGUEO32hLSz5GCl8yG0EsYh2UWhJ0lTRH0R3i29lVHnegoUT0k2','2025-02-28 05:27:45','2025-03-11 02:32:12',NULL),(6,'bd4babfc-f594-11ef-9bd7-0200a013a61c',6,'Dyah Anggarini','dyah.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$/VddK5WLx4WpYTQICB0W1uBWoAihzwa9Vrk0/rMd0v.6kQdlAxpge',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(7,'bd4cabe2-f594-11ef-b409-0200a013a61c',7,'ICC_akun_test','yacobus.setiawan@hotmail.com',NULL,'2025-02-28 05:27:45','$2y$10$6/DsnuIBHLHjSV4gpjB5fuS8KNxvgAjMYPjz7pjWpz3IMRqVZ/PSG',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(8,'bd4e375a-f594-11ef-910f-0200a013a61c',8,'Natalia Heriati','nataliaheriati.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$12$6LJ5OxDa1WW7OVQZ3xPdUul428k7Oq.KOAfc7yK4XIT4myIG1dUnO',NULL,'2025-02-28 05:27:45','2025-03-03 00:52:15',NULL),(9,'bd4f8f92-f594-11ef-b4aa-0200a013a61c',9,'Masye Polla','masyepolla.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$ZkGTYHC4L/6lLejYGgNVweD38nOA6kdsLh7RVQTJLt/dGOP373vWO',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(10,'bd50efe0-f594-11ef-b902-0200a013a61c',10,'Elprida simanjuntak','elpridasimanjuntak.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$VYjAomOEp.bVQUgW47XavuCkbK5rxNqv7zuoL.PWHaCz4cdogEDja',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(11,'bd5232f6-f594-11ef-968d-0200a013a61c',11,'Enita Sitinjak S.PD','enitasitinjak.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$BPd8IgkDR4A5vZlr6RRZEe4AyXKpCvMDe/uO/YetT3Y.7SMiI9V7y',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(12,'bd5397a4-f594-11ef-b467-0200a013a61c',12,'Eva Grace Sumasa S.Pd','evasumasa.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$onFpmGsUWALjDkudKnblJOKnXJZSKdRHBhszvbd7hvwYRWNog01Ci',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(13,'bd54f41e-f594-11ef-983a-0200a013a61c',13,'Grace Charity Tehilla Harjanto','gracecharity.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$ynQnJe17/KREQIRPEgyir.BHUy7sZ2w31cvBnsHdtqloLZMosp1GO',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(14,'bd564742-f594-11ef-95ef-0200a013a61c',14,'Ivana M. Kawung','ivanakawung.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$WdeqJ7hVthddkFUi45JsFuNdR/Wm3r2mojHc91jzFtK0LV7pysqrC',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(15,'bd579430-f594-11ef-a726-0200a013a61c',15,'Juika Sobon','juikasobon.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$CIypvEeWlwSnF62D98945ObBMR8u0CLYQxxnq1m6UfRVFJRcBVeEW',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(16,'bd58e416-f594-11ef-86c3-0200a013a61c',16,'Loed Devina Abigail','loeddevina.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$FozdHiQWpbIuAqBsuplc1ONNInFwEcEApGWwOF5ABqS9adn8GZVYG',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(17,'bd5a2e20-f594-11ef-b38b-0200a013a61c',17,'Maya Cyntia Sigar','mayasigar.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$12$pU4MUF4dARVsb.RNYqC3FuptrhbfLGEV2KOosaqn2qlmVjZCR5m/a',NULL,'2025-02-28 05:27:45','2025-03-03 00:56:42',NULL),(18,'bd5b80c2-f594-11ef-b42a-0200a013a61c',18,'Priscilla Tirsa Sulangi','priscillasulangi.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$12$Kzr8daZuCeIbrRFkklbQn.gjdaI8dwMpXS4Ot51qLzbr.8.X7SB/.',NULL,'2025-02-28 05:27:45','2025-03-16 06:31:08',NULL),(19,'bd5cdd82-f594-11ef-992e-0200a013a61c',19,'Ryen Mart Purba','ryenpurba.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$EZyPg2ZS5MA1YIJJMSpl3OBQJ1jGiXC0lWuBmllgJ7181Aj01c8yy',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(20,'bd5e2570-f594-11ef-8086-0200a013a61c',20,'Salvira Limbong','salviralimbong.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$nc1rqU3ac01k8XaAhWbFRubBd6GIImfsnAmXg4zrRYC6MrO66Q8cC',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(21,'bd5f8e38-f594-11ef-94d5-0200a013a61c',21,'Tasya Maria Febrianti','tasyamf.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$4PSFCwJc4X6CjFRrzLTowesvlx.9XCcfNF/Pq9L2n1tfKvwnxX.4m',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(22,'bd6101fa-f594-11ef-b79f-0200a013a61c',22,'Yoise Merine Seitte','yoiseseitte.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$qAUvpAYolzF4B0VAmSeI7OvtOGCB43y/Qu2MwmFxCcIg8e/OL299K',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(23,'bd626932-f594-11ef-a05d-0200a013a61c',23,'Febiyoga Alit Pawestri','febiyoga.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$KduOsDAPYDfFe2Alm8/.9uVmNYCwm0cLZN3t3tMbwNIRjBngP/uqq',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(24,'bd63ca8e-f594-11ef-9705-0200a013a61c',24,'Meniria Laoli','menirialaoli.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$w8mNDS8zSeLCTqukoV6CneQpUDaa6mQk72FyblssjcvuCnpz3Q16.',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(25,'bd653126-f594-11ef-9c93-0200a013a61c',25,'Wildah Edrostina Nababan','wildah.hhk@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$0o.C.VTE2ov7lBvPLlUF/uQJ7fohUiqmIsyPuh0AE51CDEOBNOF1u',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(26,'bd66b1b8-f594-11ef-973f-0200a013a61c',26,'Hana Flowerens Sitorus','hana.sitorus@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$AKlRM90T8N/KUgjyj7X4T.XWklUXzCetcnGmZiPBRAm6zqluaT0Fu',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(27,'bd68315a-f594-11ef-888e-0200a013a61c',27,'Chelsia Sumendap','chelsia.sumendap@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$kBqD0CBvbxKZ/NCHWIZeRudmkt1.Ruqv8PP0j6X2pu5rHI18d3yNm',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(28,'bd699d2e-f594-11ef-8990-0200a013a61c',28,'Mangapul Silalahi','mangapulsilalahi.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$QKSWKD74V2dzeD4YZ9F.G.Hwhc7eHyDgwzsvnxJq24zwCWNbB0beW',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(29,'bd6b1118-f594-11ef-9acc-0200a013a61c',29,'Amelia Sondang Febriyanti','amelia.sondang@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$bC7n0BPY1cU6NkSkLa/jQ.Qgo7daIq3k2XwM0Xwqpe5pQUifxbD1y',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(30,'bd6caae6-f594-11ef-8395-0200a013a61c',30,'Anjelyn Susanti Purba','anjelynpurba.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$MPa37Mx68.NZRrsGlbCYa.4Bror3Pn.ncu3sARKv6jAfBRF1LPCjm',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(31,'bd6e5148-f594-11ef-9f4a-0200a013a61c',31,'Brigita Rosari','brigitarosari.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$3Yjc2BGUILDOcV52mnWr8uxWgOpK0vp8Pgw2.XudRlQv7LTmiKZXm',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(32,'bd703350-f594-11ef-8b04-0200a013a61c',32,'Christina Carolyna Bakara','christinabakara.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$9ix3Rrl7zt5PvANo6BW3W.q/tqL4MMt0YlBxDW4rGhi5a4Uiv2FFW',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(33,'bd71e196-f594-11ef-9d3f-0200a013a61c',33,'Desmin Berliani Harefa','desmin.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$MTiQR84.aCAQEEDsswxqJ.kprSAMvs896xcRLDMuKjyXoqW.6mI8C',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(34,'bd73524c-f594-11ef-a369-0200a013a61c',34,'Erik Gunena','erik.gunena@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$12$QS0BzG3OlUhPRRtjus/xTOqgyT3vhmZw0iTUL6D5cA0Gh8goOHXZG','UdwvcyftZ7PY6rErXE5dO1Si0qqz0n6Zzlg7SbqvLmwBEeiNkuOgRtag8sXA','2025-02-28 05:27:45','2025-02-28 07:39:30',NULL),(35,'bd74f598-f594-11ef-98eb-0200a013a61c',35,'Friska Yanti Tobing','friskayanti.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$Zr6Mf7jk/uNT04a2/e6JyuEGxLEw/g/9Ji.bNJgUY6pLvlNCLpwgq',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(36,'bd7661b2-f594-11ef-967f-0200a013a61c',36,'Gloria Siahaan','gloriasiahaan.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$iB2gli8eie6YSLBoCn3LK.fQ4JC6k7njkYQS93FnmQBokFwrVdHEO',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(37,'bd77fea0-f594-11ef-aa3b-0200a013a61c',37,'Hellen Christina','hellenchristina.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$Zavl4zhpnogBBoJo2mj15uIssJHJ.2B0LE9SuRSy/SAN51S3Uc/sS',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(38,'bd79e27e-f594-11ef-a354-0200a013a61c',38,'Indriani Ginting','indrianiginting.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$GbzzyaNm1P8JNrtEcxM/eOGYsRRqzfZP9xW6EEUsWgmLi64CS9r/m',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(39,'bd7b6342-f594-11ef-a037-0200a013a61c',39,'Kristian Adinata P','kristianpangaribuan.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$341GuvWPlM49c.yw2e5ny.6swCk9tdTR2vPWX2NBwyDy7u.nSZEti',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(40,'bd7cd574-f594-11ef-b484-0200a013a61c',40,'Lougi Virgi Priscilla Posumah','lougi.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$EAn/5Oh82fw5pERKnAaoze75NVxK.Wpz7QahWkiXWzUOwBQxJN5Fu',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(41,'bd7eb844-f594-11ef-9d70-0200a013a61c',41,'Mega Ningrum Suwarno Putri','meganingrum.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$dx.t72FLsSXlW0JvaMZy7.aG4A5YK2mFh/WkwRn0EkQ04DGXl1ueq',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(42,'bd80272e-f594-11ef-94c8-0200a013a61c',42,'Meini Fiana Fransiska','meinifiana.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$WZasI.Z92Q85yrLQCPlmyufH9gar6ZXQPm7iUv311Wr.zrOUDVDZy',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(43,'bd81d3b2-f594-11ef-a260-0200a013a61c',43,'Meity Varyda Dene Saragih','meitysaragih.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$XG.7y/bCb4/WBwHOzjmu4OYL4OLlVFtl5ZhfD8oOHYJrEj5Dgdp2C',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(44,'bd833734-f594-11ef-b273-0200a013a61c',44,'Monica','monica.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$eyo8FBH.kigxWGFLKAHZlubS1cGWgJ9y/ZpgsTQkauP3JHBNNWZ0O',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(45,'bd851630-f594-11ef-91e3-0200a013a61c',45,'Nora Agustina Silalahi','noraagustina@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$.wO5iamP4IqUErrqsJfnSuNWEQKYnSLcttVC2UsD4cZYuVqzlNa62',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(46,'bd86eec4-f594-11ef-b6c7-0200a013a61c',46,'Novilina Veronica Inu Dhei','novilinadhei.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$u9PjwfjyH9PEuhGi5awTDO1q5qh1zdNxGdKkEufVzub.hFMQgBWdi',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(47,'bd88f5ca-f594-11ef-af11-0200a013a61c',47,'Novita Permata Sari Tambunan','novi.tambunan@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$EYBKiTr2H5zSJLMzhEdP9usI3XrA54d1PHOg.gI1tnZyiqHx6cBf2',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(48,'bd8aa168-f594-11ef-b2d3-0200a013a61c',48,'Rados Fremiro Sembiring','rados.fsembiring@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$Ke12fnkBtxPQdu6niReqmeBccCFmKvTj/ClvUbXQSHZA6ieq3z40u',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(49,'bd8cf706-f594-11ef-88f3-0200a013a61c',49,'Rahmadianti','rahmadianti.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$yMDTpzTsASVcwkkSZzuxm.M/HVu7LqHDr2cEA9uyQ26ll69q7QtNu',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(50,'bd8efbfa-f594-11ef-90ff-0200a013a61c',50,'Rimson Marusaha Sinaga','matthew.sinaga@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$crwGniMuHEdEBlioW4btu.7RQuTg4OrM/OREt4YlE2nYTsPZp1NnW',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(51,'bd9072b4-f594-11ef-b282-0200a013a61c',51,'Ruth Magdalena Simanjuntak','lena@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$Ao80Kv7XI4Kk7J6tQrKTc.27Mc80BeqQ.dot2QeM6rjvsUbRUme6O',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(52,'bd91da96-f594-11ef-a7ff-0200a013a61c',52,'Tirsa Ester Amanda Koroh','tirsakoroh.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$Vrs9SQY8z2Er7tysHiC/Z.6BtDf5XbBGLzgyC6MVFRzNit22XAK.a',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(53,'bd936280-f594-11ef-8941-0200a013a61c',53,'Vestin Putri Telaumbanua','vestinputri.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$BoR.Bpb1s8G7Rqf3aPTDc.rV4kJGlwNOwYqOlwqk7kWpdIoi3ZfyK',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(54,'bd961520-f594-11ef-8939-0200a013a61c',54,'Vania Ananda Massangka','vaniaananda.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$XvFvJ3QDrUixYpNZAKUeGetcSrHiQbzI5wWpApaw3Hs.C5lOPjjHm',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(55,'bd97e7ba-f594-11ef-aec1-0200a013a61c',55,'Yonatan Alhas Wijaya','yonatan.awijaya@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$CXgunff0tqp/3rVMSSAjfudOpMSb/bGD4oCRC/O46lEZdk8yNrJIe',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(56,'bd9953e8-f594-11ef-97f5-0200a013a61c',56,'Elisabet Simanjuntak','elisabethsimanjuntak.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$u90S7xNsWE8lUNDTXQ94wuv0Tsl33MtQkwzGP.UZfGymPm2yUUjBq',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(57,'bd9abbca-f594-11ef-ad82-0200a013a61c',57,'Elisabeth Agnes Tnunay','agnes.tnunay@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$dGlkoiEAb2lb9zI9QSQviuBLptatKGpINhxGwJiueRDqL6WBv7rTe',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(58,'bd9c483c-f594-11ef-8f78-0200a013a61c',58,'Angela Merlyn Primatika','angelamryln.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$bwjSrwcozVnsfCOOqHMHwOgJfRv9T8YbreDOHVRAoPiDjLmnhlkLC',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(59,'bd9dc0a4-f594-11ef-85d1-0200a013a61c',59,'Dita Primalani Nainggolan','ditaprimalani.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$/UqF4XLeBqQ.8f25GO.oiOs76QasOwHq/j7iz89YSv5bJImjueQJW',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(60,'bd9f4820-f594-11ef-979a-0200a013a61c',60,'Laura A.D Sihombing','lauraad.sihombing@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$3lJ946srI9RI0xGXDlBZMO8oj7N6m7SeRhEPnAQS26lggs/4CJ6wi',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(61,'bda0b48a-f594-11ef-abb7-0200a013a61c',61,'Tracey Sheilla Asia','traceys.asia@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$mtyGtWZ8nShU7IeYM516keEdYWEz7G9KRyoTmT/uRXuJHz4esUyBO',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(62,'bda23350-f594-11ef-9dbc-0200a013a61c',62,'Rika Febriyanti Lamtiur Panjaitan','rika.panjaitan@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$IKkRzNcmlsrSf.h432nWXOi2S2LWlCkMVu7GLZf11x.xw5azMC0Eu',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(63,'bda3abf4-f594-11ef-ba0e-0200a013a61c',63,'Kristina Habeahan','kristina.habeahan@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$RPRBrfMq..7.971fZwjSre5.peM4JLkmxHjqba8JZS9qydwKg1RnK',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(64,'bda51692-f594-11ef-8f6b-0200a013a61c',64,'Betty Sianturi','bettysianturi.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$VJ56M0Wymo2DkEk5kWnJHOSRQCisEsSeFjVwQSS5GuzJIyOq/jmSK',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(65,'bda756b4-f594-11ef-8d02-0200a013a61c',66,'Margaretha Dwi Cahyani','margarethacahyani.hb-high@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$pyVBGnHswNe4t0VQsHHOL.gX6wwE9YKFZuXFprTAy90avrD34rSpG',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(66,'bda8ac8a-f594-11ef-96ef-0200a013a61c',67,'Angelis Andreas Gama','aandreasgama.hb-secondary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$unOF8gUXTM2qtzGsaej3F.uZFIaA09j5amyf4mz8QhSV7FQqIIYvm',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(67,'bdaa2d4e-f594-11ef-b452-0200a013a61c',68,'Anita Simamora','anitasimamora.hb-secondary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$Qc0N/gui8xwGkbDguoLmHOn/c46YdMVL2rnSMqE7O001Ac2WSDNVi',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(68,'bdabf656-f594-11ef-a88a-0200a013a61c',69,'Arianti','arianti.hb-high@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$i83tIH9uvOBnoNlK8AIPce5QGREsIHzKoz3kqJ/DRiheGFpPesXVm',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(69,'bdad9a7e-f594-11ef-8720-0200a013a61c',70,'Ayu Estiyanti Widiyantari Kiswanto','ayuestiyanti.hb-secondary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$BKx44c3jXDUJ97.Z5km.XeGcBhou51unRGL1MFR7/6c1Q21D6LbVO',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(70,'bdaf30a0-f594-11ef-9eb9-0200a013a61c',71,'Bunga Ratnasari Hadipitoyo','bungaratnasari.hb-secondary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$12$9ZRhQd9WCedGBdfXDHOQNu7zQeCvlWt0iibwYL3c44AerUKx.6PjK',NULL,'2025-02-28 05:27:45','2025-02-28 07:38:15',NULL),(71,'bdb0b132-f594-11ef-a5d6-0200a013a61c',72,'Chatrilitha Laurine Nouviana','cnouviana.hb-high@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$/jEgjJogPT75eowSJxQE8OeQ3Hp/xH5d31MNuAvv2oGNWIe38/yqS',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(72,'bdb3412c-f594-11ef-96bf-0200a013a61c',74,'Fertunata Monica Darsono','fertunatadarsono.hb-high@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$Oh/OrobIpa/Fxph6ItnC1OV.tAAX.a94hR2HIu.ACQae8lPszFcGG',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(73,'bdb4b0f2-f594-11ef-a2bc-0200a013a61c',75,'Jeisica Lumy','jeisicalumy.hb-seniorhigh@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$sJA7uQFJUTcfp4eMnuiz8ujSJLJjF.fzovHU1RplvRn7E/NtTmfdC',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(74,'bdb62234-f594-11ef-9163-0200a013a61c',76,'Jessie BulurDitty','jessie.hb-secondary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$xzO54jEBwzmxdroVU9YIY..HyqWj54AazKNXnSSAGcCbYUPSM7YMW',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(75,'bdb7be6e-f594-11ef-abd3-0200a013a61c',77,'Maria Josebia Pangestuti','mariajosebia.hb-secondary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$qZkJ0UqUYyXYcrU9GFxhLOsig6cxxn2yxlZvqNYKU1dTN/Kzkc/R.',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(76,'bdbcc774-f594-11ef-a0da-0200a013a61c',79,'Meylodra Wilhelmina P','meylodra.hb-secondary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$zDxTWLx90orNLIS55eICOuCExDUradgzpGuqYRgoRK8SR75ia8qXO',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(77,'bdbe4716-f594-11ef-9a1f-0200a013a61c',80,'Pingkan Patricia Ishwari','pingkanishwari.hb-high@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$RZpqymBtoo.2uxpJMXUq7u.2X9XMx1b52IK0.ufVh50tE5w5biw.i',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(78,'bdc07d9c-f594-11ef-b131-0200a013a61c',81,'Riswandi Sinurat','riswandisinurat.hb-secondary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$ZN5qUBh1Lp0idI4GXD5uZeB3DirT2kPfxwvekTu1WdpIwWmV7rrBu',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(79,'bdc20df6-f594-11ef-999d-0200a013a61c',82,'Sari Fitri Dewi Debora Sinaga','sarifitri.hb-secondary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$NEnIvxamOfuCKZPI5y7CBuc146fF6wsRyMwxNdESV.Y61Q69E1N5a',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(80,'bdc3cc86-f594-11ef-a0f8-0200a013a61c',83,'Stella Fanny Gerina','stella.hb-secondary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$HhjoSfgbEK475lzLJp3ZveXMdw.Sa5eDtFkniJE1jq3suFfd7gMhy',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(81,'bdc5a740-f594-11ef-9654-0200a013a61c',84,'Suci Florence Night Ingeale S','suciflorence.hb-secondary@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$Cs4vrfQgRnQEtMvfeH2sZOwPAEA9.ccJ.MNcRxlhCQpdUwiYSR83W',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(82,'bdc796a4-f594-11ef-9967-0200a013a61c',85,'Vina Meliyana BR Perangin angin','vinameliyana.hb-seniorhigh@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$bmSFzaH0y8uBkRoas4C.V.CyYzfdQDOjPWHgvq3lI2HqBTG2Dj48O',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(83,'bdc92f6e-f594-11ef-9c7b-0200a013a61c',86,'Sukarman','sukarman.hb-seniorhigh@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$L6wDyuQpp9sOT.arbZhm3OCKM1miZUQ8P0/fHHt8OmYJa8Cry/q4q',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(84,'bdcb873c-f594-11ef-b6bd-0200a013a61c',87,'Rizky Kurniawan','rizkykurniawan.hb-seniorhigh@hbics.sch.id',NULL,'2025-02-28 05:27:45','$2y$10$Pqb4.FRLZQ5XV0e6ON8u1eYoO121mV0bADabxnspvpBUjYnycTltS',NULL,'2025-02-28 05:27:45','2025-02-28 05:27:45',NULL),(85,'bdcd597c-f594-11ef-ba89-0200a013a61c',88,'Eryka Mayang Pamungkas','eryka.hb-secondary@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$PA1kzavwWoZD2WvZOJqbJOglT/nVNQOrAz6uLSEZj0xRHa3cHnl0y',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(86,'bdcf20d6-f594-11ef-b1d3-0200a013a61c',89,'Andreas Lukita','andreaslukita.hb-seniorhigh@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$nls80GWbjxKgDGj242ddW.7dgsYFTeQbmRCLitc/KEtyt2Gqes54W',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(87,'bdd0e236-f594-11ef-ad5b-0200a013a61c',90,'Azalia Herma','azaliaherma.hb-seniorhigh@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$XhDIizTF5tylKnqRhg5jauR4cD8KYxME4T.JmGF2CGi0kAShBnNoK',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(88,'bdd2b804-f594-11ef-a7f5-0200a013a61c',91,'Hans Gouw','hans.gouw@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$AChbTzqzr824LyzjcyI5deGtHY/30hSx2ZfJpGS3TgDLqPknL4aGy',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(89,'bdd45204-f594-11ef-8b7c-0200a013a61c',92,'Febriyanti Menasetiabudi','febriyantimenasetiabudi.hb-secondary@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$V4eM45sp/jtg/51hieBTG.ePkd4N8g4i.YU4Qm6gcjCfnCum2dZXe',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(90,'bdd5bce8-f594-11ef-acef-0200a013a61c',93,'Roosye Carolina','roosyecarolina.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$12$vI.PXrmSuFsT10WIXWfvhufyZSRLY3YsJTNt.Hhb057q3mqQVYNjS',NULL,'2025-02-28 05:27:46','2025-03-03 00:49:52',NULL),(91,'bdd736fe-f594-11ef-8c3e-0200a013a61c',94,'Eristiannponglangi','eristiannponglangi.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$4RZzWq3l8Mp8djGVWl5iiOy8W4XW4Z3i2ap/IuOiB9ci2wzB3Jiti',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(92,'bdd8dd10-f594-11ef-8c6e-0200a013a61c',95,'Olivia Deti Duta','olivia.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$AGV7p/B/FPBx3tAKcCSboOefSTJy7Xdp7ocUfJz0Gh7UwwdfwQhLq',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(93,'bddabd42-f594-11ef-b20d-0200a013a61c',96,'Tresia Tiku Lele','tere.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$4XWlQmjH0sbrXm9XODVgLOyQk5r/51SgXF/J2TdaTf7GkDK4627a2',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(94,'bddc8758-f594-11ef-94d7-0200a013a61c',97,'Vivi Natalia','vivinatalia.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$JW4OVHzFsCDgmfokVyKeq.g2lZpgZwCKYHHvm6XSwuLf8TNVrogEC',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(95,'bdde2432-f594-11ef-96d6-0200a013a61c',98,'Mely','mely.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$wXYBywcy6MGZPKmEE3paI./4nNoTPu7ONuYw7SPEVx6t9fUzAmUIO',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(96,'bddfd052-f594-11ef-9762-0200a013a61c',99,'Yenny Elmira Siahaan','yeni.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$jb34uz.HONHmYOOUKvB4F.OPRPRqJJjhrxL2W0IVmxSKOSXWDGHpq',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(97,'bde179f2-f594-11ef-842b-0200a013a61c',100,'Alek Sander Agung','aleksander.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$DFeI14XVQ/OJSVfFh29ivepV2uOgTc07Z4hb4DFQgCshgwySy.24.',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(98,'bde34f34-f594-11ef-af9c-0200a013a61c',101,'Ariadi','ardi.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$hHeHfqQSzRjArmGUn/vrsOFkjaMCI1SQBARgnOLYJM0vOhjKp.zWG',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(99,'bde4e498-f594-11ef-b647-0200a013a61c',102,'Barlevi Sharon','levi.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$YUnatZOfx1TpsceSjyjST.qimVi5E8M4VKrQVemfwnZWxKUa.lWgq',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(100,'bde6c3d0-f594-11ef-ba0f-0200a013a61c',103,'Devi Novita Sari, S.H','devi.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$aOYg/6RfJLrzHpIm3ziiae99UXiNlEWx6FxH34nEkwWo1Rs/hrVOa',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(101,'bde89b24-f594-11ef-87a9-0200a013a61c',104,'Jessica Prisicilia Sarajar','jessica.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$9aRbcQx28ehlnNYAkC/3WOTh0RkVpZ3sxIlECmgW9dj3Sc9clHY.m',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(102,'bdea638c-f594-11ef-a9bd-0200a013a61c',105,'Kerestian Naihonam','keristian.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$Q.POHF2xZwVt4.57TaI2lu/g/QJylElRznWY/bJ5imYjrHsoc3BHC',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(103,'bdec3338-f594-11ef-864a-0200a013a61c',106,'Muchtar RM','muchtar.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$0GhiXE9egflaZIwCrMeI5O3hrd4VVts5aAqaqLXaME9QIRf3ky83O',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(104,'bdede76e-f594-11ef-83b7-0200a013a61c',107,'Nofry G Mangindaan','novry.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$369KEaSpnHD80c2wrRLR3uTFGQFyLqmL2L18K4wHogf0eZ2djRux2',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(105,'bdef7958-f594-11ef-9d7a-0200a013a61c',108,'Sugeng Suriyadi','sugeng.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$8jcOHiA3i6qBeeyrGSjHk.Po47KvOEhwjIGL8sYBVwiaSDbkEL/8K',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(106,'bdf227ca-f594-11ef-ba18-0200a013a61c',110,'Tasya Gloria Wowor','tasyagloria.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$O2kOZg.olu4agr5xiWVod.zuYDgFj8Nghv/slHeHLKT3bS3XMjX0K',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(107,'bdf3c1de-f594-11ef-840f-0200a013a61c',111,'Agnes Puspa Indah','agnes.indah@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$6xMSWlpzYZ5LZamTIq6LvuoboPwvPxzRwml4HgANe6ZacgsgVyicO',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(108,'bdf56368-f594-11ef-b0ee-0200a013a61c',112,'Adytya Lambang Nugraha','adytya.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$.auZ0c9V9P3NDSLIFaO4auLWaHPtZx6HuEAaw.Q2amNUJpFgJhsSm',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(109,'bdf6ef76-f594-11ef-82b2-0200a013a61c',113,'Andre Witarsa','andre.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$3bVGVU8UVWNBe3dnnG/zgO6qZ/WTlp5RBxul8Fc5tY.wrL316zWYe',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(110,'bdf8713e-f594-11ef-a7db-0200a013a61c',114,'Ingrit Agustin Wullur','ingritaw.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$zoiSTyeyVBs36BRZpcIvyukLuyYkD3rxP5LR9OCdfPNzFrTrsY3yO',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(111,'bdfa242a-f594-11ef-9a52-0200a013a61c',115,'Natanael Ferdinand','natanael.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$/fTwm6gFMrv4icXyFKwbPe4aPdlaZCDQLsrYiWQB9uzZ13CkVqw1y',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(112,'bdfbd536-f594-11ef-bd7c-0200a013a61c',116,'Widya Disriyati Simatupang','widya.ytcb@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$2Fir8zYNCWCyGSOlgiLjd.Fr2dq.HaFsRUWaZugdbv3pUlxXGUhpG',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(113,'bdfec1a6-f594-11ef-b7c5-0200a013a61c',118,'Ireyne Nopiana Sinaga','ireyne.hb-primary@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$m0Wl2ZGooafonhW/h9kbPuswxSRqklwkpeV1PJhIGEN/7ACSN8dyG',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(114,'be0084aa-f594-11ef-b28a-0200a013a61c',119,'Mario Septianto Nugroho','marioseptianto.hb-seniorhigh@hbics.sch.id',NULL,'2025-02-28 05:27:46','$2y$10$OvZaLKQ9ydfwX3o1wqsENudBroMx/kEOoZKQ4WbWVhfoduO2IOV1K',NULL,'2025-02-28 05:27:46','2025-02-28 05:27:46',NULL),(115,'414a9f2c-f7bf-11ef-a403-0200a013a61c',120,'Lesyel Jovana','lesyeljovana.edcon@hbics.sch.id','+62 815-4922-7735',NULL,'$2y$12$y/JU13be7Bs5FfniPRdxe.52sGxNfjyUYuFMnuveVu9iaS8nOqob.',NULL,'2025-03-02 23:37:07','2025-03-02 23:38:25',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-25  4:56:47
