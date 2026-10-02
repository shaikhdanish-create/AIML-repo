-- day9_null_handling.sql
-- Day 9: dealing with NULLs today. Realized a lot of "messy data" problems
-- in ML prep are really just NULL handling problems in disguise.

-- Finding rows with missing values
SELECT * FROM orders WHERE order_amount IS NULL;

-- COALESCE: fill in a default instead of leaving it NULL
SELECT order_id, COALESCE(order_amount, 0) AS order_amount_clean
FROM orders;

-- NULLIF: the opposite trick - turn a specific "bad" value into NULL
-- (useful when 0 or -1 was used as a placeholder for missing data)
SELECT customer_id, NULLIF(total_spend, 0) AS total_spend_or_null
FROM customer_ml_features;

-- Note to self: NULL doesn't equal anything, not even another NULL -
-- that's why "WHERE column = NULL" silently returns nothing and you
-- have to use "IS NULL" / "IS NOT NULL" instead. Wasted 10 minutes
-- debugging this before remembering that.
