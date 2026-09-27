-- day4_subqueries_ctes.sql
--
-- Day 4 of 7-day SQL roadmap: Subqueries & CTEs
-- Topics: subqueries in WHERE/FROM, correlated subqueries, CTEs (WITH ... AS)
--
-- Assumes sample tables:
-- employees(employee_id, first_name, last_name, department, salary)
-- orders(order_id, customer_id, order_date, order_amount)
-- customers(customer_id, customer_name, city)

-- 1. Simple subquery in WHERE: employees earning above the company average
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 2. Subquery with IN: customers who have placed at least one order
SELECT customer_name
FROM customers
WHERE customer_id IN (SELECT DISTINCT customer_id FROM orders);

-- 3. Subquery with NOT IN: customers who have never placed an order
SELECT customer_name
FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM orders);

-- 4. Correlated subquery: employees earning above THEIR department's average
SELECT e.first_name, e.department, e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department = e.department
);

-- 5. Subquery in FROM (derived table): department averages, filtered
SELECT department, avg_salary
FROM (
    SELECT department, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
) AS dept_averages
WHERE avg_salary > 55000;

-- 6. CTE version of #4: same result, more readable
WITH dept_avg AS (
    SELECT department, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
)
SELECT e.first_name, e.department, e.salary, d.avg_salary
FROM employees e
JOIN dept_avg d ON e.department = d.department
WHERE e.salary > d.avg_salary;

-- 7. CTE with multiple steps: top spender per city
WITH customer_spend AS (
    SELECT c.customer_id, c.customer_name, c.city,
           SUM(o.order_amount) AS total_spend
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name, c.city
),
ranked_spend AS (
    SELECT *,
           RANK() OVER (PARTITION BY city ORDER BY total_spend DESC) AS spend_rank
    FROM customer_spend
)
SELECT customer_name, city, total_spend
FROM ranked_spend
WHERE spend_rank = 1;

-- 8. Multiple CTEs chained together: high-value customers and their order count
WITH high_spenders AS (
    SELECT customer_id, SUM(order_amount) AS total_spend
    FROM orders
    GROUP BY customer_id
    HAVING SUM(order_amount) > 1000
),
order_counts AS (
    SELECT customer_id, COUNT(order_id) AS total_orders
    FROM orders
    GROUP BY customer_id
)
SELECT h.customer_id, h.total_spend, o.total_orders
FROM high_spenders h
JOIN order_counts o ON h.customer_id = o.customer_id
ORDER BY h.total_spend DESC;


-- 9. Subquery: employees earning the minimum salary
SELECT first_name, last_name, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

-- 10. Subquery: employees earning the maximum salary
SELECT first_name, last_name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

-- 11. Subquery: employees from departments with average salary above 55000
SELECT first_name, department, salary
FROM employees
WHERE department IN (
    SELECT department
    FROM employees
    GROUP BY department
    HAVING AVG(salary) > 55000
);

-- 12. EXISTS subquery: customers with orders
SELECT c.customer_id, c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- 13. NOT EXISTS subquery: customers without orders
SELECT c.customer_id, c.customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- 14. Subquery: orders above the average order amount
SELECT order_id, customer_id, order_amount
FROM orders
WHERE order_amount > (SELECT AVG(order_amount) FROM orders);

-- 15. Subquery: orders from the latest order date
SELECT order_id, customer_id, order_date, order_amount
FROM orders
WHERE order_date = (SELECT MAX(order_date) FROM orders);

-- 16. CTE: total spending for each customer
WITH customer_totals AS (
    SELECT customer_id, SUM(order_amount) AS total_spend
    FROM orders
    GROUP BY customer_id
)
SELECT customer_id, total_spend
FROM customer_totals
ORDER BY total_spend DESC;

-- 17. CTE: average order amount by customer
WITH customer_avg AS (
    SELECT customer_id, AVG(order_amount) AS avg_order
    FROM orders
    GROUP BY customer_id
)
SELECT customer_id, avg_order
FROM customer_avg
ORDER BY avg_order DESC;

-- 18. CTE: total spending by customer city
WITH city_spend AS (
    SELECT c.city, SUM(o.order_amount) AS total_spend
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.city
)
SELECT city, total_spend
FROM city_spend
ORDER BY total_spend DESC;

-- 19. CTE: find high-value orders
WITH high_value_orders AS (
    SELECT order_id, customer_id, order_amount
    FROM orders
    WHERE order_amount > 1000
)
SELECT order_id, customer_id, order_amount
FROM high_value_orders
ORDER BY order_amount DESC;

-- 20. CTE: count orders for each customer
WITH customer_orders AS (
    SELECT customer_id, COUNT(order_id) AS order_count
    FROM orders
    GROUP BY customer_id
)
SELECT customer_id, order_count
FROM customer_orders
ORDER BY order_count DESC;

-- 21. CTE: count employees in each department
WITH department_counts AS (
    SELECT department, COUNT(employee_id) AS employee_count
    FROM employees
    GROUP BY department
)
SELECT department, employee_count
FROM department_counts
ORDER BY employee_count DESC;

-- 22. Subquery: customers spending more than 2000
SELECT customer_id, customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(order_amount) > 2000
);

-- 23. Correlated subquery: orders above each customer's average
SELECT o.order_id, o.customer_id, o.order_amount
FROM orders o
WHERE o.order_amount > (
    SELECT AVG(o2.order_amount)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
);

-- 24. CTE: calculate customer spending and show customer names
WITH customer_spend AS (
    SELECT customer_id, SUM(order_amount) AS total_spend
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_name, s.total_spend
FROM customers c
JOIN customer_spend s ON c.customer_id = s.customer_id
ORDER BY s.total_spend DESC;

-- 25. CTE: customers whose spending is above average customer spending
WITH customer_spend AS (
    SELECT customer_id, SUM(order_amount) AS total_spend
    FROM orders
    GROUP BY customer_id
),
average_spend AS (
    SELECT AVG(total_spend) AS avg_spend
    FROM customer_spend
)
SELECT customer_id, total_spend
FROM customer_spend
WHERE total_spend > (SELECT avg_spend FROM average_spend);

-- 26. Correlated subquery: highest-paid employee in each department
SELECT e.first_name, e.last_name, e.department, e.salary
FROM employees e
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department = e.department
);

-- 27. CTE: list orders with a simple date-based filter
WITH recent_orders AS (
    SELECT order_id, customer_id, order_date, order_amount
    FROM orders
    WHERE order_date >= '2026-01-01'
)
SELECT order_id, customer_id, order_date, order_amount
FROM recent_orders
ORDER BY order_date;

-- 28. Final CTE practice: customers with at least two orders
WITH customer_order_counts AS (
    SELECT customer_id, COUNT(order_id) AS order_count
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_name, x.order_count
FROM customers c
JOIN customer_order_counts x ON c.customer_id = x.customer_id
WHERE x.order_count >= 2
ORDER BY x.order_count DESC;
