-- WHERE clauses

-- show me all columns in the employees table
select *
from employees;


-- ########################
-- BETWEEN keyword
-- show me employees whose emp_no is from 10026- 10083
SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no BETWEEN 10026 AND 10082;


-- ########################
-- LIKE/NOT LIKE keyword
-- show me the first name of all employees whose first name has a 'sus' in it
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

-- all employees whose hire date was in 1990
select first_name, last_name, hire_date
from employees
where hire_date like '1990-%';

-- all employees whose last name starts with B
select emp_no, last_name
from employees
where last_name like 'B%';

-- all employees whose last name starts with Z
select emp_no, last_name, first_name
from employees
where last_name like 'Z%';

-- all employees whose birth date was after 1960-01-01
select first_name, last_name, birth_date
from employees
where birth_date > '1960-01-01';

-- all employees whose last name as an 'oo' in it
select *
from employees
where last_name like '%oo%';

-- all employees whose first_name has less than 4 letters and have an employee number between 10400-10500
select emp_no, first_name as short_name
from employees
where length (first_name) < 4 
and emp_no > 10400
and emp_no < 10500;

-- all employees whose first name is mary and last name starts with F
select *
from employees
where first_name like 'Mary' 
or last_name like 'F%';

-- all employees whose employee number is between 10001- 10100
select *
from employees
where emp_no between 10001 
and 10100;

-- all employees who have a salary over 10K
select * 
from salaries
where salary > 10000;