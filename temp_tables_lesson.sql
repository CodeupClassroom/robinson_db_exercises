/*

Temporary Tables

*/

-- Temporary tables 
-- are tables that exist for a present session
-- and then otherwise poof out of existence

-- for a level of more permanancy than this,
-- look into the concept of VIEWS

-- You presently do not have access rights to create
-- a temp table in most schemas in our server
CREATE TEMPORARY TABLE new_fake_table;

-- You can check where you are with SELECT DATABASES()
SELECT DATABASE();

-- IF you look at all available schema,
-- you should see one with your username
-- robinson_XXXX insstead of ada_XXXX
SHOW DATABASES;

-- I'm using my sandbox with my student account
USE ada_674;

-- If we show tables, we note that there is nothing here
SHOW TABLES;

-- so why is it useful?
-- short answer:
-- we can create temp tables here
-- both from scratch and from queries via other schemas

-- We use dot notation to pull from another scehma
-- Just the same way that you would typically do
-- if you were using absolute paths for files in CLI
SELECT * FROM employees.employees LIMIT 5;


CREATE TEMPORARY TABLE new_fake_table
AS (SELECT * FROM employees.employees LIMIT 5);

SELECT * FROM new_fake_table;

SHOW TABLES;

SELECT * FROM new_fake_table;

-- Lets create a brand new temp table
-- not from a query but from defined information

-- remember sql did not like the idea of 
-- creating a temp table with just a name
-- and nothing else -- we need to provide what goes inside
CREATE TEMPORARY TABLE my_nums (
	n INT UNSIGNED NOT NULL,
    name VARCHAR(25) NOT NULL);
    
-- lets take a peek at it:
DESCRIBE my_nums;

SELECT * FROM my_nums;

-- How do I put stuff in there?
-- INSERT
INSERT INTO my_nums(n, name) 
VALUES (1, 'class'), (2, 'robinson');

-- check back at what we did:
SELECT * FROM my_nums;

-- We defined both fields as non null so we cant create
-- a row of information without filling both out:
-- '3' is OK
INSERT INTO my_nums(n, name)
VALUES ('3', 'ham'), (4, 'sandwich');

-- 16hello is not ok
INSERT INTO my_nums(n, name)
VALUES ('16hello', 'ham'), (25, 'sandwiches');

-- peek back at what we did:

SELECT * FROM my_nums;

-- Changing the table:
-- Change can mean a few different things!

-- UPDATE!
-- UPDATE will change information that exists in your cells

-- change the value of our name field
-- lets add a word to it
UPDATE my_nums
SET name = CONCAT('Hello, ', name);

-- looking at what we did:
SELECT * FROM my_nums;

-- We can essentially put any operative change inside of 
-- the set assignment that works as per usual
-- (function calls, mathmatic operators, case statements..)
UPDATE my_nums
SET n = n*3;

SELECT * FROM my_nums;

UPDATE my_nums
SET name = CASE
			WHEN
				name LIKE '%ham%' THEN 'Hello, spam'
			ELSE name
		END;
SELECT * FROM my_nums;


-- UPDATE my_nums
-- we defined this field name as not being able
-- to contain nulls (AKA not contain information)
-- and we still cannot change this fact in this way:
-- SET name = CASE
-- 			WHEN
-- 				name LIKE '%spam%' THEN NULL
-- 			ELSE name
-- 		END;
SELECT * FROM my_nums;

-- DELETE 
DELETE FROM my_nums WHERE name LIKE '%class%';

SELECT * FROM my_nums;


-- well what if I do want to change the table like that?
-- (like that means removing information from a cell)

-- We have to change the table structure!
-- we can do this a few different ways as well

-- ALTER

-- change the table my_nums
-- to where the name field
-- is now a 22 length varchar
ALTER TABLE my_nums
MODIFY name VARCHAR(22);

DESCRIBE my_nums;

SELECT * FROM my_nums;

UPDATE my_nums
SET name = CASE
			WHEN
				name LIKE '%spam%' THEN NULL
			ELSE name
		END;
        
SELECT * FROM my_nums;

DELETE FROM my_nums WHERE n = 9;

-- ADDING IN NEW FIELDS:
ALTER TABLE my_nums
ADD extra_text varchar(20);

SELECT * FROM my_nums;

-- adding content to the new field:
UPDATE my_nums
SET extra_text = CONCAT(name, '!!!');

SELECT * FROM my_nums;

-- deleting not a row but a column:
ALTER TABLE my_nums
DROP name;

SELECT * FROM my_nums;

DROP TABLE IF EXISTS my_nums;

SELECT * FROM my_nums;

USE employees;

-- reversal of the dot notation for paths:
SELECT * 
FROM employees 
JOIN dept_emp 
USING(emp_no)
JOIN departments
USING (dept_no)
WHERE dept_emp.to_date > NOW()
AND dept_name = 'sales'
LIMIT 10;

SELECT DATABASE();

CREATE TEMPORARY TABLE ada_674.current_sales AS (
SELECT * 
FROM employees 
JOIN dept_emp 
USING(emp_no)
JOIN departments
USING (dept_no)
WHERE dept_emp.to_date > NOW()
AND dept_name = 'sales'
);

SELECT * FROM current_sales;

USE ada_674;
SELECT * FROM current_sales LIMIT 10;








