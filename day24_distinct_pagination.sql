-- day24_distinct_pagination.sql
-- Day 24: a small one today. DISTINCT and OFFSET are things I've used  
-- a little without really thinking about them.

-- Unique cities in the customers table
SELECT DISTINCT city
FROM customers;

-- How many different customers have actually ordered?
SELECT COUNT(DISTINCT customer_id) AS active_customers
FROM orders;

-- Pagination: page 1, then page 2, with 10 rows each
SELECT order_id, order_date, order_amount
FROM orders
ORDER BY order_date DESC
LIMIT 10 OFFSET 0;

SELECT order_id, order_date, order_amount
FROM orders
ORDER BY order_date DESC
LIMIT 10 OFFSET 10;

-- Note to self: without ORDER BY the pages can come back in a random
-- order, so pages might repeat or skip rows. COUNT(*) and
-- COUNT(DISTINCT ...) give very different numbers too.
