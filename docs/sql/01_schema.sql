-- Banking Management System
-- MySQL 8.0+ | Run this script first.
-- WARNING: This script drops and recreates project tables in the selected database.

CREATE DATABASE IF NOT EXISTS banking_management_system
  CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE banking_management_system;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `nominee`;
DROP TABLE IF EXISTS `emi_payment`;
DROP TABLE IF EXISTS `bank_transaction`;
DROP TABLE IF EXISTS `bank_account`;
DROP TABLE IF EXISTS `loan`;
DROP TABLE IF EXISTS `customer`;
DROP TABLE IF EXISTS `branch`;
DROP TABLE IF EXISTS `account_type`;
DROP TABLE IF EXISTS `active_customers`;
DROP TABLE IF EXISTS `loan_customers`;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `branch` (
  `branch_id` int NOT NULL,
  `branch_name` varchar(100) NOT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`branch_id`),
  UNIQUE KEY `branch_name` (`branch_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `account_type` (
  `account_type_id` int NOT NULL,
  `account_type_name` varchar(50) NOT NULL,
  `minimum_balance` decimal(15,2) NOT NULL,
  PRIMARY KEY (`account_type_id`),
  UNIQUE KEY `account_type_name` (`account_type_name`),
  CONSTRAINT `chk_account_min_balance` CHECK ((`minimum_balance` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `mobile_number` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  `referrer_customer_id` int DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `mobile_number` (`mobile_number`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_customer_branch` (`branch_id`),
  KEY `fk_customer_referrer` (`referrer_customer_id`),
  KEY `idx_customer_name` (`customer_name`),
  CONSTRAINT `fk_customer_branch` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `fk_customer_referrer` FOREIGN KEY (`referrer_customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `chk_customer_gender` CHECK ((`gender` in (_utf8mb4'Male',_utf8mb4'Female',_utf8mb4'Other')))
) ENGINE=InnoDB AUTO_INCREMENT=1051 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `bank_account` (
  `account_number` bigint NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `account_type_id` int NOT NULL,
  `opening_date` date NOT NULL,
  `balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `account_status` varchar(20) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`account_number`),
  KEY `fk_account_customer` (`customer_id`),
  KEY `fk_account_type` (`account_type_id`),
  CONSTRAINT `fk_account_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `fk_account_type` FOREIGN KEY (`account_type_id`) REFERENCES `account_type` (`account_type_id`),
  CONSTRAINT `chk_account_balance` CHECK ((`balance` >= 0)),
  CONSTRAINT `chk_account_status` CHECK ((`account_status` in (_utf8mb4'Active',_utf8mb4'Inactive',_utf8mb4'Closed')))
) ENGINE=InnoDB AUTO_INCREMENT=1081 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `bank_transaction` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `account_number` bigint NOT NULL,
  `transaction_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `transaction_type` varchar(10) NOT NULL,
  `transaction_amount` decimal(15,2) NOT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `fk_transaction_account` (`account_number`),
  KEY `idx_transaction_date` (`transaction_date`),
  CONSTRAINT `fk_transaction_account` FOREIGN KEY (`account_number`) REFERENCES `bank_account` (`account_number`),
  CONSTRAINT `chk_transaction_amount` CHECK ((`transaction_amount` > 0)),
  CONSTRAINT `chk_transaction_type` CHECK ((`transaction_type` in (_utf8mb4'Credit',_utf8mb4'Debit')))
) ENGINE=InnoDB AUTO_INCREMENT=1401 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `loan` (
  `loan_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `loan_type` varchar(50) NOT NULL,
  `loan_amount` decimal(15,2) NOT NULL,
  `interest_rate` decimal(5,2) NOT NULL,
  `loan_status` varchar(20) NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`loan_id`),
  KEY `fk_loan_customer` (`customer_id`),
  CONSTRAINT `fk_loan_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `chk_interest_rate` CHECK ((`interest_rate` > 0)),
  CONSTRAINT `chk_loan_amount` CHECK ((`loan_amount` > 0)),
  CONSTRAINT `chk_loan_status` CHECK ((`loan_status` in (_utf8mb4'Active',_utf8mb4'Closed',_utf8mb4'Pending')))
) ENGINE=InnoDB AUTO_INCREMENT=1031 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `emi_payment` (
  `emi_id` int NOT NULL AUTO_INCREMENT,
  `loan_id` int NOT NULL,
  `payment_date` date NOT NULL,
  `emi_amount` decimal(15,2) NOT NULL,
  `payment_status` varchar(20) NOT NULL,
  PRIMARY KEY (`emi_id`),
  KEY `fk_emi_loan` (`loan_id`),
  CONSTRAINT `fk_emi_loan` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`),
  CONSTRAINT `chk_emi_amount` CHECK ((`emi_amount` > 0)),
  CONSTRAINT `chk_payment_status` CHECK ((`payment_status` in (_utf8mb4'Paid',_utf8mb4'Pending')))
) ENGINE=InnoDB AUTO_INCREMENT=1157 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `nominee` (
  `nominee_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `nominee_name` varchar(100) NOT NULL,
  `relationship` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`nominee_id`),
  KEY `fk_nominee_customer` (`customer_id`),
  CONSTRAINT `fk_nominee_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1051 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `active_customers` (
  `customer_id` int NOT NULL DEFAULT '0',
  `customer_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `loan_customers` (
  `customer_id` int NOT NULL DEFAULT '0',
  `customer_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
