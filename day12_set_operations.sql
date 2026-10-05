--day12_set_operations.sql
-- Day 12: UNION today. Kept mixing it up with JOIN at first - took a
-- bit to realize JOIN combines columns side by side, UNION stacks rows.

-- UNION: combine two similar result sets, duplicates removed automatically
SELECT customer_name AS name, 'customer' AS source
FROM customers
UNION
SELECT first_name AS name, 'employee' AS source
FROM employees;

-- UNION ALL: same thing but keeps duplicates (and runs faster, no dedup step)
SELECT city FROM customers
UNION ALL 
SELECT department FROM employees;
 
-- INTERSECT: only rows that show up in both sets
-- (not supported in MySQL - emulate with an INNER JOIN or IN instead)
SELECT customer_id FROM orders
INTERSECT
SELECT customer_id FROM customers WHERE city = 'Nagpur';

-- Note to self: UNION needs both queries to have the same number of
-- columns, and matching-ish data types - learned that one from a
-- UNION ALL is faster because SQL doesn't need to check for duplicates.
