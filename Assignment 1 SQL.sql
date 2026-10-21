-- MySQL Assignment 1
-- Topic: DDL Commands and Constraints
-- Description: Creating, altering, renaming, truncating, and dropping tables,
-- and applying and testing database constraints.
-- Start fresh (this deletes the existing employee database)
DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;
CREATE TABLE Departments (
    department_id INT,
    department_name VARCHAR(100)
);

SHOW TABLES;
DESCRIBE Departments;
CREATE TABLE Location (
    location_id INT,
    location VARCHAR(30)
);
CREATE TABLE Employees (
    employee_id INT,
    employee_name VARCHAR(50),
    gender ENUM('M', 'F'),
    age INT,
    hire_date DATE,
    designation VARCHAR(100),
    department_id INT,
    location_id INT,
    salary DECIMAL(10,2)
);
SHOW TABLES;
DESCRIBE Location;
DESCRIBE Employees;
ALTER TABLE Employees
ADD email VARCHAR(100);
ALTER TABLE Employees
MODIFY COLUMN designation VARCHAR(200);
ALTER TABLE Employees
DROP COLUMN age;
ALTER TABLE Employees
RENAME COLUMN hire_date TO date_of_joining;
RENAME TABLE Departments TO Departments_Info;
RENAME TABLE Location TO Locations;
TRUNCATE TABLE Employees;
DROP TABLE Employees;
-- DDL practice: dropping the database
DROP DATABASE employee;

-- Recreate the database for constraint exercises
CREATE DATABASE employee;
USE employee;
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE Location (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    location VARCHAR(30) NOT NULL UNIQUE
);
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    gender ENUM('M', 'F'),
    age INT CHECK (age >= 18),
    hire_date DATE DEFAULT (CURRENT_DATE),
    designation VARCHAR(200),
    department_id INT,
    location_id INT,
    salary DECIMAL(10,2),
       CONSTRAINT fk_employees_department
        FOREIGN KEY (department_id)
        REFERENCES Departments(department_id),

    CONSTRAINT fk_employees_location
        FOREIGN KEY (location_id)
        REFERENCES Location(location_id)
);
DESCRIBE Employees;
SHOW CREATE TABLE Departments;
SHOW CREATE TABLE Location;
SHOW CREATE TABLE Employees;
SHOW TABLES;
INSERT INTO Departments (department_id, department_name)
VALUES (1, 'HR');
INSERT INTO Location (location)
VALUES ('Chennai');
INSERT INTO Employees
(employee_id, employee_name, gender, age, designation, department_id, location_id, salary)
VALUES
(1, 'Arun', 'M', 25, 'Analyst', 1, 1, 30000.00);
SELECT * FROM Employees;
-- Test CHECK constraint: age below 18 (expected to fail)
-- INSERT INTO Employees
-- (employee_id, employee_name, gender, age, department_id, location_id)
-- VALUES
-- (2, 'Ravi', 'M', 16, 1, 1);
-- Test ENUM constraint: invalid gender 'X' (expected to fail)
-- INSERT INTO Employees
-- (employee_id, employee_name, gender, age, department_id, location_id)
-- VALUES
-- (2, 'Ravi', 'X', 20, 1, 1);
SELECT employee_id, employee_name, hire_date
FROM Employees;
-- Test NOT NULL constraint: missing employee name (expected to fail)
-- INSERT INTO Employees
-- (employee_id, employee_name, gender, age, department_id, location_id)
-- VALUES
-- (2, NULL, 'M', 25, 1, 1);
-- Test UNIQUE constraint: duplicate department name (expected to fail)
-- INSERT INTO Departments (department_id, department_name)
-- VALUES (2, 'HR');
-- Test FOREIGN KEY: invalid department_id 99 (expected to fail)
-- INSERT INTO Employees
-- (employee_id, employee_name, gender, age, department_id, location_id)
-- VALUES
-- (2, 'Ravi', 'M', 25, 99, 1);
-- Test FOREIGN KEY: invalid location_id 99 (expected to fail)
-- INSERT INTO Employees
-- (employee_id, employee_name, gender, age, department_id, location_id)
-- VALUES
-- (2, 'Ravi', 'M', 25, 1, 99);
SELECT * FROM Employees;
SELECT * FROM Location;
DESCRIBE Departments;
DESCRIBE Location;
DESCRIBE Employees;

