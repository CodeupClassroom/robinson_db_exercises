##########################################
-- CASE STATEMENT EXERCISES
##########################################

use employees;

show tables;


##########################################
##########################################

-- #1. Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.

-- using 'if function'
select emp_no, dept_no, from_date as start_date, to_date as end_date,
if (to_date > now(), 1, 0) as is_current_employee
from dept_emp;

-- using 'case statement'
SELECT emp_no, dept_no, from_date as start_date, to_date as end_date,
	CASE to_date
		WHEN '9999-01-01' THEN 1
		ELSE 0
		END AS is_current_employee
FROM dept_emp;


##########################################

-- #2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

-- Break it down:
-- How do we get the first letter of a name?
select last_name, substr(last_name, 1,1)
from employees;

-- Now, using a case and between keyword
select last_name,
	case 
		 when last_name between 'a' and 'i%' then 'a_h'
		when last_name between 'i' and 'r%' then 'i_q'
		when last_name between 'r' and 'zz%' then 'r_z'
	else 'other'
	end as alpha_group
from employees;

-- OR 
-- using case and substr
 SELECT last_name,
 	CASE
 		WHEN substr(last_name, 1,1) BETWEEN 'a' AND 'h' THEN 'A_H_last_name'
 		WHEN substr(last_name, 1,1) BETWEEN 'i'AND 'q' THEN 'I_Q_last_name'
 		WHEN substr(last_name, 1,1) BETWEEN 'r' AND 'z' THEN 'R-Z_last_name'
 		ELSE 'other'
 		END AS alpha_group
 	FROM employees;

-- OR
-- using <= operators
SELECT
    first_name,
    last_name,
    CASE
        WHEN LEFT(last_name, 1) <= 'H' THEN 'A-H'
        WHEN SUBSTR(last_name, 1, 1) <= 'Q' THEN 'I-Q'
        WHEN LEFT(last_name, 1) <= 'Z' THEN 'R-Z'
    END AS alpha_group
FROM employees;


##########################################

-- 3. How many employees (current or previous) were born in each decade?

-- First, let's see what range we are working with.. how many decades?
select min(birth_date), max(birth_date)
from employees;

-- We only have two decades so we can use a case with when/else
select count(*) AS count_per_decade,
	case
		when birth_date like '195%' then 'born_in_50s'
        else 'born_in_60s'
	end as birth_decade
from employees
group by birth_decade;

-- OR

CASE
 		WHEN birth_date BETWEEN '1950-01-01' AND '1959-12-31' THEN 'born_in_1950s'
 		WHEN birth_date BETWEEN '1960-01-01' AND '1969-12-31' THEN 'born_in_1960s'
 		ELSE 'other'
 		END AS employees_born_per_decade,
 	count(*) AS count_per_decade
 	FROM employees
 	GROUP BY employees_born_per_decade
 	ORDER BY count_per_decade;


##########################################

-- 4. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

select
    round(avg(salary),2) as avg_salary,
  case 
		when dept_name IN ('research','development') then 'R&D'
        when dept_name IN ('sales','marketing') then 'Sales & Marketing'
        when dept_name IN ('Production', 'Quality Management') then 'Prod & QM'
        when dept_name IN ('Finance', 'human resources') then 'Finance & HR'
        else dept_name
end as dept_group
from departments
join dept_emp using (dept_no)
join salaries using (emp_no)
where salaries.to_date > now() and dept_emp.to_date>now()
group by dept_group;

-- OR

SELECT AVG(salary) AS average_salary,
        CASE 
            WHEN dept_name IN ('research', 'development') THEN 'R&D'
            WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
            WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
            WHEN dept_name IN ('Customer Service') THEN 'Customer Service' 
            WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
            ELSE dept_name
            END AS dept_group
FROM departments
    JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
    JOIN employees ON dept_emp.emp_no = employees.emp_no
    JOIN salaries ON employees.emp_no = salaries.emp_no
GROUP BY dept_name
ORDER BY average_salary DESC;
