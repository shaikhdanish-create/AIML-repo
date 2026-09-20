-- day2_aggregations.sql
--
-- Day 2 of 7-day SQL roadmap: Aggregations
-- Topics: COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING
--
-- Assumes sample tables:
-- employees(employee_id, first_name, last_name, department, salary, hire_date)
-- orders(order_id, customer_id, order_date, order_amount)

-- 1. COUNT: total number of employees
SELECT COUNT(*) AS total_employees
FROM employees;

-- 2. SUM: total salary paid across the company
SELECT SUM(salary) AS total_salary_paid
FROM employees;

-- 3. AVG: average salary across the company
SELECT AVG(salary) AS avg_salary
FROM employees;

-- 4. MIN / MAX: salary range
SELECT MIN(salary) AS lowest_salary, MAX(salary) AS highest_salary
FROM employees;

-- 5. GROUP BY: average salary per department
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department;

-- 6. GROUP BY with COUNT: number of employees per department
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department;

-- 7. GROUP BY with multiple aggregates
SELECT department,
       COUNT(*) AS employee_count,
       AVG(salary) AS avg_salary,
       MAX(salary) AS highest_salary
FROM employees
GROUP BY department;

-- 8. HAVING: departments where average salary exceeds 60,000
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;

-- 9. HAVING with COUNT: departments with more than 5 employees
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;

-- 10. Aggregations on a second table: total and average order value per customer
SELECT customer_id,
       COUNT(order_id) AS total_orders,
       SUM(order_amount) AS total_spend,
       AVG(order_amount) AS avg_order_value
FROM orders
GROUP BY customer_id;

-- 11. Combining it all: departments with more than 3 employees,
-- ordered by average salary, highest first
SELECT department,
       COUNT(*) AS employee_count,
       AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING COUNT(*) > 3
ORDER BY avg_salary DESC;

-- Practice aggregation: count employees in each city
SELECT city, COUNT(*) AS employee_count
FROM employees
GROUP BY city;
