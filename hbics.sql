-- -------------------------------------------------------------
-- TablePlus 6.4.0(598)
--
-- https://tableplus.com/
--
-- Database: hbics_testing
-- Generation Time: 2025-03-22 15:53:23.4280
-- -------------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


DROP TABLE IF EXISTS `academic_records`;
CREATE TABLE `academic_records` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `achievements`;
CREATE TABLE `achievements` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
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

DROP TABLE IF EXISTS `admission_stage_statuses`;
CREATE TABLE `admission_stage_statuses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admission_stage_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_number` int NOT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admission_stage_statuses_admission_stage_id_foreign` (`admission_stage_id`),
  CONSTRAINT `admission_stage_statuses_admission_stage_id_foreign` FOREIGN KEY (`admission_stage_id`) REFERENCES `admission_stages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `admission_stages`;
CREATE TABLE `admission_stages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_number` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admission_stages_model_type_model_id_index` (`model_type`,`model_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `admission_student_quotas`;
CREATE TABLE `admission_student_quotas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` bigint unsigned NOT NULL,
  `school_year_id` bigint unsigned NOT NULL,
  `school_grade_id` bigint unsigned NOT NULL,
  `max_quota` int NOT NULL DEFAULT '0',
  `used_quota` int NOT NULL DEFAULT '0',
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

DROP TABLE IF EXISTS `admission_student_stages`;
CREATE TABLE `admission_student_stages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admission_student_id` bigint unsigned NOT NULL,
  `admission_stage_id` bigint unsigned NOT NULL,
  `admission_stage_status_id` bigint unsigned NOT NULL,
  `officer_id` bigint unsigned DEFAULT NULL,
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

DROP TABLE IF EXISTS `admission_students`;
CREATE TABLE `admission_students` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_id` bigint unsigned NOT NULL,
  `school_id` bigint unsigned NOT NULL,
  `school_year_id` bigint unsigned NOT NULL,
  `school_grade_id` bigint unsigned NOT NULL,
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `admission_students_registration_number_unique` (`registration_number`),
  KEY `admission_students_transaction_id_foreign` (`transaction_id`),
  KEY `admission_students_school_id_foreign` (`school_id`),
  KEY `admission_students_school_year_id_foreign` (`school_year_id`),
  KEY `admission_students_school_grade_id_foreign` (`school_grade_id`),
  CONSTRAINT `admission_students_school_grade_id_foreign` FOREIGN KEY (`school_grade_id`) REFERENCES `school_grades` (`id`),
  CONSTRAINT `admission_students_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`),
  CONSTRAINT `admission_students_school_year_id_foreign` FOREIGN KEY (`school_year_id`) REFERENCES `school_years` (`id`),
  CONSTRAINT `admission_students_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `areas`;
CREATE TABLE `areas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `attachments`;
CREATE TABLE `attachments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attachments_uuid_unique` (`uuid`),
  KEY `attachments_model_type_model_id_index` (`model_type`,`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `banners`;
CREATE TABLE `banners` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `banners_uuid_unique` (`uuid`),
  UNIQUE KEY `banners_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `careers`;
CREATE TABLE `careers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `careers_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `certifications`;
CREATE TABLE `certifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `chats`;
CREATE TABLE `chats` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  `sender_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `community_involvements`;
CREATE TABLE `community_involvements` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `employee_assignments`;
CREATE TABLE `employee_assignments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `employee_id` bigint unsigned NOT NULL,
  `area_id` bigint unsigned NOT NULL,
  `position_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_datetime` datetime NOT NULL,
  `end_datetime` datetime NOT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `events_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `experiences`;
CREATE TABLE `experiences` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `families`;
CREATE TABLE `families` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint unsigned NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `faqs`;
CREATE TABLE `faqs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_number` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `faqs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `galleries`;
CREATE TABLE `galleries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
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

DROP TABLE IF EXISTS `gallery_items`;
CREATE TABLE `gallery_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gallery_id` bigint unsigned NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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

DROP TABLE IF EXISTS `honor_prizes`;
CREATE TABLE `honor_prizes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `language_skills`;
CREATE TABLE `language_skills` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `offices`;
CREATE TABLE `offices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `offices_uuid_unique` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `operational_areas`;
CREATE TABLE `operational_areas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `operational_areas_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `operational_hours`;
CREATE TABLE `operational_hours` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `operational_area_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `pages`;
CREATE TABLE `pages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pages_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `positions`;
CREATE TABLE `positions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `area_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `positions_uuid_unique` (`uuid`),
  KEY `positions_area_id_foreign` (`area_id`),
  CONSTRAINT `positions_area_id_foreign` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `post_categories`;
CREATE TABLE `post_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `post_categories_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author_id` bigint unsigned NOT NULL,
  `category_id` bigint unsigned DEFAULT NULL,
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

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_uuid_unique` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
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
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `public_feedbacks`;
CREATE TABLE `public_feedbacks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
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

DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `school_classroom_members`;
CREATE TABLE `school_classroom_members` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_classroom_id` bigint unsigned NOT NULL,
  `student_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_classroom_members_uuid_unique` (`uuid`),
  KEY `school_classroom_members_school_classroom_id_foreign` (`school_classroom_id`),
  KEY `school_classroom_members_student_id_foreign` (`student_id`),
  CONSTRAINT `school_classroom_members_school_classroom_id_foreign` FOREIGN KEY (`school_classroom_id`) REFERENCES `school_classrooms` (`id`),
  CONSTRAINT `school_classroom_members_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `school_classrooms`;
CREATE TABLE `school_classrooms` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` bigint unsigned NOT NULL,
  `school_grade_id` bigint unsigned NOT NULL,
  `school_major_id` bigint unsigned DEFAULT NULL,
  `homeroom_teacher_id` bigint unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacity` int NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `school_club_members`;
CREATE TABLE `school_club_members` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_club_id` bigint unsigned NOT NULL,
  `student_id` bigint unsigned NOT NULL,
  `school_classroom_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `school_clubs`;
CREATE TABLE `school_clubs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` bigint unsigned NOT NULL,
  `mentor_id` bigint unsigned DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `school_extracurricular_members`;
CREATE TABLE `school_extracurricular_members` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_extracurricular_id` bigint unsigned NOT NULL,
  `student_id` bigint unsigned NOT NULL,
  `school_classroom_id` bigint unsigned NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `school_extracurriculars`;
CREATE TABLE `school_extracurriculars` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` bigint unsigned NOT NULL,
  `mentor_id` bigint unsigned DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `school_grades`;
CREATE TABLE `school_grades` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_level_id` bigint unsigned NOT NULL,
  `school_phase_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_number` int NOT NULL,
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

DROP TABLE IF EXISTS `school_levels`;
CREATE TABLE `school_levels` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_number` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_levels_uuid_unique` (`uuid`),
  UNIQUE KEY `school_levels_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `school_majors`;
CREATE TABLE `school_majors` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_majors_uuid_unique` (`uuid`),
  KEY `school_majors_school_id_foreign` (`school_id`),
  CONSTRAINT `school_majors_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `school_phases`;
CREATE TABLE `school_phases` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_level_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_number` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_phases_uuid_unique` (`uuid`),
  KEY `school_phases_school_level_id_foreign` (`school_level_id`),
  CONSTRAINT `school_phases_school_level_id_foreign` FOREIGN KEY (`school_level_id`) REFERENCES `school_levels` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `school_subject_groups`;
CREATE TABLE `school_subject_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_subject_groups_uuid_unique` (`uuid`),
  KEY `school_subject_groups_school_id_foreign` (`school_id`),
  CONSTRAINT `school_subject_groups_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `school_subjects`;
CREATE TABLE `school_subjects` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` bigint unsigned NOT NULL,
  `school_subject_group_id` bigint unsigned NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `school_years`;
CREATE TABLE `school_years` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_year` year NOT NULL,
  `end_year` year NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_years_uuid_unique` (`uuid`),
  UNIQUE KEY `school_years_name_unique` (`name`),
  UNIQUE KEY `school_years_start_year_unique` (`start_year`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `schools`;
CREATE TABLE `schools` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_level_id` bigint unsigned NOT NULL,
  `headmaster_id` bigint unsigned DEFAULT NULL,
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

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `specializations`;
CREATE TABLE `specializations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `student_guardians`;
CREATE TABLE `student_guardians` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_id` bigint unsigned NOT NULL,
  `guardian_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_guardians_uuid_unique` (`uuid`),
  KEY `student_guardians_student_id_foreign` (`student_id`),
  KEY `student_guardians_guardian_id_foreign` (`guardian_id`),
  CONSTRAINT `student_guardians_guardian_id_foreign` FOREIGN KEY (`guardian_id`) REFERENCES `users` (`id`),
  CONSTRAINT `student_guardians_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `student_schools`;
CREATE TABLE `student_schools` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` bigint unsigned NOT NULL,
  `school_classroom_id` bigint unsigned NOT NULL,
  `student_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `students`;
CREATE TABLE `students` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint unsigned NOT NULL,
  `school_id` bigint unsigned NOT NULL,
  `school_grade_id` bigint unsigned NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `sub_attendances`;
CREATE TABLE `sub_attendances` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `sub_broadcasts`;
CREATE TABLE `sub_broadcasts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `sub_cards`;
CREATE TABLE `sub_cards` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `sub_design_items`;
CREATE TABLE `sub_design_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_design_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `sub_designs`;
CREATE TABLE `sub_designs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_designs_uuid_unique` (`uuid`),
  KEY `sub_designs_submission_id_foreign` (`submission_id`),
  CONSTRAINT `sub_designs_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `sub_documentations`;
CREATE TABLE `sub_documentations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `sub_equipment_items`;
CREATE TABLE `sub_equipment_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_equipment_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
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

DROP TABLE IF EXISTS `sub_equipments`;
CREATE TABLE `sub_equipments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint unsigned NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_equipments_uuid_unique` (`uuid`),
  KEY `sub_equipments_submission_id_foreign` (`submission_id`),
  CONSTRAINT `sub_equipments_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `sub_event_items`;
CREATE TABLE `sub_event_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_event_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
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

DROP TABLE IF EXISTS `sub_events`;
CREATE TABLE `sub_events` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `sub_install_repair_items`;
CREATE TABLE `sub_install_repair_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_install_repair_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
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

DROP TABLE IF EXISTS `sub_install_repairs`;
CREATE TABLE `sub_install_repairs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint unsigned NOT NULL,
  `assigned_id` bigint unsigned DEFAULT NULL,
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

DROP TABLE IF EXISTS `sub_leaves`;
CREATE TABLE `sub_leaves` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `sub_material_items`;
CREATE TABLE `sub_material_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_material_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
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

DROP TABLE IF EXISTS `sub_materials`;
CREATE TABLE `sub_materials` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint unsigned NOT NULL,
  `bill_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_materials_uuid_unique` (`uuid`),
  KEY `sub_materials_submission_id_foreign` (`submission_id`),
  CONSTRAINT `sub_materials_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=997 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `sub_media_posts`;
CREATE TABLE `sub_media_posts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `sub_outstations`;
CREATE TABLE `sub_outstations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `sub_resignation_items`;
CREATE TABLE `sub_resignation_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_resignation_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `checker_id` bigint unsigned DEFAULT NULL,
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

DROP TABLE IF EXISTS `sub_resignations`;
CREATE TABLE `sub_resignations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `sub_vehicles`;
CREATE TABLE `sub_vehicles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `submission_approval_delegates`;
CREATE TABLE `submission_approval_delegates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_approver_id` bigint unsigned NOT NULL,
  `delegate_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `submission_approvals`;
CREATE TABLE `submission_approvals` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_id` bigint unsigned NOT NULL,
  `approver_id` bigint unsigned NOT NULL,
  `delegate_id` bigint unsigned DEFAULT NULL,
  `is_delegated` tinyint(1) NOT NULL DEFAULT '0',
  `sort_number` int NOT NULL,
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

DROP TABLE IF EXISTS `submission_approvers`;
CREATE TABLE `submission_approvers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_group_id` bigint unsigned NOT NULL,
  `area_id` bigint unsigned NOT NULL,
  `approver_id` bigint unsigned NOT NULL,
  `sort_number` int NOT NULL,
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

DROP TABLE IF EXISTS `submission_groups`;
CREATE TABLE `submission_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_number` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `submission_groups_uuid_unique` (`uuid`),
  UNIQUE KEY `submission_groups_name_unique` (`name`),
  UNIQUE KEY `submission_groups_code_unique` (`code`),
  UNIQUE KEY `submission_groups_reference_code_unique` (`reference_code`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `submissions`;
CREATE TABLE `submissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_group_id` bigint unsigned NOT NULL,
  `area_id` bigint unsigned NOT NULL,
  `submitter_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `testimonials`;
CREATE TABLE `testimonials` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
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

DROP TABLE IF EXISTS `training_records`;
CREATE TABLE `training_records` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `transaction_items`;
CREATE TABLE `transaction_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `quantity` int NOT NULL DEFAULT '0',
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

DROP TABLE IF EXISTS `transaction_payments`;
CREATE TABLE `transaction_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint unsigned NOT NULL,
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

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_id` bigint unsigned NOT NULL,
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

INSERT INTO `admission_stage_statuses` (`id`, `uuid`, `admission_stage_id`, `title`, `sort_number`, `color`, `is_finished`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'bd3a1932-f594-11ef-93fa-0200a013a61c', 1, 'Menunggu', 1, '', 0, '2025-02-28 05:27:45', '2025-03-04 02:59:19', NULL),
(2, 'bd3a4df8-f594-11ef-b46c-0200a013a61c', 1, 'Lanjut', 2, '', 1, '2025-02-28 05:27:45', '2025-03-04 02:59:19', NULL),
(3, 'bd3ab446-f594-11ef-9532-0200a013a61c', 2, 'Menunggu', 1, '', 0, '2025-02-28 05:27:45', '2025-03-04 02:59:19', NULL),
(4, 'bd3ae286-f594-11ef-8eeb-0200a013a61c', 2, 'Lanjut', 2, '', 1, '2025-02-28 05:27:45', '2025-03-04 02:59:19', NULL),
(5, 'bd3b4960-f594-11ef-86be-0200a013a61c', 3, 'Menunggu', 1, '', 0, '2025-02-28 05:27:45', '2025-03-04 02:59:19', NULL),
(6, 'bd3b77aa-f594-11ef-a6ae-0200a013a61c', 3, 'Lulus', 2, '', 1, '2025-02-28 05:27:45', '2025-03-04 02:59:19', NULL),
(7, 'bd3ba806-f594-11ef-b9da-0200a013a61c', 3, 'Gagal', 3, '', 1, '2025-02-28 05:27:45', '2025-03-04 02:59:19', NULL),
(8, 'bd3c0a94-f594-11ef-8440-0200a013a61c', 4, 'Menunggu', 1, '', 0, '2025-02-28 05:27:45', '2025-03-04 02:59:19', NULL),
(9, 'bd3c3fc8-f594-11ef-bd37-0200a013a61c', 4, 'Selesai', 2, '', 1, '2025-02-28 05:27:45', '2025-03-04 02:59:19', NULL),
(10, 'bd3c9d9c-f594-11ef-9a2e-0200a013a61c', 5, 'Menunggu', 1, '', 0, '2025-02-28 05:27:45', '2025-03-04 02:59:19', NULL),
(11, 'bd3ccf4c-f594-11ef-93dd-0200a013a61c', 5, 'Selesai', 2, '', 1, '2025-02-28 05:27:45', '2025-03-04 02:59:19', NULL),
(12, 'bd3e1c6c-f594-11ef-ac92-0200a013a61c', 6, 'Menunggu', 1, '', 0, '2025-02-28 05:27:45', '2025-03-04 03:01:46', NULL),
(13, 'bd3e51e6-f594-11ef-abe8-0200a013a61c', 6, 'Lulus', 2, '', 1, '2025-02-28 05:27:45', '2025-03-04 03:01:46', NULL),
(14, 'bd3e80a8-f594-11ef-b5b9-0200a013a61c', 6, 'Gagal', 3, '', 1, '2025-02-28 05:27:45', '2025-03-04 03:01:46', NULL),
(15, 'bd3ee02a-f594-11ef-8059-0200a013a61c', 7, 'Menunggu', 1, '', 0, '2025-02-28 05:27:45', '2025-03-04 03:01:46', NULL),
(16, 'bd3f0fbe-f594-11ef-855e-0200a013a61c', 7, 'Selesai', 2, '', 1, '2025-02-28 05:27:45', '2025-03-04 03:01:46', NULL),
(17, 'bd3f753a-f594-11ef-92ab-0200a013a61c', 8, 'Menunggu', 1, '', 0, '2025-02-28 05:27:45', '2025-03-04 03:01:46', NULL),
(18, 'bd3fa58c-f594-11ef-aca7-0200a013a61c', 8, 'Selesai', 2, '', 1, '2025-02-28 05:27:45', '2025-03-04 03:01:46', NULL),
(19, 'bd40f9a0-f594-11ef-91dd-0200a013a61c', 9, 'Menunggu', 1, '', 0, '2025-02-28 05:27:45', '2025-03-03 01:07:15', NULL),
(20, 'bd412b6e-f594-11ef-8c43-0200a013a61c', 9, 'Lulus', 2, '', 1, '2025-02-28 05:27:45', '2025-03-03 01:07:15', NULL),
(21, 'bd415c7e-f594-11ef-a070-0200a013a61c', 9, 'Gagal', 3, '', 1, '2025-02-28 05:27:45', '2025-03-03 01:07:15', NULL),
(22, 'bd41cf06-f594-11ef-b74e-0200a013a61c', 10, 'Menunggu', 1, '', 0, '2025-02-28 05:27:45', '2025-03-03 01:07:15', NULL),
(23, 'bd41fd32-f594-11ef-b7c1-0200a013a61c', 10, 'Selesai', 2, '', 1, '2025-02-28 05:27:45', '2025-03-03 01:07:15', NULL),
(24, 'bd4263c6-f594-11ef-b949-0200a013a61c', 11, 'Menunggu', 1, '', 0, '2025-02-28 05:27:45', '2025-03-03 01:07:15', NULL),
(25, 'bd429378-f594-11ef-b253-0200a013a61c', 11, 'Selesai', 2, '', 1, '2025-02-28 05:27:45', '2025-03-03 01:07:15', NULL),
(26, 'bd43bc8a-f594-11ef-b114-0200a013a61c', 12, 'Menunggu', 1, '', 0, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(27, 'bd43ea48-f594-11ef-bc67-0200a013a61c', 12, 'Lulus', 2, '', 1, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(28, 'bd441d24-f594-11ef-936b-0200a013a61c', 12, 'Gagal', 3, '', 1, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(29, 'bd447df0-f594-11ef-a075-0200a013a61c', 13, 'Menunggu', 1, '', 0, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(30, 'bd44aeba-f594-11ef-a839-0200a013a61c', 13, 'Selesai', 2, '', 1, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(31, 'bd450d4c-f594-11ef-bcc1-0200a013a61c', 14, 'Menunggu', 1, '', 0, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(32, 'bd4538a8-f594-11ef-add2-0200a013a61c', 14, 'Selesai', 2, '', 1, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(33, 'f230b70a-f8a4-11ef-a106-0200a013a61c', 20, 'Menunggu', 1, NULL, 0, '2025-03-04 03:01:19', '2025-03-04 03:01:46', NULL),
(34, 'f23103ea-f8a4-11ef-a7e8-0200a013a61c', 20, 'Selesai', 2, NULL, 1, '2025-03-04 03:01:19', '2025-03-04 03:01:46', NULL);

INSERT INTO `admission_stages` (`id`, `uuid`, `model_type`, `model_id`, `type`, `title`, `sort_number`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'bd39cce8-f594-11ef-b96a-0200a013a61c', 'App\\Models\\School', 1, 'PRE', 'Observasi Calon Siswa', 1, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(2, 'bd3a83ea-f594-11ef-b61e-0200a013a61c', 'App\\Models\\School', 1, 'PRE', 'Penyampaian Hasil Observasi Calon Siswa', 2, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(3, 'bd3b14b8-f594-11ef-879a-0200a013a61c', 'App\\Models\\School', 1, 'PRE', 'Wawancara Wali', 3, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(4, 'bd3bdbfa-f594-11ef-8e53-0200a013a61c', 'App\\Models\\School', 1, 'POST', 'Kelengkapan Seragam', 4, '2025-02-28 05:27:45', '2025-03-04 02:59:19', NULL),
(5, 'bd3c70e2-f594-11ef-ad42-0200a013a61c', 'App\\Models\\School', 1, 'POST', 'Kelengkapan Buku', 5, '2025-02-28 05:27:45', '2025-03-04 02:59:19', NULL),
(6, 'bd3de3a0-f594-11ef-b955-0200a013a61c', 'App\\Models\\School', 2, 'PRE', 'Wawancara Wali', 1, '2025-02-28 05:27:45', '2025-03-04 03:01:19', NULL),
(7, 'bd3eb2bc-f594-11ef-8e82-0200a013a61c', 'App\\Models\\School', 2, 'POST', 'Kelengkapan Seragam', 2, '2025-02-28 05:27:45', '2025-03-04 03:01:19', NULL),
(8, 'bd3f448e-f594-11ef-a6c3-0200a013a61c', 'App\\Models\\School', 2, 'POST', 'Kelengkapan Buku', 3, '2025-02-28 05:27:45', '2025-03-04 03:01:19', NULL),
(9, 'bd40c142-f594-11ef-892b-0200a013a61c', 'App\\Models\\School', 3, 'PRE', 'Wawancara Orang Tua / Wali', 1, '2025-02-28 05:27:45', '2025-03-03 01:07:15', NULL),
(10, 'bd419c16-f594-11ef-8072-0200a013a61c', 'App\\Models\\School', 3, 'POST', 'Kelengkapan Seragam', 2, '2025-02-28 05:27:45', '2025-03-03 01:07:15', NULL),
(11, 'bd4231da-f594-11ef-964a-0200a013a61c', 'App\\Models\\School', 3, 'POST', 'Kelengkapan Buku', 3, '2025-02-28 05:27:45', '2025-03-03 01:07:15', NULL),
(12, 'bd438684-f594-11ef-b1b3-0200a013a61c', 'App\\Models\\School', 4, 'PRE', 'Wawancara Wali', 3, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(13, 'bd444e2a-f594-11ef-b97d-0200a013a61c', 'App\\Models\\School', 4, 'POST', 'Kelengkapan Seragam', 1, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(14, 'bd44df66-f594-11ef-bf62-0200a013a61c', 'App\\Models\\School', 4, 'POST', 'Kelengkapan Buku', 2, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(20, 'f2305d0a-f8a4-11ef-9811-0200a013a61c', 'App\\Models\\School', 2, 'POST', 'Observarsi Penempatan Kelas & Pemilihan Eskul', 4, '2025-03-04 03:01:19', '2025-03-04 03:01:19', NULL);

INSERT INTO `admission_student_quotas` (`id`, `uuid`, `school_id`, `school_year_id`, `school_grade_id`, `max_quota`, `used_quota`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'c479e434-01d8-11f0-817b-0200a013a61c', 1, 1, 1, 20, 0, '2025-03-15 20:04:56', '2025-03-15 20:04:56', NULL),
(2, 'c47a49ec-01d8-11f0-8360-0200a013a61c', 1, 1, 2, 52, 0, '2025-03-15 20:04:56', '2025-03-15 20:04:56', NULL),
(3, 'c47ac0de-01d8-11f0-b310-0200a013a61c', 1, 1, 3, 45, 0, '2025-03-15 20:04:56', '2025-03-15 20:04:56', NULL),
(4, 'c47b0404-01d8-11f0-88f7-0200a013a61c', 1, 1, 4, 60, 0, '2025-03-15 20:04:56', '2025-03-15 20:04:56', NULL);

INSERT INTO `areas` (`id`, `uuid`, `model_type`, `model_id`, `name`, `phone`, `email`, `hotline`, `address`, `logo`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'bcc6b23a-f594-11ef-b863-0200a013a61c', 'App\\Models\\School', 1, 'KB & TK Happy Holy Kids', NULL, 'admin.hhk@hbics.sch.id', NULL, NULL, NULL, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(2, 'bcc76ac2-f594-11ef-ae7b-0200a013a61c', 'App\\Models\\School', 2, 'SDK Harapan Bangsa', NULL, 'admin.sdk@hbics.sch.id', NULL, NULL, NULL, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(3, 'bcc817b0-f594-11ef-99b8-0200a013a61c', 'App\\Models\\School', 3, 'SMPK Harapan Bangsa', NULL, 'admin.smpk@hbics.sch.id', NULL, NULL, NULL, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(4, 'bcc8f5d6-f594-11ef-950f-0200a013a61c', 'App\\Models\\School', 4, 'SMAK Harapan Bangsa', NULL, 'admin.smak@hbics.sch.id', NULL, NULL, NULL, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(5, 'bcc9d69a-f594-11ef-92c0-0200a013a61c', 'App\\Models\\Office', 1, 'HCM', NULL, NULL, NULL, NULL, NULL, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(6, 'bcca72e4-f594-11ef-9864-0200a013a61c', 'App\\Models\\Office', 2, 'QRD', NULL, NULL, NULL, NULL, NULL, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(7, 'bccb1096-f594-11ef-ad2a-0200a013a61c', 'App\\Models\\Office', 3, 'FA', NULL, NULL, NULL, NULL, NULL, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(8, 'bccb9b06-f594-11ef-a46c-0200a013a61c', 'App\\Models\\Office', 4, 'ICC', NULL, NULL, NULL, NULL, NULL, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(9, 'bccc2724-f594-11ef-9c71-0200a013a61c', 'App\\Models\\Office', 5, 'GA', NULL, NULL, NULL, NULL, NULL, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(10, 'bcccb4a0-f594-11ef-94f5-0200a013a61c', 'App\\Models\\Office', 6, 'Management', NULL, NULL, NULL, NULL, NULL, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL);

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('admin1@gmail.com|172.68.211.200', 'i:1;', 1740724526),
('admin1@gmail.com|172.68.211.200:timer', 'i:1740724526;', 1740724526),
('admin1@gmail.com|172.70.214.26', 'i:1;', 1740723769),
('admin1@gmail.com|172.70.214.26:timer', 'i:1740723769;', 1740723769),
('bungaratnasari.hb-secondary@hbics.sch.id|172.69.22.234', 'i:2;', 1740963112),
('bungaratnasari.hb-secondary@hbics.sch.id|172.69.22.234:timer', 'i:1740963112;', 1740963112),
('bungaratnasari.hb-secondary@hbics.sch.id|172.71.210.172', 'i:1;', 1740728216),
('bungaratnasari.hb-secondary@hbics.sch.id|172.71.210.172:timer', 'i:1740728216;', 1740728216),
('nataliaheriati.hhk@hbics.sch.id|172.70.206.6', 'i:1;', 1740963175),
('nataliaheriati.hhk@hbics.sch.id|172.70.206.6:timer', 'i:1740963175;', 1740963175);

INSERT INTO `employee_assignments` (`id`, `uuid`, `employee_id`, `area_id`, `position_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'bd4735c2-f594-11ef-9331-0200a013a61c', 1, 1, 2, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(2, 'bd48c4a0-f594-11ef-a9f3-0200a013a61c', 2, 1, 2, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(3, 'bd4a1f08-f594-11ef-bc32-0200a013a61c', 3, 1, 3, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(4, 'bd4b7d94-f594-11ef-aaeb-0200a013a61c', 4, 7, 4, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(5, 'bd4e064a-f594-11ef-ac3e-0200a013a61c', 6, 1, 5, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(6, 'bd4f5d60-f594-11ef-9bae-0200a013a61c', 7, 1, 6, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(7, 'bd50bb56-f594-11ef-a787-0200a013a61c', 8, 1, 2, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(8, 'bd520448-f594-11ef-9a08-0200a013a61c', 9, 1, 2, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(9, 'bd53641e-f594-11ef-aaca-0200a013a61c', 10, 1, 2, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(10, 'bd54c5e8-f594-11ef-b0e9-0200a013a61c', 11, 1, 2, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(11, 'bd56138a-f594-11ef-a339-0200a013a61c', 12, 1, 2, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(12, 'bd576546-f594-11ef-9785-0200a013a61c', 13, 1, 7, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(13, 'bd58b4dc-f594-11ef-9371-0200a013a61c', 14, 1, 2, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(14, 'bd59fb80-f594-11ef-84b4-0200a013a61c', 15, 1, 8, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(15, 'bd5b4f80-f594-11ef-a9b9-0200a013a61c', 16, 1, 9, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(16, 'bd5cae16-f594-11ef-bdab-0200a013a61c', 17, 1, 2, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(17, 'bd5df7d0-f594-11ef-90b7-0200a013a61c', 18, 1, 10, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(18, 'bd5f5c9c-f594-11ef-8df6-0200a013a61c', 19, 1, 2, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(19, 'bd60c2d0-f594-11ef-ab90-0200a013a61c', 20, 1, 11, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(20, 'bd6230c0-f594-11ef-8919-0200a013a61c', 21, 1, 2, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(21, 'bd6397da-f594-11ef-a654-0200a013a61c', 22, 1, 2, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(22, 'bd64fd96-f594-11ef-b6e8-0200a013a61c', 23, 1, 2, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(23, 'bd667d74-f594-11ef-96ba-0200a013a61c', 24, 2, 12, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(24, 'bd67f55a-f594-11ef-95a0-0200a013a61c', 25, 2, 13, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(25, 'bd696e94-f594-11ef-8aab-0200a013a61c', 26, 2, 14, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(26, 'bd6adfa4-f594-11ef-b847-0200a013a61c', 27, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(27, 'bd6c6c20-f594-11ef-8bf0-0200a013a61c', 28, 2, 16, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(28, 'bd6e15b6-f594-11ef-a25b-0200a013a61c', 29, 2, 17, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(29, 'bd6fed6e-f594-11ef-b4e0-0200a013a61c', 30, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(30, 'bd71a622-f594-11ef-aa2d-0200a013a61c', 31, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(31, 'bd731e6c-f594-11ef-a8e4-0200a013a61c', 32, 10, 18, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(32, 'bd74c26c-f594-11ef-8b62-0200a013a61c', 33, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(33, 'bd76348a-f594-11ef-bb9e-0200a013a61c', 34, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(34, 'bd77c930-f594-11ef-9db4-0200a013a61c', 35, 2, 19, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(35, 'bd79a64c-f594-11ef-addd-0200a013a61c', 36, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(36, 'bd7b3048-f594-11ef-abf4-0200a013a61c', 37, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(37, 'bd7ca09a-f594-11ef-b7b3-0200a013a61c', 38, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(38, 'bd7e7e06-f594-11ef-83bf-0200a013a61c', 39, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(39, 'bd7ff646-f594-11ef-9c7a-0200a013a61c', 40, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(40, 'bd8197da-f594-11ef-a7f2-0200a013a61c', 41, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(41, 'bd830250-f594-11ef-9192-0200a013a61c', 42, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(42, 'bd84dc9c-f594-11ef-b690-0200a013a61c', 43, 2, 20, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(43, 'bd86bcd8-f594-11ef-96bc-0200a013a61c', 44, 2, 21, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(44, 'bd88c4b0-f594-11ef-b4b6-0200a013a61c', 45, 2, 22, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(45, 'bd8a7148-f594-11ef-85c4-0200a013a61c', 46, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(46, 'bd8cbc6e-f594-11ef-abf8-0200a013a61c', 47, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(47, 'bd8ebdfc-f594-11ef-86f2-0200a013a61c', 48, 4, 23, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(48, 'bd904492-f594-11ef-9448-0200a013a61c', 49, 6, 24, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(49, 'bd91a0b2-f594-11ef-abb9-0200a013a61c', 50, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(50, 'bd9317c6-f594-11ef-9139-0200a013a61c', 51, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(51, 'bd959f32-f594-11ef-b64e-0200a013a61c', 52, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(52, 'bd97add6-f594-11ef-b564-0200a013a61c', 53, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(53, 'bd99204e-f594-11ef-a46f-0200a013a61c', 54, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(54, 'bd9a8aba-f594-11ef-bcaa-0200a013a61c', 55, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(55, 'bd9c1308-f594-11ef-a211-0200a013a61c', 56, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(56, 'bd9d926e-f594-11ef-bf20-0200a013a61c', 57, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(57, 'bd9f12d8-f594-11ef-a0ce-0200a013a61c', 58, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(58, 'bda083d4-f594-11ef-9d73-0200a013a61c', 59, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(59, 'bda1fbe2-f594-11ef-b602-0200a013a61c', 60, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(60, 'bda3777e-f594-11ef-bdc1-0200a013a61c', 61, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(61, 'bda4e1d6-f594-11ef-bb12-0200a013a61c', 62, 2, 15, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(62, 'bda64b48-f594-11ef-a3eb-0200a013a61c', 63, 4, 25, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(63, 'bda7231a-f594-11ef-a45d-0200a013a61c', 64, 4, 26, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(64, 'bda87e86-f594-11ef-a9f9-0200a013a61c', 65, 3, 27, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(65, 'bda9f0f4-f594-11ef-9078-0200a013a61c', 66, 3, 28, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(66, 'bdabafc0-f594-11ef-ab8e-0200a013a61c', 67, 3, 27, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(67, 'bdad6400-f594-11ef-bc1d-0200a013a61c', 68, 4, 23, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(68, 'bdaef2b6-f594-11ef-8f7f-0200a013a61c', 69, 10, 18, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(69, 'bdb079ce-f594-11ef-9b40-0200a013a61c', 70, 4, 29, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(70, 'bdb1f376-f594-11ef-9fbd-0200a013a61c', 71, 4, 23, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(71, 'bdb30b1c-f594-11ef-aff7-0200a013a61c', 72, 4, 30, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(72, 'bdb47dbc-f594-11ef-a485-0200a013a61c', 73, 3, 27, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(73, 'bdb5f03e-f594-11ef-b8a3-0200a013a61c', 74, 10, 18, '2025-02-28 05:27:45', '2025-03-02 23:38:56', '2025-03-02 23:38:56'),
(74, 'bdb7852a-f594-11ef-a287-0200a013a61c', 75, 3, 27, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(75, 'bdb8f04a-f594-11ef-add0-0200a013a61c', 76, 3, 31, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(76, 'bdbc8ec6-f594-11ef-a2ce-0200a013a61c', 77, 3, 27, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(77, 'bdbe1840-f594-11ef-8446-0200a013a61c', 78, 4, 32, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(78, 'bdc046a6-f594-11ef-9214-0200a013a61c', 79, 3, 27, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(79, 'bdc1d458-f594-11ef-88db-0200a013a61c', 80, 3, 27, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(80, 'bdc38f8c-f594-11ef-9a4d-0200a013a61c', 81, 3, 33, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(81, 'bdc565e6-f594-11ef-847c-0200a013a61c', 82, 3, 27, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(82, 'bdc75d4c-f594-11ef-b6fa-0200a013a61c', 83, 4, 23, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(83, 'bdc8f0b2-f594-11ef-85e6-0200a013a61c', 84, 4, 23, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(84, 'bdcb4088-f594-11ef-8ce9-0200a013a61c', 85, 4, 23, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(85, 'bdcd1a0c-f594-11ef-89a5-0200a013a61c', 86, 4, 23, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(86, 'bdcedc52-f594-11ef-80c9-0200a013a61c', 87, 4, 23, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(87, 'bdd0995c-f594-11ef-8637-0200a013a61c', 88, 4, 23, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(88, 'bdd274f2-f594-11ef-9374-0200a013a61c', 89, 4, 23, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(89, 'bdd419c4-f594-11ef-99d5-0200a013a61c', 90, 3, 34, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(90, 'bdd5858e-f594-11ef-bca3-0200a013a61c', 91, 10, 18, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(91, 'bdd701f2-f594-11ef-b1f4-0200a013a61c', 92, 7, 35, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(92, 'bdd89c60-f594-11ef-af28-0200a013a61c', 93, 7, 35, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(93, 'bdda7ed6-f594-11ef-b58f-0200a013a61c', 94, 7, 35, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(94, 'bddc4806-f594-11ef-a8f9-0200a013a61c', 95, 7, 35, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(95, 'bdddecba-f594-11ef-a73f-0200a013a61c', 96, 9, 36, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(96, 'bddf8fac-f594-11ef-abd6-0200a013a61c', 97, 5, 37, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(97, 'bde146da-f594-11ef-881c-0200a013a61c', 98, 9, 38, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(98, 'bde315f0-f594-11ef-8642-0200a013a61c', 99, 9, 39, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(99, 'bde4a776-f594-11ef-aee8-0200a013a61c', 100, 9, 40, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(100, 'bde681c2-f594-11ef-b34c-0200a013a61c', 101, 5, 41, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(101, 'bde856be-f594-11ef-b588-0200a013a61c', 102, 9, 42, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(102, 'bdea1ad0-f594-11ef-a9c3-0200a013a61c', 103, 9, 42, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(103, 'bdebf328-f594-11ef-85dc-0200a013a61c', 104, 9, 40, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(104, 'bdedaf1a-f594-11ef-9097-0200a013a61c', 105, 9, 43, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(105, 'bdef417c-f594-11ef-9676-0200a013a61c', 106, 9, 40, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(106, 'bdf0e130-f594-11ef-9479-0200a013a61c', 107, 9, 42, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(107, 'bdf1f1c4-f594-11ef-85a9-0200a013a61c', 108, 9, 42, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(108, 'bdf3839a-f594-11ef-a993-0200a013a61c', 109, 6, 44, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(109, 'bdf51a48-f594-11ef-8e1e-0200a013a61c', 110, 8, 45, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(110, 'bdf6b84e-f594-11ef-a95f-0200a013a61c', 111, 8, 45, '2025-02-28 05:27:46', '2025-02-28 07:30:48', '2025-02-28 07:30:48'),
(111, 'bdf836ec-f594-11ef-ae82-0200a013a61c', 112, 6, 46, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(112, 'bdf9e1ea-f594-11ef-b54a-0200a013a61c', 113, 6, 24, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(113, 'bdfb99c2-f594-11ef-9b02-0200a013a61c', 114, 5, 47, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(114, 'bdfd655e-f594-11ef-a540-0200a013a61c', 115, 9, 43, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(115, 'bdfe81aa-f594-11ef-8aaf-0200a013a61c', 116, 2, 48, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(116, 'be004184-f594-11ef-80fe-0200a013a61c', 117, 4, 23, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(117, '0a534c56-f5a5-11ef-9627-0200a013a61c', 32, 8, 45, '2025-02-28 07:24:26', '2025-02-28 07:24:26', NULL),
(118, '138229be-f5a5-11ef-bfe8-0200a013a61c', 15, 8, 45, '2025-02-28 07:24:41', '2025-02-28 07:24:41', NULL),
(119, '1aad6c1c-f5a5-11ef-a8ec-0200a013a61c', 91, 8, 45, '2025-02-28 07:24:53', '2025-02-28 07:24:53', NULL),
(120, '2abcc378-f5a5-11ef-9429-0200a013a61c', 69, 8, 45, '2025-02-28 07:25:20', '2025-02-28 07:25:20', NULL),
(121, '7d54b61a-f7bf-11ef-8e06-0200a013a61c', 118, 10, 18, '2025-03-02 23:38:48', '2025-03-02 23:38:48', NULL),
(122, '88b9610e-f7bf-11ef-984c-0200a013a61c', 15, 10, 18, '2025-03-02 23:39:07', '2025-03-02 23:39:07', NULL),
(123, '97736db6-f7bf-11ef-aacb-0200a013a61c', 118, 8, 45, '2025-03-02 23:39:32', '2025-03-02 23:39:32', NULL);

INSERT INTO `employees` (`id`, `uuid`, `profile_id`, `identity_number`, `start_date`, `end_date`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'bd46cf92-f594-11ef-85a7-0200a013a61c', 3, '000000000', '2025-02-25', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(2, 'bd486ac8-f594-11ef-af7a-0200a013a61c', 4, '90.099.189.123', '2024-07-10', '2024-07-31', 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(3, 'bd49c800-f594-11ef-9977-0200a013a61c', 5, '04.002.080507', '2007-05-08', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(4, 'bd4b2164-f594-11ef-84d4-0200a013a61c', 6, '02.144.140519', '2019-05-14', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(5, 'bd4c75e6-f594-11ef-9815-0200a013a61c', 7, '201.1110.100.2000', '2024-07-11', '2027-03-04', 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(6, 'bd4da6dc-f594-11ef-aa3f-0200a013a61c', 8, '04.005.110110', '2010-01-11', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(7, 'bd4f0496-f594-11ef-a5d3-0200a013a61c', 9, '03.10.010712', '2012-07-01', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(8, 'bd5066b0-f594-11ef-9f5a-0200a013a61c', 10, '04.029.070714', '2014-07-07', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(9, 'bd51a778-f594-11ef-83c4-0200a013a61c', 11, '04.026.160514', '2014-05-16', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(10, 'bd530bfe-f594-11ef-b587-0200a013a61c', 12, '04.046.230622', '2022-06-23', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(11, 'bd546242-f594-11ef-9aa3-0200a013a61c', 13, '04.048.010822', '2022-08-01', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(12, 'bd55b872-f594-11ef-8188-0200a013a61c', 14, '03.07.241112', '2011-11-24', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(13, 'bd570c18-f594-11ef-a148-0200a013a61c', 15, '04.02.1220615', '2015-06-24', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(14, 'bd585ae6-f594-11ef-b049-0200a013a61c', 16, '04.049.130723', '2023-07-13', '2026-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(15, 'bd59a1da-f594-11ef-a05b-0200a013a61c', 17, '03.11.160113', '2013-01-16', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(16, 'bd5af472-f594-11ef-bc12-0200a013a61c', 18, '04.043.180618', '2018-06-18', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(17, 'bd5c54ac-f594-11ef-bc0c-0200a013a61c', 19, '03.004.010411', '2011-04-01', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(18, 'bd5d9af6-f594-11ef-a194-0200a013a61c', 20, '04.045.210322', '2022-03-21', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(19, 'bd5f042c-f594-11ef-ab01-0200a013a61c', 21, '04.051.300819', '2019-08-30', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(20, 'bd605caa-f594-11ef-a8eb-0200a013a61c', 22, '04.044.240619', '2019-06-24', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(21, 'bd61cf86-f594-11ef-9361-0200a013a61c', 23, '04.052.210624', '2024-06-21', '2027-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(22, 'bd633d4e-f594-11ef-add7-0200a013a61c', 24, '04.053.270624', '2024-06-27', '2027-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(23, 'bd64a59e-f594-11ef-9c89-0200a013a61c', 25, '04.050.210923', '2023-09-21', '2026-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(24, 'bd661b0e-f594-11ef-9a98-0200a013a61c', 26, '05.097.220616', '2016-06-22', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(25, 'bd6797e0-f594-11ef-92ad-0200a013a61c', 27, '05.018.010811', '2011-08-01', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(26, 'bd6913c2-f594-11ef-a8f2-0200a013a61c', 28, '05.038.010513', '2013-05-01', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(27, 'bd6a864e-f594-11ef-ace4-0200a013a61c', 29, '05.159.010922', '2022-09-01', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(28, 'bd6bf876-f594-11ef-805e-0200a013a61c', 30, '05.091.280316', '2016-03-28', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(29, 'bd6da9e6-f594-11ef-928f-0200a013a61c', 31, '05.089.280316', '2016-03-28', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(30, 'bd6f652e-f594-11ef-9ac9-0200a013a61c', 32, '05.137.050421', '2021-04-05', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(31, 'bd7137a0-f594-11ef-a54c-0200a013a61c', 33, '05.160.311022', '2022-10-31', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(32, 'bd72c0ac-f594-11ef-9dfd-0200a013a61c', 34, '02.153.080321', '2021-03-08', '2024-12-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(33, 'bd745de0-f594-11ef-a469-0200a013a61c', 35, '05.149.080721', '2021-07-08', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(34, 'bd75d99a-f594-11ef-9985-0200a013a61c', 36, '05.162.030723', '2023-07-03', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(35, 'bd776b70-f594-11ef-998f-0200a013a61c', 37, '05.086.280316', '2016-03-28', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(36, 'bd793dc4-f594-11ef-836d-0200a013a61c', 38, '05.140.200421', '2021-04-20', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(37, 'bd7ac75c-f594-11ef-9a9c-0200a013a61c', 39, '05.123.180219', '2019-02-18', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(38, 'bd7c3db2-f594-11ef-8be1-0200a013a61c', 40, '05.161.211122', '2022-11-21', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(39, 'bd7e10f6-f594-11ef-8a9e-0200a013a61c', 41, '05.157.270622', '2022-06-27', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(40, 'bd7f912e-f594-11ef-95c2-0200a013a61c', 42, '05.158.270622', '2022-06-27', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(41, 'bd81225a-f594-11ef-bb00-0200a013a61c', 43, '05.079.041015', '2015-10-04', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(42, 'bd82aa1c-f594-11ef-ab78-0200a013a61c', 44, '05.152.070322', '2022-03-07', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(43, 'bd846e2e-f594-11ef-8eb5-0200a013a61c', 45, '05.151.120721', '2021-07-12', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(44, 'bd865cc0-f594-11ef-9810-0200a013a61c', 46, '05.138.050421', '2021-04-05', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(45, 'bd8862cc-f594-11ef-ad9c-0200a013a61c', 47, '05.134.220321', '2021-03-22', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(46, 'bd8a07f8-f594-11ef-b358-0200a013a61c', 48, '05.163.100723', '2023-07-10', '2026-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(47, 'bd8c4d74-f594-11ef-a5b5-0200a013a61c', 49, '05.154.240622', '2022-06-24', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(48, 'bd8e4f34-f594-11ef-b4ea-0200a013a61c', 50, '05.150.120721', '2021-07-12', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(49, 'bd8fe1dc-f594-11ef-8d51-0200a013a61c', 51, '04.037.270420', '2020-04-27', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(50, 'bd9147ac-f594-11ef-83b7-0200a013a61c', 52, '05.122.101218', '2018-12-10', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(51, 'bd92b3b2-f594-11ef-a00a-0200a013a61c', 53, '05.146.160621', '2021-06-16', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(52, 'bd94c7d8-f594-11ef-9601-0200a013a61c', 54, '05.166.060324', '2024-03-06', '2027-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(53, 'bd974be8-f594-11ef-91f1-0200a013a61c', 55, '05.167.130524', '2024-05-13', '2027-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(54, 'bd98bc4e-f594-11ef-9edf-0200a013a61c', 56, '05.168.280624', '2024-06-28', '2027-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(55, 'bd9a2fb6-f594-11ef-b7d4-0200a013a61c', 57, '05.169.270624', '2024-07-01', '2027-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(56, 'bd9bac74-f594-11ef-89b1-0200a013a61c', 58, '05.170.280624', '2024-07-01', '2027-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(57, 'bd9d3314-f594-11ef-b208-0200a013a61c', 59, '05.171.020724', '2024-07-02', '2027-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(58, 'bd9eaa46-f594-11ef-892a-0200a013a61c', 60, '05.172.110724', '2024-07-11', '2027-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(59, 'bda027ae-f594-11ef-8f57-0200a013a61c', 61, '05.173.110724', '2024-07-11', '2027-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(60, 'bda19bde-f594-11ef-88b2-0200a013a61c', 62, '05.174.080724', '2024-07-08', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(61, 'bda30fa0-f594-11ef-aae8-0200a013a61c', 63, '05.175.150724', '2024-07-15', '2027-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(62, 'bda482a4-f594-11ef-ac68-0200a013a61c', 64, '05.139.200421', '2021-04-20', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(63, 'bda5f332-f594-11ef-abb0-0200a013a61c', 65, '06.01.010714', '2006-09-01', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(64, 'bda6c99c-f594-11ef-83c0-0200a013a61c', 66, '06.014.120716', '2016-07-12', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(65, 'bda81f9a-f594-11ef-920f-0200a013a61c', 67, '05.094.020516', '2016-05-02', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(66, 'bda9895c-f594-11ef-894a-0200a013a61c', 68, '06.053.071019', '2019-10-07', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(67, 'bdab3a9a-f594-11ef-8620-0200a013a61c', 69, '06.071.141022', '2022-10-14', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(68, 'bdacf8ee-f594-11ef-9c41-0200a013a61c', 70, '06.075.250523', '2023-05-25', '2026-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(69, 'bdae90dc-f594-11ef-a683-0200a013a61c', 71, '06.069.250722', '2022-07-25', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(70, 'bdb01696-f594-11ef-9af9-0200a013a61c', 72, '02.011.010811', '2011-08-01', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(71, 'bdb1943a-f594-11ef-84a3-0200a013a61c', 73, '06.065.170621', '2021-06-17', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(72, 'bdb2abf4-f594-11ef-aef0-0200a013a61c', 74, '06.040.031218', '2018-12-03', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(73, 'bdb417a0-f594-11ef-a9fc-0200a013a61c', 75, '06.074.220523', '2023-05-22', '2026-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(74, 'bdb593aa-f594-11ef-865a-0200a013a61c', 76, '06.078.101123', '2023-11-10', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(75, 'bdb7201c-f594-11ef-8264-0200a013a61c', 77, '06.072.010323', '2023-03-01', '2026-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(76, 'bdb8932a-f594-11ef-a9b3-0200a013a61c', 78, '06.060.200421', '2021-04-20', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(77, 'bdbc1ea0-f594-11ef-9bc9-0200a013a61c', 79, '06.073.010323', '2023-03-01', '2026-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(78, 'bdbdbf3a-f594-11ef-88c2-0200a013a61c', 80, '06.03.010614', '2014-06-02', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(79, 'bdbfd8ce-f594-11ef-8ffc-0200a013a61c', 81, '06.070.110822', '2022-08-11', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(80, 'bdc174ae-f594-11ef-81c1-0200a013a61c', 82, '06.067.060722', '2022-06-06', '2026-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(81, 'bdc32524-f594-11ef-94ff-0200a013a61c', 83, '06.076.310523', '2023-05-31', '2026-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(82, 'bdc4eec2-f594-11ef-8838-0200a013a61c', 84, '06.066.160921', '2021-09-16', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(83, 'bdc6ecf4-f594-11ef-8188-0200a013a61c', 85, '06.062.200421', '2021-04-20', NULL, 'PERMANENT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(84, 'bdc88bae-f594-11ef-9bca-0200a013a61c', 86, '06.079.250324', '2024-03-25', '2027-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(85, 'bdcac248-f594-11ef-a570-0200a013a61c', 87, '06.080.240624', '2024-06-24', '2027-06-20', 'CONTRACT', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(86, 'bdccaa0e-f594-11ef-9f02-0200a013a61c', 88, '06.081.240624', '2024-06-24', '2027-06-20', 'CONTRACT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(87, 'bdce6876-f594-11ef-86be-0200a013a61c', 89, '06.082.260624', '2024-06-26', '2027-06-20', 'CONTRACT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(88, 'bdd0238c-f594-11ef-933d-0200a013a61c', 90, '06.083.010724', '2024-07-01', '2027-06-20', 'CONTRACT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(89, 'bdd20512-f594-11ef-9fcf-0200a013a61c', 91, '06.084.100724', '2024-07-10', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(90, 'bdd3ba4c-f594-11ef-9562-0200a013a61c', 92, '06.058.190421', '2021-04-19', NULL, 'PERMANENT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(91, 'bdd52968-f594-11ef-8e2b-0200a013a61c', 93, '05.153.180422', '2022-04-18', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(92, 'bdd69bb8-f594-11ef-aea7-0200a013a61c', 94, '02.168.020323', '2023-03-02', '2025-03-02', 'CONTRACT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(93, 'bdd82faa-f594-11ef-95c3-0200a013a61c', 95, '02.161.210422', '2022-04-21', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(94, 'bdd9fbd2-f594-11ef-9c55-0200a013a61c', 96, '02.051.311014', '2014-10-31', NULL, 'PERMANENT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(95, 'bddbd650-f594-11ef-8404-0200a013a61c', 97, '02.163.020922', '2022-10-12', '2024-10-12', 'CONTRACT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(96, 'bddd813a-f594-11ef-81bd-0200a013a61c', 98, '02.099.080317', '2017-03-08', NULL, 'PERMANENT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(97, 'bddf1554-f594-11ef-921e-0200a013a61c', 99, '02.089.020816', '2016-08-02', NULL, 'PERMANENT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(98, 'bde0d538-f594-11ef-8950-0200a013a61c', 100, '02.165.010223', '2023-02-01', '2025-02-01', 'CONTRACT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(99, 'bde2a6a6-f594-11ef-959a-0200a013a61c', 101, '02.082.220216', '2016-02-22', NULL, 'PERMANENT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(100, 'bde43cc8-f594-11ef-8aa2-0200a013a61c', 102, '02.003.010107', '2007-01-01', NULL, 'PERMANENT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(101, 'bde60698-f594-11ef-bfe8-0200a013a61c', 103, '02.166.160223', '2023-02-16', '2026-06-20', 'CONTRACT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(102, 'bde7da68-f594-11ef-9ec5-0200a013a61c', 104, '02.138.170718', '2018-07-17', NULL, 'PERMANENT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(103, 'bde99bb4-f594-11ef-8e6d-0200a013a61c', 105, '02.009.180612', '2009-06-18', NULL, 'PERMANENT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(104, 'bdeb7b96-f594-11ef-b37c-0200a013a61c', 106, '02.001.010606', '2006-06-01', NULL, 'PERMANENT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(105, 'bded3f3a-f594-11ef-971d-0200a013a61c', 107, '02.101.310317', '2017-03-31', NULL, 'PERMANENT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(106, 'bdeed5b6-f594-11ef-b070-0200a013a61c', 108, '02.162.020922', '2022-09-02', '2024-12-03', 'CONTRACT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(107, 'bdf07b96-f594-11ef-8c8e-0200a013a61c', 109, '02.067.271112', '2012-11-27', NULL, 'PERMANENT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(108, 'bdf18310-f594-11ef-8b90-0200a013a61c', 110, '02.174.290424', '2024-04-29', '2025-04-28', 'CONTRACT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(109, 'bdf31a68-f594-11ef-ba0c-0200a013a61c', 111, '02.169.021023', '2023-10-02', NULL, 'PERMANENT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(110, 'bdf4ae8c-f594-11ef-9748-0200a013a61c', 112, '02.159.190922', '2022-09-19', '2024-09-19', 'CONTRACT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(111, 'bdf64918-f594-11ef-8b8c-0200a013a61c', 113, '02.167.160223', '2023-02-16', '2025-02-16', 'CONTRACT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(112, 'bdf7cb26-f594-11ef-8ffa-0200a013a61c', 114, '02.137.180618', '2018-06-18', NULL, 'PERMANENT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(113, 'bdf9762e-f594-11ef-a577-0200a013a61c', 115, '02.173.300123', '2023-01-30', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(114, 'bdfb2a6e-f594-11ef-8d0a-0200a013a61c', 116, '06.037.010617', '2017-06-01', NULL, 'PERMANENT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(115, 'bdfce854-f594-11ef-819b-0200a013a61c', 117, '02.175.280824', '2024-08-28', '2025-08-27', 'CONTRACT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(116, 'bdfe00b8-f594-11ef-b64f-0200a013a61c', 118, '05.176.220724', '2024-07-22', '2025-06-20', 'CONTRACT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(117, 'bdffca42-f594-11ef-b247-0200a013a61c', 119, '06.085.050824', '2024-08-05', '2027-06-20', 'CONTRACT', '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(118, '412425e0-f7bf-11ef-8bdb-0200a013a61c', 120, '000.000.000001', '2025-02-03', '2026-02-03', 'PROBATION', '2025-03-02 23:37:07', '2025-03-02 23:38:25', NULL);

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_auth_tables', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_01_29_135255_create_permission_tables', 1),
(5, '2025_01_29_135713_create_chats_table', 1),
(6, '2025_01_30_030137_create_information_tables', 1),
(7, '2025_01_30_030237_create_entity_tables', 1),
(8, '2025_01_30_030338_create_organization_tables', 1),
(9, '2025_01_30_035311_create_submission_tables', 1),
(10, '2025_01_30_055317_create_publication_tables', 1),
(11, '2025_01_30_071832_create_transaction_tables', 1),
(12, '2025_01_30_073808_create_admission_tables', 1),
(13, '2025_03_03_090847_create_school_tables', 2),
(14, '2025_01_30_030338_create_office_tables', 3),
(15, '2025_01_30_030339_create_school_tables', 3),
(16, '2025_03_05_061740_update_columns_families_table', 3);

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(3, 'App\\Models\\User', 3),
(3, 'App\\Models\\User', 4),
(3, 'App\\Models\\User', 5),
(3, 'App\\Models\\User', 6),
(3, 'App\\Models\\User', 7),
(3, 'App\\Models\\User', 8),
(3, 'App\\Models\\User', 9),
(3, 'App\\Models\\User', 10),
(3, 'App\\Models\\User', 11),
(3, 'App\\Models\\User', 12),
(3, 'App\\Models\\User', 13),
(3, 'App\\Models\\User', 14),
(3, 'App\\Models\\User', 15),
(3, 'App\\Models\\User', 16),
(3, 'App\\Models\\User', 17),
(3, 'App\\Models\\User', 18),
(3, 'App\\Models\\User', 19),
(3, 'App\\Models\\User', 20),
(3, 'App\\Models\\User', 21),
(3, 'App\\Models\\User', 22),
(3, 'App\\Models\\User', 23),
(3, 'App\\Models\\User', 24),
(3, 'App\\Models\\User', 25),
(3, 'App\\Models\\User', 26),
(3, 'App\\Models\\User', 27),
(3, 'App\\Models\\User', 28),
(3, 'App\\Models\\User', 29),
(3, 'App\\Models\\User', 30),
(3, 'App\\Models\\User', 31),
(3, 'App\\Models\\User', 32),
(3, 'App\\Models\\User', 33),
(3, 'App\\Models\\User', 34),
(3, 'App\\Models\\User', 35),
(3, 'App\\Models\\User', 36),
(3, 'App\\Models\\User', 37),
(3, 'App\\Models\\User', 38),
(3, 'App\\Models\\User', 39),
(3, 'App\\Models\\User', 40),
(3, 'App\\Models\\User', 41),
(3, 'App\\Models\\User', 42),
(3, 'App\\Models\\User', 43),
(3, 'App\\Models\\User', 44),
(3, 'App\\Models\\User', 45),
(3, 'App\\Models\\User', 46),
(3, 'App\\Models\\User', 47),
(3, 'App\\Models\\User', 48),
(3, 'App\\Models\\User', 49),
(3, 'App\\Models\\User', 50),
(3, 'App\\Models\\User', 51),
(3, 'App\\Models\\User', 52),
(3, 'App\\Models\\User', 53),
(3, 'App\\Models\\User', 54),
(3, 'App\\Models\\User', 55),
(3, 'App\\Models\\User', 56),
(3, 'App\\Models\\User', 57),
(3, 'App\\Models\\User', 58),
(3, 'App\\Models\\User', 59),
(3, 'App\\Models\\User', 60),
(3, 'App\\Models\\User', 61),
(3, 'App\\Models\\User', 62),
(3, 'App\\Models\\User', 63),
(3, 'App\\Models\\User', 64),
(3, 'App\\Models\\User', 65),
(3, 'App\\Models\\User', 66),
(3, 'App\\Models\\User', 67),
(3, 'App\\Models\\User', 68),
(3, 'App\\Models\\User', 69),
(3, 'App\\Models\\User', 70),
(3, 'App\\Models\\User', 71),
(3, 'App\\Models\\User', 72),
(3, 'App\\Models\\User', 73),
(3, 'App\\Models\\User', 74),
(3, 'App\\Models\\User', 75),
(3, 'App\\Models\\User', 76),
(3, 'App\\Models\\User', 77),
(3, 'App\\Models\\User', 78),
(3, 'App\\Models\\User', 79),
(3, 'App\\Models\\User', 80),
(3, 'App\\Models\\User', 81),
(3, 'App\\Models\\User', 82),
(3, 'App\\Models\\User', 83),
(3, 'App\\Models\\User', 84),
(3, 'App\\Models\\User', 85),
(3, 'App\\Models\\User', 86),
(3, 'App\\Models\\User', 87),
(3, 'App\\Models\\User', 88),
(3, 'App\\Models\\User', 89),
(3, 'App\\Models\\User', 90),
(3, 'App\\Models\\User', 91),
(3, 'App\\Models\\User', 92),
(3, 'App\\Models\\User', 93),
(3, 'App\\Models\\User', 94),
(3, 'App\\Models\\User', 95),
(3, 'App\\Models\\User', 96),
(3, 'App\\Models\\User', 97),
(3, 'App\\Models\\User', 98),
(3, 'App\\Models\\User', 99),
(3, 'App\\Models\\User', 100),
(3, 'App\\Models\\User', 101),
(3, 'App\\Models\\User', 102),
(3, 'App\\Models\\User', 103),
(3, 'App\\Models\\User', 104),
(3, 'App\\Models\\User', 105),
(3, 'App\\Models\\User', 106),
(3, 'App\\Models\\User', 107),
(3, 'App\\Models\\User', 108),
(3, 'App\\Models\\User', 109),
(3, 'App\\Models\\User', 110),
(3, 'App\\Models\\User', 111),
(3, 'App\\Models\\User', 112),
(3, 'App\\Models\\User', 113),
(3, 'App\\Models\\User', 114),
(3, 'App\\Models\\User', 115);

INSERT INTO `offices` (`id`, `uuid`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'bcc9a206-f594-11ef-8a6e-0200a013a61c', 'HCM', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(2, 'bcca3e32-f594-11ef-9bb0-0200a013a61c', 'QRD', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(3, 'bccadf54-f594-11ef-8dad-0200a013a61c', 'FA', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(4, 'bccb69b0-f594-11ef-a756-0200a013a61c', 'ICC', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(5, 'bccbf8d0-f594-11ef-9325-0200a013a61c', 'GA', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(6, 'bccc8336-f594-11ef-87dc-0200a013a61c', 'Management', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL);

INSERT INTO `positions` (`id`, `uuid`, `area_id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'bccd5f36-f594-11ef-b61b-0200a013a61c', 3, 'Administrator School', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(2, 'bccde712-f594-11ef-8a72-0200a013a61c', 1, 'Teacher', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(3, 'bcce850a-f594-11ef-9726-0200a013a61c', 1, 'Principal School', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(4, 'bccef364-f594-11ef-b094-0200a013a61c', 7, 'Manager', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(5, 'bccf7870-f594-11ef-868c-0200a013a61c', 1, 'Vice Principal School', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(6, 'bccff84a-f594-11ef-904a-0200a013a61c', 1, 'Vice Principal Curriculum', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(7, 'bcd07414-f594-11ef-9702-0200a013a61c', 1, 'Character Coordinator', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(8, 'bcd0e7be-f594-11ef-8bf4-0200a013a61c', 1, 'Extracurricular Coordinator', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(9, 'bcd15e9c-f594-11ef-b366-0200a013a61c', 1, 'Equipment Coordinator', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(10, 'bcd1f1cc-f594-11ef-ab29-0200a013a61c', 1, 'Administrator School', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(11, 'bcd28fa6-f594-11ef-b92e-0200a013a61c', 1, 'Worship Coordinator', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(12, 'bcd31f20-f594-11ef-8c98-0200a013a61c', 2, 'Principal School', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(13, 'bcd3b2c8-f594-11ef-81eb-0200a013a61c', 2, 'Vice Principal Curriculum', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(14, 'bcd457f0-f594-11ef-9797-0200a013a61c', 2, 'Vice Principal Student Affairs', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(15, 'bcd4e60c-f594-11ef-9cc4-0200a013a61c', 2, 'Teacher', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(16, 'bcd5806c-f594-11ef-8066-0200a013a61c', 2, 'Equipment Coordinator', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(17, 'bcd61630-f594-11ef-a65e-0200a013a61c', 2, 'Facilities Coordinator', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(18, 'bcd6a71c-f594-11ef-9da4-0200a013a61c', 10, 'Staff', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(19, 'bcd732ae-f594-11ef-8fb5-0200a013a61c', 2, 'Extracurricular Coordinator', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(20, 'bcd7baee-f594-11ef-a497-0200a013a61c', 2, 'Worship Coordinator', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(21, 'bcd8475c-f594-11ef-9f38-0200a013a61c', 2, 'Curriculum Coordinator', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(22, 'bcd8d74e-f594-11ef-a691-0200a013a61c', 2, 'Administration Staff', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(23, 'bcd974f6-f594-11ef-8472-0200a013a61c', 4, 'Teacher', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(24, 'bcd9e5ee-f594-11ef-b896-0200a013a61c', 6, 'Staff', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(25, 'bcda82b0-f594-11ef-ad68-0200a013a61c', 4, 'Principal School', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(26, 'bcdaf0f6-f594-11ef-a957-0200a013a61c', 4, 'Vice Principal School', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(27, 'bcdba79e-f594-11ef-a2f2-0200a013a61c', 3, 'Teacher', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(28, 'bcdc21d8-f594-11ef-a23c-0200a013a61c', 3, 'Character Coordinator', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(29, 'bcdca338-f594-11ef-a6ed-0200a013a61c', 4, 'Coordinator School', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(30, 'bcdd198a-f594-11ef-b5ce-0200a013a61c', 4, 'Curriculum Coordinator', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(31, 'bcdd8636-f594-11ef-b4de-0200a013a61c', 3, 'Extracurricular Coordinator', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(32, 'bcddf530-f594-11ef-b6e5-0200a013a61c', 4, 'Character Coordinator', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(33, 'bcde6024-f594-11ef-8a7e-0200a013a61c', 3, 'Administration Staff', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(34, 'bcdecda2-f594-11ef-81b7-0200a013a61c', 3, 'Curriculum Coordinator', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(35, 'bcdf504c-f594-11ef-9004-0200a013a61c', 7, 'Staff', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(36, 'bcdfc694-f594-11ef-9877-0200a013a61c', 9, 'Manager', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(37, 'bce0376e-f594-11ef-868d-0200a013a61c', 5, 'Assistant Manager', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(38, 'bce0c274-f594-11ef-b0ac-0200a013a61c', 9, 'Maintenance Staff', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(39, 'bce12d36-f594-11ef-9dc2-0200a013a61c', 9, 'Maintenance Coordinator', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(40, 'bce1dcea-f594-11ef-8b22-0200a013a61c', 9, 'Driver', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(41, 'bce2512a-f594-11ef-8726-0200a013a61c', 5, 'Staff', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(42, 'bce34ff8-f594-11ef-b30b-0200a013a61c', 9, 'Staff', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(43, 'bce409e8-f594-11ef-b569-0200a013a61c', 9, 'ICT Staff', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(44, 'bce48ea4-f594-11ef-8cee-0200a013a61c', 6, 'Manager', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(45, 'bce546f0-f594-11ef-9bdf-0200a013a61c', 8, 'Staff', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(46, 'bce5bde2-f594-11ef-ad0a-0200a013a61c', 6, 'Supervisor', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(47, 'bce63344-f594-11ef-b060-0200a013a61c', 5, 'Manager', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(48, 'bce6e032-f594-11ef-94c8-0200a013a61c', 2, 'Administrator School', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL);

INSERT INTO `products` (`id`, `uuid`, `name`, `code`, `type`, `price`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'bd38d22a-f594-11ef-b9de-0200a013a61c', 'Formulir Pendaftaran Siswa Baru', 'ADMISSION_STUDENT_FORM', 'SYSTEM', 300000.00, '2025-02-28 05:27:45', '2025-03-03 02:33:09', NULL);

INSERT INTO `profiles` (`id`, `uuid`, `national_id`, `name`, `birth_place`, `birth_date`, `gender`, `blood_type`, `religion`, `marital_status`, `email`, `phone`, `address`, `postal_code`, `avatar`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'bce80ae8-f594-11ef-8746-0200a013a61c', NULL, 'SAFFix', NULL, NULL, NULL, NULL, NULL, NULL, 'admin@saffix.id', NULL, NULL, NULL, NULL, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(2, 'bd110380-f594-11ef-a9ae-0200a013a61c', NULL, 'HBICS', NULL, NULL, NULL, NULL, NULL, NULL, 'admin@hbics.sch.id', NULL, NULL, NULL, NULL, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(3, 'bd465cce-f594-11ef-bd00-0200a013a61c', '000000000', 'Developer Saffix', NULL, NULL, NULL, NULL, NULL, NULL, 'developer@saffix.id', NULL, NULL, NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(4, 'bd48383c-f594-11ef-9f47-0200a013a61c', '16255.891002771.90', 'Yacobus S', 'Balikpapan', '1989-07-12', 'MALE', 'AB', 'JEWISH', 'WIDOWED', 'yacobus.s@hbics.sch.id', NULL, 'I dont know my address', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(5, 'bd499880-f594-11ef-af35-0200a013a61c', '6471044412890002', 'Dina Adesthy Njoo', 'Balikpapan', '1989-12-04', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'dinaadesthy.hhk@hbics.sch.id', NULL, 'Komp BB Mediterania pos 11 Blok U1/36', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(6, 'bd4aee6a-f594-11ef-815e-0200a013a61c', '3571015705880002', 'Dyah Anggarini', 'Kediri', '1988-05-17', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'dyah.ytcb@hbics.sch.id', NULL, 'Perumahan Graha Mulawarman Blok C No 32, Balikpapan', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(7, 'bd4c4526-f594-11ef-8f65-0200a013a61c', '61.221.2220033.2111', 'ICC_akun_test', 'Balikpapan', '1970-02-05', 'MALE', 'O', 'HINDU', 'SINGLE', 'yacobus.setiawan@hotmail.com', NULL, 'Jalan Telaga Sari No 28', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(8, 'bd4d77fc-f594-11ef-a14c-0200a013a61c', '6471055412830008', 'Natalia Heriati', 'Kediri', '1983-12-14', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'nataliaheriati.hhk@hbics.sch.id', NULL, 'Jl Wonorejo III Rt 51 Blok C  No 16', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(9, 'bd4ed41c-f594-11ef-825f-0200a013a61c', '6471046704780007', 'Masye Polla', 'Manado', '1978-04-27', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'masyepolla.hhk@hbics.sch.id', NULL, 'Perumahan Pesona Alam Permai Block CC 10 Batu Ampar', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(10, 'bd50362c-f594-11ef-b9db-0200a013a61c', '1212034307870005', 'Elprida simanjuntak', 'Ombur', '1987-07-03', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'elpridasimanjuntak.hhk@hbics.sch.id', NULL, 'Jl. Swadaya No 29 Rt 2', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(11, 'bd5177b2-f594-11ef-bece-0200a013a61c', '1218156104910003', 'Enita Sitinjak S.PD', 'Sei belutu', '1991-04-21', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'enitasitinjak.hhk@hbics.sch.id', NULL, 'Jl. Swadaya No 29 Rt 2', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(12, 'bd52d8fa-f594-11ef-8116-0200a013a61c', '6371014202910016', 'Eva Grace Sumasa S.Pd', 'Muara Teweh', '1991-02-02', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'evasumasa.hhk@hbics.sch.id', NULL, 'Jl. Rhein No 118 Perum Griya Permata Asri', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(13, 'bd5433e4-f594-11ef-bd4d-0200a013a61c', '6471056609010003', 'Grace Charity Tehilla Harjanto', 'Magelang', '2001-09-26', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'gracecharity.hhk@hbics.sch.id', NULL, 'Balikpapan Baru Orlando DA-01', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(14, 'bd558730-f594-11ef-9a33-0200a013a61c', '6471024804800003', 'Ivana M. Kawung', 'Kawangkoan', '1980-04-08', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'ivanakawung.hhk@hbics.sch.id', NULL, 'Jl Syarifudin Yoes jln Terang Blok A No 2', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(15, 'bd56de50-f594-11ef-aac2-0200a013a61c', '6474034706850002', 'Juika Sobon', 'Balikpapan', '1985-06-07', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'juikasobon.hhk@hbics.sch.id', NULL, 'Jln Letjen S Parman No 24 Rt 29', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(16, 'bd582bf2-f594-11ef-9d2a-0200a013a61c', '3171064608970001', 'Loed Devina Abigail', 'Jakarta', '1997-08-06', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'loeddevina.hhk@hbics.sch.id', NULL, 'Jln Aup No 6 Rt 006', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(17, 'bd5973b8-f594-11ef-83e4-0200a013a61c', '7171075909830001', 'Maya Cyntia Sigar', 'Langowan', '1983-09-09', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'mayasigar.hhk@hbics.sch.id', NULL, 'Jl. Tiga RT 2 Kampung timur', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(18, 'bd5ac222-f594-11ef-9612-0200a013a61c', '6471054505890005', 'Priscilla Tirsa Sulangi', 'Balikpapan', '1989-05-05', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'priscillasulangi.hhk@hbics.sch.id', NULL, 'Jln Kintamani XIV V17 Balikpapan Regency', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(19, 'bd5c2234-f594-11ef-97c9-0200a013a61c', '6471045103860004', 'Ryen Mart Purba', 'Balikpapan', '1986-03-11', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'ryenpurba.hhk@hbics.sch.id', NULL, 'Syarifuddin yoes Rt 45 No 82 Gg Duatan Sakai Kel. Sepinggan baru', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(20, 'bd5d6e82-f594-11ef-beef-0200a013a61c', '7326146707000001', 'Salvira Limbong', 'Baruppu', '2000-07-27', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'salviralimbong.hhk@hbics.sch.id', NULL, 'Balikpapan Baru blok U2 No 5', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(21, 'bd5eccbe-f594-11ef-a803-0200a013a61c', '3373036402010002', 'Tasya Maria Febrianti', 'Jakarta', '2001-02-24', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'tasyamf.hhk@hbics.sch.id', NULL, 'R E Martadinata No 43 RT 22', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(22, 'bd60267c-f594-11ef-9486-0200a013a61c', '3507084902870006', 'Yoise Merine Seitte', 'Situbondo', '1987-02-09', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'yoiseseitte.hhk@hbics.sch.id', NULL, 'Perum Griya Permata Asri Blok H-35 Rt 29 No F145', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(23, 'bd619f0c-f594-11ef-8d97-0200a013a61c', '3314014702890001', 'Febiyoga Alit Pawestri', 'Klaten', '1989-02-07', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'febiyoga.hhk@hbics.sch.id', NULL, 'Jln Telaga sari II No 28', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(24, 'bd630702-f594-11ef-a55e-0200a013a61c', '1204055406000001', 'Meniria Laoli', 'Ombolata Saloo', '2000-03-27', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'menirialaoli.hhk@hbics.sch.id', NULL, 'Ombolata Saloo', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(25, 'bd647498-f594-11ef-aef6-0200a013a61c', '6471056110810006', 'Wildah Edrostina Nababan', 'Medan', '1981-10-21', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'wildah.hhk@hbics.sch.id', NULL, 'Palm Hills, Blok AA 2 No. 15', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(26, 'bd65e35a-f594-11ef-8c26-0200a013a61c', '6408046101880001', 'Hana Flowerens Sitorus', 'Bontang', '1988-01-21', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'hana.sitorus@hbics.sch.id', NULL, 'Jl. Musi No 33A Perum GPA', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(27, 'bd67611c-f594-11ef-bac5-0200a013a61c', '6471036403830004', 'Chelsia Sumendap', 'Tondano', '1983-03-24', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'chelsia.sumendap@hbics.sch.id', NULL, 'Minangkabau RT 04 No 40A, Batu Ampar', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(28, 'bd68dbe6-f594-11ef-ae2f-0200a013a61c', '6472051609810003', 'Mangapul Silalahi', 'Motung', '1981-09-16', 'MALE', NULL, 'CHRISTIAN', 'MARRIED', 'mangapulsilalahi.hb-primary@hbics.sch.id', NULL, 'Perum Graha Indah PGRI Blok B2 No 10', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(29, 'bd6a516a-f594-11ef-8e16-0200a013a61c', '6471024402890002', 'Amelia Sondang Febriyanti', 'Jakarta', '1989-02-04', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'amelia.sondang@hbics.sch.id', NULL, 'Perum Bumi Nirwana Indah Blok I/1A', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(30, 'bd6bc176-f594-11ef-800c-0200a013a61c', '6409014308910005', 'Anjelyn Susanti Purba', 'Balikpapan', '1991-08-03', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'anjelynpurba.hb-primary@hbics.sch.id', NULL, 'Jln Perintis Penajam Utara', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(31, 'bd6d6508-f594-11ef-94fd-0200a013a61c', '6472034105930005', 'Brigita Rosari', 'Palu', '1993-05-01', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'brigitarosari.hb-primary@hbics.sch.id', NULL, 'Jln Pattimura Perum Batu Ampar Lestari Blok C3B No 10 Rt 60', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(32, 'bd6f1b96-f594-11ef-b11e-0200a013a61c', '1207056609940001', 'Christina Carolyna Bakara', 'Panyabungan', '1994-09-26', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'christinabakara.hb-primary@hbics.sch.id', NULL, 'Jl. Kembang Kencana no 9p RT 07 RW 02, Jakarta', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(33, 'bd70f98e-f594-11ef-af9e-0200a013a61c', '1204015112960005', 'Desmin Berliani Harefa', 'Gunungsitoli', '1996-12-11', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'desmin.hb-primary@hbics.sch.id', NULL, 'Jl Tirta No 5 GG Panti Asuhan B', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(34, 'bd728222-f594-11ef-b472-0200a013a61c', '6471021009910001', 'Erik Gunena', 'Balikpapan', '1991-09-10', 'MALE', NULL, 'CHRISTIAN', 'MARRIED', 'erik.gunena@hbics.sch.id', NULL, 'Jln Adil Makmur No 12 Rt 20 Balikpapan', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(35, 'bd741a92-f594-11ef-9737-0200a013a61c', '1272055508910006', 'Friska Yanti Tobing', 'Pematangsiantar', '1991-08-15', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'friskayanti.hb-primary@hbics.sch.id', NULL, 'Balikpapan Regency Blok JB3 No 32', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(36, 'bd75a4c0-f594-11ef-97ec-0200a013a61c', '6471034504840001', 'Gloria Siahaan', 'Bontang', '1984-04-05', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'gloriasiahaan.hb-primary@hbics.sch.id', NULL, 'Kutai Hills 8 No 12 Perum Wika', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(37, 'bd772e1c-f594-11ef-a663-0200a013a61c', '6471035410820002', 'Hellen Christina', 'Jakarta', '1982-10-14', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'hellenchristina.hb-primary@hbics.sch.id', NULL, 'Jl. Tepo KM  10 Rt 007 Karang Joang Perum Bumi , Karang joang', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(38, 'bd78fa76-f594-11ef-978b-0200a013a61c', '1275055705980004', 'Indriani Ginting', 'Binjai', '1998-05-17', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'indrianiginting.hb-primary@hbics.sch.id', NULL, 'Jln Sei Bangkatan Kota Binjai', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(39, 'bd7a980e-f594-11ef-a6ef-0200a013a61c', '1207231411930003', 'Kristian Adinata P', 'Sei Semayang', '1993-11-14', 'MALE', NULL, 'CHRISTIAN', 'SINGLE', 'kristianpangaribuan.hb-primary@hbics.sch.id', NULL, 'Dusun XI Jln Binjai KM 13, 1 GG. Horas No 102', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(40, 'bd7c0414-f594-11ef-9a7f-0200a013a61c', '6471054401920006', 'Lougi Virgi Priscilla Posumah', 'Balikpapan', '1992-01-04', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'lougi.hb-primary@hbics.sch.id', NULL, 'Jl Telaga Sari 3 No 3', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(41, 'bd7dd460-f594-11ef-b1bb-0200a013a61c', '6471056608990002', 'Mega Ningrum Suwarno Putri', 'Balikpapan', '1999-08-26', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'meganingrum.hb-primary@hbics.sch.id', NULL, 'Perum Sepinggan Asri', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(42, 'bd7f59a2-f594-11ef-8026-0200a013a61c', '6112016305960008', 'Meini Fiana Fransiska', 'Sanggau', '1996-05-23', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'meinifiana.hb-primary@hbics.sch.id', NULL, 'BTN Teluk Mulus Rt 004', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(43, 'bd80e574-f594-11ef-bf3a-0200a013a61c', '6472036605830002', 'Meity Varyda Dene Saragih', 'Samarinda', '1983-05-26', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'meitysaragih.hb-primary@hbics.sch.id', NULL, 'Perum Blue Sapphire blok C No.4', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(44, 'bd8273c6-f594-11ef-83ac-0200a013a61c', '6403096304990001', 'Monica', 'Tanjung Redeb', '1999-04-23', 'FEMALE', NULL, 'BUDDHIST', 'SINGLE', 'monica.hb-primary@hbics.sch.id', NULL, 'Jln Pasar Batu Rt 006 Teluk Bayur', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(45, 'bd84234c-f594-11ef-a231-0200a013a61c', '1207284208910002', 'Nora Agustina Silalahi', 'Lubuk Pakam', '1991-08-02', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'noraagustina@hbics.sch.id', NULL, 'Gg. Budi Cawang III Rt 012', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(46, 'bd8619a4-f594-11ef-afb3-0200a013a61c', '6402035411960001', 'Novilina Veronica Inu Dhei', 'Samarinda', '1996-11-14', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'novilinadhei.hb-primary@hbics.sch.id', NULL, 'Manunggal II Street, Durian Alley No 47', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(47, 'bd881e2a-f594-11ef-af31-0200a013a61c', '6471055107900001', 'Novita Permata Sari Tambunan', 'Balikpapan', '1990-07-11', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'novi.tambunan@hbics.sch.id', NULL, 'Jalan Dua No 18 Gn Samarinda', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(48, 'bd89c77a-f594-11ef-baab-0200a013a61c', '1271112001850003', 'Rados Fremiro Sembiring', 'Medan', '1985-01-20', 'MALE', NULL, 'CHRISTIAN', 'MARRIED', 'rados.fsembiring@hbics.sch.id', NULL, 'Jl Melati III Tanah Tinggi', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(49, 'bd8c0666-f594-11ef-b678-0200a013a61c', '6406084102950001', 'Rahmadianti', 'Tarakan', '1993-02-01', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'rahmadianti.hb-primary@hbics.sch.id', NULL, 'Long Bila kec Malinau Barat', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(50, 'bd8e0e70-f594-11ef-88b7-0200a013a61c', '1407101011930006', 'Rimson Marusaha Sinaga', 'Sei Meranti', '1993-11-10', 'MALE', NULL, 'CHRISTIAN', 'SINGLE', 'matthew.sinaga@hbics.sch.id', NULL, 'Jln. Lingkar Danau Buatan Rt 01', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(51, 'bd8fb0ae-f594-11ef-809c-0200a013a61c', '3275024504850030', 'Ruth Magdalena Simanjuntak', 'Jakarta', '1985-04-05', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'lena@hbics.sch.id', NULL, 'Jln S Parman Perumahan Pesona Azarya Blok A 77 Rt 30', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(52, 'bd911520-f594-11ef-a4e3-0200a013a61c', '6471056709920004', 'Tirsa Ester Amanda Koroh', 'Balikpapan', '1992-09-27', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'tirsakoroh.hb-primary@hbics.sch.id', NULL, 'Jl. Bubut No 99', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(53, 'bd927e4c-f594-11ef-8016-0200a013a61c', '1204015209950004', 'Vestin Putri Telaumbanua', 'Padang', '1995-09-12', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'vestinputri.hb-primary@hbics.sch.id', NULL, 'Jl. Ki Hajar Dewantara Karang Balik Tarakan', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(54, 'bd9459e2-f594-11ef-85a0-0200a013a61c', '6408044404020009', 'Vania Ananda Massangka', 'Balikpapan', '2000-04-04', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'vaniaananda.hb-primary@hbics.sch.id', NULL, 'Jln Timur Raya Rt 46 No 388', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(55, 'bd9717ae-f594-11ef-b9d1-0200a013a61c', '3277022910990008', 'Yonatan Alhas Wijaya', 'Cimahi', '1999-10-29', 'MALE', NULL, 'CHRISTIAN', 'SINGLE', 'yonatan.awijaya@hbics.sch.id', NULL, 'Babakan Sari 009', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(56, 'bd988b70-f594-11ef-81f9-0200a013a61c', '1216076310940001', 'Elisabet Simanjuntak', 'Bonan Dolok', '1994-10-23', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'elisabethsimanjuntak.hb-primary@hbics.sch.id', NULL, 'Regency Cluster Castarica Blok JA1 No 38', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(57, 'bd99fb5e-f594-11ef-bab7-0200a013a61c', '5301184108960002', 'Elisabeth Agnes Tnunay', 'Buraen', '1996-08-01', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'agnes.tnunay@hbics.sch.id', NULL, 'Buraen, Rt 007', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(58, 'bd9b6c14-f594-11ef-ab28-0200a013a61c', '6471054705960005', 'Angela Merlyn Primatika', 'Balikpapan', '1996-05-07', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'angelamryln.hb-primary@hbics.sch.id', NULL, 'Jl Prapatan Dalam No 07', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(59, 'bd9cfd54-f594-11ef-98d0-0200a013a61c', '1271044209880005', 'Dita Primalani Nainggolan', 'Padang', '1988-09-02', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'ditaprimalani.hb-primary@hbics.sch.id', NULL, 'Jl Menteng VII Gg Swasembada', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(60, 'bd9e6f40-f594-11ef-accd-0200a013a61c', '1271134909900004', 'Laura A.D Sihombing', 'Medan', '1990-09-09', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'lauraad.sihombing@hbics.sch.id', NULL, 'Rukem Jaya III/ 41', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(61, 'bd9ff036-f594-11ef-8f87-0200a013a61c', '6472034606980003', 'Tracey Sheilla Asia', 'Samarinda', '1998-06-06', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'traceys.asia@hbics.sch.id', NULL, 'Komp Wika Blok CB5 nomor 12A', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(62, 'bda16768-f594-11ef-a104-0200a013a61c', '6471055502890003', 'Rika Febriyanti Lamtiur Panjaitan', 'Pekanbaru', '1989-02-15', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'rika.panjaitan@hbics.sch.id', NULL, 'Perum Melati Bintang Residence Blok no 3', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(63, 'bda2db3e-f594-11ef-a913-0200a013a61c', '1272016407980004', 'Kristina Habeahan', 'Pematangsiantar', '1998-07-24', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'kristina.habeahan@hbics.sch.id', NULL, 'Permosi No 6B', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(64, 'bda44938-f594-11ef-9968-0200a013a61c', '1272054611910001', 'Betty Sianturi', 'Marihat tapian nauli', '1991-11-06', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'bettysianturi.hb-primary@hbics.sch.id', NULL, 'Jl Melanthon Siregar 01/02 Siantar', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(65, 'bda5c024-f594-11ef-a013-0200a013a61c', '6471046604780004', 'Ruth Murwani Dumasthary. S.Sos., M.Pd', 'Pontianak', '1978-04-26', 'FEMALE', 'A', 'CHRISTIAN', 'MARRIED', NULL, NULL, 'Pelangi Pesona Residence I-6', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(66, 'bda699ae-f594-11ef-8f25-0200a013a61c', '3518066003880001', 'Margaretha Dwi Cahyani', 'Nganjuk', '1988-03-20', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'margarethacahyani.hb-high@hbics.sch.id', NULL, 'Pelangi Metro Residence Blok M No 23', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(67, 'bda7ed5e-f594-11ef-8fc9-0200a013a61c', '6471031303850003', 'Angelis Andreas Gama', 'Balikpapan', '1985-03-13', 'MALE', NULL, 'CHRISTIAN', 'MARRIED', 'aandreasgama.hb-secondary@hbics.sch.id', NULL, 'Jl. Bubut No 99', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(68, 'bda94cda-f594-11ef-a9ac-0200a013a61c', '6471054706970006', 'Anita Simamora', 'Balikpapan', '1997-06-07', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'anitasimamora.hb-secondary@hbics.sch.id', NULL, 'Jln Jokotole No 126 Rt 14', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(69, 'bdaaf1ca-f594-11ef-9fac-0200a013a61c', '3273026704820011', 'Arianti', 'Bogor', '1982-04-27', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'arianti.hb-high@hbics.sch.id', NULL, 'Jl Ciheulang II No 11', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(70, 'bdacbe9c-f594-11ef-9158-0200a013a61c', '3471036712870002', 'Ayu Estiyanti Widiyantari Kiswanto', 'Yogyakarta', '1987-12-27', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'ayuestiyanti.hb-secondary@hbics.sch.id', NULL, 'Klitren Lor GK 3/378', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(71, 'bdae53b0-f594-11ef-956c-0200a013a61c', '3312126810920001', 'Bunga Ratnasari Hadipitoyo', 'Surakarta', '1992-10-28', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'bungaratnasari.hb-secondary@hbics.sch.id', NULL, 'Sepinggan Pratama Blok J7 No 2', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(72, 'bdafe130-f594-11ef-9eb4-0200a013a61c', '6471045311810002', 'Chatrilitha Laurine Nouviana', 'Balikpapan', '1981-11-13', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'cnouviana.hb-high@hbics.sch.id', NULL, 'Jl. Prapatan No 14 Rt 29', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(73, 'bdb15cb8-f594-11ef-8800-0200a013a61c', '3175065011890021', 'Christine Novita Mandasari', 'Jakarta', '1989-11-10', 'FEMALE', 'O', 'CHRISTIAN', 'SINGLE', NULL, NULL, 'Jalan Indrakila No. 9 Gunung Samarinda, Balikpapan Utara', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(74, 'bdb252f8-f594-11ef-ab24-0200a013a61c', '6474026002930002', 'Fertunata Monica Darsono', 'Bontang', '1993-02-20', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'fertunatadarsono.hb-high@hbics.sch.id', NULL, 'Batu ampar lestari Blok C-4 No 05 Balikpapan', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(75, 'bdb3dc54-f594-11ef-acf2-0200a013a61c', '7102135701930001', 'Jeisica Lumy', 'Manado', '1993-01-17', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'jeisicalumy.hb-seniorhigh@hbics.sch.id', NULL, 'Jaga III Sea Mitra', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(76, 'bdb55976-f594-11ef-87f3-0200a013a61c', '5171044412910003', 'Jessie BulurDitty', 'Ambon', '1991-12-04', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'jessie.hb-secondary@hbics.sch.id', NULL, 'Jl. Prona III Gg Perjuangan No. 12B', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(77, 'bdb6dcd8-f594-11ef-888c-0200a013a61c', '6471026109980002', 'Maria Josebia Pangestuti', 'Balikpapan', '1998-09-21', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'mariajosebia.hb-secondary@hbics.sch.id', NULL, 'Jl Hasanuddin No 107', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(78, 'bdb85e78-f594-11ef-b461-0200a013a61c', '1471115307950041', 'Mesianna Simbolon', 'Pekanbaru', '1995-07-13', 'FEMALE', 'AB', 'CHRISTIAN', 'SINGLE', NULL, NULL, 'Jl.Sidomukti No 6 Sigunggung Pekanbaru', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(79, 'bdbbd116-f594-11ef-8ec3-0200a013a61c', '7371126105970003', 'Meylodra Wilhelmina P', 'Ujung Pandang', '1997-05-21', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'meylodra.hb-secondary@hbics.sch.id', NULL, 'Jl Tagari Rt 002', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(80, 'bdbd8b14-f594-11ef-817a-0200a013a61c', '6471054601820005', 'Pingkan Patricia Ishwari', 'Jakarta', '1982-01-06', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'pingkanishwari.hb-high@hbics.sch.id', NULL, 'Perum Her 2 blok K2 No 7 jln Rinjani Sepinggan', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(81, 'bdbf9b0c-f594-11ef-aaf4-0200a013a61c', '1208043007970002', 'Riswandi Sinurat', 'Sirpang Sigodang', '1997-07-30', 'MALE', NULL, 'CHRISTIAN', 'SINGLE', 'riswandisinurat.hb-secondary@hbics.sch.id', NULL, 'Simpang Sigodang, Panei', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(82, 'bdc13ea8-f594-11ef-bee6-0200a013a61c', '1208207101980001', 'Sari Fitri Dewi Debora Sinaga', 'Nagori', '1999-01-31', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'sarifitri.hb-secondary@hbics.sch.id', NULL, 'Desa Sibuntuon, Kec Dolok Pardamean', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(83, 'bdc2e3fc-f594-11ef-96f2-0200a013a61c', '3277034801930017', 'Stella Fanny Gerina', 'Cimahi', '1993-01-08', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'stella.hb-secondary@hbics.sch.id', NULL, 'Sungai Ampal No 15 Rt 43', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(84, 'bdc4a994-f594-11ef-b9f0-0200a013a61c', '1271096610920003', 'Suci Florence Night Ingeale S', 'Medan', '1992-10-26', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'suciflorence.hb-secondary@hbics.sch.id', NULL, 'Jl.Aman Bagansiapiapi, Kec.Bangko', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(85, 'bdc6993e-f594-11ef-b99d-0200a013a61c', '1206014109970001', 'Vina Meliyana BR Perangin angin', 'Kabanjahe', '1997-09-01', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'vinameliyana.hb-seniorhigh@hbics.sch.id', NULL, 'Gang Naga Bonar, Kabanjahe', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(86, 'bdc8498c-f594-11ef-a40c-0200a013a61c', '5206022810971004', 'Sukarman', 'Nggembe', '1997-10-28', 'MALE', NULL, 'ISLAM', 'SINGLE', 'sukarman.hb-seniorhigh@hbics.sch.id', NULL, 'Dusun Oi Wontu', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(87, 'bdca79a0-f594-11ef-8da4-0200a013a61c', '1306091704960002', 'Rizky Kurniawan', 'Bukit tinggi', '1996-04-17', 'MALE', NULL, 'ISLAM', 'SINGLE', 'rizkykurniawan.hb-seniorhigh@hbics.sch.id', NULL, 'Kampung Baru Pelipit', NULL, NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(88, 'bdcc6026-f594-11ef-b974-0200a013a61c', '6472065006990004', 'Eryka Mayang Pamungkas', 'Samarinda', '1999-06-10', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'eryka.hb-secondary@hbics.sch.id', NULL, 'Simpang Raya, RT 001', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(89, 'bdce2514-f594-11ef-af32-0200a013a61c', '3507090806920002', 'Andreas Lukita', 'Malang', '1992-06-08', 'MALE', NULL, 'CHRISTIAN', 'SINGLE', 'andreaslukita.hb-seniorhigh@hbics.sch.id', NULL, 'Jln Raya Kedok RT 017', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(90, 'bdcfe502-f594-11ef-b2af-0200a013a61c', '3372036911960005', 'Azalia Herma', 'Surakarta', '1996-11-29', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'azaliaherma.hb-seniorhigh@hbics.sch.id', NULL, 'Jl May. Jend Sutoyo 14', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(91, 'bdd1bec2-f594-11ef-896c-0200a013a61c', '3172050304900003', 'Hans Gouw', 'Jakarta', '1990-04-03', 'FEMALE', NULL, 'BUDDHIST', 'SINGLE', 'hans.gouw@hbics.sch.id', NULL, 'Taman Hidup Baru I /26', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(92, 'bdd37bcc-f594-11ef-a831-0200a013a61c', '8101144402980001', 'Febriyanti Menasetiabudi', 'Ambon', '1998-02-04', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'febriyantimenasetiabudi.hb-secondary@hbics.sch.id', NULL, 'BTN Waitatiri Blok CI No 12', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(93, 'bdd4f52e-f594-11ef-ab18-0200a013a61c', '6474036506970002', 'Roosye Carolina', 'Bontang', '1997-06-25', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'roosyecarolina.hb-primary@hbics.sch.id', NULL, 'Jln S Parman No 28 Bontang', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(94, 'bdd6633c-f594-11ef-b0ae-0200a013a61c', '6471055607910004', 'Eristiannponglangi', 'Bittuang', '1991-07-16', 'FEMALE', NULL, 'ISLAM', 'MARRIED', 'eristiannponglangi.ytcb@hbics.sch.id', NULL, 'Jln Wolter Monginsidi No 17', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(95, 'bdd7f288-f594-11ef-9b8f-0200a013a61c', '6471044512040002', 'Olivia Deti Duta', 'Makassar', '2004-12-05', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'olivia.ytcb@hbics.sch.id', NULL, 'Jln Pemuda Batakan Rt 66', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(96, 'bdd9b500-f594-11ef-807b-0200a013a61c', '7326144505950003', 'Tresia Tiku Lele', 'Baruppu', '1995-05-05', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'tere.ytcb@hbics.sch.id', NULL, 'Balikpapan Baru blok U2 No 5', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(97, 'bddb9320-f594-11ef-9ee5-0200a013a61c', '6471024712000004', 'Vivi Natalia', 'Balikpapan', '2000-12-07', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'vivinatalia.ytcb@hbics.sch.id', NULL, 'Jl Adil Makmur No 08', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(98, 'bddd4184-f594-11ef-aa59-0200a013a61c', '6471046310770009', 'Mely', 'Jambi', '1977-10-23', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'mely.ytcb@hbics.sch.id', NULL, 'Jl. Sungai Ampal No 20, Sumber Rejo Balikpapan', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(99, 'bdded864-f594-11ef-93d1-0200a013a61c', '6471036505810004', 'Yenny Elmira Siahaan', 'Pangkalan Berandan', '1981-05-25', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'yeni.ytcb@hbics.sch.id', NULL, 'Perumahan Pesona Azarya Blok B71', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(100, 'bde09564-f594-11ef-9dee-0200a013a61c', '6402131608900003', 'Alek Sander Agung', 'Balikpapan', '1990-08-16', 'MALE', NULL, 'ISLAM', 'MARRIED', 'aleksander.ytcb@hbics.sch.id', NULL, 'Jln Batu Ratna Km 11 Perum Atlantic Village', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(101, 'bde26a92-f594-11ef-8834-0200a013a61c', '6471051108800006', 'Ariadi', 'Balikpapan', '1980-08-11', 'MALE', NULL, 'ISLAM', 'MARRIED', 'ardi.ytcb@hbics.sch.id', NULL, 'Jl. Prapatan No 14 Rt 29', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(102, 'bde3fe66-f594-11ef-b3ef-0200a013a61c', '6471032709820002', 'Barlevi Sharon', 'Balikpapan', '1982-09-27', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'levi.ytcb@hbics.sch.id', NULL, 'Per Villa Kita D-5 KM 8,5', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(103, 'bde5b5c6-f594-11ef-a45d-0200a013a61c', '3507164512900003', 'Devi Novita Sari, S.H', 'Malang', '1990-12-05', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'devi.ytcb@hbics.sch.id', NULL, 'Bukit Batakan Permai II F5 Blok 8', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(104, 'bde79206-f594-11ef-9848-0200a013a61c', '6471055909000005', 'Jessica Prisicilia Sarajar', 'Balikpapan', '2000-09-19', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'jessica.ytcb@hbics.sch.id', NULL, 'Jln Jend Sudirman No 52 Rt 25', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(105, 'bde956fe-f594-11ef-8e38-0200a013a61c', '6471042805740005', 'Kerestian Naihonam', 'Wahai', '1974-05-28', 'MALE', NULL, 'CHRISTIAN', 'MARRIED', 'keristian.ytcb@hbics.sch.id', NULL, 'Per Villa Kita D-5 KM 8,5', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(106, 'bdeb341a-f594-11ef-9b34-0200a013a61c', '6471022204610001', 'Muchtar RM', 'Balikpapan', '1961-04-22', 'FEMALE', NULL, 'ISLAM', 'MARRIED', 'muchtar.ytcb@hbics.sch.id', NULL, 'Jln Giri Rejo No 43 Rt 28 Kel Karang Joang', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(107, 'bdecfe9e-f594-11ef-a2dd-0200a013a61c', '6471040911870004', 'Nofry G Mangindaan', 'Rerer', '1987-11-09', 'MALE', NULL, 'CHRISTIAN', 'MARRIED', 'novry.ytcb@hbics.sch.id', NULL, 'Jl Riko RT 18 Baru olo', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(108, 'bdee984e-f594-11ef-b92e-0200a013a61c', '6474011304870005', 'Sugeng Suriyadi', 'Bontang', '1987-04-13', 'MALE', NULL, 'ISLAM', 'WIDOWED', 'sugeng.ytcb@hbics.sch.id', NULL, 'Jln Syarifudin Yoes Rt 41', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(109, 'bdf04266-f594-11ef-8a34-0200a013a61c', '7304020911630002', 'Suwigyo', 'tulung agung', '1963-11-09', 'MALE', NULL, 'ISLAM', 'MARRIED', NULL, NULL, 'Jln Indra Kila', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(110, 'bdf13306-f594-11ef-b498-0200a013a61c', '6471055907020004', 'Tasya Gloria Wowor', 'Balikpapan', '2002-07-19', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'tasyagloria.ytcb@hbics.sch.id', NULL, 'Jl. Bantimurung No 232 Gn. Bahagia', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(111, 'bdf2df9e-f594-11ef-b0f9-0200a013a61c', '3171044301870002', 'Agnes Puspa Indah', 'Jakarta', '1987-01-03', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'agnes.indah@hbics.sch.id', NULL, 'Jl Komp Balikpapan Permai K1 No 18', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(112, 'bdf472aa-f594-11ef-a327-0200a013a61c', '6471052409940001', 'Adytya Lambang Nugraha', 'Balikpapan', '1994-09-24', 'MALE', NULL, 'ISLAM', 'MARRIED', 'adytya.ytcb@hbics.sch.id', NULL, 'Jln PJHI Perum CGS Blok AB No 37', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(113, 'bdf6101a-f594-11ef-99aa-0200a013a61c', '3275033007950027', 'Andre Witarsa', 'Bekasi', '1995-07-30', 'MALE', NULL, 'CHRISTIAN', 'SINGLE', 'andre.ytcb@hbics.sch.id', NULL, 'Permata Hijau Permai Blok H 3 No 18', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(114, 'bdf793fe-f594-11ef-a99e-0200a013a61c', '6471045408950001', 'Ingrit Agustin Wullur', 'Banjarmasin', '1995-08-14', 'FEMALE', NULL, 'CHRISTIAN', 'SINGLE', 'ingritaw.ytcb@hbics.sch.id', NULL, 'Jln Banjar No 37 Rt 06 Gn Sari', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(115, 'bdf92bb0-f594-11ef-a085-0200a013a61c', '3603170612040002', 'Natanael Ferdinand', 'Tangerang', '2004-12-06', 'MALE', NULL, 'CHRISTIAN', 'SINGLE', 'natanael.ytcb@hbics.sch.id', NULL, 'Jln Mulawarman Gang Telaga Mas', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(116, 'bdfae662-f594-11ef-97a9-0200a013a61c', '3174105612850008', 'Widya Disriyati Simatupang', 'Jakarta', '1985-12-16', 'FEMALE', NULL, 'CHRISTIAN', 'MARRIED', 'widya.ytcb@hbics.sch.id', NULL, 'Perum sepinggan', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(117, 'bdfc9f0c-f594-11ef-a59c-0200a013a61c', '6471032609020001', 'Jo Kevin Nathaniel', 'Balikpapan', '2002-09-26', 'MALE', 'O', 'CHRISTIAN', 'SINGLE', NULL, NULL, 'Jl Soekarno Hatta Km 1 No 15', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(118, 'bdfdbba8-f594-11ef-9715-0200a013a61c', '6472036511880001', 'Ireyne Nopiana Sinaga', 'Padang Sidempuan', '1988-11-25', 'FEMALE', 'B', 'CHRISTIAN', 'MARRIED', 'ireyne.hb-primary@hbics.sch.id', NULL, 'Perum Batakan Mas Blok HH No 7', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(119, 'bdff8848-f594-11ef-8970-0200a013a61c', '3275121209980003', 'Mario Septianto Nugroho', 'Jakarta', '1998-09-12', 'MALE', 'A', 'CHRISTIAN', 'SINGLE', 'marioseptianto.hb-seniorhigh@hbics.sch.id', NULL, 'Kampung Sawah Rt 005', NULL, NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(120, '4123dae0-f7bf-11ef-aabd-0200a013a61c', '6471026207060002', 'Lesyel Jovana', 'Balikpapan', '2006-07-22', 'FEMALE', NULL, 'ISLAM', 'SINGLE', 'lesyeljovana.edcon@hbics.sch.id', '+62 815-4922-7735', 'Jl. Gunung Empat  RT 46 no 49', NULL, NULL, '2025-03-02 23:37:07', '2025-03-02 23:38:25', NULL);

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'System Admin', 'web', '2025-02-28 05:27:44', '2025-02-28 05:27:44'),
(2, 'Site Admin', 'web', '2025-02-28 05:27:44', '2025-02-28 05:27:44'),
(3, 'Employee', 'web', '2025-02-28 05:27:44', '2025-02-28 05:27:44'),
(4, 'Student', 'web', '2025-02-28 05:27:44', '2025-02-28 05:27:44'),
(5, 'Guardian', 'web', '2025-02-28 05:27:44', '2025-02-28 05:27:44'),
(6, 'Member', 'web', '2025-02-28 05:27:44', '2025-02-28 05:27:44');

INSERT INTO `school_grades` (`id`, `uuid`, `school_level_id`, `school_phase_id`, `title`, `sort_number`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'bcbf225e-f594-11ef-88ce-0200a013a61c', 1, 1, '1', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(2, 'bcbf59b8-f594-11ef-ab89-0200a013a61c', 1, 1, '2', 2, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(3, 'bcbf8e10-f594-11ef-9f3f-0200a013a61c', 1, 1, '3', 3, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(4, 'bcbfc2fe-f594-11ef-8d72-0200a013a61c', 1, 1, '4', 4, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(5, 'bcc0d946-f594-11ef-937d-0200a013a61c', 2, 2, '1', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(6, 'bcc10e20-f594-11ef-b398-0200a013a61c', 2, 2, '2', 2, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(7, 'bcc17d9c-f594-11ef-a7b9-0200a013a61c', 2, 3, '3', 3, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(8, 'bcc1b05a-f594-11ef-97fb-0200a013a61c', 2, 3, '4', 4, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(9, 'bcc219dc-f594-11ef-9529-0200a013a61c', 2, 4, '5', 5, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(10, 'bcc249b6-f594-11ef-9b48-0200a013a61c', 2, 4, '6', 6, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(11, 'bcc31b8e-f594-11ef-875a-0200a013a61c', 3, 5, '7', 7, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(12, 'bcc3536a-f594-11ef-b56c-0200a013a61c', 3, 5, '8', 8, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(13, 'bcc38786-f594-11ef-8039-0200a013a61c', 3, 5, '9', 9, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(14, 'bcc46bba-f594-11ef-ae89-0200a013a61c', 4, 6, '10', 10, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(15, 'bcc4d4ba-f594-11ef-bf3a-0200a013a61c', 4, 7, '11', 11, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(16, 'bcc50976-f594-11ef-ae64-0200a013a61c', 4, 7, '12', 12, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL);

INSERT INTO `school_levels` (`id`, `uuid`, `title`, `code`, `sort_number`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'bcbe28d6-f594-11ef-9a54-0200a013a61c', 'Kindergarten', 'KINDERGARTEN', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(2, 'bcc05b10-f594-11ef-bd65-0200a013a61c', 'Elementary', 'ELEMENTARY', 2, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(3, 'bcc2b5c2-f594-11ef-b6d3-0200a013a61c', 'Middle', 'MIDDLE', 3, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(4, 'bcc40080-f594-11ef-bad8-0200a013a61c', 'High', 'HIGH', 4, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL);

INSERT INTO `school_phases` (`id`, `uuid`, `school_level_id`, `title`, `sort_number`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'bcbecf2a-f594-11ef-b9cf-0200a013a61c', 1, 'Foundation Phase', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(2, 'bcc09d82-f594-11ef-be0d-0200a013a61c', 2, 'Phase A', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(3, 'bcc147b4-f594-11ef-8985-0200a013a61c', 2, 'Phase B', 2, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(4, 'bcc1e336-f594-11ef-9b6c-0200a013a61c', 2, 'Phase C', 3, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(5, 'bcc2e934-f594-11ef-b506-0200a013a61c', 3, 'Phase D', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(6, 'bcc4347e-f594-11ef-8c2a-0200a013a61c', 4, 'Phase E', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(7, 'bcc49d9c-f594-11ef-a599-0200a013a61c', 4, 'Phase F', 2, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL);

INSERT INTO `school_years` (`id`, `uuid`, `name`, `start_year`, `end_year`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'e0bcedb6-f7ca-11ef-bdd1-0200a013a61c', '2024 / 2025', '2024', '2025', 1, '2025-03-03 01:00:19', '2025-03-03 02:32:48', NULL),
(2, 'fb06f572-f7ca-11ef-9a39-0200a013a61c', '2025 / 2026', '2025', '2026', 1, '2025-03-03 01:01:03', '2025-03-03 01:01:39', NULL),
(3, 'c6e2732c-f7d7-11ef-aea8-0200a013a61c', '2026 / 2027', '2026', '2027', 1, '2025-03-03 02:32:39', '2025-03-03 02:32:39', NULL),
(4, '05f0c052-f7fe-11ef-bbce-0200a013a61c', '2027/ 2028', '2027', '2028', 1, '2025-03-03 07:06:26', '2025-03-03 07:06:26', NULL);

INSERT INTO `schools` (`id`, `uuid`, `school_level_id`, `headmaster_id`, `use_major`, `use_subject`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'bcc631e8-f594-11ef-bd65-0200a013a61c', 1, NULL, 0, 0, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(2, 'bcc72aa8-f594-11ef-9286-0200a013a61c', 2, NULL, 0, 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(3, 'bcc7e3bc-f594-11ef-bcf9-0200a013a61c', 3, NULL, 0, 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(4, 'bcc8b09e-f594-11ef-9b63-0200a013a61c', 4, NULL, 1, 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL);

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('0OAfwhs8954zlC9SMZZAliFbgrPAdu1f5JCxB1EF', NULL, '178.79.144.246', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20100101 Firefox/8.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQnNOZHU0QW5vbnFoRVlmZDMxblk2Nk1nOTU0M0hVOHQ0VDNNQ2dESiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742533467),
('14O5h4rMEjHQuMwCe0OqcMMHGOR9zOruTsScik5i', NULL, '165.232.38.230', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia2RqaEZVbjZaQ2xYRTYzclk0Yk1YOGh0SE00VkN2Tks4NHVTS3dTbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742568532),
('1pCmvL74s4TABSR8hyoEOBI0aTAUODUKLqqLPod4', NULL, '147.185.133.136', 'Expanse, a Palo Alto Networks company, searches across the global IPv4 space multiple times per day to identify customers&#39; presences on the Internet. If you would like to be excluded from our scans, please send IP addresses/domains to: scaninfo@paloaltonetworks.com', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicXdEUnE0YzhGRndsTm9Fa3FkcVBMdGw0WTNwbjVRSjFlOUpxSTRIVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742518709),
('3aDPzg4OIKoD2IKPvkQrduLBj2QVivkKRoDIdCA4', NULL, '172.71.124.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWHZhZlBkd3NyYURhbGtYQU5mdWlxMFlYOWtqcGlGaFh5UUJmM0RRdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742600165),
('3DPi4kzrjjw9aHSogiBj720cmM2Mbdtou2tRSC6e', NULL, '104.23.166.122', 'Mozlila/5.0 (Linux; Android 7.0; SM-G892A Bulid/NRD90M; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/60.0.3112.107 Moblie Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUnhUSVFrajVnUkJXZkE0WEhRR0pSdGlYT0lYeU1pWkF5Y0Y1QzVHcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742605297),
('3RKPpLTQeRVQxUB6cUfGNr7R5T892QiVdFk5ltaz', NULL, '60.13.7.222', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiamVKTEp1dzMxN3RwZ1lUTHVQVXFmWVQ1VnpaQmF4QzlaSklpUnB0dyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742515611),
('3sUBmKYIyUeP7Us1bbE0vp1FhkTiVc3HdqGOnjZk', NULL, '165.232.38.230', 'Mozilla/4.0 (compatible; MSIE 9.0; Windows NT 10.0; .NET4.0C; .NET4.0E; .NET CLR 2.0.50727; .NET CLR 3.0.30729; .NET CLR 3.5.30729)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ3RtbEZ3VVE4RFdtS3laRE9DTG56RmR2MlRKMmZvUkF3dnNmbG9OZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742568537),
('5rxTNTSMVrHSOxg3vdixvzldIxGcP8TEo7f5GgEp', NULL, '172.71.158.57', 'Mozilla/5.0 (SS; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid3c3UjdKVUpOaHFpYnRwVXF2dU1qRjdJbEVUMzNvS2thbkxiblQ1cyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTI1OiJodHRwczovL2hiaWNzLnNhZmZpeC5pZC8/Y2RhJTI3JTIyJTNDJTJGc2NyaXB0JTNFJTNDc2NyaXB0JTNFYWxlcnQlMjhkb2N1bWVudC5kb21haW4lMjklM0MlMkZzY3JpcHQlM0U9JmxvY2FsZT1sb2NhbGUlM0RkZS1ERSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742547391),
('6GkwLl3kg0X8BtVrYIuBZiWaAD3El5jviBlYyRjG', NULL, '162.158.106.201', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 15_5_7; es) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0.7 Safari/605.1.15', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT1pId3BxR2ZJTWF3QU9aUzhBbzFzeU1uQlVOeUhyOTZWd1loMDFxYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742529679),
('6yMZTUgGp3xTUGlIzYAmn1gp6JKsGxj9oGg74eUe', NULL, '27.98.228.214', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM2xOSVUxb1pla0hMem9VbFlEek5abU45OVFoejRqRFM0UG51MmdhNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742517950),
('7em8qr2LmQ2Rivtnl68Ewh2w7mUSjDnxSlKUq4Pr', NULL, '162.158.108.47', 'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTTBDMFJ3Rk50T252TklOZnJVWmpWbnJ4VVhSWWtsNmJsNlVpRWZKbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742527238),
('7QOKBkpoYH4H87rU2dmdTOfqgyTtY7ho71v2np8G', NULL, '45.148.10.35', 'l9tcpid/v1.1.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicGRNM2RKeEJ1SDhkdWdoZHFQVHZIaGFma0QyV2Q2dU5HRjR6MnN5byI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742517068),
('7SXWXkI4LyQ530Na9sEEKrYaEsQEoZHORKQsoND1', NULL, '101.70.121.133', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicGVTa2RtYVF5VnEyYjBvczFqWTZLeklrcDlGcTlybmJBS2lDdE9XeCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742518612),
('7TP4NPGie9Ixxy4MoOox9AWXWjuWqhzDYmvPdTU6', NULL, '164.52.0.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidEU3eVBzT0F3aURTOUtSZnNyUk1yT3Y2V3dBa1JKY2R5eW1pMVBZUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742603142),
('8liBMn1Ppsdjj3YrlRpZOjTBmxU3XK5GHJuOT0ri', NULL, '165.22.180.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicFBnamVoTkdOdE91UVNiaFlKdklKRG1QdW1Ba2dYemF5TlZvbTlXTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742595003),
('8QBRCyZEQXNQac3mEc99VMs6PgK4HTJMCISofI1L', NULL, '108.162.216.242', 'curl/7.61.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieXg1djdvcG9tMHVMd2hiREs1SEc2dnlDNHViNEp3SnRSV0ZNOTcyUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742587701),
('a2aS3tALa2WwbeBBeqsomKIJZYbFTYIc8W1alzUG', NULL, '194.50.16.252', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaEVVeHBESTh2UXAyWmY2dHlDcGhUaFVrbDk1WUhXOTZVbVU4bFl5MSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742571990),
('AeCmW82zmChzqEMAed0v9ZmvzSTKzJx6JKDaT6wJ', NULL, '172.71.124.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0 Teams/25060.205.3499.6849 (49)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZFQxSDA3RzBRRVVpVnJYYnJldGQyZDBXTUp5UHEzTkxLVkZSaEZCUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742539196),
('aLzY3ClgbxQQgOthhMRwYXrEl5VslciiUNhhPoPi', NULL, '195.178.110.163', 'l9tcpid/v1.1.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUjMzOXlKeUVpZXp2bXU2UjBVZzh3bmpGeEFsN09lQzlwdDR2UW5qciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742594361),
('bHXdNquk48q1VFRWi7HHH0WF1KaGLnOZZdUgh5GE', NULL, '122.188.34.163', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVHpmZEhMSFNJRXhLZldYQU5oeGIwYThWQ3R4czZNajE3ZnBwMVFSRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742515431),
('buAdkW44wNwAuTv1JvBZbeuW0467WcgE8KMRApu3', NULL, '119.164.100.176', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieU5meWFwbjdrcm0xOVZBUG1KRHFHajl3d0JVZlp5eVhWcDBJSHFrYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742517411),
('CBdEjFhs62uJRJMPGCPBzDecyOJ2mdpIKwkNv094', NULL, '116.252.76.7', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaHBTWkc3QVdZTmxBOXZsMEJ5aUdIeGJlanFUWlhnNEdYaWtodElZMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742515907),
('CEFWRK4kj7qV37mIvhhK2cHyIAYjCqpYwVIMAyRm', NULL, '20.65.194.6', 'Mozilla/5.0 zgrab/0.x', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNVJCM1R1Z252b2FTYlV5Z2EwYkE1WXlzc1FuWGxJaHk4VUtnQXBOaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742514414),
('CgNASh6n8NKv176IZ7EgqkfEIBuVOzlVtXyYoUyp', NULL, '162.216.150.253', 'Expanse, a Palo Alto Networks company, searches across the global IPv4 space multiple times per day to identify customers&#39; presences on the Internet. If you would like to be excluded from our scans, please send IP addresses/domains to: scaninfo@paloaltonetworks.com', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicDFEM1BKYTNBMUVmcHBvbEVkQUdiQng5a2c4NnRxWXdWcTA5WmZMSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742601112),
('CHgzoiZIu5M3Ek1jqNLjnDohji1mcW6wxjvUnfyd', NULL, '45.148.10.35', 'l9tcpid/v1.1.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV0V4R3p1NGlWWktVNjdJVXUyRTV5RElqNURpT1hmNEw4OHRiOFQweiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742604933),
('CWXUyFSarmSSWaZfs7oawOWMHhn1UOvryaif8fiF', NULL, '223.167.169.234', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidDgwaGN4YVVUSkRUZjdrRll2YmN6c3ZPaGRxUTVRZk1JOVlxWXBDaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742516988),
('dmA2rMN9ZLuNE19BYjdCUCuV7yNawWpGieFkYkhc', NULL, '108.162.227.13', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/85.0.4183.127 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNUM1R1RYYjgyYWN6UEhUcmtkZU02eFNETk84MFgxWmpqYWQ1Q2luSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742529679),
('FcdeagMP95O6Xu27LUblrChVmJQ4CYZ8FYONzAFX', NULL, '172.71.82.94', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:126.0) Gecko/20100101 Firefox/126.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU2xjbHJlMk9NbGFIWFFCSEtrdHhNMWVsVmlCd3BrNGppRDY2cWdRZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742612159),
('fkqnT51mgFZf0KEUh3vXJEGT5Rz1YOxEkiRwKksG', NULL, '167.94.138.181', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT2VUUnVNTThLYzFGNEx0aW9FMmVZcXhpdDc3N3E2b3lPdFhuMlFyQiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742599823),
('FqAuReVLGTeELuXLJrtzMDW8hr6VEhu8ezBZDfPY', NULL, '185.242.226.159', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.190 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSFd2dm5KT3BzRTZLREU3VUI5UTRtMkpkSUdhaEF2ck1wbU5IWVhPQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742533067),
('FSCnEbhEBAs1kLatJvWo5oN3gFRgBGYp4R052Uz9', NULL, '118.212.122.56', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia1g1TExMR0Q5amVFTVBEdWpNOXV4eDJGZFpDdXNSRGlxV29SRW5vOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742516028),
('FUecTinotGHeYDxny4iteXd3k0sooMYk3rz46jIq', NULL, '45.14.225.211', 'libwww-perl/6.78', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaUx5NDNLdTBvMmp4aVZzRGJVUkRIUlFKZ0V0UmhoSjd1YVFBRDJmRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742576129),
('GGL63rzR4Wk3myVFRmCToqtICytR2eXhdIe4Cpvc', NULL, '175.17.174.6', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZm40UUJuSElGQW1DVDBqRUswOFhyZTFyZ3dtUXZ3NExJRmlXZDc1YyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742517350),
('gSfBqyyLamABxBSqSJPFqIGpOuPSJZRB6AIjtlqt', NULL, '18.97.5.110', 'Mozilla/5.0 (Windows NT 6.2;en-US) AppleWebKit/537.32.36 (KHTML, live Gecko) Chrome/60.0.3016.102 Safari/537.32', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid0k3WERhaWZWYVdRY1R5NDRhQzJWbEJzWGRUTnc3TzZRYTVER1hldiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742512329),
('huecsk2phf2OzH1CdbBklmj8sRLAsxfJfnS5htci', NULL, '71.6.134.235', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQkE2YzBRb2l0VnVtSGd1RkEzdXhyUkZHVGFBQXQ0SmFqcmNEZjBSQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742572031),
('hXgZdTtz6y3OMfnfjLkkfF5FHN0aFEqHjCBevHdK', NULL, '218.104.149.199', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVnQ5cjhadDdJTjRHb29FOG1UUGYxNFcxSUdiam1pMFhHbGdyUXlqcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742515308),
('idAXcdlB6u4MtPgxM6hyXffbVjlEuU27l5TZlgmc', NULL, '104.23.168.62', 'Mozlila/5.0 (Linux; Android 7.0; SM-G892A Bulid/NRD90M; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/60.0.3112.107 Moblie Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWmtvc0JvTW9wNkEzNENtTHB1eTc0MmhqUTlKNDhrbE5tWVBLYzZLRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742570586),
('iQtP7zbrl5gUOxJ7nincMLgWdglQSIlYT970qOrD', NULL, '220.250.10.128', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTzVqMXdMTnUxUkxGemRNOXNoZ01zZ1ZhSE85d3UxUG9FVnRhbk5aYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742517830),
('iSRg0pCdo50DbFcBN58JH9ARQeq8s5fGB0cAGCFz', NULL, '172.69.165.61', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.3 Safari/605.5.16', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRnRYMDV4THVZTUE1dzRBdW5SdkJ3OHhzaFF0SkFVeXZjM1VHeFJ3MSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742597775),
('itTutg5CW7p16FaM0ZYrjB1Y2o7HvCqQblFRqqas', NULL, '172.71.147.85', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.6998.88 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid2xzRmV4ZEpiaExUQkFHNWw0dXBSemIybERCM0xzazN3ZkYxdHBuaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742522931),
('jxjm5sxZKBJ1NOEmX7CoACNq3AtNyMVR4B7WyqoO', NULL, '206.168.34.49', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVG1MZnBoU3BlVlpERGRSdHdLMkRVTUdoOG9sckRiQm54cnVFYnlHVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742593913),
('JXJqRuEqpI5DmY1aQNqVcB5Aegy5KW5CRZx0nLnG', NULL, '108.162.227.12', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.3.1 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQXJlY3Z1SDV3OThzcEV0b0lveWIxM1ZLeGpyQ3lWcjZ1dnhMRTNQcyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742619447),
('jzy4eQUi3jNZqqRaELOrrMreCoRbhtzES94EIYEa', NULL, '110.177.179.13', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiazdvZkpaM0xVczZ1Ukh0a2djaE1JTFN1QnFKTTBTUVd4VzZwVTBtcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742518250),
('KbkfYDI5F8MYzJIrdBhEwZZLsxhN881veQXahBXx', NULL, '27.98.228.48', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic29QcWJNSmpyM0NxTXVtclYwa3hVTTJJVmozWGd0Zm1SZ3k2M21RcyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742515489),
('kdbDhwHXgvGTq3kyualFJMZWp0Uby0rDhenTyi7T', NULL, '223.93.189.211', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR2xOVlRmQ0hWVzhtT2hldjhiVHFoQjhYRzFKNDN5aGg3eGJIOW9RZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742518670),
('KhJ67liSQBhTvIN6YprW8iNFTj6GvrhMC8nWFixZ', NULL, '60.13.7.74', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRGRCdUJ3ZzFkZWNyaGhpc1lyNG1YVFBGaklmU1FzWnZnSVJPUVRYTyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742516754),
('khvnJV551hwsX2ab980VsCXaYTt5wYrAWTCSM3Og', NULL, '194.50.16.252', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:55.0) Gecko/20100101 Firefox/55.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieUFrOWhlVnpKc2hWakp1QnBjdWdLQjNKUDRsODBLMzBKSURuU2drOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742577494),
('kLe1q14cwZPKjmodBwIr28OJEhnxPWVAapPIZze2', NULL, '150.255.91.178', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWmpxR1FnT3BFT2gxYlhMcldSNXZhUXFIallzRUVvT3pCY1lFaDBnTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742516330),
('kmI3lK2okIZwy4jFaPlIzQmtzpNlm8uiIEBkCR55', NULL, '45.148.10.35', 'l9tcpid/v1.1.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNHlQTnlLb0VpbEtpMXVUWGZoME1zTklBNE95dXhMdXpsSThDVWpMRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742537127),
('L3pc3VsCMyfGPK98rGrOPkgVc1eaKKSJYYwCFDny', NULL, '112.94.253.138', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidkxWSFkzRGFsVHJmUUFuTFcyMlFJb1lBOHVCVlZ1am1Cc1hmR3ZENCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742518130),
('lOButFh1XD9i69ImiZqxvvMdNRNoTya4FDgyKjOl', NULL, '45.156.128.43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS0dpU2xiOEZUNjI5NEZiRjRjSm5vQnl1TFdOUG5qYk54Tm5hMnBTMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742626469),
('lpqduGrVKuVDET5TqUCfY4sE5HlQh5r8PrBmvqvo', NULL, '172.70.147.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36 Edge/16.16299', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibk1oWllwZ0Z5ZkdmRzdodUNES1N0SGdYTGxRZEVLYVV3MTU2STBPTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkLz9nZl9wYWdlPXVwbG9hZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742519928),
('M4ZStb9yqsdoMuckAxK7xFbptNixFEjTui7M8ABX', NULL, '1.24.16.154', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWDVHVnl1NWNsMzRackw4RVFwNk1oY0UxNkRMNTdxUzhtNGdhMlBLcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742517049),
('M90t9hNxYtgI5Y3olVePARbekXyprjqXqvxtjQsQ', NULL, '92.255.57.178', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36 Edg/115.0.1901.203', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibHg4dnZmckZucE5KY291RG90TFVDNnB0TmxPQ0ZueDNUTzhvT3lyTyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742612439),
('mm4QKmomTogHKYlUO9vYltK7qacZtPH0yFaLIN1q', NULL, '162.158.106.240', 'Mozilla/5.0 (Knoppix; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSk1tSWlsVW1reDEwcExXVjVTTnljRkt5SUtEQVB3SE5NRGtQbnBsZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742619447),
('MmJwRcWfq61hD4foh2II2MdYjc9FZSvJ0pTUUknW', NULL, '60.13.138.67', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNXZ6TlZoTmIwblZMRWh3dVJ0SXJFT1Vocml0azVVb0U4Qlo3WmpLbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742515368),
('mSvIqAY2WtmDySDyykkH06p4O787NUdTgHk38cLb', NULL, '162.158.107.21', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 14_3_1) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.3.1 Safari/605.1.15', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYnpHTjk0ajYycVhYSHNwaDdlQ1J3ZFdqeVRKVEN2WGtDYjBmSUJNSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742597775),
('nJMJbQc7DukfcFsGNrkQLq8eMVykujw9FVcI6DOO', NULL, '112.94.253.65', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibm9jUnk3VjVlQ0Y4VThyTU9FcUNOdnBQV1ZTVHJGMnlsUDRkUXhqUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742517231),
('nsoxMt4PJtnvRoVSLMrY0nDtUx8RImOD933HXLwz', NULL, '141.101.105.120', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Firefox/45.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY1ZpTVBjUUxNQVBVdVV0SWQ0WUIwRWFJT2dOSTFtSldGVzVNV2VwVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742584697),
('NXfbxFFEntxRxetDB1DdJDDspiOKseIxZ3mbpBic', NULL, '206.168.34.49', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT0V5TExFdkEycWtTZktBRjl3QTB3UUdqOGZVTkFobUp3SE95dXJoVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742593899),
('Olxc3FlhxpZYc4a3SMkmS2y5buazkk1wMyb7y2sO', NULL, '183.95.159.229', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiazFEYXZ6WTlyNUd5VzVUSDRZR3JKaHdiZDZCaEg0NkNhNm93Wkt2MSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742516209),
('P7Vqi42aapMO2tRuKJ3JshTC6L9JfSjuMcTAR4V3', NULL, '60.16.205.246', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVVI2aXBrWUxIcjFrUkY3STZIR1Rwc0tFQ2M1UWpSaG9zcjcyMVQ1WiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742518491),
('PbT8qnePemveFHII6jlSpI6QvugL2leQnEAhYUpR', NULL, '185.242.226.159', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.190 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUHR2eXo0UVRvakdxbndQVlJaWkgyOVNDclEwS0t5OGsxMmQ5RUZ5MyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742601657),
('pchz52mG65xfRTQqZbaGTHY9msXk1BVUKCto3ba5', NULL, '172.71.82.12', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4240.193 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYjd3OUhoMlQ0c2dydGYySnJyODJnbmlWRTVydFhVa3ljRlIyWlUxdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742535574),
('pFywajMX4KmrDelToWXowR2grZN0f5nn5yOa6I7x', NULL, '172.70.92.230', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoielVoNVlTNXFIdFpoTlNxT1dmOEVpRHFLOVpPelRZS25OUUoxWEtmRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkLz9hdXRob3I9MSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742519926),
('pi1AAp1S57DokFJNZJGLgg4Pt7fLpQwmaxTv6cyH', NULL, '172.71.174.179', 'python-requests/2.26.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ0psQW42Qm1tQUlnZWRoeGxCS2hGSlkzdXc3d3Z0bjZVSFhBU2lrbiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742569393),
('PxttCICSE5wJVAqVPhRUexpF0hj39q3goD7UGrx4', NULL, '205.210.31.195', 'Expanse, a Palo Alto Networks company, searches across the global IPv4 space multiple times per day to identify customers&#39; presences on the Internet. If you would like to be excluded from our scans, please send IP addresses/domains to: scaninfo@paloaltonetworks.com', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUmdqczZ5eEVBZEhYRG5QbERsQmlCTEFkcDVNcTFUU05WbGZPY0tCYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742605832),
('Q9HZgoMB3FvKg0PGKelNv9a3WkLoICF4U9KE9WFz', NULL, '222.94.32.54', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNzVCS05qeld3cFRBcUQxeFFNR2NiYVBtamxLZmFiejBRcDRXSFNlNCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742516088),
('QEcDvUonM43DrKe2Iv1Tz3vtMa0zYeg2zJmbYT4E', NULL, '206.168.34.80', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRVFLdEgzRncxUWd5MmdRVndRQ05iN2pFMXA0eXBMN3FPSk5Gek1PTyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742537512),
('QoF1qMELZBxxHmSeIgiDASmWDsIckkl3xGLKi3xX', NULL, '172.69.166.24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieVpEWm1EVXRLTURlRkU5NHl4bmo3OG9VOEtzcVV5UVZ6TWpGeVlCTyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742509275),
('qQ1GfJ2xPCSQwLsEvQ8Vak65IE0d0uzHTF008avO', NULL, '34.140.24.35', 'python-requests/2.32.3', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiem8yUDZ1RTZobzRqVzhhZEdJdG9PZGJ3NmVka0lEeDYyV3pSVG9zbiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742574873),
('Qq2Z4WIIEwSgcMDPE6aSH4lqWQgyoKWkmIgKqiF4', NULL, '42.92.120.179', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib2NKMXQzVFpLV2tjQjRNdVZSemZUdTJna0taNnJrWmowWWRhMGVoVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742517168),
('qSTqJtVtSh2067D0bild9eXzAyHFKi387IMLpUyc', NULL, '3.145.165.18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM0JmeDBaOTJYTnRLYzB4TE13Tm81MHNjS1RTTkVUMWtJamt1alcwYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742574395),
('raNc6xC1n1ljzQddmpsTWlSZRyXFXI6VjK0XnV2Z', NULL, '162.158.88.47', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYkJ6SWdPeVM3eUVzc080Sm9xY0lKRmk2cjVFSjZQRlNIRTJpaGdRdyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742587068),
('rbCR4VjGl604DiwZx9nibSCiF3xb3C6YkI7owbOR', NULL, '71.6.146.185', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaVdIaXFZMnBpUWdIUVFQZ1B3aVA0TjJkRGNnOTFTWFVIR0lDMFAyWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742555045),
('rdfGULqY5QZYUcjadvs7Zq7zxGintiMmUID1UFUv', NULL, '58.59.246.213', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTnB3NjVUTHZDMmQydksxRzRVZEpNZHBxTk1oYUhFMVFyWWVWVk9IcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742515126),
('Rnmve74BXapxuTxF1YTQJrQuW3AROD7eE5t0nLcs', NULL, '92.255.85.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36 Edg/115.0.1901.203', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMEN1VzdHTnZNTnh6YnJzYmZ5Y1Y5cU1wOW1CazQyVDlPVHU1VzBERyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742514900),
('RNtyeCKfFgc2Yr41fNlHUsH9WvNcPpFOeGXsb6ma', NULL, '183.160.195.190', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOVd3N05nUUxLR3JJSGdkdUdaMXFDNFBSaGVJQkt6RkJLVUVYZWFrQiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742515669),
('sFW3jLIkjXgpJbSuhFGZDYU0bYK48gZtHL81rMGe', NULL, '111.224.235.252', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSnlOVEVWRGUzNVRtNUFMV085UnhXSkZpQ2N1R004S1gyenA5OGRzZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742516883),
('sKf4K2599eDFLK7HQ86VdSEkaNNGl7PGo8PyeYqc', NULL, '20.29.36.97', 'Mozilla/5.0 zgrab/0.x', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSnNnbVV1MGVlNkVXcW9Vc1phc3BtZ0k0YmhGWDVsZnVyMnRtVVI0cSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742602336),
('SLuekyuNmdIII0yr2BexUpI3fD5Mb5ywJfHtlOnu', NULL, '162.158.190.7', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.124 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMEZQMG9kZ3JpTmpiWnRBdDVsMzBsSml4OWw5RUQ5am80cnExVlBXSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742552662),
('sMlphbcK5sxL6NmCFNSnWdM1A4m9cgkChFVL3ZdG', NULL, '172.71.152.4', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4.1 Safari/605.1.15', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV3pOcU43cjNMelRMOUx1ZTJTcXpJblFwMTM1dnp2TWlJRldrZDA2RiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkLz9lY2hvJTIweG5sTGtqV3dJUT0iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1742619447),
('snaAQutcyUk4GySWbW0sBIo4aYeIACpZ4WUuFrnz', NULL, '172.68.22.235', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.6998.88 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibHN0SkZha1R0Qng1T0RMdURRN1Vsd01tNjY0UjNRVVFoRnR6WjNHQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742617873),
('T0g6B03toVk5MHYcfwaE56lOqP0FGtLOvgVJrCPF', NULL, '1.24.16.253', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ09qdmlKMkN2TDE5SUs5VzROa3M5TE1GOExkWEx3dlhqY0dBVWtEaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742517532),
('temdoCoQd0kAboH99iVynEWovuCfX4oF0mvj6tDD', NULL, '184.105.247.254', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:108.0) Gecko/20100101 Firefox/108.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib2E5b1hacFF3SG9XeWQ0UmFjYXV0MWhveVB5TmVaeGFOZVlmWm8zRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742561525),
('u4yEZB71debNl7S4meVo3Zc3DrYPFzh34Wgvcr1G', NULL, '162.158.38.85', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTTdOTGhYTUlwTjZCSXJ4WThmZ3VoTGtURHNhWFlIclJ0UGFMb3o0eiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkL2luZGV4LnBocCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742511465),
('u7NYSFrwTeTbExbPPPyxrEQLImAckKd2C5FUv7Hc', NULL, '172.70.208.35', 'Mozilla/5.0 (ZZ; Linux i686; rv:121.0) Gecko/20100101 Firefox/121.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ2dkWlZRdVdDbGlUeEJCYklEeWZsT3hRVThJbktCaFdlczFyZjV5SCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742609190),
('u9VBkIjLNukfYcfo2JhzK8SO4DhW4QWYFnOHBrc6', NULL, '113.128.63.102', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia3diYWVtV21wV3g0eVdodXcyd016NUNvZ0VSYjR0NXpmUEZtN2k5cyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742518189),
('uc0e592TcGrFdJ9UoEvfRWUrtTM1FOJ48hB5f4l2', NULL, '111.224.221.217', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRkNWQVZwSHJyRWFoaXlxY1NGdVNJMVBsMVIyWHdGWVNZSGsyN0pIcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742517649),
('UpyEGojhtVITwnm1qe4deh57warFltnrt5uoPduU', NULL, '184.105.247.254', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:108.0) Gecko/20100101 Firefox/108.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMUI1UVdYaWF0RXZJTnBBOVVWcnFNMFdXeU9IU1llOUlqVWVtdWY2biI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742560914),
('USauavakCusflcWBncBH2ALwBR8qvWheBWCoBhNP', NULL, '164.52.0.92', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYkl4Zm5ROTdxWEJmNUFrb0s1VHl3eGVMbkVEMHJFQTY2aWVvRERsRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742603146),
('uSOIfnbVcXtWwB5fkAFdtAmRx6hDdhbatt16frIC', NULL, '123.245.85.208', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidktYRExWaUdIVENDNWZKWVBlS1BHZkg0aDJLb1Vla00zWG1Ga2lVWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742515789),
('va7MjzuniH09Q9IRRbJbqrX5FoHgEnT5U3ieex9Q', NULL, '219.143.174.234', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQm9pQzhlZEQ2aGx6eFRnd3VHZGxGTU1ESVc4SFlsc2tzZ0V6WW96UyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742515193),
('viDNL3JfZh2EbjQw4c7DRCWwcXZLSs7JNpAoTH4g', NULL, '220.167.232.55', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaXZQWEJsaEFLOGxxclBKaklPdTBtVVI0aHg1ZU9tREdQam5LU291bCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742514966),
('vWkqg7b6kl1A7V2b1tVcF4rKmuFYQSMJMGWpe0GE', NULL, '222.94.32.122', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOWs5ODYwRURMelZPbXFKNjBIT3QwNWZZZmphN2xDeDlYdmdDRVg5MyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742516387),
('wxbMGbEQPB2tsHUQCNzzgHaF3fyCn2PJIoBnt7fj', NULL, '45.14.225.211', 'libwww-perl/6.78', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUE9UVUIyV0daeHdzTUpaRVpURjJCWmdhOVFUdE9nZGdiWFg5Um50ZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742608939),
('X6hqiqDFmKHrxTtUyYzUsJG0E7n4IcIDuDiWNq6k', NULL, '175.30.48.77', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic1VtNzN4blg2dGFLYlZDbU90ZTBjQXlBajhLS3JjVWxNZkxCY1BWRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742518375),
('x8XWfJJqhtEOGTChssgtnJobG9OP8aYm1F6rrXfm', NULL, '18.191.142.108', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUTJsc2ZqeXUydElidmQxUGRYVHdJRFowM3kxazAzMEtiOXF0T25mRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742548869),
('XbDjiqqyIt8F1wEkNHiCjGStQVRd4bPipM0KihDd', NULL, '165.22.180.81', 'Mozilla/4.0 (compatible; MSIE 9.0; Windows NT 10.0; .NET4.0C; .NET4.0E; .NET CLR 2.0.50727; .NET CLR 3.0.30729; .NET CLR 3.5.30729)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ0I5U0NVc2poazNDOU5QbUY2T2JkRThvTXExYU1BSGEwb0hERnN6dSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742595007),
('xffA4gkcP1TNC705Y2lDGfvJ3qJO39upRJTgQ8YR', NULL, '119.48.135.138', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidjR3OWI5Q0xJQ2tZZnhoa0J0ejFZMHBCWU1aeFdMYkVBZXQyMHdJTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742515008),
('XImFsWFCTVqirx6QtiecTj2SAqE6sq7AnyziALzh', NULL, '119.4.128.142', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZTJlT0pKMHpGSTd5ZzlENkVzWDFUWWFUSFB4ZmM4dXJnbmFsbHhQYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742516511),
('xuVrFIBEhLPBdBQ92c0WIncP4TlH7sggPwH3hgzI', NULL, '20.204.74.136', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT3BMRzZpV2NaS2xGVnZ4VUtSckxsZ1Voc3JIUUREQnF6TVd0eE1sbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742550073),
('Xv5ZYHLPAEXGmW8MzerpgQlX7c6zUaPewgqxb9gs', NULL, '120.36.16.99', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiREd6U2Jjb0oxQkRTSnNRb1VKTTQ4UlMxWmpSbzgwbktxZHVIbFQydyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742518013),
('YgVWswfPFQwCr2ELImATGBuwzcCyBOWBmfVyK1NJ', NULL, '153.0.125.29', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOWJEYlVCU3N5WHAzZjVCNTRHWXBab3IxMXNNeUdMQnF6eTRDQTFtZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742516628),
('yOod6b1xMjEOiUFpF0xHJ3eTInfBgit3TPYwDebP', NULL, '92.255.57.58', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidFJGMHFjdEJvR2xMZmJYWWFIb2ZvRjlaZWowWWVjM2lOa1p4b3RxNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTI6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOC8/WERFQlVHX1NFU1NJT05fU1RBUlQ9cGhwc3Rvcm0iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1742568637),
('YSmRnldWGHfOLms1RNcdgNN0xYcZDCCOrcO974Uz', NULL, '123.178.210.198', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOGsyVXRJQ2huNEhrZXZHZUlVS2hjaDdRVXpJdWJtWjBsMThBbnhHOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742517771),
('YXPzlHcOdimJmH4vbvkCwnkzcrwJGgCobAhrGl7F', NULL, '167.94.138.181', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRUl2U2hVOGJGV2JnOGdJS2J1WjRlSkhUZWE1YW5BbEhZcmdpMWc0VyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742599835),
('z6eaeyLGQvdMn3PqMj8Y9OADwBRQ1ExSuQsBI96Q', NULL, '185.242.226.159', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.190 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR2dNbFJ6NWEzWVY5c1hMYXZ4dEp1d01OSVVmcmZoMnVDSXhMOFVDeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vMTYwLjE5LjE2Ni4yOCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1742566826),
('Zfyc3rN5JhNexWATrED4yh2EcnQtAhsx48wJ8FcS', NULL, '172.70.189.87', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQUlzdVhDQ1FRYUxGRWlCY0hrS0lzUTZaSHRHc1U0bWZoWDV0d2J4NSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742518123),
('Zto3EHs2nBMzEU3hACgXb6TD5yu9nrSXNnaLB5Ni', NULL, '104.23.190.146', 'Mozilla/5.0 (compatible)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMUhHZm5EVTJLUms4WHdVRURqMzJtd05ldGl4UlFkSlY4U0JrQzRDcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vaGJpY3Muc2FmZml4LmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742550575);

INSERT INTO `submission_groups` (`id`, `uuid`, `name`, `code`, `reference_code`, `reference_number`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'bcb6224e-f594-11ef-8317-0200a013a61c', 'Install & Repair', 'INSTALL_REPAIR', 'IRP', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(2, 'bcb6dd4c-f594-11ef-aaa5-0200a013a61c', 'Design', 'DESIGN', 'DSN', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(3, 'bcb77928-f594-11ef-8a70-0200a013a61c', 'Documentation', 'DOCUMENTATION', 'DOC', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(4, 'bcb7f254-f594-11ef-a4a0-0200a013a61c', 'Broadcast', 'BROADCAST', 'BRC', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(5, 'bcb84f7e-f594-11ef-aa50-0200a013a61c', 'Media Post', 'MEDIA_POST', 'MDP', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(6, 'bcb8e0a6-f594-11ef-b1a9-0200a013a61c', 'Card', 'CARD', 'CRD', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(7, 'bcb94c80-f594-11ef-8ae3-0200a013a61c', 'Vehicle', 'VEHICLE', 'VHC', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(8, 'bcb9b7ce-f594-11ef-b767-0200a013a61c', 'Material', 'MATERIAL', 'MTL', 997, '2025-02-28 05:27:44', '2025-03-16 06:09:35', NULL),
(9, 'bcba0f76-f594-11ef-a33d-0200a013a61c', 'Event', 'EVENT', 'EVT', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(10, 'bcba7d9e-f594-11ef-b743-0200a013a61c', 'Attendance', 'ATTENDANCE', 'ATD', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(11, 'bcbad294-f594-11ef-ad78-0200a013a61c', 'Equipment', 'EQUIPMENT', 'EQP', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(12, 'bcbb2ca8-f594-11ef-aee4-0200a013a61c', 'Outstation', 'OUTSTATION', 'OTS', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(13, 'bcbbba9c-f594-11ef-a731-0200a013a61c', 'Leave', 'LEAVE', 'LEV', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(14, 'bcbc18de-f594-11ef-a2df-0200a013a61c', 'Training', 'TRAINING', 'TRN', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(15, 'bcbd3700-f594-11ef-9ce4-0200a013a61c', 'Resignation', 'RESIGNATION', 'RSN', 1, '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL);

INSERT INTO `users` (`id`, `uuid`, `profile_id`, `name`, `email`, `phone`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'bd0fb5de-f594-11ef-937f-0200a013a61c', 1, 'SAFFix', 'admin@saffix.id', NULL, '2025-02-28 05:27:44', '$2y$12$hxDmGDPG6YGzsu1YnYjHpOIJAjwQkwE2EEw/gzJTOM/jqAnESJD5C', 'SkF0o8zGon', '2025-02-28 05:27:44', '2025-02-28 05:27:44', NULL),
(2, 'bd3745ae-f594-11ef-8351-0200a013a61c', 2, 'HBICS', 'admin@hbics.sch.id', NULL, '2025-02-28 05:27:44', '$2y$12$PvO7ApYRGdOm3cReV0MqmOgIcD849xrTy6rlDu1VKOAIq9pIvabaW', 'BU8sFP1R7RoFIioLnhWTpP6QLpUtSX861RBaryFOPcKIozy4ckMl8PHhMbDF', '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(3, 'bd476970-f594-11ef-8b3c-0200a013a61c', 3, 'Developer Saffix', 'developer@saffix.id', NULL, '2025-02-28 05:27:45', '$2y$12$0NImtbCrBA6G4VtiTUvcMe7HLGJa/Rfqv8XWyo8D54RDyDtzGzQPG', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(4, 'bd48f65a-f594-11ef-8ee4-0200a013a61c', 4, 'Yacobus S', 'yacobus.s@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$12$HwxXAUnoQSOzYs1AC2ZNXu5u22s1UDwS3nBO2BgS8TcXmfJ374QzK', NULL, '2025-02-28 05:27:45', '2025-03-09 07:48:18', NULL),
(5, 'bd4a4dd4-f594-11ef-ae5b-0200a013a61c', 5, 'Dina Adesthy Njoo', 'dinaadesthy.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$12$oUrjSqng9bL/9FuMUnExmua1nhC0/0QRbD7NZIpLx6cFKmj3QPw/W', 'jEBjvOyuXlGUEO32hLSz5GCl8yG0EsYh2UWhJ0lTRH0R3i29lVHnegoUT0k2', '2025-02-28 05:27:45', '2025-03-11 02:32:12', NULL),
(6, 'bd4babfc-f594-11ef-9bd7-0200a013a61c', 6, 'Dyah Anggarini', 'dyah.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$/VddK5WLx4WpYTQICB0W1uBWoAihzwa9Vrk0/rMd0v.6kQdlAxpge', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(7, 'bd4cabe2-f594-11ef-b409-0200a013a61c', 7, 'ICC_akun_test', 'yacobus.setiawan@hotmail.com', NULL, '2025-02-28 05:27:45', '$2y$10$6/DsnuIBHLHjSV4gpjB5fuS8KNxvgAjMYPjz7pjWpz3IMRqVZ/PSG', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(8, 'bd4e375a-f594-11ef-910f-0200a013a61c', 8, 'Natalia Heriati', 'nataliaheriati.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$12$6LJ5OxDa1WW7OVQZ3xPdUul428k7Oq.KOAfc7yK4XIT4myIG1dUnO', NULL, '2025-02-28 05:27:45', '2025-03-03 00:52:15', NULL),
(9, 'bd4f8f92-f594-11ef-b4aa-0200a013a61c', 9, 'Masye Polla', 'masyepolla.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$ZkGTYHC4L/6lLejYGgNVweD38nOA6kdsLh7RVQTJLt/dGOP373vWO', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(10, 'bd50efe0-f594-11ef-b902-0200a013a61c', 10, 'Elprida simanjuntak', 'elpridasimanjuntak.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$VYjAomOEp.bVQUgW47XavuCkbK5rxNqv7zuoL.PWHaCz4cdogEDja', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(11, 'bd5232f6-f594-11ef-968d-0200a013a61c', 11, 'Enita Sitinjak S.PD', 'enitasitinjak.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$BPd8IgkDR4A5vZlr6RRZEe4AyXKpCvMDe/uO/YetT3Y.7SMiI9V7y', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(12, 'bd5397a4-f594-11ef-b467-0200a013a61c', 12, 'Eva Grace Sumasa S.Pd', 'evasumasa.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$onFpmGsUWALjDkudKnblJOKnXJZSKdRHBhszvbd7hvwYRWNog01Ci', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(13, 'bd54f41e-f594-11ef-983a-0200a013a61c', 13, 'Grace Charity Tehilla Harjanto', 'gracecharity.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$ynQnJe17/KREQIRPEgyir.BHUy7sZ2w31cvBnsHdtqloLZMosp1GO', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(14, 'bd564742-f594-11ef-95ef-0200a013a61c', 14, 'Ivana M. Kawung', 'ivanakawung.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$WdeqJ7hVthddkFUi45JsFuNdR/Wm3r2mojHc91jzFtK0LV7pysqrC', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(15, 'bd579430-f594-11ef-a726-0200a013a61c', 15, 'Juika Sobon', 'juikasobon.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$CIypvEeWlwSnF62D98945ObBMR8u0CLYQxxnq1m6UfRVFJRcBVeEW', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(16, 'bd58e416-f594-11ef-86c3-0200a013a61c', 16, 'Loed Devina Abigail', 'loeddevina.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$FozdHiQWpbIuAqBsuplc1ONNInFwEcEApGWwOF5ABqS9adn8GZVYG', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(17, 'bd5a2e20-f594-11ef-b38b-0200a013a61c', 17, 'Maya Cyntia Sigar', 'mayasigar.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$12$pU4MUF4dARVsb.RNYqC3FuptrhbfLGEV2KOosaqn2qlmVjZCR5m/a', NULL, '2025-02-28 05:27:45', '2025-03-03 00:56:42', NULL),
(18, 'bd5b80c2-f594-11ef-b42a-0200a013a61c', 18, 'Priscilla Tirsa Sulangi', 'priscillasulangi.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$12$Kzr8daZuCeIbrRFkklbQn.gjdaI8dwMpXS4Ot51qLzbr.8.X7SB/.', NULL, '2025-02-28 05:27:45', '2025-03-16 06:31:08', NULL),
(19, 'bd5cdd82-f594-11ef-992e-0200a013a61c', 19, 'Ryen Mart Purba', 'ryenpurba.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$EZyPg2ZS5MA1YIJJMSpl3OBQJ1jGiXC0lWuBmllgJ7181Aj01c8yy', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(20, 'bd5e2570-f594-11ef-8086-0200a013a61c', 20, 'Salvira Limbong', 'salviralimbong.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$nc1rqU3ac01k8XaAhWbFRubBd6GIImfsnAmXg4zrRYC6MrO66Q8cC', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(21, 'bd5f8e38-f594-11ef-94d5-0200a013a61c', 21, 'Tasya Maria Febrianti', 'tasyamf.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$4PSFCwJc4X6CjFRrzLTowesvlx.9XCcfNF/Pq9L2n1tfKvwnxX.4m', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(22, 'bd6101fa-f594-11ef-b79f-0200a013a61c', 22, 'Yoise Merine Seitte', 'yoiseseitte.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$qAUvpAYolzF4B0VAmSeI7OvtOGCB43y/Qu2MwmFxCcIg8e/OL299K', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(23, 'bd626932-f594-11ef-a05d-0200a013a61c', 23, 'Febiyoga Alit Pawestri', 'febiyoga.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$KduOsDAPYDfFe2Alm8/.9uVmNYCwm0cLZN3t3tMbwNIRjBngP/uqq', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(24, 'bd63ca8e-f594-11ef-9705-0200a013a61c', 24, 'Meniria Laoli', 'menirialaoli.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$w8mNDS8zSeLCTqukoV6CneQpUDaa6mQk72FyblssjcvuCnpz3Q16.', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(25, 'bd653126-f594-11ef-9c93-0200a013a61c', 25, 'Wildah Edrostina Nababan', 'wildah.hhk@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$0o.C.VTE2ov7lBvPLlUF/uQJ7fohUiqmIsyPuh0AE51CDEOBNOF1u', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(26, 'bd66b1b8-f594-11ef-973f-0200a013a61c', 26, 'Hana Flowerens Sitorus', 'hana.sitorus@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$AKlRM90T8N/KUgjyj7X4T.XWklUXzCetcnGmZiPBRAm6zqluaT0Fu', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(27, 'bd68315a-f594-11ef-888e-0200a013a61c', 27, 'Chelsia Sumendap', 'chelsia.sumendap@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$kBqD0CBvbxKZ/NCHWIZeRudmkt1.Ruqv8PP0j6X2pu5rHI18d3yNm', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(28, 'bd699d2e-f594-11ef-8990-0200a013a61c', 28, 'Mangapul Silalahi', 'mangapulsilalahi.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$QKSWKD74V2dzeD4YZ9F.G.Hwhc7eHyDgwzsvnxJq24zwCWNbB0beW', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(29, 'bd6b1118-f594-11ef-9acc-0200a013a61c', 29, 'Amelia Sondang Febriyanti', 'amelia.sondang@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$bC7n0BPY1cU6NkSkLa/jQ.Qgo7daIq3k2XwM0Xwqpe5pQUifxbD1y', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(30, 'bd6caae6-f594-11ef-8395-0200a013a61c', 30, 'Anjelyn Susanti Purba', 'anjelynpurba.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$MPa37Mx68.NZRrsGlbCYa.4Bror3Pn.ncu3sARKv6jAfBRF1LPCjm', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(31, 'bd6e5148-f594-11ef-9f4a-0200a013a61c', 31, 'Brigita Rosari', 'brigitarosari.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$3Yjc2BGUILDOcV52mnWr8uxWgOpK0vp8Pgw2.XudRlQv7LTmiKZXm', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(32, 'bd703350-f594-11ef-8b04-0200a013a61c', 32, 'Christina Carolyna Bakara', 'christinabakara.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$9ix3Rrl7zt5PvANo6BW3W.q/tqL4MMt0YlBxDW4rGhi5a4Uiv2FFW', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(33, 'bd71e196-f594-11ef-9d3f-0200a013a61c', 33, 'Desmin Berliani Harefa', 'desmin.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$MTiQR84.aCAQEEDsswxqJ.kprSAMvs896xcRLDMuKjyXoqW.6mI8C', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(34, 'bd73524c-f594-11ef-a369-0200a013a61c', 34, 'Erik Gunena', 'erik.gunena@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$12$QS0BzG3OlUhPRRtjus/xTOqgyT3vhmZw0iTUL6D5cA0Gh8goOHXZG', 'UdwvcyftZ7PY6rErXE5dO1Si0qqz0n6Zzlg7SbqvLmwBEeiNkuOgRtag8sXA', '2025-02-28 05:27:45', '2025-02-28 07:39:30', NULL),
(35, 'bd74f598-f594-11ef-98eb-0200a013a61c', 35, 'Friska Yanti Tobing', 'friskayanti.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$Zr6Mf7jk/uNT04a2/e6JyuEGxLEw/g/9Ji.bNJgUY6pLvlNCLpwgq', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(36, 'bd7661b2-f594-11ef-967f-0200a013a61c', 36, 'Gloria Siahaan', 'gloriasiahaan.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$iB2gli8eie6YSLBoCn3LK.fQ4JC6k7njkYQS93FnmQBokFwrVdHEO', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(37, 'bd77fea0-f594-11ef-aa3b-0200a013a61c', 37, 'Hellen Christina', 'hellenchristina.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$Zavl4zhpnogBBoJo2mj15uIssJHJ.2B0LE9SuRSy/SAN51S3Uc/sS', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(38, 'bd79e27e-f594-11ef-a354-0200a013a61c', 38, 'Indriani Ginting', 'indrianiginting.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$GbzzyaNm1P8JNrtEcxM/eOGYsRRqzfZP9xW6EEUsWgmLi64CS9r/m', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(39, 'bd7b6342-f594-11ef-a037-0200a013a61c', 39, 'Kristian Adinata P', 'kristianpangaribuan.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$341GuvWPlM49c.yw2e5ny.6swCk9tdTR2vPWX2NBwyDy7u.nSZEti', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(40, 'bd7cd574-f594-11ef-b484-0200a013a61c', 40, 'Lougi Virgi Priscilla Posumah', 'lougi.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$EAn/5Oh82fw5pERKnAaoze75NVxK.Wpz7QahWkiXWzUOwBQxJN5Fu', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(41, 'bd7eb844-f594-11ef-9d70-0200a013a61c', 41, 'Mega Ningrum Suwarno Putri', 'meganingrum.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$dx.t72FLsSXlW0JvaMZy7.aG4A5YK2mFh/WkwRn0EkQ04DGXl1ueq', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(42, 'bd80272e-f594-11ef-94c8-0200a013a61c', 42, 'Meini Fiana Fransiska', 'meinifiana.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$WZasI.Z92Q85yrLQCPlmyufH9gar6ZXQPm7iUv311Wr.zrOUDVDZy', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(43, 'bd81d3b2-f594-11ef-a260-0200a013a61c', 43, 'Meity Varyda Dene Saragih', 'meitysaragih.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$XG.7y/bCb4/WBwHOzjmu4OYL4OLlVFtl5ZhfD8oOHYJrEj5Dgdp2C', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(44, 'bd833734-f594-11ef-b273-0200a013a61c', 44, 'Monica', 'monica.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$eyo8FBH.kigxWGFLKAHZlubS1cGWgJ9y/ZpgsTQkauP3JHBNNWZ0O', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(45, 'bd851630-f594-11ef-91e3-0200a013a61c', 45, 'Nora Agustina Silalahi', 'noraagustina@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$.wO5iamP4IqUErrqsJfnSuNWEQKYnSLcttVC2UsD4cZYuVqzlNa62', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(46, 'bd86eec4-f594-11ef-b6c7-0200a013a61c', 46, 'Novilina Veronica Inu Dhei', 'novilinadhei.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$u9PjwfjyH9PEuhGi5awTDO1q5qh1zdNxGdKkEufVzub.hFMQgBWdi', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(47, 'bd88f5ca-f594-11ef-af11-0200a013a61c', 47, 'Novita Permata Sari Tambunan', 'novi.tambunan@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$EYBKiTr2H5zSJLMzhEdP9usI3XrA54d1PHOg.gI1tnZyiqHx6cBf2', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(48, 'bd8aa168-f594-11ef-b2d3-0200a013a61c', 48, 'Rados Fremiro Sembiring', 'rados.fsembiring@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$Ke12fnkBtxPQdu6niReqmeBccCFmKvTj/ClvUbXQSHZA6ieq3z40u', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(49, 'bd8cf706-f594-11ef-88f3-0200a013a61c', 49, 'Rahmadianti', 'rahmadianti.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$yMDTpzTsASVcwkkSZzuxm.M/HVu7LqHDr2cEA9uyQ26ll69q7QtNu', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(50, 'bd8efbfa-f594-11ef-90ff-0200a013a61c', 50, 'Rimson Marusaha Sinaga', 'matthew.sinaga@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$crwGniMuHEdEBlioW4btu.7RQuTg4OrM/OREt4YlE2nYTsPZp1NnW', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(51, 'bd9072b4-f594-11ef-b282-0200a013a61c', 51, 'Ruth Magdalena Simanjuntak', 'lena@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$Ao80Kv7XI4Kk7J6tQrKTc.27Mc80BeqQ.dot2QeM6rjvsUbRUme6O', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(52, 'bd91da96-f594-11ef-a7ff-0200a013a61c', 52, 'Tirsa Ester Amanda Koroh', 'tirsakoroh.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$Vrs9SQY8z2Er7tysHiC/Z.6BtDf5XbBGLzgyC6MVFRzNit22XAK.a', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(53, 'bd936280-f594-11ef-8941-0200a013a61c', 53, 'Vestin Putri Telaumbanua', 'vestinputri.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$BoR.Bpb1s8G7Rqf3aPTDc.rV4kJGlwNOwYqOlwqk7kWpdIoi3ZfyK', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(54, 'bd961520-f594-11ef-8939-0200a013a61c', 54, 'Vania Ananda Massangka', 'vaniaananda.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$XvFvJ3QDrUixYpNZAKUeGetcSrHiQbzI5wWpApaw3Hs.C5lOPjjHm', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(55, 'bd97e7ba-f594-11ef-aec1-0200a013a61c', 55, 'Yonatan Alhas Wijaya', 'yonatan.awijaya@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$CXgunff0tqp/3rVMSSAjfudOpMSb/bGD4oCRC/O46lEZdk8yNrJIe', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(56, 'bd9953e8-f594-11ef-97f5-0200a013a61c', 56, 'Elisabet Simanjuntak', 'elisabethsimanjuntak.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$u90S7xNsWE8lUNDTXQ94wuv0Tsl33MtQkwzGP.UZfGymPm2yUUjBq', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(57, 'bd9abbca-f594-11ef-ad82-0200a013a61c', 57, 'Elisabeth Agnes Tnunay', 'agnes.tnunay@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$dGlkoiEAb2lb9zI9QSQviuBLptatKGpINhxGwJiueRDqL6WBv7rTe', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(58, 'bd9c483c-f594-11ef-8f78-0200a013a61c', 58, 'Angela Merlyn Primatika', 'angelamryln.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$bwjSrwcozVnsfCOOqHMHwOgJfRv9T8YbreDOHVRAoPiDjLmnhlkLC', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(59, 'bd9dc0a4-f594-11ef-85d1-0200a013a61c', 59, 'Dita Primalani Nainggolan', 'ditaprimalani.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$/UqF4XLeBqQ.8f25GO.oiOs76QasOwHq/j7iz89YSv5bJImjueQJW', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(60, 'bd9f4820-f594-11ef-979a-0200a013a61c', 60, 'Laura A.D Sihombing', 'lauraad.sihombing@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$3lJ946srI9RI0xGXDlBZMO8oj7N6m7SeRhEPnAQS26lggs/4CJ6wi', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(61, 'bda0b48a-f594-11ef-abb7-0200a013a61c', 61, 'Tracey Sheilla Asia', 'traceys.asia@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$mtyGtWZ8nShU7IeYM516keEdYWEz7G9KRyoTmT/uRXuJHz4esUyBO', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(62, 'bda23350-f594-11ef-9dbc-0200a013a61c', 62, 'Rika Febriyanti Lamtiur Panjaitan', 'rika.panjaitan@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$IKkRzNcmlsrSf.h432nWXOi2S2LWlCkMVu7GLZf11x.xw5azMC0Eu', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(63, 'bda3abf4-f594-11ef-ba0e-0200a013a61c', 63, 'Kristina Habeahan', 'kristina.habeahan@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$RPRBrfMq..7.971fZwjSre5.peM4JLkmxHjqba8JZS9qydwKg1RnK', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(64, 'bda51692-f594-11ef-8f6b-0200a013a61c', 64, 'Betty Sianturi', 'bettysianturi.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$VJ56M0Wymo2DkEk5kWnJHOSRQCisEsSeFjVwQSS5GuzJIyOq/jmSK', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(65, 'bda756b4-f594-11ef-8d02-0200a013a61c', 66, 'Margaretha Dwi Cahyani', 'margarethacahyani.hb-high@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$pyVBGnHswNe4t0VQsHHOL.gX6wwE9YKFZuXFprTAy90avrD34rSpG', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(66, 'bda8ac8a-f594-11ef-96ef-0200a013a61c', 67, 'Angelis Andreas Gama', 'aandreasgama.hb-secondary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$unOF8gUXTM2qtzGsaej3F.uZFIaA09j5amyf4mz8QhSV7FQqIIYvm', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(67, 'bdaa2d4e-f594-11ef-b452-0200a013a61c', 68, 'Anita Simamora', 'anitasimamora.hb-secondary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$Qc0N/gui8xwGkbDguoLmHOn/c46YdMVL2rnSMqE7O001Ac2WSDNVi', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(68, 'bdabf656-f594-11ef-a88a-0200a013a61c', 69, 'Arianti', 'arianti.hb-high@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$i83tIH9uvOBnoNlK8AIPce5QGREsIHzKoz3kqJ/DRiheGFpPesXVm', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(69, 'bdad9a7e-f594-11ef-8720-0200a013a61c', 70, 'Ayu Estiyanti Widiyantari Kiswanto', 'ayuestiyanti.hb-secondary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$BKx44c3jXDUJ97.Z5km.XeGcBhou51unRGL1MFR7/6c1Q21D6LbVO', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(70, 'bdaf30a0-f594-11ef-9eb9-0200a013a61c', 71, 'Bunga Ratnasari Hadipitoyo', 'bungaratnasari.hb-secondary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$12$9ZRhQd9WCedGBdfXDHOQNu7zQeCvlWt0iibwYL3c44AerUKx.6PjK', NULL, '2025-02-28 05:27:45', '2025-02-28 07:38:15', NULL),
(71, 'bdb0b132-f594-11ef-a5d6-0200a013a61c', 72, 'Chatrilitha Laurine Nouviana', 'cnouviana.hb-high@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$/jEgjJogPT75eowSJxQE8OeQ3Hp/xH5d31MNuAvv2oGNWIe38/yqS', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(72, 'bdb3412c-f594-11ef-96bf-0200a013a61c', 74, 'Fertunata Monica Darsono', 'fertunatadarsono.hb-high@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$Oh/OrobIpa/Fxph6ItnC1OV.tAAX.a94hR2HIu.ACQae8lPszFcGG', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(73, 'bdb4b0f2-f594-11ef-a2bc-0200a013a61c', 75, 'Jeisica Lumy', 'jeisicalumy.hb-seniorhigh@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$sJA7uQFJUTcfp4eMnuiz8ujSJLJjF.fzovHU1RplvRn7E/NtTmfdC', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(74, 'bdb62234-f594-11ef-9163-0200a013a61c', 76, 'Jessie BulurDitty', 'jessie.hb-secondary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$xzO54jEBwzmxdroVU9YIY..HyqWj54AazKNXnSSAGcCbYUPSM7YMW', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(75, 'bdb7be6e-f594-11ef-abd3-0200a013a61c', 77, 'Maria Josebia Pangestuti', 'mariajosebia.hb-secondary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$qZkJ0UqUYyXYcrU9GFxhLOsig6cxxn2yxlZvqNYKU1dTN/Kzkc/R.', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(76, 'bdbcc774-f594-11ef-a0da-0200a013a61c', 79, 'Meylodra Wilhelmina P', 'meylodra.hb-secondary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$zDxTWLx90orNLIS55eICOuCExDUradgzpGuqYRgoRK8SR75ia8qXO', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(77, 'bdbe4716-f594-11ef-9a1f-0200a013a61c', 80, 'Pingkan Patricia Ishwari', 'pingkanishwari.hb-high@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$RZpqymBtoo.2uxpJMXUq7u.2X9XMx1b52IK0.ufVh50tE5w5biw.i', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(78, 'bdc07d9c-f594-11ef-b131-0200a013a61c', 81, 'Riswandi Sinurat', 'riswandisinurat.hb-secondary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$ZN5qUBh1Lp0idI4GXD5uZeB3DirT2kPfxwvekTu1WdpIwWmV7rrBu', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(79, 'bdc20df6-f594-11ef-999d-0200a013a61c', 82, 'Sari Fitri Dewi Debora Sinaga', 'sarifitri.hb-secondary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$NEnIvxamOfuCKZPI5y7CBuc146fF6wsRyMwxNdESV.Y61Q69E1N5a', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(80, 'bdc3cc86-f594-11ef-a0f8-0200a013a61c', 83, 'Stella Fanny Gerina', 'stella.hb-secondary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$HhjoSfgbEK475lzLJp3ZveXMdw.Sa5eDtFkniJE1jq3suFfd7gMhy', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(81, 'bdc5a740-f594-11ef-9654-0200a013a61c', 84, 'Suci Florence Night Ingeale S', 'suciflorence.hb-secondary@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$Cs4vrfQgRnQEtMvfeH2sZOwPAEA9.ccJ.MNcRxlhCQpdUwiYSR83W', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(82, 'bdc796a4-f594-11ef-9967-0200a013a61c', 85, 'Vina Meliyana BR Perangin angin', 'vinameliyana.hb-seniorhigh@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$bmSFzaH0y8uBkRoas4C.V.CyYzfdQDOjPWHgvq3lI2HqBTG2Dj48O', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(83, 'bdc92f6e-f594-11ef-9c7b-0200a013a61c', 86, 'Sukarman', 'sukarman.hb-seniorhigh@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$L6wDyuQpp9sOT.arbZhm3OCKM1miZUQ8P0/fHHt8OmYJa8Cry/q4q', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(84, 'bdcb873c-f594-11ef-b6bd-0200a013a61c', 87, 'Rizky Kurniawan', 'rizkykurniawan.hb-seniorhigh@hbics.sch.id', NULL, '2025-02-28 05:27:45', '$2y$10$Pqb4.FRLZQ5XV0e6ON8u1eYoO121mV0bADabxnspvpBUjYnycTltS', NULL, '2025-02-28 05:27:45', '2025-02-28 05:27:45', NULL),
(85, 'bdcd597c-f594-11ef-ba89-0200a013a61c', 88, 'Eryka Mayang Pamungkas', 'eryka.hb-secondary@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$PA1kzavwWoZD2WvZOJqbJOglT/nVNQOrAz6uLSEZj0xRHa3cHnl0y', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(86, 'bdcf20d6-f594-11ef-b1d3-0200a013a61c', 89, 'Andreas Lukita', 'andreaslukita.hb-seniorhigh@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$nls80GWbjxKgDGj242ddW.7dgsYFTeQbmRCLitc/KEtyt2Gqes54W', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(87, 'bdd0e236-f594-11ef-ad5b-0200a013a61c', 90, 'Azalia Herma', 'azaliaherma.hb-seniorhigh@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$XhDIizTF5tylKnqRhg5jauR4cD8KYxME4T.JmGF2CGi0kAShBnNoK', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(88, 'bdd2b804-f594-11ef-a7f5-0200a013a61c', 91, 'Hans Gouw', 'hans.gouw@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$AChbTzqzr824LyzjcyI5deGtHY/30hSx2ZfJpGS3TgDLqPknL4aGy', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(89, 'bdd45204-f594-11ef-8b7c-0200a013a61c', 92, 'Febriyanti Menasetiabudi', 'febriyantimenasetiabudi.hb-secondary@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$V4eM45sp/jtg/51hieBTG.ePkd4N8g4i.YU4Qm6gcjCfnCum2dZXe', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(90, 'bdd5bce8-f594-11ef-acef-0200a013a61c', 93, 'Roosye Carolina', 'roosyecarolina.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$12$vI.PXrmSuFsT10WIXWfvhufyZSRLY3YsJTNt.Hhb057q3mqQVYNjS', NULL, '2025-02-28 05:27:46', '2025-03-03 00:49:52', NULL),
(91, 'bdd736fe-f594-11ef-8c3e-0200a013a61c', 94, 'Eristiannponglangi', 'eristiannponglangi.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$4RZzWq3l8Mp8djGVWl5iiOy8W4XW4Z3i2ap/IuOiB9ci2wzB3Jiti', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(92, 'bdd8dd10-f594-11ef-8c6e-0200a013a61c', 95, 'Olivia Deti Duta', 'olivia.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$AGV7p/B/FPBx3tAKcCSboOefSTJy7Xdp7ocUfJz0Gh7UwwdfwQhLq', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(93, 'bddabd42-f594-11ef-b20d-0200a013a61c', 96, 'Tresia Tiku Lele', 'tere.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$4XWlQmjH0sbrXm9XODVgLOyQk5r/51SgXF/J2TdaTf7GkDK4627a2', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(94, 'bddc8758-f594-11ef-94d7-0200a013a61c', 97, 'Vivi Natalia', 'vivinatalia.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$JW4OVHzFsCDgmfokVyKeq.g2lZpgZwCKYHHvm6XSwuLf8TNVrogEC', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(95, 'bdde2432-f594-11ef-96d6-0200a013a61c', 98, 'Mely', 'mely.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$wXYBywcy6MGZPKmEE3paI./4nNoTPu7ONuYw7SPEVx6t9fUzAmUIO', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(96, 'bddfd052-f594-11ef-9762-0200a013a61c', 99, 'Yenny Elmira Siahaan', 'yeni.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$jb34uz.HONHmYOOUKvB4F.OPRPRqJJjhrxL2W0IVmxSKOSXWDGHpq', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(97, 'bde179f2-f594-11ef-842b-0200a013a61c', 100, 'Alek Sander Agung', 'aleksander.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$DFeI14XVQ/OJSVfFh29ivepV2uOgTc07Z4hb4DFQgCshgwySy.24.', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(98, 'bde34f34-f594-11ef-af9c-0200a013a61c', 101, 'Ariadi', 'ardi.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$hHeHfqQSzRjArmGUn/vrsOFkjaMCI1SQBARgnOLYJM0vOhjKp.zWG', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(99, 'bde4e498-f594-11ef-b647-0200a013a61c', 102, 'Barlevi Sharon', 'levi.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$YUnatZOfx1TpsceSjyjST.qimVi5E8M4VKrQVemfwnZWxKUa.lWgq', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(100, 'bde6c3d0-f594-11ef-ba0f-0200a013a61c', 103, 'Devi Novita Sari, S.H', 'devi.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$aOYg/6RfJLrzHpIm3ziiae99UXiNlEWx6FxH34nEkwWo1Rs/hrVOa', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(101, 'bde89b24-f594-11ef-87a9-0200a013a61c', 104, 'Jessica Prisicilia Sarajar', 'jessica.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$9aRbcQx28ehlnNYAkC/3WOTh0RkVpZ3sxIlECmgW9dj3Sc9clHY.m', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(102, 'bdea638c-f594-11ef-a9bd-0200a013a61c', 105, 'Kerestian Naihonam', 'keristian.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$Q.POHF2xZwVt4.57TaI2lu/g/QJylElRznWY/bJ5imYjrHsoc3BHC', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(103, 'bdec3338-f594-11ef-864a-0200a013a61c', 106, 'Muchtar RM', 'muchtar.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$0GhiXE9egflaZIwCrMeI5O3hrd4VVts5aAqaqLXaME9QIRf3ky83O', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(104, 'bdede76e-f594-11ef-83b7-0200a013a61c', 107, 'Nofry G Mangindaan', 'novry.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$369KEaSpnHD80c2wrRLR3uTFGQFyLqmL2L18K4wHogf0eZ2djRux2', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(105, 'bdef7958-f594-11ef-9d7a-0200a013a61c', 108, 'Sugeng Suriyadi', 'sugeng.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$8jcOHiA3i6qBeeyrGSjHk.Po47KvOEhwjIGL8sYBVwiaSDbkEL/8K', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(106, 'bdf227ca-f594-11ef-ba18-0200a013a61c', 110, 'Tasya Gloria Wowor', 'tasyagloria.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$O2kOZg.olu4agr5xiWVod.zuYDgFj8Nghv/slHeHLKT3bS3XMjX0K', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(107, 'bdf3c1de-f594-11ef-840f-0200a013a61c', 111, 'Agnes Puspa Indah', 'agnes.indah@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$6xMSWlpzYZ5LZamTIq6LvuoboPwvPxzRwml4HgANe6ZacgsgVyicO', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(108, 'bdf56368-f594-11ef-b0ee-0200a013a61c', 112, 'Adytya Lambang Nugraha', 'adytya.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$.auZ0c9V9P3NDSLIFaO4auLWaHPtZx6HuEAaw.Q2amNUJpFgJhsSm', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(109, 'bdf6ef76-f594-11ef-82b2-0200a013a61c', 113, 'Andre Witarsa', 'andre.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$3bVGVU8UVWNBe3dnnG/zgO6qZ/WTlp5RBxul8Fc5tY.wrL316zWYe', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(110, 'bdf8713e-f594-11ef-a7db-0200a013a61c', 114, 'Ingrit Agustin Wullur', 'ingritaw.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$zoiSTyeyVBs36BRZpcIvyukLuyYkD3rxP5LR9OCdfPNzFrTrsY3yO', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(111, 'bdfa242a-f594-11ef-9a52-0200a013a61c', 115, 'Natanael Ferdinand', 'natanael.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$/fTwm6gFMrv4icXyFKwbPe4aPdlaZCDQLsrYiWQB9uzZ13CkVqw1y', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(112, 'bdfbd536-f594-11ef-bd7c-0200a013a61c', 116, 'Widya Disriyati Simatupang', 'widya.ytcb@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$2Fir8zYNCWCyGSOlgiLjd.Fr2dq.HaFsRUWaZugdbv3pUlxXGUhpG', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(113, 'bdfec1a6-f594-11ef-b7c5-0200a013a61c', 118, 'Ireyne Nopiana Sinaga', 'ireyne.hb-primary@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$m0Wl2ZGooafonhW/h9kbPuswxSRqklwkpeV1PJhIGEN/7ACSN8dyG', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(114, 'be0084aa-f594-11ef-b28a-0200a013a61c', 119, 'Mario Septianto Nugroho', 'marioseptianto.hb-seniorhigh@hbics.sch.id', NULL, '2025-02-28 05:27:46', '$2y$10$OvZaLKQ9ydfwX3o1wqsENudBroMx/kEOoZKQ4WbWVhfoduO2IOV1K', NULL, '2025-02-28 05:27:46', '2025-02-28 05:27:46', NULL),
(115, '414a9f2c-f7bf-11ef-a403-0200a013a61c', 120, 'Lesyel Jovana', 'lesyeljovana.edcon@hbics.sch.id', '+62 815-4922-7735', NULL, '$2y$12$y/JU13be7Bs5FfniPRdxe.52sGxNfjyUYuFMnuveVu9iaS8nOqob.', NULL, '2025-03-02 23:37:07', '2025-03-02 23:38:25', NULL);



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;