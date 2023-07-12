--  Using the example from the lesson, create a
--  temporary table called employees_with_departments 
-- that contains first_name, last_name, and dept_name 
-- for employees currently with that department. Be 
-- absolutely sure to create this table on your own 
-- database. If you see "Access denied for user ...", 
-- it means that the query was attempting to write a 
-- new table to a database that you can only read.
USE ada_674;
-- build out the query like usual
SELECT
	first_name,
    last_name,
    dept_name
FROM
	employees.employees
-- we want employeees to departments
-- our link between those as a joiner table is dept_emp
JOIN employees.dept_emp
USING (emp_no)
JOIN employees.departments 
USING (dept_no)
-- under the condition that the emp works for that dept rn
WHERE to_date > NOW();


CREATE TEMPORARY TABLE employees_with_departments AS (
SELECT
	first_name,
    last_name,
    dept_name
FROM
	employees.employees
JOIN employees.dept_emp
	USING (emp_no)
JOIN employees.departments 
	USING (dept_no)
WHERE to_date > NOW()
) ;

-- peek to make sure again
SELECT * FROM employees_with_departments LIMIT 3;

--  Add a column named full_name to this table. 
-- ask: make a new field
-- this is a structrual change
-- which means we need an ALTER
-- ALTER table employees_with_departments
-- ADD full_name; -- lets figure out what number to put in my varchar



-- It should be a VARCHAR whose length is the sum 
-- of the lengths of the first name and last name columns.
-- length is a function we can use to check string lengths
SELECT LENGTH('ham sandwich');

SELECT MAX(
	LENGTH(
		CONCAT(
			first_name, ' ', last_name)
)
) FROM employees_with_departments;
-- max value is 30. lets go with that.
DESCRIBE employees_with_departments;

-- for real this time:
ALTER table employees_with_departments
ADD full_name VARCHAR(30);

-- new field is blank, will need to be filled via UPDATE
UPDATE employees_with_departments
SET full_name = 
	CONCAT(
		first_name, 
        ' ',
        last_name
    );
SELECT * FROM employees_with_departments;


-- Update the table so that the full_name column contains 
-- the correct data.

-- Remove the first_name and last_name columns from 
-- the table.
-- DROP is a structural change
ALTER TABLE employees_with_departments
DROP COLUMN last_name,
DROP COLUMN first_name;

SELECT * FROM employees_with_departments LIMIT 4;

-- What is another way you could have ended up with 
-- this same table?
CREATE TEMPORARY TABLE employees_with_departments AS (
SELECT
	CONCAT(
		first_name, 
        ' ',
		last_name) AS full_name,
    dept_name
FROM
	employees.employees
JOIN employees.dept_emp
	USING (emp_no)
JOIN employees.departments 
	USING (dept_no)
WHERE to_date > NOW()
) ;

--     Create a temporary table based on the 
-- payment table from the sakila database.
-- test out an initial query:
CREATE TEMPORARY TABLE sak_pay AS (
	SELECT * FROM sakila.payment);

--     Write the SQL necessary to transform the amount 
-- column such that it is stored as an integer 
-- representing the number of cents of the payment. 
-- For example, 1.99 should become 199.
-- thing * 100 = new thing
-- easy, yes I know this math

-- This dont work tho
-- UPDATE sak_pay
-- SET amount = amount * 100;

DESCRIBE sak_pay;
-- I have a limitation here with decimal(5,2)
-- so we need to change the data type before we update

ALTER TABLE sak_pay
MODIFY amount DECIMAL(10,2);

UPDATE sak_pay
SET amount = amount * 100;

-- round the value from amount
UPDATE sak_pay
SET amount = ROUND(amount);

-- change it to an int now
ALTER TABLE sak_pay
MODIFY amount INT UNSIGNED;

DESCRIBE sak_pay;
SELECT amount FROM sak_pay LIMIT 2;

-- alternatively, change it in your select statement

CREATE TEMPORARY TABLE sak_pay2 AS(
SELECT
	CAST(ROUND(amount * 100) AS UNSIGNED)
FROM sakila.payment);

DESCRIBE sak_pay2;

--     Go back to the employees database. 
-- Find out how the current average pay in each 
-- department compares to the overall current pay 
-- for everyone at the company. For this comparison, 
-- you will calculate the z-score for each salary. 
-- In terms of salary, what is the best department 
-- right now to work for? The worst?

-- departments average salary - overall average salary
-- /
-- stdev of all salaries

-- lets get the stuff we need:

-- The stuff we need is two-fold:

-- 1. departments and their average salary

-- 2. the average and stdev of all salaries

-- thing 1:
-- build a query that gets my departments and avg sals
SELECT 
	-- just dept names and avg salaries
	dept_name,
    AVG(salary) AS dept_avg
FROM 
	-- departments from employees schema
	employees.departments d
JOIN employees.dept_emp de
	-- link dept_no to dept_emp
	USING(dept_no)
JOIN employees.salaries s
	-- link emp_no to salaries
	USING(emp_no)
WHERE 
	-- current employees salaries in active departments
	de.to_date > NOW()
	AND 
    s.to_date > NOW()
-- aggregate based on department
GROUP BY dept_name;

CREATE TEMPORARY TABLE dept_avgs (
SELECT 
	dept_name,
    AVG(salary) AS dept_avg
FROM 
	employees.departments d
JOIN employees.dept_emp de
	USING(dept_no)
JOIN employees.salaries s
	USING(emp_no)
WHERE 
	de.to_date > NOW()
	AND 
    s.to_date > NOW()
GROUP BY dept_name);

-- thing 2:
-- get the metrics that I want to compare these vals with
-- avg overall salary
-- stddev overall salary

DROP TABLE IF EXISTS metrics;


-- build the query that gets those things:
CREATE TEMPORARY TABLE metrics (
SELECT
	AVG(salary) AS overall,
    STDDEV(salary) AS stdv
FROM 
	employees.salaries s
WHERE to_date > NOW());

-- lets add some new fields into our department
--  average table

-- adding new fields, thats a strutural change
-- which means that we want to use an alter

-- mean values:
ALTER TABLE dept_avgs
ADD overall_avg FLOAT;

-- stdev values
ALTER TABLE dept_avgs
ADD overall_std FLOAT;

-- z values
ALTER TABLE dept_avgs
ADD zscore FLOAT;

SELECT * FROM dept_avgs;

-- put values in cells that are already there:
-- UPDATE!
UPDATE dept_avgs
SET overall_avg = 
	(
    SELECT overall FROM metrics
    );
    
SELECT * FROM dept_avgs;

UPDATE dept_avgs
SET overall_std = 
	(
    SELECT stdv FROM metrics
    );

SELECT * FROM dept_avgs;

UPDATE dept_avgs
SET zscore = 
(dept_avg - overall_avg) / overall_std;

SELECT dept_name, zscore FROM dept_avgs
ORDER BY zscore DESC;



-- Not using temp tables:
WITH depts AS (
	SELECT 
		dept_name,
		AVG(salary) AS dept_avg
	FROM 
		employees.departments d
	JOIN employees.dept_emp de
		USING(dept_no)
	JOIN employees.salaries s
		USING(emp_no)
	WHERE 
		de.to_date > NOW()
		AND 
		s.to_date > NOW()
	GROUP BY dept_name)
SELECT 
	dept_name,
    dept_avg,
    -- x - mu / o 
    (dept_avg - (
		SELECT AVG(salary) 
        FROM employees.salaries s
        WHERE s.to_date > NOW()))
        /
        (SELECT STDDEV(salary) 
        FROM employees.salaries s
        WHERE s.to_date > NOW()) 
        AS z_score
FROM depts;