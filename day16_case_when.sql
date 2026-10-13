-- day16_case_when.sql
-- Day 16: CASE WHEN. I've been using it for the churn label since Day 7
-- but never really looked at it on its own, so today was a proper look.

-- Bucketing customers into spend segments
SELECT customer_id,
       total_spend,
       CASE
           WHEN total_spend >= 1000 THEN 'high'
           WHEN total_spend >= 300  THEN 'medium'
           ELSE 'low'
       END AS spend_segment
FROM customer_ml_features;

-- Using CASE inside an aggregate: count orders by size in one pass
SELECT
    COUNT(CASE WHEN order_amount >= 500 THEN 1 END) AS big_orders,
    COUNT(CASE WHEN order_amount < 500 THEN 1 END)  AS small_orders
FROM orders;

-- Note to self: CASE checks conditions top to bottom and stops at the
-- first match, so the order of the WHEN lines actually matters. Also
-- forgot the ELSE once and got NULLs back - not fun to debug.
