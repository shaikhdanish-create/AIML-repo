-- day6_query_optimization.sql
-- Day 6: playing around with query optimization. Nothing fancy today,
-- just comparing a "bad" query to a better version and learning EXPLAIN.

-- Before: pulling everything, no idea how slow this actually is
SELECT * FROM orders WHERE customer_id = 1042;

-- After: only grabbing the columns I actually need
SELECT order_id, order_date, order_amount
FROM orders
WHERE customer_id = 1042;

-- Used EXPLAIN to see how the database is running this query
-- (should be way faster once customer_id has an index on it)
EXPLAIN SELECT order_id, order_date, order_amount
FROM orders
WHERE customer_id = 1042;

-- Note to self: an index on customer_id would turn this into a quick
-- lookup instead of scanning the whole orders table row by row.


description 
Kept today light — took a query I'd normally write without thinking (SELECT *) and compared 
  it to a version that only grabs the columns I need. Ran EXPLAIN on it just to see what the
  database is actually doing under the hood. Still wrapping my head around indexes, 
  but the idea that customer_id without an index means scanning
  every row makes a lot more sense now.
