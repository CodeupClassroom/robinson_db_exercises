-- FUNCTIONS EXERCISES

-- ########################
-- #2 Write a query to to find all employees whose last name starts and ends with 'E'. 
USE employees;
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'e%e';

-- Use concat() to combine their first and last name together as a single column named full_name.
SELECT concat(first_name,' ', last_name) AS full_name 
FROM employees
WHERE last_name LIKE 'e%e';


-- ########################
-- #3 Convert the names produced in your last query to all uppercase.
SELECT upper(
concat(first_name, ' ', last_name))
AS 'full_name'
FROM employees
where last_name like 'e%e';


-- ########################
-- #4. Use a function to determine how many results were returned from your previous query.
select count(*)
from employees
where last_name like 'e%e';


-- ########################
-- #5 Find all employees hired in the 90s and born on Christmas. 
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25';

-- Use datediff() function to find how many days they have been working at the company 
SELECT *, datediff(now(), hire_date) 
AS days_with_company
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25';


-- ########################
-- #6 Find the smallest and largest current salary from the salaries table.
-- largest $158,220
SELECT MAX(salary) 
FROM salaries
WHERE to_date LIKE '9999%'; 

-- Smallest $38,632
SELECT MIN(salary) 
FROM salaries
WHERE to_date LIKE '9999%';

-- or 

SELECT MIN(salary), MAX(salary) 
FROM salaries
WHERE to_date LIKE '9999%';

-- or
SELECT MIN(salary), MAX(salary)
FROM salaries
Where to_date > from_date;

-- ########################
-- #7  Use your knowledge of built in SQL functions to generate a username for all of the employees. 
-- A username should be all lowercase, and consist of the first character of the employees first name, 
-- the first 4 characters of the employees last name, an underscore, 
-- the month the employee was born, and the last two digits of the year that they were born.

SELECT lower(
concat(
substr(first_name, 1, 1), 
substr(last_name, 1,4), 
'_', 
substr(birth_date, 6,2), 
substr(birth_date, 3,2))) 
AS username, first_name, last_name, birth_date
FROM employees;

-- or (using left)

SELECT 
LOWER(
CONCAT(
LEFT(first_name, 1),
LEFT(last_name, 4),
'_',
SUBSTR(birth_date, 6, 2),
SUBSTR(birth_date, 3, 2))) AS username,
first_name,last_name,birth_date
FROM employees
LIMIT 10;

-- or 

SELECT 
LOWER(CONCAT(
SUBSTR(first_name, 1, 1),
SUBSTR(last_name, 1, 4),
'_',
date_format(birth_date, '%m%y'))) AS username, first_name, last_name, birth_date
FROM employees
LIMIT 10;