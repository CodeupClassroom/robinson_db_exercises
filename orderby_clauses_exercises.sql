-- ORDER BY Exercises


-- ###########################
-- #2 Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name.  
-- What was the first and last name in the first row of the results? (Answer: Irene Reutenauer)
-- What was the first and last name of the last person in the table? (Answer: Vidya Simmen)


select * 
from employees
where first_name in ('Irena', 'Vidya','Maya')
order by first_name;

select * 
from employees
where first_name in ('Irena', 'Vidya','Maya')
order by first_name
limit 1 offset 708;


-- ###########################
-- #3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. 
-- What was the first and last name in the first row of the results? (Answer: Irena Acton
-- What was the first and last name of the last person in the table? (Answer:Vidya Zweizig)

select * 
from employees
where first_name in ('Irena', 'Vidya','Maya')
order by first_name, last_name;

select * 
from employees
where first_name in ('Irena', 'Vidya','Maya')
order by first_name, last_name
limit 1 offset 708;


-- ###########################
-- #4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. 
-- What was the first and last name in the first row of the results? (Answer: Irena Acton)
-- What was the first and last name of the last person in the table? (Answer: Maya Zyda)

select * 
from employees
where first_name in ('Irena', 'Vidya','Maya')
order by last_name, first_name;

select * 
from employees
where first_name in ('Irena', 'Vidya','Maya')
order by last_name, first_name
limit 1 offset 708;


-- ###########################
-- #5. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. 
-- Enter a comment with the number of employees returned (Answer: 899)
-- the first employee number and their first and last name (Answer: 10021- Ramzi Erde )
-- and the last employee number with their first and last name (Answer: Tadahiro Erde)

select *
from employees
where last_name like 'e%e'
order by emp_no;

select *
from employees
where last_name like 'e%e'
order by emp_no
limit 1 offset 898;

-- ###########################
-- #6. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. 
-- Enter a comment with the number of employees returned (Answer: 899)
-- the name of the newest employee (Answer: Teiji Eldridge)
-- the name of the oldest employee (Answer: Sergi Erde)

select *
from employees
where last_name like 'e%e'
order by hire_date DESC;

select *
from employees
where last_name like 'e%e'
order by hire_date DESC
limit 1 offset 898;


-- ###########################
-- #7. Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. 
-- the number of employees returned (Answer: 362)
-- the name of the oldest employee who was hired last (Answer: Khun Berini) 
-- the name of the youngest employee who was hired first. (Answer: Douadi Pettis) 

select *
from employees
where birth_date like '%12-25'
and hire_date like '199%'
order by birth_date, hire_date DESC;

select *
from employees
where birth_date like '%12-25'
and hire_date like '199%'
order by birth_date;

