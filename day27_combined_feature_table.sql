-- day27_combined_feature_table.sql
-- Day 27: putting the last few weeks together. Instead of learning
-- something new, I joined a few earlier ideas into one feature table.

CREATE VIEW customer_feature_table AS
WITH spend AS (  
    SELECT customer_id,
           COUNT(order_id)   AS total_orders,
           SUM(order_amount) AS total_spend
    FROM orders 
    GROUP BY customer_id
),
gaps AS (
    SELECT customer_id,
           AVG(DATEDIFF(order_date, prev_order_date)) AS avg_days_between_orders
    FROM (
        SELECT customer_id,
               order_date,
               LAG(order_date) OVER (
                   PARTITION BY customer_id
                   ORDER BY order_date
               ) AS prev_order_date  
        FROM orders
    ) x
    WHERE prev_order_date IS NOT NULL
    GROUP BY customer_id
)
SELECT c.customer_id,
       COALESCE(s.total_orders, 0) AS total_orders,
       COALESCE(s.total_spend, 0)  AS total_spend,
       g.avg_days_between_orders
FROM customers c
LEFT JOIN spend s ON c.customer_id = s.customer_id
LEFT JOIN gaps  g ON c.customer_id = g.customer_id;

-- Note to self: customers with one order have no gap value, so that
-- column stays NULL for them. I'll need to fill it in on the pandas
-- side later, which is a decision for the model, not the query.
