-- ORDER BY clauses lesson

use employees;

select * 
from employees;

-- SELECT column FROM table ORDER BY column_name [ASC|DESC];

-- order results by last name in alphabetic order (default is ascending)
SELECT first_name, last_name
FROM employees
ORDER BY last_name;

-- OR order results by last name in REVERSE alphabetic order
SELECT first_name, last_name
FROM employees
ORDER BY last_name DESC;

-- we can also order by multiple columns by chaining 
SELECT first_name, last_name
FROM employees
ORDER BY last_name DESC, first_name ASC;