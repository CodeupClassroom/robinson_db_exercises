
-- Let's use a fun database to dive into this:

use farmers_market;

###########################

-- Correct syntax for if function:
-- SELECT IF(condition, value_1, value_2) AS new_column
-- FROM table_a;

###########################

-- Let's take a look at what some one the tables hold.

select *
from customer;

select *
from vendor;

select *
from booth;

###########################

-- Let's use the booth table to walk through the if function:

-- In this instance, we want to find all the booths that are classified as small.

SELECT IF(condition, value_1, value_2) AS new_column
FROM table_a;

select *, IF(booth_price_level = 'A', True, False) AS is_small_booth
from booth;

-- What would happen if we didn't use an alias?

select *, IF(booth_type = 'Small', 0, 1)
from booth;

-- As we can see, we get a long, hard to read name created by SQL. This is why aliasing is recommended for this instance.

###########################
###########################

-- CASE STATEMENTS

-- Syntax 1:
/* SELECT
    CASE column_a
        WHEN condition_a THEN value_1
        WHEN condition_b THEN value_2
        ELSE value_3
    END AS new_column_name
FROM table_a;
*/

USE employees;

SELECT
    dept_name,
    CASE dept_name
        WHEN 'research' THEN 'Development'
        WHEN 'marketing' THEN 'Sales'
        ELSE dept_name
    END AS dept_group
FROM departments;

###########################

-- Syntax 2:
/* SELECT
    CASE
       WHEN column_a > condition_1 THEN value_1
       WHEN column_b <= condition_2 THEN value_2
       ELSE value_3
   END AS new_column_name
FROM table_a;
*/

USE employees;

SELECT *,
   CASE
       WHEN dept_name IN ('research', 'development') THEN 'R&D'
       WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
       WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
       ELSE dept_name
   END AS dept_group
FROM departments;
