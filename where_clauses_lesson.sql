-- WHERE clauses

-- show me all columns in the employees table
select *
from employees;


-- ########################
-- BETWEEN keyword
-- show me employees who's emp_no is from 10026- 10083
SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no BETWEEN 10026 AND 10082;


-- ########################
-- LIKE/NOT LIKE keyword
-- show me the first name of all employees who's first name has a 'sus' in it
SELECT first_name
FROM employees
WHERE first_name LIKE '%sus%';

-- we will get the same results by doing this:
SELECT DISTINCT first_name
FROM employees
WHERE first_name NOT LIKE '%sus%';


-- ########################
-- IN keyword
-- show me the emp_no and first name of all employees who have those last names
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name IN ('Herber', 'Dredge', 'Lipner', 'Baek');


-- ########################
-- NULL/NOT NULL keyword
-- show me the emp_no and title of all employees do not have a null in their to date
SELECT emp_no, title
FROM titles
WHERE to_date IS NOT NULL;


-- ########################
-- CHAINING WHERE clauses
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name IN ('Herber','Baek')
  AND emp_no < 20000;


-- ########################
-- Student examples:
--
select first_name, last_name, hire_date
from employees
where hire_date like '1990-%';

select emp_no, last_name
from employees
where last_name like 'B%';

select emp_no, last_name, first_name
from employees
where last_name like 'Z%';

select first_name, last_name, birth_date
from employees
where birth_date > '1960-01-01';

select *
from employees
where last_name like '%oo%';

select emp_no, first_name as short_name
from employees
where length (first_name) < 4 
and emp_no > 10400
and emp_no < 10500;

select *
from employees
where first_name = 'Mary' 
or last_name = 'F%';

select *
from employees
where emp_no between 10001 
and 10100;

select * 
from salaries
where salary > 10000;