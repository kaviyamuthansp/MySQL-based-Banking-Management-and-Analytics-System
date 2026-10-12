# Banking Management System (MySQL)

A learning project built in MySQL Workbench to practice relational schema design, constraints, sample data, joins, aggregation, subqueries, views, indexing, metadata queries, date/time functions, regular expressions, and analytical SQL.

## Environment

- MySQL Server 8.0+ (the source export identifies MySQL 8.0.46)
- MySQL Workbench
- Git / GitHub

## Repository structure

```text
Banking-Management-System-GitHub/
├── README.md
├── docs/
│   ├── PROJECT_AUDIT.md
│   └── TOPIC_COVERAGE.md
└── sql/
    ├── 01_schema.sql
    ├── 02_sample_data.sql
    ├── 03_views.sql
    ├── 04_queries_and_reports.sql
    ├── 05_mysql_adaptations.sql
    └── original/
        └── Dump20261012.sql
```

## Run in MySQL Workbench

1. Open `sql/01_schema.sql` and execute it. **It drops and recreates the project tables**, so do not run it against a database containing data you need.
2. Execute `sql/02_sample_data.sql`.
3. Execute `sql/03_views.sql`.
4. Run queries from `sql/04_queries_and_reports.sql` individually or section by section.
5. Review `sql/05_mysql_adaptations.sql`. Its administrative commands are commented out intentionally; select only what you understand and have permission to run.

The scripts use the database name `banking_management_system`, which is the database recorded in the supplied export.

## Main tables

- `branch`
- `customer`
- `account_type`
- `bank_account`
- `bank_transaction`
- `loan`
- `emi_payment`
- `nominee`

The export also contains `active_customers` and `loan_customers`, which are sample tables used for set-operation exercises.

## Data and scope

The supplied dump contains 10 tables, 2 reporting views, and sample rows. The original dump is preserved under `sql/original/`. The cleaned scripts are reorganized for dependency-aware execution; redundant indexes on an already indexed primary/unique key were removed from the cleaned schema. Query exercises in `04_queries_and_reports.sql` and MySQL-specific notes in `05_mysql_adaptations.sql` are supplemental project material, not statements copied from the original export.

This is a demonstration dataset. Do not use the example names, contact details, or balances as real banking data.

## Compatibility notes

- The scripts target MySQL 8.0+. `INTERSECT` and `EXCEPT` examples require MySQL 8.0.31 or later.
- MySQL does not support Oracle `CREATE SYNONYM`, `MINUS`, `DBTIMEZONE`, or Oracle data dictionary views such as `USER_TABLES`. MySQL alternatives are documented in `05_mysql_adaptations.sql`.
- MySQL uses `AUTO_INCREMENT` in this schema instead of Oracle-style sequences.
- The original exported views were defined as `DEFINER='root'@'localhost'`. The cleaned view script omits that machine-specific definer so it is more portable.
- No live database execution test was performed as part of generating this package. Execute the scripts in a disposable local schema and check the Workbench output before submitting.

## Audit

See `docs/PROJECT_AUDIT.md` for findings and `docs/TOPIC_COVERAGE.md` for the coverage matrix.
