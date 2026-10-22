-- day23_alter_table.sql
-- Day 23: ALTER TABLE. On Day 14 I built tables from scratch, but I
-- never thought about what happens when I forget a column later.

-- Adding a new column to an existing table
ALTER TABLE customers
ADD COLUMN email VARCHAR(100);

-- Filling it in for one customer
UPDATE customers
SET email = 'aarav@example.com'
WHERE customer_id = 1;

-- Renaming a column that has a confusing name
ALTER TABLE customers
RENAME COLUMN city TO home_city;

-- Removing a column I don't need anymore
ALTER TABLE customers
DROP COLUMN email;

-- Note to self: DROP COLUMN throws the data away for good, so it's
-- worth checking twice before running it. Also handy for ML work,
-- since I can add a new feature column without rebuilding the table.
