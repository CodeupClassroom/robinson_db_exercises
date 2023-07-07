-- LIMIT Exercises


-- ###########################
-- #2 List the first 10 distinct last name sorted in descending order.

select distinct last_name
from employees
order by last_name DESC
limit 10;

-- Answer: (Zykh, Zyda, Zwicker, Zweizig, Zumaque, Zultner, Zucker, Zuberek, Zschoche, Zongker)


-- ###########################
-- #3. Find all previous or current employees hired in the 90s and born on Christmas. 
-- Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. 
-- Write a comment in your code that lists the five names of the employees returned.

select first_name, last_name
from employees
where birth_date like '%12-25'
and hire_date like '199%'
order by hire_date
limit 5;

-- Answer:
-- Alselm	Cappello
-- Utz	Mandell
-- Bouchung	Schreiter
-- Baocai	Kushner
-- Petter	Stroustrup


-- ###########################
-- #4. Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.

select first_name, last_name
from employees
where birth_date like '%12-25'
and hire_date like '199%'
order by hire_date
limit 5 offset 45;

-- Answer:
-- Pranay Narwekar
-- Marjo Farrow
-- Ennio Karcich
-- Dines Lubachevsky
-- Ipke Fontan

##### BREAKDOWN THE OFFSET
-- Page 1 -> LIMIT = 5, OFFSET = 0, Records 1-5
-- Page 2 -> LIMIT = 5, OFFSET = 5, Records 6-10
-- Page 3 -> LIMIT = 5, OFFSET = 10, Records 11-15

## FORMULA
-- Answer: If I want page 10, the formula could be something like this:

-- (Page - 1) * Limit = Offset
-- (10-1) * 5 = 45
-- Page 9 * 5 = 45, so page 10 is offset 45 or 9 pages with limits of 5 each.