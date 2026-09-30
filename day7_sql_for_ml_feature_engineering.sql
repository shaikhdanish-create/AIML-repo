-- day7_sql_for_ml_feature_engineering.sql
-- Day 7: wrapping up the week by tying SQL back to the ML side of things.  
-- Basically prepping data the way I'd want it before feeding it into a model.
  
-- Pulling a couple of basic features per customer from their orders  
SELECT customer_id,
       COUNT(order_id) AS total_orders,
       SUM(order_amount) AS total_spend
FROM orders
GROUP BY customer_id;

-- Turning "days since last order" into a simple churn label
-- (1 = probably churned, 0 = still active) - nothing fancy, just a CASE WHEN
SELECT customer_id,
       total_orders,
       total_spend,
       CASE WHEN days_since_last_order > 90 THEN 1 ELSE 0 END AS churn_label
FROM customer_features;

-- This is basically the same idea from my churn feature engineering script,
-- just a reminder of how SQL fits into the ML pipeline before pandas/sklearn.

SELECT DISTINCT city
FROM students;

DROP TABLE students;
