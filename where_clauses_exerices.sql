-- WHERE clauses exercises

use employees;
select database();
show tables;


-- #####################
-- #1. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. 
-- What is the employee number of the top three results?
-- Answer: 10200, 10397, 10610

select * 
from employees
where first_name in ('Irena', 'Vidya','Maya');


-- #####################
-- #2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q1, but use OR instead of IN. What is the employee number of the top three results? 
-- Answer: 10200, 10397, 10610
-- Does it match the previous question? -- Answer: yes

select *
from employees
where first_name = 'Irena'
or first_name = 'Vidya'
or first_name = 'Maya';

-- to check that im only bringing back these names
select distinct first_name
from employees
where first_name = 'Irena'
or first_name = 'Vidya'
or first_name = 'Maya'; 


-- #####################
-- #3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who are male. 
-- What is the employee number of the top three results.
-- Answer: 10200, 10397, 10821
select *
from employees
where (first_name = 'Irena'
or first_name = 'Vidya'
or first_name = 'Maya')
and gender = 'M';


-- #####################
-- #4. Find all unique last names that start with 'E'.
select distinct last_name
from employees
where last_name like 'e%';


-- #####################
-- #5. Find all unique last names that start or end with 'E'.
select distinct last_name
from employees
where last_name like 'e%'
OR last_name like '%e';


-- #####################
-- #6. Find all unique last names that end with E, but does not start with E?
select distinct last_name
from employees
where last_name like '%e'
AND last_name NOT like 'e%';


-- #####################
-- #7. Find all unique last names that start and end with 'E'.
select distinct last_name
from employees
where last_name like 'e%e';


-- #####################
-- #8. Find all current or previous employees hired in the 90s. 
-- Enter a comment with top three employee numbers.
-- Answer: 10008, 10011, 10012
select *
from employees
where hire_date like '199%';

-- another way to do this:
select *
from employees
where hire_date between '1990-01-01' and '1999-12-31';


-- #####################
-- #9. Find all current or previous employees born on Christmas. 
-- Enter a comment with top three employee numbers.
-- Answer: 10078, 10115, 10261
select *
from employees
where birth_date like '%12-25';


-- #####################
-- #10. Find all current or previous employees hired in the 90s and born on Christmas. 
-- Enter a comment with top three employee numbers.
-- Answer: 10261, 10438, 10681
select *
from employees
where hire_date like '199%'
and birth_date like '%12-25';


-- #####################
-- #11. Find all unique last names that have a 'q' in their last name.
select distinct last_name
from employees
where last_name like '%q%';


-- #####################
-- #12. Find all unique last names that have a 'q' in their last name but not 'qu'.
select distinct last_name
from employees
where last_name like '%q%'
and last_name not like '%qu%';