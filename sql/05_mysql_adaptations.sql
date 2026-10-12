-- MySQL adaptations for Oracle-oriented assignment topics
-- Review and run selected statements individually as needed.
USE banking_management_system;

-- AUTO_INCREMENT is MySQL's common identity-generation approach; this project
-- already uses it for customer, account, transaction, loan, EMI and nominee IDs.
-- MySQL does not implement Oracle CREATE SYNONYM.

-- MySQL session/system time-zone settings (not Oracle DBTIMEZONE/SESSIONTIMEZONE):
SELECT @@global.time_zone AS global_time_zone,
       @@session.time_zone AS session_time_zone,
       @@system_time_zone AS system_time_zone;

-- Metadata / data dictionary examples (MySQL information_schema):
SELECT table_name
FROM information_schema.tables
WHERE table_schema = DATABASE();

SELECT table_name, constraint_name, constraint_type
FROM information_schema.table_constraints
WHERE table_schema = DATABASE()
ORDER BY table_name, constraint_type;

SELECT table_name, index_name, column_name, non_unique
FROM information_schema.statistics
WHERE table_schema = DATABASE()
ORDER BY table_name, index_name, seq_in_index;

-- MySQL has no direct FULL OUTER JOIN syntax. Emulate it with a LEFT JOIN
-- plus unmatched rows from the right side.
SELECT c.customer_id, c.customer_name, l.loan_id
FROM customer AS c
LEFT JOIN loan AS l ON l.customer_id = c.customer_id
UNION ALL
SELECT c.customer_id, c.customer_name, l.loan_id
FROM customer AS c
RIGHT JOIN loan AS l ON l.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Oracle MINUS is represented by EXCEPT in MySQL 8.0.31+.
-- If your server is older, use NOT EXISTS / anti-join instead.

-- Example index creation. Avoid re-creating indexes already present in schema.
-- customer.customer_name and bank_transaction.transaction_date already have indexes.
-- UNIQUE indexes already exist on customer.mobile_number and customer.email.

-- Example read-only role/user administration (OPTIONAL; requires suitable privileges).
-- Replace the example username and host to match your environment.
-- CREATE ROLE IF NOT EXISTS 'banking_readonly';
-- GRANT SELECT ON banking_management_system.* TO 'banking_readonly';
-- CREATE USER IF NOT EXISTS 'banking_report_user'@'localhost' IDENTIFIED BY 'REPLACE_WITH_A_STRONG_PASSWORD';
-- GRANT 'banking_readonly' TO 'banking_report_user'@'localhost';
-- SET DEFAULT ROLE 'banking_readonly' TO 'banking_report_user'@'localhost';
