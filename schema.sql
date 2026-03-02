-- ============================================================
-- ShelfShare — DDL (SQLite3)
-- Task 5: Data Definition Statements
-- ============================================================

PRAGMA foreign_keys = ON;

-- 1. User
CREATE TABLE User (
    userId      TEXT PRIMARY KEY,
    name        TEXT NOT NULL,
    email       TEXT NOT NULL UNIQUE,
    joinedAt    TEXT NOT NULL DEFAULT (datetime('now'))
);

-- 2. Book
CREATE TABLE Book (
    isbn        TEXT PRIMARY KEY,
    title       TEXT NOT NULL,
    star_rating REAL CHECK (star_rating >= 0 AND star_rating <= 5)
);

-- 3. Author
CREATE TABLE Author (
    authorId    TEXT PRIMARY KEY,
    name        TEXT NOT NULL,
    birth_year  TEXT
);

-- 4. Authorship (resolves Book ↔ Author M:M)
CREATE TABLE Authorship (
    isbn        TEXT NOT NULL,
    authorId    TEXT NOT NULL,
    PRIMARY KEY (isbn, authorId),
    FOREIGN KEY (isbn)     REFERENCES Book(isbn),
    FOREIGN KEY (authorId) REFERENCES Author(authorId)
);

-- 5. Genre
CREATE TABLE Genre (
    genreId     TEXT PRIMARY KEY,
    name        TEXT NOT NULL,
    description TEXT
);

-- 6. BookGenre (resolves Book ↔ Genre M:M)
CREATE TABLE BookGenre (
    isbn        TEXT NOT NULL,
    genreId     TEXT NOT NULL,
    PRIMARY KEY (isbn, genreId),
    FOREIGN KEY (isbn)    REFERENCES Book(isbn),
    FOREIGN KEY (genreId) REFERENCES Genre(genreId)
);

-- 7. UserBook (a user's copy of a book)
CREATE TABLE UserBook (
    userBookId       TEXT PRIMARY KEY,
    isbn             TEXT NOT NULL,
    userId           TEXT NOT NULL,
    visibilityPublic BOOLEAN NOT NULL DEFAULT 1,
    status           TEXT NOT NULL DEFAULT 'AVAILABLE'
                     CHECK (status IN ('AVAILABLE', 'REQUESTED', 'LOANED')),
    condition        TEXT NOT NULL DEFAULT 'LIKENEW'
                     CHECK (condition IN ('LIKENEW', 'GOOD', 'FAIR', 'BEATEN')),
    FOREIGN KEY (isbn)   REFERENCES Book(isbn),
    FOREIGN KEY (userId) REFERENCES User(userId)
);

-- 8. LendingCircle
CREATE TABLE LendingCircle (
    circleId      TEXT PRIMARY KEY,
    name          TEXT NOT NULL,
    createdAtDate TEXT NOT NULL DEFAULT (datetime('now')),
    description   TEXT
);

-- 9. JoinMembership (resolves User ↔ LendingCircle M:M)
CREATE TABLE JoinMembership (
    membershipId    TEXT PRIMARY KEY,
    userId          TEXT NOT NULL,
    circleId        TEXT NOT NULL,
    permissionLevel TEXT NOT NULL DEFAULT 'member',
    canBorrow       BOOLEAN NOT NULL DEFAULT 1,
    canLend         BOOLEAN NOT NULL DEFAULT 1,
    joinedAt        TEXT NOT NULL DEFAULT (datetime('now')),
    UNIQUE (userId, circleId),
    FOREIGN KEY (userId)   REFERENCES User(userId),
    FOREIGN KEY (circleId) REFERENCES LendingCircle(circleId)
);

-- 10. Loan
CREATE TABLE Loan (
    loanId            TEXT PRIMARY KEY,
    userBookId        TEXT NOT NULL,
    loaneeId          TEXT NOT NULL,
    dueDate           TEXT,
    returnedAtDate    TEXT,
    status            TEXT NOT NULL DEFAULT 'ACTIVE'
                      CHECK (status IN ('ACTIVE', 'RETURNED', 'OVERDUE')),
    conditionAtLend   TEXT NOT NULL
                      CHECK (conditionAtLend IN ('LIKENEW', 'GOOD', 'FAIR', 'BEATEN')),
    conditionAtReturn TEXT
                      CHECK (conditionAtReturn IN ('LIKENEW', 'GOOD', 'FAIR', 'BEATEN') OR conditionAtReturn IS NULL),
    FOREIGN KEY (userBookId) REFERENCES UserBook(userBookId),
    FOREIGN KEY (loaneeId)   REFERENCES User(userId)
);

-- 11. BorrowRequest
CREATE TABLE BorrowRequest (
    requestId       TEXT PRIMARY KEY,
    loanerId        TEXT NOT NULL,
    isbn            TEXT NOT NULL,
    loaneeId        TEXT NOT NULL,
    requestedAtDate TEXT NOT NULL DEFAULT (datetime('now')),
    status          TEXT NOT NULL DEFAULT 'PENDING'
                    CHECK (status IN ('PENDING', 'ACCEPTED', 'DENIED')),
    message         TEXT,
    FOREIGN KEY (loanerId) REFERENCES User(userId),
    FOREIGN KEY (isbn)     REFERENCES Book(isbn),
    FOREIGN KEY (loaneeId) REFERENCES User(userId)
);

-- 12. Review
CREATE TABLE Review (
    reviewId       TEXT PRIMARY KEY,
    review_maker   TEXT NOT NULL,
    review_subject TEXT NOT NULL,
    loanId         TEXT NOT NULL,
    rating         INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment        TEXT,
    createdAtDate  TEXT NOT NULL DEFAULT (datetime('now')),
    type           TEXT NOT NULL CHECK (type IN ('BORROWER', 'LENDER')),
    FOREIGN KEY (review_maker)   REFERENCES User(userId),
    FOREIGN KEY (review_subject) REFERENCES User(userId),
    FOREIGN KEY (loanId)         REFERENCES Loan(loanId)
);
