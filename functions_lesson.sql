/*

SQL Lesson: Functions

*/
-- First function call: Database
-- Structurally when we invoke or call a function
-- you see the name of the function itself,
-- which is Database in this case,
-- followed by two parenthesis, ()
-- the parenthesis are the thing that let you know
-- that this function is being called or invoked
-- In this way, we see the function Database being called
-- the *return* of this function is the name of 
-- the current schema we are using
-- Select: show me
-- Database(): the function that checks what schema I am in
SELECT DATABASE();

-- We've seen select with various instances
-- Which may or may not come from a table in any case
SELECT 'hello robinson!';

-- Part 1: Numerical functions
SELECT * FROM albums;
-- make sure which are numerical columns:
DESCRIBE albums;

SELECT sales FROM albums;

-- getting the maximum value from these sales:
-- we feed in sales as an argument (the name of the field)
SELECT MAX(sales) FROM albums;
-- This will technically work on nonnumeric string values
-- due to the nature of ascii encoding but largely does not
-- have a ton of meaning for us

SELECT MAX(name) FROM albums;

-- stay tuned for how to make this work better:
-- SELECT name FROM albums
-- WHERE sales = MAX(sales);

-- This doesnt work either.  We will need aggregation to make
-- it functional :)
-- SELECT name, MAX(sales) FROM albums;

-- Other numerical functions we will find useful:
-- AVG() MIN()
SELECT MIN(sales), MAX(sales), AVG(sales) FROM albums;

-- String functions!
SELECT * FROM albums;
-- Concat!
SELECT 
CONCAT('artist name', ' - ', 'album name', ' extra stuff here');

SELECT 
CONCAT(artist, ' - ', name) AS full_name
FROM albums;

SELECT * FROM fruits_db.fruits;

-- slicing up strings: SUBSTR()

SELECT 'hello robinson!';
-- indexing in sql: start at 1
-- h: 1
-- e: 2, l: 3, l:4, o:5 
SELECT SUBSTR('hello robinson!',7, 8);
-- SUBSTR:
-- (subject,
-- starting index,
-- number of characters (optional)
-- )
SELECT SUBSTR('hello robinson!',7);

SELECT SUBSTR(name, 5, 4) FROM albums;

-- replacement!

SELECT REPLACE('hello robinson!', 'hello', 'hey');
-- order of arguments with replace:
-- REPLACE(
-- subject, the thing you want to apply the function to
-- search term, the thing you want to replace
-- replacement term, the thing you want to sub it with
-- note replacement is case sensitive!
SELECT * FROM albums;
SELECT REPLACE(
				name,
				'dark',
                'light')
FROM albums;

-- time: how do I compare to now?
-- NOW() gives currrent timestamp with date
SELECT NOW();
-- CURDATE gives present date without time
SELECT CURDATE();
-- UNIX_TIMESTAMP gives number of seconds since epoch in 1970
-- UNIX_TIMESTAMP(subj) will convert the subj into seconds since the epoch
-- if the subj is a datetime

SELECT UNIX_TIMESTAMP();

-- Casting!
-- what if want different data type?

SELECT sales FROM albums;

SELECT CONCAT('now this isnt a number: ', sales) FROM albums;
 
 USE chipotle;
 SELECT * FROM orders;
 
 -- turn the item price into a number:
 -- first step: get rid of that dollar sign
 SELECT REPLACE(item_price, '$', '') FROM orders;
 
 SELECT SUBSTR(item_price, 2) FROM orders;
 
 -- CAST will turn a data type from one to another (if possible)
-- CAST(subject AS data_type)
SELECT CAST('hello' AS float);
SELECT CAST('45.7' AS float);
SELECT * FROM orders LIMIT 2;
SELECT CAST(
SUBSTR(item_price, 2)
AS float) * 100 AS calculated_price, 
item_name
 FROM orders;
