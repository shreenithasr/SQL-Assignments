/*
PROJECT TITLE: Analyzing E-Learning Platform Purchases Using MySQL
MODULE: MySQL Module End Assignment

DATABASE: elearning_purchases

TABLES:
1. learners
2. courses
3. purchases

PROJECT OBJECTIVES:
1. Create a relational database.
2. Explore data using INNER JOIN, LEFT JOIN and RIGHT JOIN.
3. Analyse learner spending.
4. Identify the most purchased courses.
5. Analyse category-wise revenue.
6. Identify learners purchasing from multiple categories.
7. Identify courses that have not been purchased.

NOTE:
The dataset contains illustrative sample records created
for this academic assignment.
*/

CREATE DATABASE IF NOT EXISTS elearning_purchases;
USE elearning_purchases;
SHOW DATABASES;

-- =========================================
-- 1. TABLE CREATION
-- =========================================
CREATE TABLE learners (
    learner_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    country VARCHAR(60) NOT NULL
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(150) NOT NULL,
    category VARCHAR(80) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    learner_id INT NOT NULL,
    course_id INT NOT NULL,
    quantity INT NOT NULL,
    purchase_date DATE NOT NULL,

    FOREIGN KEY (learner_id)
        REFERENCES learners(learner_id),

    FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
);

SHOW TABLES;

-- =========================================
-- 2. SAMPLE DATA INSERTION
-- =========================================
INSERT INTO learners
(learner_id, full_name, country)
VALUES
(1, 'Asha Kumar', 'India'),
(2, 'Rahul Sharma', 'India'),
(3, 'Maria Garcia', 'USA'),
(4, 'Daniel Smith', 'UK'),
(5, 'Priya Nair', 'India');

INSERT INTO courses
(course_id, course_name, category, unit_price)
VALUES
(101, 'SQL Data Analytics', 'Data', 499.00),
(102, 'Power BI Essentials', 'Data', 699.00),
(103, 'Excel for Beginners', 'Productivity', 299.00),
(104, 'Python Programming', 'Data', 799.00),
(105, 'UI UX Design Basics', 'Design', 599.00),
(106, 'Digital Marketing Fundamentals', 'Marketing', 399.00);

INSERT INTO purchases
(purchase_id, learner_id, course_id, quantity, purchase_date)
VALUES
(1001, 1, 101, 2, '2026-01-05'),
(1002, 1, 102, 1, '2026-01-12'),
(1003, 2, 101, 1, '2026-01-15'),
(1004, 2, 103, 3, '2026-02-02'),
(1005, 3, 104, 1, '2026-02-10'),
(1006, 3, 102, 2, '2026-02-18'),
(1007, 4, 105, 1, '2026-03-01'),
(1008, 1, 103, 1, '2026-03-05');

-- Verify inserted records
SELECT * FROM learners;

SELECT * FROM courses;

SELECT * FROM purchases;

-- =========================================
-- 3. DATA EXPLORATION USING JOINS
-- =========================================

-- INNER JOIN: Display learner purchase details
SELECT
    l.learner_id,
    l.full_name AS learner_name,
    l.country,
    c.course_name,
    c.category,
    p.quantity,
    FORMAT(c.unit_price, 2) AS unit_price,
    FORMAT(p.quantity * c.unit_price, 2) AS total_amount,
    p.purchase_date

FROM purchases AS p

INNER JOIN learners AS l
    ON p.learner_id = l.learner_id

INNER JOIN courses AS c
    ON p.course_id = c.course_id

ORDER BY p.purchase_date;

-- LEFT JOIN: Display all learners and their purchases

SELECT
    l.learner_id,
    l.full_name AS learner_name,
    l.country,
    c.course_name,
    c.category,
    p.quantity,
    FORMAT(c.unit_price, 2) AS unit_price,
    FORMAT(p.quantity * c.unit_price, 2) AS total_amount,
    p.purchase_date

FROM learners AS l

LEFT JOIN purchases AS p
    ON l.learner_id = p.learner_id

LEFT JOIN courses AS c
    ON p.course_id = c.course_id

ORDER BY l.learner_id;

-- RIGHT JOIN: Display all courses and their purchases

SELECT
    c.course_id,
    c.course_name,
    c.category,
    l.full_name AS learner_name,
    l.country,
    p.quantity,
    FORMAT(c.unit_price, 2) AS unit_price,
    FORMAT(p.quantity * c.unit_price, 2) AS total_amount,
    p.purchase_date

FROM purchases AS p

RIGHT JOIN courses AS c
    ON p.course_id = c.course_id

LEFT JOIN learners AS l
    ON p.learner_id = l.learner_id

ORDER BY c.course_id;

-- =========================================
-- 4. ANALYTICAL QUERIES (Q1-Q5)
-- =========================================

-- Q1: Total spending of each learner
SELECT
    l.learner_id,
    l.full_name AS learner_name,
    l.country,

    FORMAT(
        COALESCE(SUM(p.quantity * c.unit_price), 0), 2
    ) AS total_spending

FROM learners AS l

LEFT JOIN purchases AS p
    ON l.learner_id = p.learner_id

LEFT JOIN courses AS c
    ON p.course_id = c.course_id

GROUP BY
    l.learner_id,
    l.full_name,
    l.country

ORDER BY
    SUM(p.quantity * c.unit_price) DESC;
    
-- Q2: Top 3 most purchased courses
SELECT
    c.course_id,
    c.course_name,
    SUM(p.quantity) AS total_quantity_sold

FROM courses AS c

INNER JOIN purchases AS p
    ON c.course_id = p.course_id

GROUP BY
    c.course_id,
    c.course_name

ORDER BY
    total_quantity_sold DESC,
    c.course_name ASC

LIMIT 3;

-- Q3: Category-wise revenue and unique learners
SELECT
    c.category,

    FORMAT(
        COALESCE(SUM(p.quantity * c.unit_price), 0), 2
    ) AS total_revenue,

    COUNT(DISTINCT p.learner_id) AS unique_learners

FROM courses AS c

LEFT JOIN purchases AS p
    ON c.course_id = p.course_id

GROUP BY
    c.category

ORDER BY
    SUM(p.quantity * c.unit_price) DESC;
    
-- Q4: Learners purchasing from more than one category
SELECT
    l.learner_id,
    l.full_name AS learner_name,

    COUNT(DISTINCT c.category) AS categories_purchased

FROM learners AS l

INNER JOIN purchases AS p
    ON l.learner_id = p.learner_id

INNER JOIN courses AS c
    ON p.course_id = c.course_id

GROUP BY
    l.learner_id,
    l.full_name

HAVING
    COUNT(DISTINCT c.category) > 1

ORDER BY
    categories_purchased DESC;
    
-- Q5: Identify courses that have never been purchased
SELECT
    c.course_id,
    c.course_name,
    c.category,
    FORMAT(c.unit_price, 2) AS unit_price

FROM courses AS c

LEFT JOIN purchases AS p
    ON c.course_id = p.course_id

WHERE p.purchase_id IS NULL

ORDER BY c.course_name;