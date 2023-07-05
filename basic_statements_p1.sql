-- Two dashes make a single line comment in SQL
/*
This is
a 
multi line comment*/
-- Ask the server: What section am I in presently?
SELECT database();
-- answer: NULL (you aren't anywhere yet)
-- SELECT => fetch me
-- database() ==> parens mean this is a function call
-- the function checks which database you are in presently

-- USE will guide me to the database I want to see
USE fruits_db;

SELECT database();

USE employees;

-- SELECT, what do?

-- SELECT will present information back to us as the user

-- hello world:
SELECT 'hello robinson';

-- What are the tables here in fruits_db again?
SHOW TABLES;

-- GENERAL STRUCTURE:
-- SELECT => Please grab me
-- <some thing> ==> usually field names
-- FROM ==> where do you want to select this data from?
-- <some thing> ==> a table name

-- what field names are in fruits?
DESCRIBE fruits;
-- three field names present: id, name, quantity

-- grab just the name field from fruits
SELECT name FROM fruits;

-- show me the whole table:
SELECT * FROM fruits;

-- Show me where I can go again?
SHOW DATABASES;
-- cool lets go to chipotle
USE chipotle;
-- what tables are in chipotle?
SHOW TABLES;
-- show me everything in orders
SELECT * FROM orders;
-- I cant select from fruits table anymore when I am living in
-- my chipotle db *unless* I use dot notation to 
-- specify a more absolute path to that table
SELECT * FROM fruits_db.fruits;
-- where am I again?
SELECT database();
SELECT * FROM orders;
-- note the data type on the price and how the dollar sign
-- changes what we can do with the data
DESCRIBE orders;

-- DISTINCT will give me unique item names in the table
SELECT DISTINCT item_name FROM orders;

USE fruits_db;
SELECT * FROM fruits;

-- what if we call name something else?
-- we can use an alias
SELECT name AS fruit_description FROM fruits;

SELECT * FROM fruits;

SELECT 
-- grab id
id, 
-- and quantity
quantity,
-- and the sum of id and quantity 
id + quantity 
AS 
-- but call that added_col
added_col 
-- all from the fruits table
FROM 
fruits;

-- WHERE

-- lets select everything in fruits where
-- the quantity is less than 5
SELECT 
*
FROM 
fruits
WHERE
quantity < 5;

-- numerical comparison operators:
-- =
-- >, <
-- >=, <=
-- !=
SELECT * FROM fruits WHERE quantity = 2;

-- equivalency works for string matches
SELECT * FROM fruits WHERE name = 'cantelope';

SELECT * FROM fruits WHERE name LIKE '%an%';

-- things that start with an:
SELECT * FROM fruits WHERE name LIKE 'an%';

-- things that end with an:
SELECT * FROM fruits WHERE name LIKE '%an';

-- BETWEEN:
-- select a range of values (inclusive)
SELECT * FROM fruits WHERE quantity BETWEEN 2 AND 4;

SELECT * FROM fruits
WHERE quantity >= 2 
AND quantity <=4;


