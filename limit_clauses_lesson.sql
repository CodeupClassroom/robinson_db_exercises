-- LIMIT clauses lesson

use employees;

select * 
from employees;

-- SELECT columns FROM table LIMIT count [OFFSET count];

-- give me the first 10 results
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name LIKE 'M%'
LIMIT 10;

-- now, give me 25 results but start at result 50
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name LIKE 'M%'
LIMIT 25 OFFSET 50;
