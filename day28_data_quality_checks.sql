-- day28_data_quality_checks.sql
-- Day 28: four weeks done. Instead of a new topic, I wrote some quick
-- sanity checks for the feature view from yesterday. Seems smarter to
-- check the data before any model sees it. 

-- Does the view have one row per customer, like it should?
SELECT COUNT(*) AS feature_rows,
       (SELECT COUNT(*) FROM customers) AS customer_rows
FROM customer_feature_table;

-- How many NULLs are hiding in each column?
SELECT SUM(CASE WHEN total_orders IS NULL THEN 1 ELSE 0 END)            AS null_orders,
       SUM(CASE WHEN total_spend IS NULL THEN 1 ELSE 0 END)             AS null_spend,
       SUM(CASE WHEN avg_days_between_orders IS NULL THEN 1 ELSE 0 END) AS null_gaps
FROM customer_feature_table;

-- Anything strange, like negative spend?
SELECT customer_id, total_spend
FROM customer_feature_table
WHERE total_spend < 0;

-- Note to self: the null_gaps number should roughly match the one-time
-- customers. If it's way off, something in the joins is wrong.
