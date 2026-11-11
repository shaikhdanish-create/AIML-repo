-- day29_train_test_split.sql
-- Day 29: splitting data into train and test sets directly in SQL.
-- I only ever did this in sklearn before, so this felt new.
 
-- Using the customer_id to split roughly 80/20
-- (same customer always lands in the same set, no randomness)
SELECT *,
       CASE WHEN MOD(customer_id, 5) = 0 THEN 'test' ELSE 'train' END AS data_split
FROM customer_feature_table;
  
-- Checking the split sizes look about right
SELECT CASE WHEN MOD(customer_id, 5) = 0 THEN 'test' ELSE 'train' END AS data_split,
       COUNT(*) AS rows_in_split 
FROM customer_feature_table
GROUP BY data_split;

-- Note to self: a split based on the ID is repeatable, so I get the
-- same train and test rows every time I run it. A random split would
-- change on each run, which makes results hard to compare. It only
-- works if the IDs are not sorted in some meaningful way though.
