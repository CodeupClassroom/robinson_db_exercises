-- ###############
-- GROUP BY EXERCISES

use employees;

-- ###############
-- #2. In your script, use DISTINCT to find the unique titles in the titles table. 
-- How many unique titles have there ever been? Answer that in a comment in your SQL file.
-- Answer: 7
select count(distinct title)
from titles;


-- ###############
-- #3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
select last_name
from employees
where last_name like 'e%e'
group by last_name;

-- or
select last_name
from employees
group by last_name
having last_name like 'e%e';

-- or 
select distinct last_name
from employees
where last_name like 'e%e';


-- ###############
-- #4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
select first_name, last_name
from employees
where last_name like 'e%e'
group by first_name, last_name;


-- ###############
-- #5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
-- Answer:
-- Chleq
-- Lindqvist
-- Qiwen

select last_name
from employees
where last_name like '%q%'
	and last_name not like '%qu%'
group by last_name;


-- ###############
-- #6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.

select last_name, count(*) as count_unique_last_name
from employees
where last_name like '%q%'
	and last_name not like '%qu%'
group by last_name
order by count_unique_last_name DESC;


-- ###############
-- #7. Find all employees with first names 'Irena', 'Vidya', or 'Maya'. 
-- Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

select first_name, gender, count(*) as name_count_by_gender
from employees
where first_name IN ('Irena','Vidya','Maya')
group by first_name, gender
order by name_count_by_gender;


-- ###############
-- #8. Using your query that generates a username for all of the employees, generate a count employees for each unique username.

select
	lower(concat(
    left(first_name, 1)
    ,left(last_name,4)
    ,'_'
    ,substr(birth_date,6,2)
    ,substr(birth_date,3,2)
    )) as username, count(*)
from employees
group by username;


-- ###############
-- #9. From your previous query, are there any duplicate usernames? 
-- What is the higest number of times a username shows up? 

select
	lower(concat(
    left(first_name, 1)
    ,left(last_name,4)
    ,'_'
    ,substr(birth_date,6,2)
    ,substr(birth_date,3,2)
    )) as username, count(*)
from employees
group by username
having count(*) > 1
order by count(*) DESC; 


-- ###############
-- #9. Bonus: How many duplicate usernames are there from your previous query?

select count(*) 
from 
	(select
		lower(concat(
		left(first_name, 1)
		,left(last_name,4)
		,'_'
		,substr(birth_date,6,2)
		,substr(birth_date,3,2)
		)) as username, count(*)
	from employees
	group by username
	having count(*) > 1
	order by count(*) DESC) as derived_table_name;


-- #################
-- BONUS QUESTIONS:
-- #################
-- B1. Determine the historic average salary for each employee. 
select emp_no, round(avg(salary),2)
from salaries
group by emp_no;

-- B2. Using the dept_emp table, count how many current employees work in each department. 
-- The query result should show 9 rows, one for each department and the employee count.

select dept_no, count(distinct emp_no) as current_dept_emp
from dept_emp
where to_date > now()
group by dept_no;

-- B3. Determine how many different salaries each employee has had. 
-- This includes both historic and current.
select emp_no, count(*)
from salaries
group by emp_no
order by count(*) desc;

-- B4. Find the maximum salary for each employee.
select emp_no, max(salary)
from salaries
group by emp_no;

-- B5. Find the minimum salary for each employee.
select emp_no, min(salary)
from salaries
group by emp_no;

-- B6. Find the standard deviation of salaries for each employee.
select emp_no, round(std(salary),1), round(stddev(salary),1), count(*)
from salaries
group by emp_no;

-- B7. Now find the max salary for each employee where that max salary is greater than $150,000.
select emp_no, max(salary) as max_sal
from salaries
group by emp_no
having max_sal > 150000;

-- B8. Find the average salary for each employee where that average salary is between $80k and $90k.
select emp_no, round(avg(salary),2) as avg_sal
from salaries
group by emp_no
having avg_sal BETWEEN 80000 and 90000;