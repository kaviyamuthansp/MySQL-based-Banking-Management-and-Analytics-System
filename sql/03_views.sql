-- Reporting views. Run after schema and sample data (or after schema alone).
USE banking_management_system;

DROP VIEW IF EXISTS transaction_report_view;
DROP VIEW IF EXISTS loan_summary_view;
DROP VIEW IF EXISTS customer_account_view;

CREATE VIEW loan_summary_view AS
SELECT c.customer_name, l.loan_type, l.loan_amount, l.loan_status
FROM customer AS c
JOIN loan AS l ON l.customer_id = c.customer_id;

CREATE VIEW transaction_report_view AS
SELECT c.customer_name, t.transaction_date, t.transaction_type, t.transaction_amount,
       a.account_number, a.customer_id
FROM customer AS c
JOIN bank_account AS a ON a.customer_id = c.customer_id
JOIN bank_transaction AS t ON t.account_number = a.account_number;

CREATE VIEW customer_account_view AS
SELECT c.customer_id, c.customer_name, c.mobile_number, c.email,
       a.account_number, at.account_type_name, a.opening_date, a.balance, a.account_status
FROM customer AS c
JOIN bank_account AS a ON a.customer_id = c.customer_id
JOIN account_type AS at ON at.account_type_id = a.account_type_id;
