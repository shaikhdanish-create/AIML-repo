-- day8_views.sql
-- Day 8: going a bit past the original week. Learned about VIEWS today -
-- basically saving a query so I don't have to rewrite it every time.

CREATE VIEW customer_ml_features AS
SELECT customer_id, COUNT(order_id) AS total_orders, SUM(order_amount) AS total_spend
FROM orders
GROUP BY customer_id;

SELECT * FROM customer_ml_features WHERE total_spend > 500;

-- Note to self: a view doesn't store data, it just re-runs the query
-- underneath every time you select from it.

SELECT * FROM customer_ml_features;
SELECT customer_id, total_spend FROM customer_ml_features;
SELECT customer_id, total_spend FROM customer_ml_features ORDER BY total_spend DESC;
SELECT customer_id, total_orders FROM customer_ml_features WHERE total_orders > 3;
SELECT customer_id AS customer, total_orders AS orders, total_spend AS spending FROM customer_ml_features;
SELECT customer_id, total_orders, total_spend FROM customer_ml_features WHERE total_orders >= 2 AND total_spend >= 500;
SELECT customer_id, total_spend FROM customer_ml_features ORDER BY total_spend DESC LIMIT 10;

-- Eighth practice: count how many customers are represented in the view.
SELECT COUNT(*) AS customer_count
FROM customer_ml_features;

-- Ninth practice: find the average spending across customers.
SELECT AVG(total_spend) AS average_spend
FROM customer_ml_features;

-- Tenth practice: find the largest customer spend.
SELECT MAX(total_spend) AS highest_spend
FROM customer_ml_features;

-- Eleventh practice: find the smallest customer spend.
SELECT MIN(total_spend) AS lowest_spend
FROM customer_ml_features;

-- Twelfth practice: calculate the total spending across all customers.
SELECT SUM(total_spend) AS all_customer_spend
FROM customer_ml_features;

-- Thirteenth practice: find customers with no recorded orders.
SELECT customer_id
FROM customer_ml_features
WHERE total_orders = 0;
