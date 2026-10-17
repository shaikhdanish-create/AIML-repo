-- day19_stored_procedures.sql 
-- Day 19: stored procedures. Basically saving a query with a name and
-- a parameter, so I can call it instead of retyping it every time.
-- (MySQL syntax - other databases do this a little differently)

DELIMITER //

-- A procedure that returns the top spenders above a limit I pass in
CREATE PROCEDURE get_top_customers(IN min_spend DECIMAL(10, 2))
BEGIN
    SELECT customer_id, total_orders, total_spend
    FROM customer_ml_features
    WHERE total_spend >= min_spend
    ORDER BY total_spend DESC;
END // 

DELIMITER ;

-- Calling it with different limits
CALL get_top_customers(500);
CALL get_top_customers(1000);

-- Cleaning up when I don't need it anymore
DROP PROCEDURE IF EXISTS get_top_customers;
 
-- Note to self: this feels like a view (Day 8) but with an input.
-- The DELIMITER lines looked weird at first, they're just there so
-- MySQL doesn't think the first semicolon inside ends the whole thing.
