-- day26_days_between_orders.sql
-- Day 26: mixing LAG from Day 5 with the date functions from Day 11.
-- Goal: how many days pass between a customer's orders?

-- Step 1: put each order next to the customer's previous order date
WITH order_gaps AS (
    SELECT customer_id,
           order_date,
           LAG(order_date) OVER (
               PARTITION BY customer_id
               ORDER BY order_date
           ) AS prev_order_date
    FROM orders
)
-- Step 2: average the gap per customer
SELECT customer_id,
       AVG(DATEDIFF(order_date, prev_order_date)) AS avg_days_between_orders
FROM order_gaps
WHERE prev_order_date IS NOT NULL
GROUP BY customer_id;

-- Note to self: the first order for every customer has no previous
-- one, so LAG gives NULL there and I have to filter it out. Forgot
-- that at first and the averages looked off. This feels like a really
-- useful ML feature for predicting churn.
