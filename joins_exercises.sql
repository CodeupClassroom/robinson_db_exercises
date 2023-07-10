-- Use the employees database.
USE employees;
-- Using the example in the Associative Table Joins 
-- section as a guide, write a query that shows each 
-- department along with the name of the current manager 
-- for that department.
-- What we want to grab here:
SELECT * FROM departments LIMIT 2;
-- Department Name (departments)
SELECT * FROM dept_manager LIMIT 2;
-- Department Manager (dept_manager)
-- We want the names of those dept managers,
-- So we will join in employees

SELECT 
	dept_name,
	CONCAT(first_name, ' ', last_name) AS manager_name
FROM 
	departments AS d
JOIN 
	dept_manager AS dm
    ON d.dept_no = dm.dept_no
    AND dm.to_date > NOW()-- dm.to_date LIKE '999%'
JOIN 
	employees AS e
    ON e.emp_no = dm.emp_no
ORDER BY dept_name;
	
    
SELECT 
-- fields we want: dept name, name of manager
	dept_name,
	CONCAT(first_name, ' ', last_name) AS manager_name
FROM 
-- deparments gives us the name of the dept
	departments AS d
JOIN 
-- dept manager gives us the emp_id codes and the dept codes
	dept_manager AS dm
    USING (dept_no) -- dm.to_date LIKE '999%'
-- employees gives us the names
JOIN 
	employees AS e
    USING (emp_no)
-- specifcally current managers
WHERE dm.to_date > NOW()
-- alphabetize the results
ORDER BY dept_name;

--   Department Name    | Department Manager
--  --------------------+--------------------
--   Customer Service   | Yuchang Weedman
--   Development        | Leon DasSarma
--   Finance            | Isamu Legleitner
--   Human Resources    | Karsten Sigstam
--   Marketing          | Vishwani Minakawa
--   Production         | Oscar Ghazalie
--   Quality Management | Dung Pesch
--   Research           | Hilary Kambil
--   Sales              | Hauke Zhang

-- Find the name of all departments currently 
-- managed by women.
SELECT 
-- fields we want: dept name, name of manager
	dept_name,
	CONCAT(first_name, ' ', last_name) AS manager_name
FROM 
-- deparments gives us the name of the dept
	departments AS d
JOIN 
-- dept manager gives us the emp_id codes and the dept codes
	dept_manager AS dm
    USING (dept_no) -- dm.to_date LIKE '999%'
-- employees gives us the names
JOIN 
	employees AS e
    USING (emp_no)
-- specifcally current managers
WHERE 
	dm.to_date > NOW()
    AND
    e.gender = 'F'
-- alphabetize the results
ORDER BY dept_name;

-- Department Name | Manager Name
-- ----------------+-----------------
-- Development     | Leon DasSarma
-- Finance         | Isamu Legleitner
-- Human Resources | Karsetn Sigstam
-- Research        | Hilary Kambil

-- Find the current titles of employees 
-- currently working in the Customer Service 
-- department.
-- titles
-- all of them in customer service, which is a dept

SELECT 
	title,
    COUNT(*) AS count
FROM 
	titles t
JOIN 
	dept_emp de
	USING (emp_no)
JOIN 
	departments d
	USING (dept_no)
WHERE 
	dept_name = 'Customer Service'
	AND 
    de.to_date > NOW()
    AND
    t.to_date > NOW()
GROUP BY title
ORDER BY title;

-- Title              | Count
-- -------------------+------
-- Assistant Engineer |    68
-- Engineer           |   627
-- Manager            |     1
-- Senior Engineer    |  1790
-- Senior Staff       | 11268
-- Staff              |  3574
-- Technique Leader   |   241

-- Find the current salary of all current managers.

-- salary value: salaries table, emp_no
-- managers emp_nos are in the dept_manager table
-- department names are in the departments table
-- employees has the name of the dept_managers

SELECT
	dept_name,
    CONCAT(first_name, ' ' , last_name) manager_name,
    salary
FROM
	departments d
JOIN dept_manager dm 
	USING(dept_no)
JOIN salaries s
	USING(emp_no)
JOIN employees e
	USING(emp_no)
WHERE 
	s.to_date > NOW()
    AND
    dm.to_date > NOW()
ORDER BY dept_name;


-- Department Name    | Name              | Salary
-- -------------------+-------------------+-------
-- Customer Service   | Yuchang Weedman   |  58745
-- Development        | Leon DasSarma     |  74510
-- Finance            | Isamu Legleitner  |  83457
-- Human Resources    | Karsten Sigstam   |  65400
-- Marketing          | Vishwani Minakawa | 106491
-- Production         | Oscar Ghazalie    |  56654
-- Quality Management | Dung Pesch        |  72876
-- Research           | Hilary Kambil     |  79393
-- Sales              | Hauke Zhang       | 101987

-- Find the number of current employees
--  in each department.

-- dept_no, dept_name, num_employees

SELECT 
	-- specify which table's department number you want
	d.dept_no,
	-- dept_name comes from department table
    dept_name,
    -- its arbitrary what we count, so we count all *
    COUNT(*) AS num_employees
FROM 
	-- first left table departments
	departments AS d
JOIN dept_emp AS de
	-- link using department number
	USING(dept_no)
WHERE
	-- current employees
	de.to_date > NOW()
-- aggregation only needed on number OR name, since they 
-- are one-to-one
GROUP BY dept_name
-- order for the output to mirror
ORDER BY dept_no;

-- +---------+--------------------+---------------+
-- | dept_no | dept_name          | num_employees |
-- +---------+--------------------+---------------+
-- | d001    | Marketing          | 14842         |
-- | d002    | Finance            | 12437         |
-- | d003    | Human Resources    | 12898         |
-- | d004    | Production         | 53304         |
-- | d005    | Development        | 61386         |
-- | d006    | Quality Management | 14546         |
-- | d007    | Sales              | 37701         |
-- | d008    | Research           | 15441         |
-- | d009    | Customer Service   | 17569         |
-- +---------+--------------------+---------------+

-- Which department has the highest average salary? 
-- Hint: Use current not historic information.
SELECT
	dept_name,
	AVG(salary) AS average_salary
FROM 
	departments AS d
JOIN dept_emp AS de
	USING (dept_no)
JOIN salaries AS s
	USING (emp_no)
WHERE
	de.to_date > NOW()
    AND
    s.to_date > NOW()
-- Cant do this without a subquery; To be continued
--    AND average_salary = MAX(average_salary)
GROUP BY dept_name
ORDER BY average_salary DESC
LIMIT 1;


-- +-----------+----------------+
-- | dept_name | average_salary |
-- +-----------+----------------+
-- | Sales     | 88852.9695     |
-- +-----------+----------------+

-- Who is the highest paid employee in the 
-- Marketing department?
-- links/map:
-- employees name is in employees
-- emp_no is in employees as well as as salaries
-- emp_no is in salaries as well as dept_emp
-- department name is in dept_emp as well as departments

SELECT
	first_name,
    last_name
FROM
	employees e
JOIN salaries s
	USING(emp_no)
JOIN dept_emp de
	USING (emp_no)
JOIN departments d
	USING (dept_no)
WHERE
	de.to_date > NOW()
    AND
    s.to_date > NOW()
    AND
    dept_name = 'Marketing'
ORDER BY salary DESC
LIMIT 1;


-- +------------+-----------+
-- | first_name | last_name |
-- +------------+-----------+
-- | Akemi      | Warwick   |
-- +------------+-----------+

-- Which current department manager has the 
-- highest salary?
SELECT
	first_name,
    last_name,
    -- employees table
    salary,
    -- salaries table
    dept_name
    -- departments
FROM 
	departments d
JOIN dept_manager dm
	USING (dept_no)
JOIN salaries s
	USING (emp_no)
JOIN employees e
	USING (emp_no)
WHERE
	s.to_date > NOW()
    AND
    dm.to_date > NOW()
ORDER BY salary DESC
LIMIT 1;
    
    


-- +------------+-----------+--------+-----------+
-- | first_name | last_name | salary | dept_name |
-- +------------+-----------+--------+-----------+
-- | Vishwani   | Minakawa  | 106491 | Marketing |
-- +------------+-----------+--------+-----------+

-- Determine the average salary for each department. 
-- Use all salary information and round your results.
-- SELECT ROUND(29.4598724985, 3);

SELECT 
	dept_name,
    ROUND(AVG(salary), 0) AS average_salary
FROM
	departments AS d
JOIN dept_emp AS de
	USING(dept_no)
JOIN salaries AS s
	USING(emp_no)
GROUP BY dept_name
ORDER BY average_salary DESC;

-- +--------------------+----------------+
-- | dept_name          | average_salary | 
-- +--------------------+----------------+
-- | Sales              | 80668          | 
-- +--------------------+----------------+
-- | Marketing          | 71913          |
-- +--------------------+----------------+
-- | Finance            | 70489          |
-- +--------------------+----------------+
-- | Research           | 59665          |
-- +--------------------+----------------+
-- | Production         | 59605          |
-- +--------------------+----------------+
-- | Development        | 59479          |
-- +--------------------+----------------+
-- | Customer Service   | 58770          |
-- +--------------------+----------------+
-- | Quality Management | 57251          |
-- +--------------------+----------------+
-- | Human Resources    | 55575          |
-- +--------------------+----------------+

-- Bonus Find the names of all current employees, their department name, and their current manager's name.

-- 240,124 Rows

-- Employee Name | Department Name  |  Manager Name
-- --------------|------------------|-----------------
--  Huan Lortz   | Customer Service | Yuchang Weedman
