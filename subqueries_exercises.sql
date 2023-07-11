USE employees;

-- Find all the current employees with the 
-- same hire date as employee 101010 using a subquery.
-- A specific thing we want to reference (scalar):
-- the date of hire for employee 101010
-- Defining our inner query:
SELECT 
	hire_date
FROM employees
WHERE emp_no = 101010;

-- select everything from employees
-- link to dept_emp for current employees with join
SELECT 
	*
FROM
	employees e
JOIN dept_emp de
	ON de.emp_no = e.emp_no
	AND de.to_date > NOW()
WHERE
	hire_date = (
		-- inner query outputs a single date
		SELECT 
			hire_date
		FROM 
			employees
		WHERE 
			emp_no = 101010
            )
;


-- tactic 2:
-- grab emp_nos of current employees as another inner query
SELECT emp_no FROM dept_emp WHERE to_date > NOW();


SELECT 
	*
FROM
	employees e
-- JOIN dept_emp de
-- 	ON de.emp_no = e.emp_no
-- 	AND de.to_date > NOW()
WHERE
	emp_no IN (
		SELECT 
			emp_no 
		FROM 
			dept_emp 
		WHERE 
			to_date > NOW()
        )
AND
	hire_date = (
		-- inner query outputs a single date
		SELECT 
			hire_date
		FROM 
			employees
		WHERE 
			emp_no = 101010
            )
;
-- Find all the titles ever held by all current 
-- employees with the first name Aamod.

-- Outer query: titles
SELECT * FROM titles LIMIT 2;

-- inner query: current employees named Aamod
-- inner query:
SELECT 
	e.emp_no
FROM
	employees e
JOIN dept_emp de
	ON de.emp_no = e.emp_no
	AND de.to_date > NOW()
WHERE first_name = 'Aamod';

-- Outer query:
SELECT 
	title,
    COUNT(*)
FROM 
	titles
WHERE 
	emp_no IN (
		SELECT 
			e.emp_no
		FROM
			employees e
		JOIN dept_emp de
			ON de.emp_no = e.emp_no
			AND de.to_date > NOW()
		WHERE first_name = 'Aamod'
    )
GROUP BY title;
    
-- How many people in the employees table 
-- are no longer working for the company? 
-- Give the answer in a comment in your code.
SELECT COUNT(*) FROM dept_emp WHERE to_date < NOW();

SELECT 
	COUNT(*)
FROM 
	employees e
WHERE emp_no
NOT IN (
	-- inner query:
    SELECT emp_no FROM dept_emp
    WHERE to_date > NOW()
    );
    
    
SELECT emp_no FROM dept_emp WHERE to_date < NOW();

-- Find all the current department managers 
-- that are female. List their names in a comment 
-- in your code.

-- Outer Query:
-- grabbing the names of employees, which means employees table
-- under the condition:
-- Inner query:
-- current employee managers
SELECT 
	emp_no
FROM 
	dept_manager
WHERE 
	to_date > NOW();
-- finishing with outer query:
SELECT 
	first_name,
    last_name
FROM
	employees
WHERE
	gender = 'F'
AND
	emp_no IN
    (
		-- inner query:
		-- current emp managers
        SELECT 
			emp_no
		FROM 
			dept_manager
		WHERE 
			to_date > NOW()
    );

-- Find all the employees who currently have 
-- a higher salary than the companies overall, 
-- historical average salary.
-- inner query:
-- alllllll salaries average
SELECT 
	AVG(salary)
FROM salaries;
-- outer query:
-- all current employees that currently have a higher
-- wage than the thing we just defined above
SELECT
	COUNT(*)
FROM 
	employees e
JOIN dept_emp de
	USING (emp_no)
JOIN salaries s
	USING (emp_no)
WHERE
	de.to_date > NOW()
    AND
    s.to_date > NOW()
	AND
    salary > 
    (
		SELECT 
		AVG(salary)
		FROM salaries
	);
    
-- How many current salaries are within 1 standard 
-- deviation of the current highest salary? 
-- (Hint: you can use a built in function to calculate 
-- the standard deviation.) 
-- I want to grab a couple things here:
-- stddev of salaries
-- max of salaries
SELECT MAX(salary), STDDEV(salary)
FROM salaries s
WHERE s.to_date > NOW();

SELECT MAX(salary) - STDDEV(salary) one_dev
FROM salaries s
WHERE s.to_date > NOW();


-- all current salaries
SELECT 
	COUNT(*)
FROM salaries
WHERE salaries.to_date > NOW()
AND salary >= (
	SELECT MAX(salary) - STDDEV(salary) one_dev
	FROM salaries s
	WHERE s.to_date > NOW()
	);
  
-- define first CTE as cur_sals, current salaries
WITH cur_sals AS (
SELECT salary
FROM salaries
WHERE salaries.to_date > NOW())
-- separate with a comma
,
-- second CTE as metrics
metrics AS (
-- metrics grabs max salary and std salary
-- for current salaries
SELECT MAX(salary) max_sal, STDDEV(salary) one_dev
FROM salaries s
WHERE s.to_date > NOW()
)
-- outer query:
-- grab the count from the current salaries
SELECT COUNT(*)
FROM cur_sals
-- under the specific condition
WHERE cur_sals.salary 
-- that the salaries are between
-- inner query 1: max - stddev (from metrics)
-- inner query 2: max (from metrics)
BETWEEN 
	(SELECT max_sal - one_dev FROM metrics) 
    AND 
	(SELECT max_sal FROM metrics);





-- What percentage of all salaries 
-- is this?

SELECT 
	COUNT(*)
FROM salaries
WHERE salaries.to_date > NOW()
AND salary >= (
	SELECT MAX(salary) - STDDEV(salary) one_dev
	FROM salaries s
	WHERE s.to_date > NOW()
	);
    
SELECT 1 + 1;
SELECT 4 / 5;
-- SELECT (numerator) / (denominator);
SELECT 
	ROUND(
	(
		SELECT 
			COUNT(*)
		FROM salaries
		WHERE salaries.to_date > NOW()
		AND salary >= (
			SELECT 
				MAX(salary) - STDDEV(salary) one_dev
			FROM 
				salaries s
			WHERE s.to_date > NOW()
	)
    )
/
	(
		SELECT 
			COUNT(*)
		FROM 
			salaries
		WHERE
			salaries.to_date > NOW()
    ) 
* 100, 2);
-- Hint You will likely use multiple subqueries 
-- in a variety of ways
-- Hint It's a good practice to write out all of 
-- the small queries that you can. 
-- Add a comment above the query showing the number 
-- of rows returned. You will use this number (or the query that produced it) in other, larger queries.

-- BONUS

--     Find all the department names that currently have female managers.
--     Find the first and last name of the employee with the highest salary.

--     Find the department name that the employee with the highest salary works in.

-- Who is the highest paid employee within each 
-- department.

-- lens #1 salaries

-- lens #2: departments
SELECT 
	d.dept_name,
    d.dept_no,
    MAX(s.salary)
FROM salaries s
JOIN dept_emp de
ON de.emp_no = s.emp_no
AND s.to_date > NOW()
AND de.to_date > NOW()
JOIN departments d
USING (dept_no)
GROUP BY dept_name;

SELECT 
	e.first_name, 
    e.last_name,
    de.dept_no,
    s.salary
FROM 
	employees e
JOIN dept_emp de
	USING(emp_no)
JOIN salaries s
	USING(emp_no)
WHERE 
	de.to_date > NOW()
AND
	s.to_date > NOW();
    
-- link these two queries to eachother
WITH dept_names AS
	(
	SELECT 
		d.dept_name,
		d.dept_no,
		MAX(s.salary) AS maxsal
	FROM salaries s
	JOIN dept_emp de
		ON de.emp_no = s.emp_no
		AND s.to_date > NOW()
		AND de.to_date > NOW()
	JOIN departments d
		USING (dept_no)
	GROUP BY dept_name
	),
emp_info AS (
	SELECT 
		e.first_name, 
		e.last_name,
		de.dept_no,
		s.salary
	FROM 
		employees e
	JOIN dept_emp de
		USING(emp_no)
	JOIN salaries s
		USING(emp_no)
	WHERE 
		de.to_date > NOW()
	AND
		s.to_date > NOW()
)
SELECT 
	emp_info.first_name,
    emp_info.last_name,
    dept_names.dept_name
FROM 
	dept_names
LEFT JOIN emp_info
ON emp_info.salary = dept_names.maxsal
AND emp_info.dept_no = dept_names.dept_no;



SELECT first_name, last_name







