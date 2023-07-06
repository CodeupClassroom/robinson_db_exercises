-- Open MySQL Workbench and login to the database server
-- ok!
-- Save your work in a file named db_tables_exercises.sql
-- ok cool yes thank you
-- List all the databases
-- The command to see our options is SHOW
-- When we first walk in the place the first thing we want to
-- know is what schemas we can access --
-- translation: show me (SHOW) what schemas you have (DATABASES)
-- Reserved words are generally capitalized in SQL
-- But not actively needed to make the thing run
SHOW DATABASES;
-- Write the SQL code necessary to use the albums_db database
-- Whats our command here? *USE*
-- IF I was looking at data for my albums,
-- I could say that I was selecting from table albums

-- But, if I was somewhere else,
-- I could still select from albums
-- by specifying what schema I was looking at,
-- similarly to the way we described absolute file paths
-- in the command line
-- i.e. select *whatever* from *schema*.*table*
-- Show the currently selected database

SELECT DATABASE();

-- List all tables in the database
SHOW TABLES;
-- only one thing present here in this schema,
-- the only thing here is a single table called albums

-- Write the SQL code to switch to the employees database
USE employees;

-- Show the currently selected database
SELECT DATABASE();

-- List all tables in the database
SHOW TABLES;

-- Explore the employees table. 
-- What different data types are present in this table?
DESCRIBE employees.employees;

-- Which table(s) do you 
-- think contain a numeric type column? (Write this question and your answer in a comment)
DESCRIBE dept_emp;

-- Which table(s) do you think 
-- contain a string type column? (Write this question and your answer in a comment)

-- Which table(s) do you think 
-- contain a date type column? (Write this question and your answer in a comment)

-- What is the relationship between 
-- the employees and the departments tables? 
-- (Write this question and your answer in a comment)

DESCRIBE departments; -- dept_no, dept_name
DESCRIBE employees; -- emp_no, birth_date, f_n, l_n, gender, hire_date
DESCRIBE dept_emp; -- happens to have dept_no and emp_no

-- Show the SQL code that created the dept_manager table. 
-- Write the SQL it takes to show this as your exercise solution.
SHOW CREATE TABLE dept_manager;

/*
 
 Section Two:  Basic Statements : 

*/

-- Use the albums_db database.
-- USE album_db;
SELECT DATABASE();
-- What is the primary key for the albums table?
DESCRIBE albums_db.albums;
USE albums_db;
-- What does the column named 'name' represent?
SELECT * FROM albums;
-- its the name of an album -- the album title.

-- What do you think the sales column represents?
-- millions of dollars or millions of units?? (????)
-- (certified sales apparently according to the ex set)

-- Find the name of all albums by Pink Floyd.
SELECT
DISTINCT name,
artist
FROM
albums
WHERE
artist='Pink Floyd';

-- What is the year Sgt. Pepper's
--  Lonely Hearts Club Band was released?
SELECT
release_date
FROM
albums
WHERE
name = "Sgt. Pepper's Lonely Hearts Club Band";

SELECT
release_date
FROM
albums
WHERE
name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

SELECT
release_date
FROM
albums
WHERE
name LIKE '%Pepper%';

-- What is the genre for the album Nevermind?
SELECT
-- *
genre
FROM
albums
WHERE
name = 'Nevermind';

-- Which albums were released in the 1990s?
-- DESCRIBE albums;
SELECT 
*
FROM
albums
WHERE 
release_date BETWEEN
1990
AND
1999;

SELECT 
*
FROM
albums
WHERE 
release_date <= 1999
AND release_date >= 1990;


-- Which albums had less than 20 
-- million certified sales? 
DESCRIBE albums;
-- show me please
SELECT
-- artist name, album name
artist,
release_date,
sales,
name
FROM
-- from what table?
albums
-- under what condition?
WHERE
sales < 20;

-- Rename this column as low_selling_albums.
-- change the name of the name field
-- to low selling albums
-- under the condition
-- that the sales field is less than 20
SELECT 
name AS low_selling_albums
FROM
albums
WHERE
sales < 20;
