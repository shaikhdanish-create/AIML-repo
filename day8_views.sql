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

-- First extra practice: check all customers from the reusable view.
SELECT * FROM customer_ml_features;

-- Second practice: select only the useful feature columns.
SELECT customer_id, total_spend
FROM customer_ml_features;

-- Third practice: sort customers by their total spending.
SELECT customer_id, total_spend
FROM customer_ml_features
ORDER BY total_spend DESC;

-- Fourth practice: find customers who placed more than three orders.
SELECT customer_id, total_orders
FROM customer_ml_features
WHERE total_orders > 3;

-- Fifth practice: give the calculated columns shorter labels for reading.
SELECT customer_id AS customer,
       total_orders AS orders,
       total_spend AS spending
FROM customer_ml_features;

-- Sixth practice: show customers with both useful features together.
SELECT customer_id, total_orders, total_spend
FROM customer_ml_features
WHERE total_orders >= 2
  AND total_spend >= 500;
