-- day22_exists.sql
-- Day 22: EXISTS. I used IN and NOT IN with subqueries back on Day 4,  
-- so today I wanted to see what EXISTS does differently.

-- Customers who have placed at least one order
SELECT c.customer_id, c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- Customers who have never ordered anything
SELECT c.customer_id, c.customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- Note to self: EXISTS only checks whether any matching row is there,
-- it doesn't care what the subquery returns, which is why people write
-- SELECT 1. NOT EXISTS is also safer than NOT IN when the subquery
-- might have NULLs in it - NOT IN can quietly return nothing then.
