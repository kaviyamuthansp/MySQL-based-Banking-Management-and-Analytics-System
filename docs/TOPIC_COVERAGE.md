# SQL topic coverage matrix

This matrix separates what is evidenced in the uploaded export from what the organized project adds or documents. It is not a claim that every item in the original 37-step assignment was present in the export.

| Topic | In uploaded export | In organized project | Notes |
|---|---|---|---|
| Database selection | Header only | Covered | `01_schema.sql` creates/selects `banking_management_system` |
| Table creation | Covered | Covered | 10 tables |
| Primary keys | Covered | Covered | Declared in schema |
| Foreign keys | Covered | Covered | Customer/branch, self-referrer, account, transaction, loan, EMI, nominee links |
| CHECK constraints | Covered | Covered | Gender, balance, amount, status, interest checks |
| UNIQUE constraints | Covered | Covered | Branch name, account type name, customer mobile/email |
| Sample data / INSERT | Covered | Covered | Seed script contains extracted sample inserts |
| AUTO_INCREMENT / ID generation | Covered for selected tables | Covered/documented | MySQL approach; no Oracle sequence objects |
| SELECT / WHERE / ORDER BY | Not in export as exercise queries | Covered | `04_queries_and_reports.sql` |
| Scalar functions | Not as query exercises | Covered | UPPER, CHAR_LENGTH, TIMESTAMPDIFF |
| Aggregate functions | Not as query exercises | Covered | COUNT, MIN, MAX, SUM, AVG |
| GROUP BY / HAVING | Not as query exercises | Covered | Branch and account reports |
| INNER JOIN | Used in views | Covered | View definitions and query examples |
| LEFT / RIGHT JOIN | Not as exercise queries | Covered | Report examples and full-outer emulation |
| Subqueries | Not as exercise queries | Covered | Correlated query, ANY/ALL, NOT EXISTS |
| Set operators | Helper tables exist; queries absent | Covered with version note | UNION; INTERSECT/EXCEPT on MySQL 8.0.31+ |
| Views | 2 views | Covered | Adds `customer_account_view` |
| Indexes | Present | Covered | Duplicate indexes on PK/unique fields removed from cleaned schema |
| Synonyms | Not present | Documented limitation | MySQL does not support Oracle CREATE SYNONYM |
| User / role security | Not present | Optional commented example | Requires admin privileges; not run automatically |
| Data dictionary / metadata | Not present | Covered | `information_schema` queries |
| Date/time functions | Date/datetime columns | Covered | YEAR, MONTH, CURDATE, TIMESTAMPDIFF and timezone variables |
| Regular expressions | Not present | Covered | `REGEXP` example |
| Analytical/window functions | Not present | Covered | DENSE_RANK example |
| Final business reports | Views only | Covered | Branch balances, loan holders, EMI status, monthly transactions, dormant accounts |
| Execution proof / testing | Not included | Not included | Must be run locally in Workbench before submission |

## Items to confirm against your assignment sheet

If the marking rubric explicitly requires stored procedures, stored functions, triggers, transactions (`START TRANSACTION`/`COMMIT`/`ROLLBACK`), `EXPLAIN`, `CASE`, `IFNULL`/`COALESCE`, or a specific list of 37 queries, add them only after comparing with the exact assignment wording. They are not evidenced as implemented in the supplied dump.
