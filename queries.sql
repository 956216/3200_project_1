-- ============================================================
-- ShelfShare — Queries
-- Task 7
-- ============================================================

-- ============================================================
-- Q1: JOIN OF 3+ TABLES
-- Show all active loans with the book title, lender name,
-- borrower name, and condition at lend.
-- Joins: Loan → UserBook → Book, Loan → User (borrower),
--        UserBook → User (lender)  [4 tables]
-- ============================================================
SELECT
    ln.loanId,
    b.title                AS book_title,
    lender.name            AS lender,
    borrower.name          AS borrower,
    ln.conditionAtLend,
    ln.dueDate
FROM Loan ln
JOIN UserBook ub       ON ln.userBookId = ub.userBookId
JOIN Book b            ON ub.isbn       = b.isbn
JOIN User lender       ON ub.userId     = lender.userId
JOIN User borrower     ON ln.loaneeId   = borrower.userId
WHERE ln.status = 'ACTIVE'
ORDER BY ln.dueDate;


-- ============================================================
-- Q2: SUBQUERY
-- Users who have never been the borrower on any loan.
-- ============================================================
SELECT
    u.userId,
    u.name,
    u.email
FROM User u
WHERE u.userId NOT IN (
    SELECT DISTINCT loaneeId
    FROM Loan
)
ORDER BY u.name;


-- ============================================================
-- Q3: GROUP BY with HAVING
-- Users whose average rating as a review_subject is 4.5+
-- and who have received at least 2 reviews.
-- ============================================================
SELECT
    u.name,
    COUNT(r.reviewId)        AS review_count,
    ROUND(AVG(r.rating), 2)  AS avg_rating
FROM Review r
JOIN User u ON r.review_subject = u.userId
GROUP BY r.review_subject
HAVING COUNT(r.reviewId) >= 2
   AND AVG(r.rating) >= 4.5
ORDER BY avg_rating DESC;


-- ============================================================
-- Q4: COMPLEX SEARCH CRITERION
-- Find publicly visible, available or requested books in
-- LIKENEW or GOOD condition owned by members of the
-- 'Bay Area Bookworms' circle who have lending permission.
-- (multiple expressions with AND / OR connectors)
-- ============================================================
SELECT
    b.title,
    a.name                 AS author,
    ub.condition,
    ub.status,
    owner.name             AS owner
FROM UserBook ub
JOIN Book b              ON ub.isbn    = b.isbn
JOIN Authorship auth     ON b.isbn     = auth.isbn
JOIN Author a            ON auth.authorId = a.authorId
JOIN User owner          ON ub.userId  = owner.userId
JOIN JoinMembership jm   ON owner.userId = jm.userId
JOIN LendingCircle lc    ON jm.circleId  = lc.circleId
WHERE lc.name = 'Bay Area Bookworms'
  AND jm.canLend = 1
  AND ub.visibilityPublic = 1
  AND (ub.status = 'AVAILABLE' OR ub.status = 'REQUESTED')
  AND (ub.condition = 'LIKENEW' OR ub.condition = 'GOOD')
ORDER BY b.title;


-- ============================================================
-- Q5: SELECT CASE/WHEN
-- Classify each user by how many books they own on the platform.
-- ============================================================
SELECT
    u.name,
    COUNT(ub.userBookId) AS books_owned,
    CASE
        WHEN COUNT(ub.userBookId) = 0             THEN 'No Collection'
        WHEN COUNT(ub.userBookId) BETWEEN 1 AND 2 THEN 'Casual Reader'
        WHEN COUNT(ub.userBookId) BETWEEN 3 AND 4 THEN 'Book Lover'
        ELSE 'Library Builder'
    END AS collector_tier
FROM User u
LEFT JOIN UserBook ub ON u.userId = ub.userId
GROUP BY u.userId
ORDER BY books_owned DESC;


-- ============================================================
-- Q6: WINDOW FUNCTION (PARTITION BY)
-- Rank borrowers by number of loans within each lending circle.
-- ============================================================
SELECT
    lc.name        AS circle,
    borrower.name  AS borrower,
    loan_count,
    RANK() OVER (
        PARTITION BY lc.circleId
        ORDER BY loan_count DESC
    ) AS rank_in_circle
FROM (
    SELECT
        jm.circleId,
        ln.loaneeId,
        COUNT(ln.loanId) AS loan_count
    FROM Loan ln
    JOIN UserBook ub        ON ln.userBookId = ub.userBookId
    JOIN JoinMembership jm  ON ub.userId     = jm.userId
    GROUP BY jm.circleId, ln.loaneeId
) sub
JOIN LendingCircle lc  ON sub.circleId  = lc.circleId
JOIN User borrower     ON sub.loaneeId  = borrower.userId
ORDER BY lc.name, rank_in_circle;


-- ============================================================
-- Q7: RCTE (Recursive CTE)
-- Starting from Alice (u1), find all users reachable through
-- shared lending circle memberships within 2 hops.
-- Hop 1: users in Alice's circles. Hop 2: users in those
-- users' other circles. Shows how trust networks propagate.
-- ============================================================
WITH RECURSIVE reachable(userId, name, depth, path) AS (
    -- Base: start from Alice
    SELECT u.userId, u.name, 0, u.name
    FROM User u
    WHERE u.userId = 'u1'

    UNION

    -- Recurse: find users who share a circle with current set
    SELECT
        u2.userId,
        u2.name,
        r.depth + 1,
        r.path || ' -> ' || u2.name
    FROM reachable r
    JOIN JoinMembership jm1 ON r.userId  = jm1.userId
    JOIN JoinMembership jm2 ON jm1.circleId = jm2.circleId
    JOIN User u2            ON jm2.userId    = u2.userId
    WHERE u2.userId <> r.userId
      AND r.depth < 2
      AND INSTR(r.path, u2.name) = 0
)
SELECT userId, name, depth, path
FROM reachable
ORDER BY depth, name;
