-- feature_engineering_for_churn_model.sql 
--
-- Example SQL used to prepare a training dataset for a customer churn
-- ML model. Demonstrates common feature engineering patterns done in
-- SQL before data is handed off to pandas/scikit-learn.

-- 1. Base customer features
SELECT
    c.customer_id,
    c.signup_date,
    c.plan_type,
    DATEDIFF(CURRENT_DATE, c.signup_date) AS tenure_days
FROM customers c;

-- 2. Aggregate usage behavior (feature engineering)
SELECT
    o.customer_id,
    COUNT(o.order_id)              AS total_orders,
    SUM(o.order_amount)            AS total_spend,
    AVG(o.order_amount)            AS avg_order_value,
    MAX(o.order_date)              AS last_order_date,
    DATEDIFF(CURRENT_DATE, MAX(o.order_date)) AS days_since_last_order
FROM orders o
GROUP BY o.customer_id;

-- 3. Combine into a single training table with the churn label
SELECT
    c.customer_id,
    c.plan_type,
    DATEDIFF(CURRENT_DATE, c.signup_date) AS tenure_days,
    COALESCE(u.total_orders, 0)           AS total_orders,
    COALESCE(u.total_spend, 0)            AS total_spend,
    COALESCE(u.avg_order_value, 0)        AS avg_order_value,
    COALESCE(u.days_since_last_order, 999) AS days_since_last_order,
    CASE
        WHEN u.days_since_last_order > 90 OR u.days_since_last_order IS NULL
        THEN 1 ELSE 0
    END AS churn_label
FROM customers c
LEFT JOIN (
    SELECT
        o.customer_id,
        COUNT(o.order_id)              AS total_orders,
        SUM(o.order_amount)            AS total_spend,
        AVG(o.order_amount)            AS avg_order_value,
        DATEDIFF(CURRENT_DATE, MAX(o.order_date)) AS days_since_last_order
    FROM orders o
    GROUP BY o.customer_id
) u ON c.customer_id = u.customer_id;

-- The result of query 3 is what you'd export (or query directly via
-- pandas.read_sql) as the input dataframe for a classification model
-- like the one in simple_linear_regression.py / a churn classifier.
