-- day5_window_functions.sql
--
-- Day 5 of 7-day SQL roadmap: Window Functions
-- Topics: ROW_NUMBER(), RANK(), DENSE_RANK(), LAG()/LEAD(), running totals
--
-- Assumes sample tables:
-- employees(employee_id, first_name, last_name, department, salary)
-- orders(order_id, customer_id, order_date, order_amount)

-- 1. ROW_NUMBER: assign a unique sequential number to each employee, by salary
SELECT first_name, department, salary,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;

-- 2. ROW_NUMBER with PARTITION BY: number employees within each department
SELECT first_name, department, salary,
       ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_row_num
FROM employees;

-- 3. RANK: rank employees by salary within their department (ties get same rank, gaps after)
SELECT first_name, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
FROM employees;

-- 4. DENSE_RANK: same as RANK, but no gaps after ties
SELECT first_name, department, salary,
       DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_salary_rank
FROM employees;

-- 5. Using rank to find the top earner per department
SELECT first_name, department, salary
FROM (
    SELECT first_name, department, salary,
           RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
    FROM employees
) ranked
WHERE salary_rank = 1;

-- 6. LAG: compare each order to the previous order's amount
SELECT order_id, order_date, order_amount,
       LAG(order_amount) OVER (ORDER BY order_date) AS prev_order_amount
FROM orders;

-- 7. LEAD: compare each order to the next order's amount
SELECT order_id, order_date, order_amount,
       LEAD(order_amount) OVER (ORDER BY order_date) AS next_order_amount
FROM orders;

-- 8. LAG + difference: how much did the order amount change vs the previous order?
SELECT order_id, order_date, order_amount,
       order_amount - LAG(order_amount) OVER (ORDER BY order_date) AS change_from_prev
FROM orders;

-- 9. Running total: cumulative order amount over time
SELECT order_id, order_date, order_amount,
       SUM(order_amount) OVER (ORDER BY order_date) AS running_total
FROM orders;

-- 10. Running total per customer: cumulative spend, reset for each customer
SELECT customer_id, order_date, order_amount,
       SUM(order_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS customer_running_total
FROM orders;

-- 11. Moving average: average of the current and previous 2 orders
SELECT order_id, order_date, order_amount,
       AVG(order_amount) OVER (
           ORDER BY order_date
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) AS moving_avg_3
FROM orders;

-- 12. ROW_NUMBER ordered by employee name
SELECT first_name, department, ROW_NUMBER() OVER (ORDER BY first_name) AS name_num FROM employees;

-- 13. Rank all employees by salary
SELECT first_name, salary, RANK() OVER (ORDER BY salary DESC) AS overall_rank FROM employees;

-- 14. Dense rank employees by salary
SELECT first_name, salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank FROM employees;

-- 15. Number orders for each customer
SELECT customer_id, order_id, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS order_num FROM orders;

-- 16. Find the previous order date
SELECT order_id, order_date, LAG(order_date) OVER (ORDER BY order_date) AS previous_date FROM orders;

-- 17. Find the next order date
SELECT order_id, order_date, LEAD(order_date) OVER (ORDER BY order_date) AS next_date FROM orders;

-- 18. Calculate salary difference from department maximum
SELECT first_name, department, salary, MAX(salary) OVER (PARTITION BY department) - salary AS difference_from_max FROM employees;

-- 19. Calculate department average salary
SELECT first_name, department, salary, AVG(salary) OVER (PARTITION BY department) AS department_avg FROM employees;

-- 20. Calculate each order's percentage of total sales
SELECT order_id, order_amount, ROUND(100.0 * order_amount / SUM(order_amount) OVER (), 2) AS sales_percentage FROM orders;

-- 21. Rank orders by amount
SELECT order_id, order_amount, ROW_NUMBER() OVER (ORDER BY order_amount DESC) AS amount_position FROM orders;

-- 22. Running order count
SELECT order_id, order_date, COUNT(*) OVER (ORDER BY order_date) AS running_order_count FROM orders;

-- 23. Running average of order amounts
SELECT order_id, order_date, AVG(order_amount) OVER (ORDER BY order_date) AS running_average FROM orders;

-- 24. Highest salary in each department
SELECT first_name, department, salary, MAX(salary) OVER (PARTITION BY department) AS max_dept_salary FROM employees;

-- 25. Lowest salary in each department
SELECT first_name, department, salary, MIN(salary) OVER (PARTITION BY department) AS min_dept_salary FROM employees;

-- 26. Total salary by department without GROUP BY
SELECT first_name, department, salary, SUM(salary) OVER (PARTITION BY department) AS dept_total_salary FROM employees;

-- 27. Employee salary share of department total
SELECT first_name, department, salary, ROUND(100.0 * salary / SUM(salary) OVER (PARTITION BY department), 2) AS salary_share FROM employees;
