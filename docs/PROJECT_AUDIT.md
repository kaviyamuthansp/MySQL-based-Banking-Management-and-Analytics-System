# Project audit based on `Dump20261012.sql`

## What the supplied export actually contains

- Database recorded in the dump header: `banking_management_system`
- Source environment: MySQL Server 8.0.46
- 10 tables: `account_type`, `active_customers`, `bank_account`, `bank_transaction`, `branch`, `customer`, `emi_payment`, `loan`, `loan_customers`, `nominee`
- 2 views: `loan_summary_view`, `transaction_report_view`
- Inserted sample rows counted from the export:
  - `branch`: 10
  - `account_type`: 5
  - `customer`: 50
  - `bank_account`: 80
  - `bank_transaction`: 200
  - `loan`: 30
  - `emi_payment`: 52
  - `nominee`: 50
  - `active_customers`: 50
  - `loan_customers`: 30

## Findings and fixes applied to the organized scripts

1. **Dependency order:** the dump's table order is not a natural run order because it was generated with foreign-key checks disabled. `01_schema.sql` creates referenced tables before dependent tables, and the seed script inserts parent rows before child rows.
2. **Database selection:** the dump identifies `banking_management_system` in its header but does not contain a `CREATE DATABASE` or `USE` statement. The organized schema explicitly creates/selects that database.
3. **Redundant indexes:** the original `bank_account` schema declares `idx_account_number` even though `account_number` is the primary key. The original `customer` schema declares `idx_customer_mobile` in addition to the unique index on `mobile_number`. Those duplicate indexes were omitted from the cleaned schema.
4. **View portability:** the original views use `DEFINER='root'@'localhost'`; the cleaned view definitions omit the host-specific definer.
5. **Temporary view placeholders:** the dump contains intermediate placeholder view definitions as part of Workbench/MySQL dump output. The organized view script contains only the final intended view definitions.
6. **Assignment query coverage:** the uploaded file is a schema/data export, not a full collection of the SQL exercises from the larger assignment. Supplemental query examples have therefore been placed in `04_queries_and_reports.sql`; they are clearly separate from the original dump.
7. **Set operators:** the sample set-operation queries use `UNION`, `INTERSECT`, and `EXCEPT`. `INTERSECT`/`EXCEPT` require MySQL 8.0.31+.
8. **Security:** user/role administration examples are commented out. They require suitable privileges and should not be run with placeholder passwords.
9. **Destructive behavior:** `01_schema.sql` drops and recreates the project tables. `02_sample_data.sql` deletes rows before reinserting the sample data. Run only in a learning/test database.

## Validation limits

This package was inspected statically from the supplied dump. It was not executed against a running MySQL server during packaging, so the README does not claim a successful end-to-end runtime test. Please run it in MySQL Workbench and inspect the Action Output panel.
