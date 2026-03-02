# 3200_project_1

We created several database components for a company we made up, named ShelfShare. Components can be seen within the various files of this repository.

Within p1_BusinessRequirements.pdf:
* Short description of our company, along with user stories, verbs, nouns, and rules

Within p1_UML_ERD.pdf:
* Screenshots of our UML and ERD, alongside a link to view our ERD in LucidCharts.

Within p1_RelationalSchema.pdf:
* Our relational schema, with proof of BCNF

Within schema.sql:
* DDL statements that create all 12 tables in SQLite3, with CHECK constraints, foreign keys, and UNIQUE constraints

Within seed.sql:
* Test data populating all 12 tables (8 users, 12 books, 12 authors, 16 user-book copies, 8 loans, 10 reviews, etc.)

Within queries.sql:
* Seven queries demonstrating the database:
  * Q1 — Join of 4+ tables: active loans with book title, lender, and borrower
  * Q2 — Subquery: users who have never borrowed a book
  * Q3 — GROUP BY with HAVING: users with avg rating ≥ 4.5 and 2+ reviews
  * Q4 — Complex search criterion: available books in Bay Area Bookworms circle (5 AND/OR conditions)
  * Q5 — SELECT CASE/WHEN: classify users into collector tiers
  * Q6 — PARTITION BY with RANK(): borrowers ranked within each circle
  * Q7 — Recursive CTE: trust network reachability through shared circle memberships

Within selfshare.db:
* The populated SQLite database file, openable in DB Browser

## Screenshots

* `Database Structure.webp` — All 12 tables created in DB Browser (Task 5)
* `Test Data 1.webp` — Author table populated
* `Test Data 2.webp` — User table populated
* `Test Data 3.webp` — Loan table populated
* `Q1.webp` through `Q7.webp` — Each query executed with SQL and results visible
