-- day8_views.sql
-- Day 8: going a bit past the original week. Learned about VIEWS today -
-- basically saving a query so I don't have to rewrite it every time.

-- Turning yesterday's feature engineering query into a reusable view
CREATE VIEW customer_ml_features AS
SELECT customer_id,  
       COUNT(order_id) AS total_orders,
       SUM(order_amount) AS total_spend
FROM orders
GROUP BY customer_id;

-- Now I can just query the view like it's a normal table
SELECT * FROM customer_ml_features
WHERE total_spend > 500;  

-- Note to self: a view doesn't store data, it just re-runs the query
-- underneath every time you select from it - handy for keeping the
-- ML feature logic in one place instead of copy-pasting it everywhere.
