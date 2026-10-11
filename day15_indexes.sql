-- day15_indexes.sql
-- learning SQL indexes - CREATE INDEX and DROP INDEX
-- Back then I wrote "an index would help" in a comment without ever
-- creating one, so today I actually did it.

-- Creating an index on the column I keep filtering by
CREATE INDEX idx_orders_customer_id    
ON orders (customer_id);

-- Same query as Day 6, but now the database has a shortcut to use
EXPLAIN SELECT order_id, order_date, order_amount
FROM orders
WHERE customer_id = 1042;

-- A composite index for queries that filter on two columns together
CREATE INDEX idx_orders_customer_date
ON orders (customer_id, order_date);

-- Removing an index I don't need anymore
DROP INDEX idx_orders_customer_id ON orders;
  
-- Note to self: indexes make reads faster but slow down INSERTs and
-- UPDATEs a little, so I shouldn't just add one to every column.
