-- day25_first_order_cohorts.sql
-- Day 25: my first try at cohort-style thinking. Grouping customers by
-- the month they first ordered, then seeing how many came back.

-- Step 1: find each customer's first order month
WITH first_orders AS (
    SELECT customer_id,
           MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY customer_id
)
-- Step 2: count how many customers started in each month
SELECT EXTRACT(YEAR FROM first_order_date)  AS yr,
       EXTRACT(MONTH FROM first_order_date) AS mo,
       COUNT(*) AS new_customers
FROM first_orders
GROUP BY yr, mo
ORDER BY yr, mo;

-- Repeat buyers: customers with more than one order
SELECT COUNT(*) AS repeat_customers
FROM (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) repeaters;

-- Note to self: MIN on a date gives the earliest one, so it's an easy
-- way to find "first time" events. This could turn into a good ML
-- feature later, like how long ago someone became a customer.
