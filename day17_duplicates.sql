-- day17_duplicates.sql
-- Day 17: duplicates. Another one of those "dirty data" problems that 
-- would quietly mess up a model if I didn't catch it first.

-- Finding duplicate customers (same name and city showing up twice)
SELECT customer_name, city, COUNT(*) AS times_seen
FROM customers
GROUP BY customer_name, city
HAVING COUNT(*) > 1;

-- Numbering the copies so I can tell which one to keep
SELECT customer_id, customer_name, city,
       ROW_NUMBER() OVER (
           PARTITION BY customer_name, city
           ORDER BY customer_id
       ) AS copy_number
FROM customers;

-- Deleting every copy except the first one
DELETE FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM (
        SELECT customer_id,
               ROW_NUMBER() OVER (
                   PARTITION BY customer_name, city
                   ORDER BY customer_id
               ) AS copy_number
        FROM customers
    ) numbered
    WHERE copy_number > 1
);

-- Note to self: run the SELECT version first and check the rows before 
-- running the DELETE. Wrapping it in a transaction like on Day 13 is
-- a good safety net too.
