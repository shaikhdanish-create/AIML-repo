-- day1_sql_basics.sql
--
-- Day 1 of 7-day SQL roadmap: Basics
-- Topics: SELECT, WHERE, ORDER BY, LIMIT, comparison & logical operators
--
-- Assumes a sample "employees" table with columns:
-- employee_id, first_name, last_name, department, salary, hire_date, city

-- 1. Basic SELECT: view all employee names and departments
SELECT first_name, last_name, department
FROM employees;

-- 2. WHERE: filter employees in the Sales department
SELECT first_name, last_name, department, salary
FROM employees
WHERE department = 'Sales';

-- 3. Comparison operators: employees earning more than 50,000
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 50000;

-- 4. AND / OR: employees in Sales earning more than 50,000
SELECT first_name, last_name, department, salary
FROM employees
WHERE department = 'Sales' AND salary > 50000;

-- 5. IN: employees from a specific set of departments
SELECT first_name, last_name, department
FROM employees
WHERE department IN ('Sales', 'Marketing', 'HR');

-- 6. BETWEEN: employees with salary in a given range
SELECT first_name, last_name, salary
FROM employees
WHERE salary BETWEEN 40000 AND 80000;

-- 7. LIKE: employees whose first name starts with "A"
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'A%';

-- 8. ORDER BY: employees sorted by salary, highest first
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC;

-- 9. ORDER BY multiple columns: department, then salary within department
SELECT first_name, last_name, department, salary
FROM employees
ORDER BY department ASC, salary DESC;

-- 10. LIMIT: top 5 highest-paid employees
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 5;

-- 11. Combining it all: top 3 highest-paid employees hired after 2020,
-- in the Engineering or Sales department
SELECT first_name, last_name, department, salary, hire_date
FROM employees
WHERE department IN ('Engineering', 'Sales')
  AND hire_date > '2020-01-01'
ORDER BY salary DESC
LIMIT 3;

-- SELECT basics: explicit columns keep queries focused

-- WHERE basics: filter rows using an exact condition

-- Comparison operators: use >, <, >=, <=, = and <> for numeric/text comparisons

-- AND: every condition must be true
