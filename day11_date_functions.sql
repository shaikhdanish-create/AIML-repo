-- day11_date_functions.sql
-- Day 11: finally sat down and actually learned date functions properly,
-- instead of just copy-pasting DATEDIFF from earlier scripts without
-- really understanding it.

-- DATEDIFF: how many days ago was this order placed?
SELECT order_id, order_date,
       DATEDIFF(CURRENT_DATE, order_date) AS days_ago
FROM orders;

-- EXTRACT: pull out just the year or month from a date
SELECT order_id, order_date,
       EXTRACT(YEAR FROM order_date) AS order_year,
       EXTRACT(MONTH FROM order_date) AS order_month
FROM orders;

-- Grouping by month to see orders over time
SELECT EXTRACT(YEAR FROM order_date) AS yr,
       EXTRACT(MONTH FROM order_date) AS mo,
       COUNT(*) AS total_orders
FROM orders
GROUP BY yr, mo
ORDER BY yr, mo;

-- DATE_ADD: find the date 30 days after signup (useful for trial periods)
SELECT customer_id, signup_date,
       DATE_ADD(signup_date, INTERVAL 30 DAY) AS trial_end_date
FROM customers;

-- Note to self: this is exactly what was happening under the hood in
-- my Day 7 churn script (days_since_last_order) - good to finally
-- understand it instead of just trusting it worked.

Description 
Finally slowed down and actually learned date functions instead of just copying DATEDIFF from earlier scripts without really getting it. Covered DATEDIFF, EXTRACT for pulling out year/month, grouping orders by month, and DATE_ADD for calculating things like a trial end date. Realized this is exactly what was happening behind the scenes in my Day 7 churn script — nice to finally understand the mechanics instead of just trusting it worked.
