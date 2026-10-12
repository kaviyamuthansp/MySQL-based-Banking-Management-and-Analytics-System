-- Query practice and business reports
-- MySQL 8.0+ | Run after 01_schema.sql and 02_sample_data.sql.
USE banking_management_system;

-- 1. Basic SELECT, WHERE, ORDER BY, aliases
SELECT customer_id, customer_name, branch_id
FROM customer
WHERE gender = 'Female'
ORDER BY customer_name;

-- 2. Scalar and string/date functions
SELECT customer_name,
       UPPER(customer_name) AS name_upper,
       CHAR_LENGTH(customer_name) AS name_length,
       TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS approximate_age
FROM customer
ORDER BY customer_name;

-- 3. Aggregate functions
SELECT COUNT(*) AS customer_count,
       MIN(customer_id) AS first_customer_id,
       MAX(customer_id) AS last_customer_id
FROM customer;

-- 4. GROUP BY and HAVING: customer count per branch
SELECT b.branch_name, COUNT(c.customer_id) AS customer_count
FROM branch AS b
LEFT JOIN customer AS c ON c.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name
HAVING COUNT(c.customer_id) >= 1
ORDER BY customer_count DESC;

-- 5. JOIN: account holders and account types
SELECT c.customer_name, a.account_number, at.account_type_name, a.balance
FROM customer AS c
JOIN bank_account AS a ON a.customer_id = c.customer_id
JOIN account_type AS at ON at.account_type_id = a.account_type_id
ORDER BY c.customer_name, a.account_number;

-- 6. LEFT JOIN: include customers who have no loan
SELECT c.customer_id, c.customer_name, l.loan_id, l.loan_type
FROM customer AS c
LEFT JOIN loan AS l ON l.customer_id = c.customer_id
ORDER BY c.customer_id;

-- 7. Correlated subquery: accounts above that customer's average balance
SELECT a.account_number, a.customer_id, a.balance
FROM bank_account AS a
WHERE a.balance > (
    SELECT AVG(a2.balance)
    FROM bank_account AS a2
    WHERE a2.customer_id = a.customer_id
);

-- 8. ANY / ALL comparison examples
SELECT account_number, balance
FROM bank_account
WHERE balance > ANY (SELECT balance FROM bank_account WHERE account_type_id = 1);

SELECT account_number, balance
FROM bank_account
WHERE balance >= ALL (SELECT balance FROM bank_account);

-- 9. Set operators: MySQL 8.0.31+ supports UNION, INTERSECT, EXCEPT.
SELECT customer_id, customer_name FROM active_customers
UNION
SELECT customer_id, customer_name FROM loan_customers;

SELECT customer_id, customer_name FROM active_customers
INTERSECT
SELECT customer_id, customer_name FROM loan_customers;

SELECT customer_id, customer_name FROM active_customers
EXCEPT
SELECT customer_id, customer_name FROM loan_customers;

-- 10. Monthly transaction totals
SELECT YEAR(transaction_date) AS transaction_year,
       MONTH(transaction_date) AS transaction_month,
       transaction_type,
       COUNT(*) AS transaction_count,
       SUM(transaction_amount) AS total_amount
FROM bank_transaction
GROUP BY YEAR(transaction_date), MONTH(transaction_date), transaction_type
ORDER BY transaction_year, transaction_month, transaction_type;

-- 11. Branch-wise total balances
SELECT b.branch_name, COALESCE(SUM(a.balance), 0) AS total_account_balance
FROM branch AS b
LEFT JOIN customer AS c ON c.branch_id = b.branch_id
LEFT JOIN bank_account AS a ON a.customer_id = c.customer_id
GROUP BY b.branch_id, b.branch_name
ORDER BY total_account_balance DESC;

-- 12. Customers with more than one account
SELECT c.customer_id, c.customer_name, COUNT(a.account_number) AS account_count
FROM customer AS c
JOIN bank_account AS a ON a.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(a.account_number) > 1
ORDER BY account_count DESC;

-- 13. Top loan holders by total loan amount
SELECT c.customer_id, c.customer_name, SUM(l.loan_amount) AS total_loan_amount
FROM customer AS c
JOIN loan AS l ON l.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_loan_amount DESC
LIMIT 10;

-- 14. EMI payment status summary
SELECT payment_status, COUNT(*) AS payment_count, SUM(emi_amount) AS total_emi_amount
FROM emi_payment
GROUP BY payment_status;

-- 15. Dormant accounts: accounts with no recorded transactions
SELECT a.account_number, a.customer_id, a.balance
FROM bank_account AS a
WHERE NOT EXISTS (
    SELECT 1
    FROM bank_transaction AS t
    WHERE t.account_number = a.account_number
);

-- 16. Window function: rank accounts by balance
SELECT account_number, customer_id, balance,
       DENSE_RANK() OVER (ORDER BY balance DESC) AS balance_rank
FROM bank_account;

-- 17. View examples
SELECT * FROM customer_account_view ORDER BY customer_name;
SELECT * FROM loan_summary_view ORDER BY loan_amount DESC;
SELECT * FROM transaction_report_view ORDER BY transaction_date DESC;

-- 18. Regular expression example (MySQL 8.0+)
SELECT customer_id, customer_name, email
FROM customer
WHERE email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$';

-- 19. Information schema: table inventory for this schema
SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = DATABASE()
ORDER BY table_type, table_name;

-- 20. Index inventory
SHOW INDEX FROM customer;
SHOW INDEX FROM bank_transaction;
