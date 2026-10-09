-- day14_create_table_constraints.sql
-- Day 14: two weeks in! Until now I've only been querying tables that
-- already existed, so today I tried building one from scratch.

-- CREATE TABLE with a primary key and a few constraints       
CREATE TABLE customers (
    customer_id   INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city          VARCHAR(50),
    signup_date   DATE DEFAULT CURRENT_DATE
);

-- A second table linked to the first with a foreign key
CREATE TABLE orders (
    order_id     INT PRIMARY KEY,
    customer_id  INT,
    order_amount DECIMAL(10, 2) CHECK (order_amount >= 0),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Adding a couple of rows to test it out
INSERT INTO customers (customer_id, customer_name, city)
VALUES (1, 'Aarav', 'Pune');

INSERT INTO orders (order_id, customer_id, order_amount)
VALUES (101, 1, 450.00);

-- Note to self: the foreign key stops me from adding an order for a
-- customer_id that doesn't exist - kind of annoying while testing, but
-- it's exactly what keeps the data clean for ML later. 
