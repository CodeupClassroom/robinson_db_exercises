/* 
Functions Exercises
*/
-- Copy the order by exercise and save it as 
-- functions_exercises.sql.
-- OK sure

-- Write a query to find all employees whose last
--  name starts and ends with 'E'. Use concat() to 
--  combine their first and last name together as a 
--  single column named full_name.
SELECT DATABASE();
USE employees;
-- (FROM: employees) employees from employees schema
-- (WHERE )under the condition: last name starts and ends with e
-- (SELECT CONCAT()) make a new field that combines first and last name
-- (AS full_name) alias that new field
SELECT
CONCAT(first_name,
' ',
last_name)
AS full_name
FROM
employees.employees
WHERE
last_name LIKE 'e%e';

-- Convert the names produced in your last query 
-- to all uppercase.
SELECT
UPPER(
CONCAT(first_name,
' ',
last_name)
)
AS full_name
FROM
employees.employees
WHERE
last_name LIKE 'e%e';

-- Use a function to determine how many results 
-- were returned from your previous query.
SELECT
COUNT(
UPPER(
CONCAT(first_name,
' ',
last_name)
)
)
AS full_name
FROM
employees.employees
WHERE
last_name LIKE 'e%e';

SELECT
COUNT(
*)
AS e_employee_count_e
FROM
employees.employees
WHERE
last_name LIKE 'e%e'
LIMIT 5;

-- Find all employees hired in the 90s and born 
-- on Christmas. Use datediff() 
-- function to find how many days 
-- they have been working at the company 
-- (Hint: You will also need to use NOW() or CURDATE())

-- all employees, no field specified (probably names I guess)
-- time worked at the company in days
-- condition (WHERE) born on 12-25, hired in the 90s
DESCRIBE employees;
SELECT * FROM employees 
WHERE hire_date LIKE '199%' LIMIT 5;


SELECT 
CONCAT(first_name, ' ', last_name) AS full_name,
DATEDIFF(CURDATE(), hire_date) / 365 AS years_employed
-- hire_date,
-- birth_date
FROM
employees
WHERE
hire_date LIKE '199%'
AND birth_date LIKE '%12-25';

-- Find the smallest and largest current salary
--  from the salaries table.
-- MAX()  --> one result, the biggest thing
-- MIN() --> one result, the smallest thing
DESCRIBE salaries;
SELECT
MAX(salary) AS best_deal,
MIN(salary) AS so_sorry,
'hello robinson'
FROM salaries;
-- Use your knowledge of built in SQL functions to generate 
-- a username for all of the employees. 
-- A username should be 
-- all lowercase, and consist of the first character of the 
-- employees first name, the first 4 characters of the 
-- employees last name, an underscore, the month the 
-- employee was born, and the last two digits of the 
-- year that they were born. Below is an example of 
-- what the first 10 rows will look like:

-- SELECT LEFT(first_name, 1) FROM employees LIMIT 5;
SELECT * FROM employees LIMIT 1; -- YYYY-MM-DD
-- all lowercase ==> LOWER()
-- first letter of first name ==> SUBSTR(first_name, 1, 1)
-- first 4 letters of last name ==> SUBSTR(last_name, 1, 4)
-- underscore ==> '_'
-- month of employees birth ==> SUBSTR(birth_date, 6, 2)
-- SELECT MONTH(birth_date) FROM employees;
-- last two digits of year of employees birth SUBSTR(birth_date, 1, 4)
--  YEAR(hire_date)


SELECT
LOWER(
CONCAT(
-- first letter first name:
SUBSTR(first_name, 1, 1),
-- first 4 last name:
SUBSTR(last_name, 1, 4),
-- underscore: 
'_',
-- month of birth date:
SUBSTR(birth_date, 6, 2),
-- year of birth date:
SUBSTR(birth_date, 3, 2)
)
)
AS username,
birth_date,
first_name, 
last_name
FROM
employees;

