-- day10_string_functions.sql
-- Day 10: cleaning up messy text data today. Feels like a natural      
-- follow-up to yesterday's NULL stuff - different flavor of "dirty data."

-- TRIM: get rid of stray whitespace around values
SELECT customer_name, TRIM(customer_name) AS customer_name_clean
FROM customers;

-- UPPER / LOWER: normalize casing so "sales" and "Sales" don't count as different
SELECT DISTINCT UPPER(department) AS department_normalized
FROM employees;

-- CONCAT: combine first and last name into one field
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;

-- SUBSTRING: pull out just the area code from a phone number, for example
SELECT phone_number, SUBSTRING(phone_number, 1, 3) AS area_code
FROM customers;

-- Note to self: cleaning text like this before grouping or joining
-- matters a lot - "Mumbai" and "mumbai " (with a trailing space) would
-- otherwise get treated as two different cities.
