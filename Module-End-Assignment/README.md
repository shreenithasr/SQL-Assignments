# Analyzing E-Learning Platform Purchases Using MySQL

## Project Overview
This project focuses on analysing e-learning platform purchase data using MySQL. The objective is to understand learner purchasing behaviour, identify popular courses and examine revenue generated across different course categories.

## Dataset Description
The project uses three related tables:

- **Learners:** Contains learner details such as learner ID, name and country.
- **Courses:** Contains course details, including course name, category and unit price.
- **Purchases:** Records purchase details such as learner ID, course ID, quantity and purchase date.

The dataset consists of 5 learners, 6 courses and 8 purchase transactions. The records are illustrative sample data created for this academic assignment.

## Tools Used
- MySQL Workbench

## SQL Concepts Covered
- Database and table creation
- Primary keys and foreign keys
- Data insertion and retrieval
- INNER JOIN, LEFT JOIN and RIGHT JOIN
- Aggregate functions: SUM(), COUNT()
- GROUP BY and HAVING
- ORDER BY and LIMIT
- COALESCE() and FORMAT()

## Analysis Performed
The project explores:
1. Total spending by each learner.
2. Top 3 courses based on quantity sold.
3. Category-wise revenue and unique learners.
4. Learners purchasing courses from multiple categories.
5. Courses that have never been purchased.

## Key Findings
- Total revenue generated: 6,188.00
- Highest revenue category: Data (4,393.00)
- Most purchased course: Excel for Beginners (4 units)
- Highest individual course revenue: Power BI Essentials (2,097.00)
- Course with no purchases: Digital Marketing Fundamentals

## Project Files
- `Module End Assignment.sql` – SQL script containing database creation, sample data, JOIN operations and analytical queries.
- `SQL Module End Assignment Docs.pdf` – One-page summary report presenting key insights and business recommendations.

## Conclusion
This project provided practical experience in using SQL to analyse relational data and identify meaningful patterns in learner purchasing behaviour. It also demonstrates how data analysis can support business insights and decision-making.
