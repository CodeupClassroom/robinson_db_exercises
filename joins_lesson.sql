/* 
Relationships and Joins
*/

-- What we want to here with joins:
-- Discover what the relationship between two or more
-- tables is
--
-- Determine what type of mapping that relattionship reps
--
-- Use that link to manifest more contextual info
-- based on the tables we have avaialble


-- check out what schemas you have available
SHOW DATABASES;
-- determine which to use (dont need to use dot notation)
USE join_example_db;
-- check out what tables live here:
SHOW TABLES;
-- check out everything in roles
SELECT * FROM roles;
-- fields available: id (PK), name
DESCRIBE roles;
DESCRIBE users;
-- id (PK), name, email, role_id (MUL*) 
-- *shared key (Foreign to Role's ID as Primary)

/*
The real stuff:
Executing a JOIN
*/

-- select every field
SELECT *
	-- from users
    -- because I define users
    -- as my first FROM, it is relegated to the LEFT table
	FROM users
-- JOIN my second (right) table roles
-- How?? Specifically ON the mapping between user table's
-- role_id and the role table's id
INNER JOIN roles ON users.role_id = roles.id;
-- BY DEFAULT:
-- If we do not specify any type of Join
-- to SQL, it will presume we want an inner join

-- LEFT JOIN:
SELECT * FROM
users
LEFT JOIN
-- note in the ON mapping with equality,
-- we are just pointing out the match.
-- There is no functional need to specify order here.
-- The order of TABLES matters per which side of the JOIN
-- statement
roles ON roles.id = users.role_id;
    
    
-- LEFT JOIN:
SELECT * FROM
roles
LEFT JOIN
-- note in the ON mapping with equality,
-- we are just pointing out the match.
-- There is no functional need to specify order here.
-- The order of TABLES matters per which side of the JOIN
-- statement
users ON roles.id = users.role_id;


-- RIGHT JOIN:
SELECT roles.name, email FROM
users
RIGHT JOIN
-- note in the ON mapping with equality,
-- we are just pointing out the match.
-- There is no functional need to specify order here.
-- The order of TABLES matters per which side of the JOIN
-- statement
roles ON roles.id = users.role_id;



SHOW DATABASES;
USE world;
SHOW TABLES;
-- city
-- country
-- countrylanguage
DESCRIBE city;
-- PK: ID
-- Name, CountryCode (MUL)
-- District,
-- Population
DESCRIBE country;
-- Code (PK)
-- Code2??
DESCRIBE countrylanguage;
-- CountryCode PK, Language PK
SELECT * FROM country LIMIT 2;
-- "Code"
SELECT * FROM countrylanguage LIMIT 2;
-- CountryCode
SELECT * FROM city LIMIT 2;
-- CountryCode

SELECT * FROM
city
JOIN countrylanguage 
ON countrylanguage.CountryCode = city.CountryCode
WHERE IsOfficial = 'T';

SELECT * FROM
city
JOIN countrylanguage 
USING (CountryCode)
WHERE IsOfficial = 'T';

select countrylanguage.CountryCode FROM countrylanguage;

SELECT * FROM country LIMIT 2;

-- select everything  from all tables
SELECT * FROM
-- from country, our left table in our first join
country
-- join the table countrylanguage, our right table in
-- our first join
JOIN countrylanguage 
ON country.Code = countrylanguage.CountryCode
-- Join city as our right table in our second join
JOIN city 
-- on the mapping of city.CC = CL.CC
ON city.CountryCode = countrylanguage.CountryCode;


-- select everything  from all tables
SELECT ct.name FROM
-- from country, our left table in our first join
country AS c
-- join the table countrylanguage, our right table in
-- our first join
JOIN countrylanguage AS cl
ON c.Code = cl.CountryCode
-- Join city as our right table in our second join
JOIN city AS ct
-- on the mapping of city.CC = CL.CC
ON ct.CountryCode = cl.CountryCode;




