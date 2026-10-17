-- day20_recursive_cte.sql
-- Day 20: recursive CTEs. Felt like a good one to finish on since it
-- builds on the self join from Day 3 and the CTEs from Day 4.

-- Walking down the whole management chain, starting from the top
WITH RECURSIVE org_chart AS (
    -- starting point: the person with no manager
    SELECT employee_id, first_name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- keep adding the people who report to someone already in the list
    SELECT e.employee_id, e.first_name, e.manager_id, o.level + 1
    FROM employees e
    JOIN org_chart o ON e.manager_id = o.employee_id
)
SELECT employee_id, first_name, level
FROM org_chart
ORDER BY level, first_name;

-- Note to self: it runs the first part once, then keeps repeating the
-- second part until nothing new shows up. The self join on Day 3 only
-- went one level up, this one goes all the way down.
