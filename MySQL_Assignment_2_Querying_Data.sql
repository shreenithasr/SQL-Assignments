-- =========================================
-- MYSQL ASSIGNMENT 2: QUERYING DATA
-- =========================================

-- DATA VERIFICATION
-- Check the total number of records in each table

USE employee;

SELECT COUNT(*) AS Total_Employees
FROM Employees;

SELECT COUNT(*) AS Total_Departments
FROM Departments;

SELECT COUNT(*) AS Total_Locations
FROM Location;

-- 1. DISTINCT VALUES
-- Retrieve unique salary values from the Employees table
SELECT DISTINCT salary
FROM Employees;

-- 2. ALIAS (AS)
-- Provide temporary names for the age and salary columns
SELECT
    age AS Employee_Age,
    salary AS Employee_Salary
FROM Employees;

-- 3. WHERE CLAUSE & OPERATORS
-- Retrieve employees earning more than 50000
-- and hired before 2016-01-01
SELECT *
FROM Employees
WHERE salary > 50000
AND hire_date < '2016-01-01';

-- Identify employees whose designation is missing
SELECT employee_id, employee_name, designation
FROM Employees
WHERE designation IS NULL;

-- Update the missing designation to 'Data Scientist'
UPDATE Employees
SET designation = 'Data Scientist'
WHERE employee_id = 5004;

-- Verify that the missing designation has been updated
SELECT employee_id, employee_name, designation
FROM Employees
WHERE employee_id = 5004;

-- 4. SORTING AND GROUPING DATA
-- A. ORDER BY
-- Sort employees by department ID ascending
-- and salary descending
SELECT *
FROM Employees
ORDER BY department_id ASC, salary DESC;

-- B. LIMIT
-- Retrieve the first 5 employees hired in 2018
-- in chronological order
SELECT *
FROM Employees
WHERE YEAR(hire_date) = 2018
ORDER BY hire_date ASC
LIMIT 5;

-- C. AGGREGATE FUNCTIONS
-- Calculate the total salary of employees
-- in the Finance department
SELECT SUM(E.salary) AS Total_Finance_Salary
FROM Employees E
INNER JOIN Departments D
ON E.department_id = D.department_id
WHERE D.department_name = 'Finance';

-- Find the minimum age among all employees
SELECT MIN(age) AS Minimum_Employee_Age
FROM Employees;

-- D. GROUP BY
-- Find the maximum salary for each location
SELECT
    L.location,
    MAX(E.salary) AS Maximum_Salary
FROM Employees E
INNER JOIN Location L
    ON E.location_id = L.location_id
GROUP BY L.location;

-- Calculate the average salary for each designation
-- containing the word 'Analyst'
SELECT
    designation,
    AVG(salary) AS Average_Salary
FROM Employees
WHERE designation LIKE '%Analyst%'
GROUP BY designation;

-- E. HAVING
-- Find departments with fewer than 3 employees
SELECT
    D.department_id,
    D.department_name,
    COUNT(E.employee_id) AS Employee_Count
FROM Departments D
LEFT JOIN Employees E
    ON D.department_id = E.department_id
GROUP BY D.department_id, D.department_name
HAVING COUNT(E.employee_id) < 3;

-- Find locations where female employees
-- have an average age below 30
SELECT
    L.location,
    AVG(E.age) AS Average_Female_Age
FROM Employees E
INNER JOIN Location L
    ON E.location_id = L.location_id
WHERE E.gender = 'F'
GROUP BY L.location
HAVING AVG(E.age) < 30;

-- 5. JOINS
-- A. INNER JOIN
-- Retrieve employee names, designations
-- and their respective department names
SELECT
    E.employee_name,
    E.designation,
    D.department_name
FROM Employees E
INNER JOIN Departments D
    ON E.department_id = D.department_id;
    
-- B. LEFT JOIN
-- Display all departments with their employee counts,
-- including departments with no employees
SELECT
    D.department_id,
    D.department_name,
    COUNT(E.employee_id) AS Total_Employees
FROM Departments D
LEFT JOIN Employees E
    ON D.department_id = E.department_id
GROUP BY D.department_id, D.department_name;

-- C. RIGHT JOIN
-- Display all locations and their assigned employees,
-- including locations without employees
SELECT
    L.location,
    E.employee_name
FROM Employees E
RIGHT JOIN Location L
    ON E.location_id = L.location_id;
-- Note: All four locations currently have employees,
-- so no NULL employee names appear in the result.