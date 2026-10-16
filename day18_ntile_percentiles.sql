-- day18_ntile_percentiles.sql
-- Day 18: back to window functions, but a few I skipped on Day 5.
-- NTILE and PERCENT_RANK seem really useful for ML-style binning.

-- NTILE: split customers into 4 equal groups (quartiles) by spend
SELECT customer_id,
       total_spend,
       NTILE(4) OVER (ORDER BY total_spend DESC) AS spend_quartile  
FROM customer_ml_features;

-- PERCENT_RANK: where does each customer sit compared to everyone else?
SELECT customer_id,
       total_spend,
       PERCENT_RANK() OVER (ORDER BY total_spend) AS spend_percentile
FROM customer_ml_features;

-- Picking out just the top 25% of spenders
SELECT customer_id, total_spend
FROM (
    SELECT customer_id,
           total_spend,
           NTILE(4) OVER (ORDER BY total_spend DESC) AS spend_quartile
    FROM customer_ml_features
) ranked
WHERE spend_quartile = 1;

-- Note to self: this is basically quantile binning, the same thing
-- I'd do with pandas qcut later. Nice to know SQL can do it before
-- the data even leaves the database.
