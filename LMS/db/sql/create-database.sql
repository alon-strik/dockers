DROP DATABASE IF EXISTS lms;
CREATE DATABASE lms;
DROP DATABASE IF EXISTS identity;
CREATE DATABASE identity;
DROP DATABASE IF EXISTS rating;
CREATE DATABASE rating;

--GRANT ALL PRIVILEGES ON lms.* TO 'lms'@'%' IDENTIFIED BY 'Admin11!' WITH GRANT OPTION;
--GRANT ALL PRIVILEGES ON identity.* TO 'lms'@'%' IDENTIFIED BY 'Admin11!' WITH GRANT OPTION;
--GRANT ALL PRIVILEGES ON rating.* TO 'lms'@'%' IDENTIFIED BY 'Admin11!' WITH GRANT OPTION;


use lms;


-- MySQL dump 10.13  Distrib 5.5.54, for debian-linux-gnu (x86_64)
--
-- Host: lms-database-vpc-9ef1ddfa.ch4cnmnpag8a.eu-west-1.rds.amazonaws.com    Database: lms
-- ------------------------------------------------------
-- Server version	5.6.27-log

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
-- Table structure for table `DATABASECHANGELOG`
--

DROP TABLE IF EXISTS `DATABASECHANGELOG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DATABASECHANGELOG` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  `CONTEXTS` varchar(255) DEFAULT NULL,
  `LABELS` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `DATABASECHANGELOGLOCK`
--

DROP TABLE IF EXISTS `DATABASECHANGELOGLOCK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DATABASECHANGELOGLOCK` (
  `ID` int(11) NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audit_logs`
--

DROP TABLE IF EXISTS `audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit_logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creation_date` datetime(3) DEFAULT NULL,
  `update_date` datetime(3) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  `user_name` varchar(64) NOT NULL,
  `result` varchar(64) DEFAULT NULL,
  `action` varchar(64) DEFAULT NULL,
  `category` varchar(64) DEFAULT NULL,
  `action_data` varchar(1024) NOT NULL,
  `response_data` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `component_encryption_keys`
--

DROP TABLE IF EXISTS `component_encryption_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `component_encryption_keys` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creation_date` datetime(3) DEFAULT NULL,
  `update_date` datetime(3) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  `serial_number` varchar(16) NOT NULL,
  `encryption_key` varbinary(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_serial_number` (`serial_number`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `components`
--

DROP TABLE IF EXISTS `components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `components` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creation_date` datetime(3) DEFAULT NULL,
  `update_date` datetime(3) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  `serial_number` varchar(255) NOT NULL,
  `type` varchar(10) NOT NULL,
  `unit_id` bigint(20) DEFAULT NULL,
  `tenant_name` varchar(64) NOT NULL,
  `hw_version` varchar(16) DEFAULT NULL,
  `sw_version` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_cu0mor85o5s3gj53h292du617` (`serial_number`),
  KEY `FK_pduwr2uqbxs15we8jare3dq2b` (`unit_id`),
  CONSTRAINT `FK_pduwr2uqbxs15we8jare3dq2b` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `daily_telemetry`
--

DROP TABLE IF EXISTS `daily_telemetry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daily_telemetry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `telemetry_time_stamp` datetime(3) DEFAULT NULL,
  `credit_minutes` smallint(6) NOT NULL,
  `on_time` smallint(6) NOT NULL,
  `standby_time` smallint(6) NOT NULL,
  `no_reception_time` smallint(6) NOT NULL,
  `critical_events_counter` tinyint(4) NOT NULL,
  `key_press_counter` tinyint(4) NOT NULL,
  `average_cellular_reception` tinyint(4) NOT NULL,
  `cellular_reception_changes` smallint(6) NOT NULL,
  `max_temperature` tinyint(4) NOT NULL,
  `charging_status` smallint(6) NOT NULL,
  `max_current_panel` tinyint(4) NOT NULL,
  `max_current_load` tinyint(4) NOT NULL,
  `max_current_battery` tinyint(4) NOT NULL,
  `max_volt_panel` double(3,1) NOT NULL,
  `max_volt_load` double(3,1) NOT NULL,
  `max_volt_battery` double(3,1) NOT NULL,
  `battery_cycles` smallint(6) NOT NULL,
  `state_of_health` tinyint(4) NOT NULL,
  `number_of_sms_received` tinyint(4) NOT NULL,
  `security_token` int(11) NOT NULL,
  `creation_date` datetime(3) DEFAULT NULL,
  `update_date` datetime(3) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  `unit_id` bigint(20) NOT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__daily_tlm_unit_id_units_id` (`unit_id`),
  KEY `FK_daily_tlm_job_id_jobs_id` (`job_id`),
  CONSTRAINT `FK__daily_tlm_unit_id_units_id` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`),
  CONSTRAINT `FK_daily_tlm_job_id_jobs_id` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `daily_telemetry_data_packets`
--

DROP TABLE IF EXISTS `daily_telemetry_data_packets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daily_telemetry_data_packets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `start_time` datetime(3) DEFAULT NULL,
  `end_time` datetime(3) DEFAULT NULL,
  `panel_generated_power` tinyint(4) NOT NULL,
  `user_load_power` tinyint(4) NOT NULL,
  `state_of_charge` tinyint(4) NOT NULL,
  `is_partial_data` bit(1) NOT NULL,
  `creation_date` datetime(3) DEFAULT NULL,
  `update_date` datetime(3) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  `telemetry_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_data_packet_daily_telemetry_id` (`telemetry_id`),
  CONSTRAINT `FK_data_packet_daily_telemetry_id` FOREIGN KEY (`telemetry_id`) REFERENCES `daily_telemetry` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_steps`
--

DROP TABLE IF EXISTS `job_steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_steps` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creation_date` datetime(3) DEFAULT NULL,
  `update_date` datetime(3) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  `name` varchar(64) NOT NULL,
  `status` varchar(64) NOT NULL,
  `job_id` bigint(20) NOT NULL,
  `spawned_job_id` bigint(20) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_jobs_steps_job_id` (`job_id`),
  CONSTRAINT `FK_jobs_steps_job_id` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creation_date` datetime(3) DEFAULT NULL,
  `update_date` datetime(3) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  `name` varchar(64) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `request_id` varchar(255) DEFAULT NULL,
  `status` varchar(64) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `response_code` varchar(255) DEFAULT NULL,
  `response_logs` varchar(255) DEFAULT NULL,
  `status_update_date` datetime(3) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `command_arguments_id` bigint(20) DEFAULT NULL,
  `tenant_name` varchar(64) NOT NULL,
  `origin_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_parent_id_to_job_id` (`parent_id`),
  KEY `fk_origin_id_to_job_id` (`origin_id`),
  CONSTRAINT `fk_origin_id_to_job_id` FOREIGN KEY (`origin_id`) REFERENCES `jobs` (`id`),
  CONSTRAINT `fk_parent_id_to_job_id` FOREIGN KEY (`parent_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `properties`
--

DROP TABLE IF EXISTS `properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `properties` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creation_date` datetime(3) DEFAULT NULL,
  `update_date` datetime(3) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  `name` varchar(128) DEFAULT NULL,
  `value` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1102 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sps_command_arguments`
--

DROP TABLE IF EXISTS `sps_command_arguments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sps_command_arguments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `job_id` bigint(20) NOT NULL,
  `creation_date` datetime(3) DEFAULT NULL,
  `update_date` datetime(3) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  `arguments` longtext,
  `security_token` varchar(128) DEFAULT NULL,
  `destination_id` varchar(128) DEFAULT NULL,
  `message_id` varchar(128) DEFAULT NULL,
  `exec_type` varchar(64) DEFAULT NULL,
  `unit_serial` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sps_command_log_request`
--

DROP TABLE IF EXISTS `sps_command_log_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sps_command_log_request` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creation_date` datetime(3) DEFAULT NULL,
  `update_date` datetime(3) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  `request_iv` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `unit_phone` varchar(20) DEFAULT NULL,
  `request_raw_data` varbinary(140) DEFAULT NULL,
  `error_message` varchar(1024) DEFAULT NULL,
  `error_code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `sps_command_log_response`
--

DROP TABLE IF EXISTS `sps_command_log_response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sps_command_log_response` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creation_date` datetime(3) DEFAULT NULL,
  `update_date` datetime(3) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  `response_iv` bigint(20) DEFAULT NULL,
  `response_raw_data` varbinary(140) DEFAULT NULL,
  `unit_request_id` bigint(20) DEFAULT NULL,
  `unit_phone` varchar(20) DEFAULT NULL,
  `error_code` varchar(20) DEFAULT NULL,
  `error_message` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_spsCmdLogRequest` (`unit_request_id`),
  CONSTRAINT `fk_spsCmdLogRequest` FOREIGN KEY (`unit_request_id`) REFERENCES `sps_command_log_request` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sps_state`
--

DROP TABLE IF EXISTS `sps_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sps_state` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creation_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  `serial_number` varchar(255) NOT NULL,
  `iv` int(11) NOT NULL DEFAULT '0',
  `fota_state` varchar(64) DEFAULT 'IDLE',
  `fota_state_msg` varchar(255) DEFAULT 'NO_ERROR',
  `encryption_mode` varchar(8) DEFAULT 'DEBUG',
  `time_diff` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial_number` (`serial_number`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `units` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creation_date` datetime(3) DEFAULT NULL,
  `update_date` datetime(3) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  `owner_phone` varchar(20) DEFAULT NULL,
  `crm_asset_id` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) NOT NULL,
  `serial_number` varchar(255) NOT NULL,
  `activation_end` datetime(3) DEFAULT NULL,
  `activation_start` datetime(3) DEFAULT NULL,
  `tenant_name` varchar(64) NOT NULL,
  `encryption_mode` varchar(255) NOT NULL DEFAULT 'DEBUG',
  `sps_state_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_number` (`phone_number`),
  UNIQUE KEY `UK_9y6j5qdly933wtul6y8cc6lem` (`serial_number`),
  UNIQUE KEY `crm_asset_id` (`crm_asset_id`),
  UNIQUE KEY `owner_phone` (`owner_phone`),
  KEY `FK__units_sps_state_id_sps_state_id` (`sps_state_id`),
  CONSTRAINT `FK__units_sps_state_id_sps_state_id` FOREIGN KEY (`sps_state_id`) REFERENCES `sps_state` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `unmanaged_units`
--

DROP TABLE IF EXISTS `unmanaged_units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unmanaged_units` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `iv` int(11) NOT NULL DEFAULT '0',
  `creation_date` datetime(3) DEFAULT NULL,
  `update_date` datetime(3) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  `serial_number` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_9y6j5qdly933wtul6y8cc6lem` (`serial_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `who_am_i_telemetry`
--

DROP TABLE IF EXISTS `who_am_i_telemetry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `who_am_i_telemetry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `iccid` varchar(20) NOT NULL,
  `msisdn` varchar(15) NOT NULL,
  `gateway_id` varchar(16) NOT NULL,
  `panel_id` varchar(16) DEFAULT NULL,
  `battery_id` varchar(16) NOT NULL,
  `idu_hw_version` tinyint(4) NOT NULL,
  `idu_sw_version` varchar(7) NOT NULL,
  `panel_version` varchar(7) NOT NULL,
  `battery_version` varchar(7) NOT NULL,
  `soc` tinyint(4) NOT NULL,
  `lac` smallint(6) NOT NULL,
  `cell_id` smallint(6) NOT NULL,
  `rssi` tinyint(4) NOT NULL,
  `number_of_sms_received_since_reset` smallint(6) NOT NULL,
  `operation_mode` tinyint(4) NOT NULL,
  `message_iv` int(11) NOT NULL,
  `creation_date` datetime(3) DEFAULT NULL,
  `update_date` datetime(3) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  `unit_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_units_id` (`unit_id`),
  KEY `FK_jobs_id` (`job_id`),
  CONSTRAINT `FK_jobs_id` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`),
  CONSTRAINT `FK_units_id` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
