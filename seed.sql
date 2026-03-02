-- ============================================================
-- ShelfShare — Seed Data
-- Task 6: Test Data Population
-- ============================================================

-- USERS (8)
INSERT INTO User (userId, name, email, joinedAt) VALUES
('u1', 'Alice Reyes',    'alice@example.com',   '2024-01-15 10:00:00'),
('u2', 'Bob Kim',        'bob@example.com',     '2024-01-20 14:30:00'),
('u3', 'Carol Martinez', 'carol@example.com',   '2024-02-01 09:00:00'),
('u4', 'Dan Johnson',    'dan@example.com',     '2024-02-10 11:45:00'),
('u5', 'Emma Wilson',    'emma@example.com',    '2024-03-05 16:20:00'),
('u6', 'Frank Lee',      'frank@example.com',   '2024-03-12 08:00:00'),
('u7', 'Grace Huang',    'grace@example.com',   '2024-04-01 13:15:00'),
('u8', 'Hector Perez',   'hector@example.com',  '2024-04-18 10:30:00');

-- BOOKS (12)
INSERT INTO Book (isbn, title, star_rating) VALUES
('978-0441013593', 'Dune',                        4.5),
('978-0441569595', 'Neuromancer',                  4.2),
('978-0441478125', 'The Left Hand of Darkness',    4.3),
('978-0679728757', 'Blood Meridian',               4.1),
('978-0553208849', 'Siddhartha',                   4.4),
('978-0805209990', 'The Trial',                    4.0),
('978-0802130303', 'Ficciones',                    4.6),
('978-0679720201', 'The Stranger',                 4.3),
('978-0140449334', 'Meditations',                  4.7),
('978-0374533557', 'Thinking, Fast and Slow',      4.4),
('978-0465026562', 'Godel, Escher, Bach',          4.8),
('978-0671027032', 'How to Win Friends',           4.2);

-- AUTHORS (12)
INSERT INTO Author (authorId, name, birth_year) VALUES
('a1',  'Frank Herbert',       '1920'),
('a2',  'William Gibson',      '1948'),
('a3',  'Ursula K. Le Guin',   '1929'),
('a4',  'Cormac McCarthy',     '1933'),
('a5',  'Hermann Hesse',       '1877'),
('a6',  'Franz Kafka',         '1883'),
('a7',  'Jorge Luis Borges',   '1899'),
('a8',  'Albert Camus',        '1913'),
('a9',  'Marcus Aurelius',     '0121'),
('a10', 'Daniel Kahneman',     '1934'),
('a11', 'Douglas Hofstadter',  '1945'),
('a12', 'Dale Carnegie',       '1888');

-- AUTHORSHIP (12 — one author per book here)
INSERT INTO Authorship (isbn, authorId) VALUES
('978-0441013593', 'a1'),
('978-0441569595', 'a2'),
('978-0441478125', 'a3'),
('978-0679728757', 'a4'),
('978-0553208849', 'a5'),
('978-0805209990', 'a6'),
('978-0802130303', 'a7'),
('978-0679720201', 'a8'),
('978-0140449334', 'a9'),
('978-0374533557', 'a10'),
('978-0465026562', 'a11'),
('978-0671027032', 'a12');

-- GENRES (5)
INSERT INTO Genre (genreId, name, description) VALUES
('g1', 'Science Fiction',    'Speculative fiction dealing with futuristic concepts'),
('g2', 'Philosophy',         'Works exploring fundamental questions of existence'),
('g3', 'Psychology',         'Study of mind, behavior, and decision-making'),
('g4', 'Literary Fiction',   'Character-driven prose with literary merit'),
('g5', 'Self-Help',          'Guides for personal improvement and social skills');

-- BOOKGENRE (15 — some books belong to multiple genres)
INSERT INTO BookGenre (isbn, genreId) VALUES
('978-0441013593', 'g1'),
('978-0441569595', 'g1'),
('978-0441478125', 'g1'),
('978-0679728757', 'g4'),
('978-0553208849', 'g2'),
('978-0553208849', 'g4'),
('978-0805209990', 'g4'),
('978-0802130303', 'g4'),
('978-0679720201', 'g2'),
('978-0679720201', 'g4'),
('978-0140449334', 'g2'),
('978-0374533557', 'g3'),
('978-0465026562', 'g3'),
('978-0465026562', 'g2'),
('978-0671027032', 'g5');

-- USERBOOK (16 — users' personal copies)
INSERT INTO UserBook (userBookId, isbn, userId, visibilityPublic, status, condition) VALUES
('ub1',  '978-0441013593', 'u1', 1, 'AVAILABLE', 'LIKENEW'),
('ub2',  '978-0441569595', 'u1', 1, 'AVAILABLE', 'GOOD'),
('ub3',  '978-0441478125', 'u1', 1, 'LOANED',    'FAIR'),
('ub4',  '978-0679728757', 'u2', 1, 'AVAILABLE', 'LIKENEW'),
('ub5',  '978-0553208849', 'u2', 1, 'REQUESTED', 'GOOD'),
('ub6',  '978-0805209990', 'u3', 0, 'AVAILABLE', 'BEATEN'),
('ub7',  '978-0802130303', 'u3', 1, 'LOANED',    'LIKENEW'),
('ub8',  '978-0679720201', 'u4', 1, 'AVAILABLE', 'GOOD'),
('ub9',  '978-0140449334', 'u5', 1, 'AVAILABLE', 'LIKENEW'),
('ub10', '978-0374533557', 'u5', 1, 'LOANED',    'GOOD'),
('ub11', '978-0465026562', 'u6', 1, 'AVAILABLE', 'LIKENEW'),
('ub12', '978-0671027032', 'u8', 1, 'REQUESTED', 'LIKENEW'),
('ub13', '978-0441013593', 'u4', 1, 'AVAILABLE', 'FAIR'),
('ub14', '978-0553208849', 'u7', 1, 'AVAILABLE', 'GOOD'),
('ub15', '978-0140449334', 'u3', 1, 'AVAILABLE', 'BEATEN'),
('ub16', '978-0679720201', 'u6', 1, 'LOANED',    'GOOD');

-- LENDING CIRCLES (3)
INSERT INTO LendingCircle (circleId, name, createdAtDate, description) VALUES
('c1', 'Bay Area Bookworms',  '2024-02-01 12:00:00', 'Lending circle for readers in the SF Bay Area'),
('c2', 'CS Reading Group',    '2024-03-01 10:00:00', 'Computer science and math book swaps'),
('c3', 'Philosophy Corner',   '2024-04-01 09:00:00', 'Circle for philosophy and literature enthusiasts');

-- JOIN MEMBERSHIPS (14)
INSERT INTO JoinMembership (membershipId, userId, circleId, permissionLevel, canBorrow, canLend, joinedAt) VALUES
('m1',  'u1', 'c1', 'admin',  1, 1, '2024-02-01 12:00:00'),
('m2',  'u2', 'c1', 'member', 1, 1, '2024-02-05 09:00:00'),
('m3',  'u3', 'c1', 'member', 1, 1, '2024-02-08 14:00:00'),
('m4',  'u4', 'c1', 'member', 1, 1, '2024-02-15 11:00:00'),
('m5',  'u5', 'c1', 'member', 1, 0, '2024-03-10 16:00:00'),
('m6',  'u6', 'c2', 'admin',  1, 1, '2024-03-01 10:00:00'),
('m7',  'u1', 'c2', 'member', 1, 1, '2024-03-05 08:30:00'),
('m8',  'u5', 'c2', 'member', 1, 1, '2024-03-08 12:00:00'),
('m9',  'u7', 'c2', 'member', 1, 1, '2024-03-15 10:00:00'),
('m10', 'u4', 'c3', 'admin',  1, 1, '2024-04-01 09:00:00'),
('m11', 'u3', 'c3', 'member', 1, 1, '2024-04-05 11:00:00'),
('m12', 'u8', 'c3', 'member', 0, 1, '2024-04-10 15:00:00'),
('m13', 'u7', 'c3', 'member', 1, 1, '2024-04-20 09:00:00'),
('m14', 'u2', 'c2', 'member', 1, 1, '2024-03-20 14:00:00');

-- LOANS (8)
INSERT INTO Loan (loanId, userBookId, loaneeId, dueDate, returnedAtDate, status, conditionAtLend, conditionAtReturn) VALUES
('ln1', 'ub3',  'u2', '2024-06-01', NULL,          'ACTIVE',   'FAIR',    NULL),
('ln2', 'ub7',  'u4', '2024-06-10', NULL,          'ACTIVE',   'LIKENEW', NULL),
('ln3', 'ub10', 'u1', '2024-06-15', NULL,          'ACTIVE',   'GOOD',    NULL),
('ln4', 'ub1',  'u4', '2024-04-01', '2024-03-28',  'RETURNED', 'LIKENEW', 'LIKENEW'),
('ln5', 'ub4',  'u1', '2024-04-05', '2024-04-03',  'RETURNED', 'LIKENEW', 'LIKENEW'),
('ln6', 'ub8',  'u5', '2024-05-01', '2024-04-28',  'RETURNED', 'GOOD',    'GOOD'),
('ln7', 'ub11', 'u7', '2024-05-10', '2024-05-08',  'RETURNED', 'LIKENEW', 'LIKENEW'),
('ln8', 'ub16', 'u8', '2024-05-15', NULL,          'OVERDUE',  'GOOD',    NULL);

-- BORROW REQUESTS (6)
INSERT INTO BorrowRequest (requestId, loanerId, isbn, loaneeId, requestedAtDate, status, message) VALUES
('br1', 'u2', '978-0553208849', 'u3', '2024-05-20 10:00:00', 'PENDING',  'Would love to borrow Siddhartha!'),
('br2', 'u8', '978-0671027032', 'u3', '2024-05-22 13:00:00', 'PENDING',  'Can I borrow How to Win Friends?'),
('br3', 'u1', '978-0441013593', 'u4', '2024-02-25 08:00:00', 'ACCEPTED', 'Requesting Dune'),
('br4', 'u2', '978-0679728757', 'u1', '2024-03-01 12:00:00', 'ACCEPTED', 'Blood Meridian please'),
('br5', 'u4', '978-0679720201', 'u5', '2024-03-28 10:00:00', 'ACCEPTED', 'Can I grab The Stranger?'),
('br6', 'u5', '978-0374533557', 'u2', '2024-05-10 09:00:00', 'DENIED',   'Requesting Thinking Fast and Slow');

-- REVIEWS (10)
INSERT INTO Review (reviewId, review_maker, review_subject, loanId, rating, comment, createdAtDate, type) VALUES
('r1',  'u4', 'u1', 'ln4', 5, 'Alice lent Dune in perfect condition.',               '2024-03-29 10:00:00', 'LENDER'),
('r2',  'u1', 'u4', 'ln4', 4, 'Dan returned the book in great shape.',               '2024-03-29 11:00:00', 'BORROWER'),
('r3',  'u1', 'u2', 'ln5', 5, 'Bob keeps his books immaculate.',                     '2024-04-04 09:00:00', 'LENDER'),
('r4',  'u2', 'u1', 'ln5', 5, 'Alice returned early and in same condition.',          '2024-04-04 10:00:00', 'BORROWER'),
('r5',  'u5', 'u4', 'ln6', 4, 'Dan lent The Stranger in good condition as described.','2024-04-29 16:00:00', 'LENDER'),
('r6',  'u4', 'u5', 'ln6', 3, 'Emma returned a bit late but book was fine.',          '2024-04-29 17:00:00', 'BORROWER'),
('r7',  'u7', 'u6', 'ln7', 5, 'Frank is an excellent lender. GEB was mint.',          '2024-05-09 11:00:00', 'LENDER'),
('r8',  'u6', 'u7', 'ln7', 4, 'Grace returned GEB promptly, very reliable.',          '2024-05-09 12:00:00', 'BORROWER'),
('r9',  'u2', 'u1', 'ln1', 4, 'Alice lent Left Hand of Darkness, good experience.',   '2024-05-20 10:00:00', 'LENDER'),
('r10', 'u1', 'u5', 'ln3', 4, 'Emma lent Thinking Fast and Slow, arrived on time.',   '2024-05-25 09:00:00', 'LENDER');
