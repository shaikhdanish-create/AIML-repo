-- day3_joins.sql
--
-- Day 3 of 7-day SQL roadmap: Joins
-- Topics: INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN, self join
--
-- Assumes sample tables:
-- customers(customer_id, customer_name, city)
-- orders(order_id, customer_id, order_date, order_amount)
-- employees(employee_id, first_name, last_name, manager_id, department)

-- 1. INNER JOIN: orders matched with their customers
SELECT o.order_id, c.customer_name, o.order_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- 2. LEFT JOIN: all customers, with their orders if they have any
SELECT c.customer_name, o.order_id, o.order_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- 3. LEFT JOIN + IS NULL: find customers who have never placed an order
SELECT c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 4. RIGHT JOIN: all orders, with customer info if it exists
-- (equivalent to a LEFT JOIN with tables swapped - some databases
-- like SQLite don't support RIGHT JOIN directly)
SELECT c.customer_name, o.order_id, o.order_amount
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;

-- 5. FULL OUTER JOIN: every customer and every order, matched where possible
-- (not supported in MySQL directly - emulate with UNION of LEFT and RIGHT JOIN)
SELECT c.customer_name, o.order_id
FROM customers c
FULL OUTER JOIN orders o ON c.customer_id = o.customer_id;

-- 6. Self join: employees paired with their managers
SELECT e1.first_name AS employee_name,
       e2.first_name AS manager_name
FROM employees e1
JOIN employees e2 ON e1.manager_id = e2.employee_id;

-- 7. Self join with LEFT JOIN: include employees who have no manager (e.g. CEO)
SELECT e1.first_name AS employee_name,
       e2.first_name AS manager_name
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id;

-- 8. Join + aggregation: total spend per customer, including customers with $0
SELECT c.customer_name,
       COALESCE(SUM(o.order_amount), 0) AS total_spend
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- 9. Joining three tables: orders, customers, and their department (if applicable)
SELECT o.order_id, c.customer_name, c.city, o.order_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE c.city = 'Nagpur';

-- 10. Combining it all: top 5 customers by total spend, including city
SELECT c.customer_name, c.city,
       SUM(o.order_amount) AS total_spend
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name, c.city
ORDER BY total_spend DESC
LIMIT 5;

-- INNER JOIN practice: show customer names with order dates
SELECT c.customer_name, o.order_date FROM customers c INNER JOIN orders o ON c.customer_id = o.customer_id;
