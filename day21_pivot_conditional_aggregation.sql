-- day21_pivot_conditional_aggregation.sql
-- Day 21: three weeks done. Today I tried turning rows into columns,
-- which is the shape a lot of ML models actually want their data in.

-- Spend per customer for each quarter, one column per quarter
SELECT customer_id,
       SUM(CASE WHEN EXTRACT(MONTH FROM order_date) BETWEEN 1 AND 3
                THEN order_amount ELSE 0 END)  AS q1_spend,
       SUM(CASE WHEN EXTRACT(MONTH FROM order_date) BETWEEN 4 AND 6
                THEN order_amount ELSE 0 END)  AS q2_spend,
       SUM(CASE WHEN EXTRACT(MONTH FROM order_date) BETWEEN 7 AND 9
                THEN order_amount ELSE 0 END)  AS q3_spend,
       SUM(CASE WHEN EXTRACT(MONTH FROM order_date) BETWEEN 10 AND 12
                THEN order_amount ELSE 0 END)  AS q4_spend
FROM orders
GROUP BY customer_id;

-- Note to self: this is just CASE WHEN from Day 16 inside SUM from
-- Day 2, nothing brand new. Funny how the later topics keep being
-- earlier ones stuck together. A pivot like this gives each customer
-- one row with a few features, which is exactly what a model wants.

--Three weeks in, and today I turned rows into columns by putting CASE WHEN inside SUM to get one spend column per quarter for each customer. Funny realization: it’s just Day 16 and Day 2 stuck together, and a lot of the later topics keep turning out to be earlier ones combined. It also gives each customer a single row of features, which is the shape an ML model wants
