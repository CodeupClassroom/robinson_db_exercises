SELECT * FROM albums_db.albums;
SELECT artist, MAX(sales), COUNT(*) FROM albums_db.albums GROUP BY artist;

-- OVER is used for window functions (look up for extra SQL knowledge :)
-- SELECT artist, MAX(sales) OVER( PARTITION BY artist) FROM albums_db.albums;


--     Create a new file named group_by_exercises.sql
USE employees;
--     In your script, use DISTINCT to find the unique 
--     titles in the titles table. How many unique titles 
--     have there ever been? Answer that in a comment in 
--     your SQL file.
DESCRIBE titles;

-- get the unique values of title:
SELECT DISTINCT title FROM titles;

-- get the number of unique historical titles:
SELECT COUNT(DISTINCT title) FROM titles;

--     Write a query to find a list of all unique last 
--     names that start and end with 'E' using GROUP BY.
-- last names:

-- Using DISTINCT:
-- SELECT DISTINCT last_name
-- -- from the employees table
-- FROM employees
-- WHERE last_name LIKE 'e%e';

-- USING GROUPBY:
SELECT last_name
-- from the employees table
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name;

--     Write a query to to find all unique combinations 
--     of first and last names of all employees whose 
--     last names start and end with 'E'.

-- grab first name, last name, glue them together
SELECT 
	CONCAT(
		first_name,
        ' ',
		last_name)
        AS full_name
FROM
employees
-- establish that we are only getting last names that meet
-- the 'e%e' distinction
WHERE last_name LIKE 'e%e'
-- narrow down to unique instances
GROUP BY full_name;

--     Write a query to find the unique last names
--     with a 'q' but not 'qu'. Include those names 
--     in a comment in your sql code.
SELECT last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

--     Add a COUNT() to your results for exercise 
--     5 to find the number of employees with the 
--     same last name.

SELECT last_name,
COUNT(*)
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

--     Find all employees with first names 'Irena', 
--     'Vidya', or 'Maya'. Use COUNT(*) and GROUP 
--     BY to find the number of employees with those 
--     names for each gender.
SELECT first_name,
gender,
COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender;


--     Using your query that generates a username for all 
--     employees, generate a count of employees with 
--     each unique username.

WITH dup_users AS (
SELECT
LOWER(
CONCAT(
-- first letter first name:
SUBSTR(first_name, 1, 1),
-- first 4 last name:
SUBSTR(last_name, 1, 4),
-- underscore: 
'_',
-- month of birth date:
SUBSTR(birth_date, 6, 2),
-- year of birth date:
SUBSTR(birth_date, 3, 2)
)
)
AS username,
COUNT(*) AS dup_count
FROM
employees
GROUP BY username
ORDER BY dup_count DESC)
SELECT SUM(dup_count) FROM dup_users
;

--     From your previous query, are there any 
--     duplicate usernames? What is the highest 
--     number of times a username shows up? 
--     Bonus: How many duplicate usernames are there?

-- Bonus: More practice with aggregate functions:

--     Determine the historic average salary 
--     for each employee. When you hear, read, or
--     think "for each" with regard to SQL, 
--     you'll probably be grouping by that exact column.
SELECT * FROM salaries LIMIT 5;
SELECT emp_no, AVG(salary) FROM salaries GROUP BY emp_no;

--     Using the dept_emp table, count how 
--     many current employees work in each department. 
--     The query result should show 9 rows, 
--     one for each department and the employee count.
SELECT * FROM dept_emp LIMIT 2;
SELECT dept_no, COUNT(*) FROM dept_emp WHERE to_date > NOW() GROUP BY dept_no;

--     Determine how many different salaries 
--     each employee has had. This includes both 
--     historic and current.
SELECT emp_no, COUNT(*) FROM salaries GROUP BY emp_no;

--     Find the maximum salary for each employee.
SELECT emp_no, MAX(salary) FROM salaries GROUP BY emp_no;
--     Find the minimum salary for each employee.
SELECT emp_no, MAX(salary), MIN(salary) FROM salaries GROUP BY emp_no;

--     Find the standard deviation of salaries 
--     for each employee.
SELECT emp_no, MAX(salary), MIN(salary), STDDEV(salary) FROM salaries GROUP BY emp_no;

--     Find the max salary for each employee where 
--     that max salary is greater than $150,000.
SELECT emp_no, MAX(salary) FROM salaries GROUP BY emp_no HAVING MAX(salary) > 150000;

--     Find the average salary for each employee 
--     where that average salary is between $80k and $90k.
SELECT emp_no, AVG(salary) AS avg_sal
FROM salaries
GROUP BY emp_no
HAVING avg_sal BETWEEN 80000 AND 90000;