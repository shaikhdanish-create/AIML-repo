-- day13_transactions.sql
-- Day 13: transactions. Funny timing - right after learning how to
-- roll back a messed-up git push, turns out SQL has its own "undo" too.

-- Start a transaction before making changes
BEGIN TRANSACTION;

UPDATE employees
SET salary = salary * 1.10
WHERE department = 'Sales';

-- Check the result before committing to it
SELECT first_name, department, salary FROM employees WHERE department = 'Sales';

-- If it looks wrong, undo everything since BEGIN TRANSACTION
ROLLBACK;

-- If it looks right, make it permanent instead
-- COMMIT;

-- Note to self: ROLLBACK only works before COMMIT - once committed,
-- it's like a pushed git commit, you'd need a new change to undo it,
-- not a rollback.
