/* 
Subqueries
*/

USE employees;
-- highest average salary value: 88852.9695
SELECT
	dept_name,
	ROUND(AVG(salary),0) AS average_salary
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
    GROUP BY dept_name
HAVING average_salary = (
SELECT 
	ROUND(AVG(salary)) avg_sal
FROM 
	salaries s
JOIN dept_emp de
	USING(emp_no)
JOIN departments d
	USING(dept_no)
WHERE s.to_date > NOW()
AND de.to_date > NOW()
GROUP BY dept_name
ORDER BY avg_sal DESC
LIMIT 1
);
-- ORDER BY average_salary DESC
-- LIMIT 1;
SELECT * FROM departments LIMIT 2;
-- how would I get that average salary on its own?
SELECT 
	AVG(salary) avg_sal
FROM 
	salaries s
JOIN dept_emp de
	USING(emp_no)
JOIN departments d
	USING(dept_no)
GROUP BY dept_name
ORDER BY avg_sal DESC
LIMIT 1;


-- SUBQUERIES 
-- three main flavors:
-- scalar comparisons
-- compare value x in a field
-- with the version of x that you want
-- that happens to be the output of a different query
-- i.e. WHERE x = (some_value)
-- which would look a little like
-- WHERE x = (45.65)
-- ==> WHERE x = (SELECT MAX(x) FROM table_a)
-- list/columnar comparisons
-- I want to compare my results to a group
-- WHERE x IN ('thing_1', 'thing_2', 'thing_3')
-- WHERE x IN (SELECT things from table a WHERE ...)
-- table comparisons
-- We want to compare references from an entire table
-- which often will look similar to a join
-- or have slightly different results

SELECT * FROM customer_subscriptions;
SELECT * FROM customer_subscriptions WHERE internet_service_type_id = 3;
SHOW TABLES;

-- Show all customers
-- customer ids
-- whose total charges
-- are greater than the average
SELECT * FROM customer_payments LIMIT 2;

--
SELECT 
	customer_id,
    total_charges
    FROM customer_payments
WHERE
total_charges > AVG(total_charges);


-- grabbing my average total charges for these customers

SELECT 
	-- grabbing customer_id
    -- grabbing total_charges
	customer_id, total_charges
FROM customer_payments
	-- from customer _payments
    -- WHERE condition:
    -- the customer has given more money than the average customer
    -- to make the comparison on the aggregate:
	WHERE total_charges > 
    -- compare total charges to the single number
    -- output by the select statement made here:
    -- note the lack of semicolon in the subquery
	(SELECT AVG(total_charges) FROM customer_payments);


-- field/list/iterables/columnar values:
-- New question:
-- ids and total_charges for all customers
-- who happen to have internet service type #3
SELECT * 
FROM customer_subscriptions WHERE 
internet_service_type_id = 3;

-- I may execute:
SELECT 
	c_charge.customer_id,
    c_charge.total_charges
FROM
	customer_payments c_charge
JOIN customer_subscriptions cs
	USING(customer_id)
WHERE internet_service_type_id = 3;

SELECT customer_id, total_charges
FROM customer_payments
WHERE customer_id IN(
	SELECT customer_id 
    FROM customer_subscriptions
	WHERE internet_service_type_id = 3);

SELECT customer_id FROM customer_subscriptions
WHERE internet_service_type_id = 3;

-- When we talk about entire table subqueries:
WITH big_spenders AS (
SELECT customer_id, total_charges
FROM customer_payments
WHERE total_charges > 
(SELECT AVG(total_charges) FROM customer_payments)
)
SELECT customer_id FROM big_spenders;

-- subqueries for entire tables:
SHOW TABLES;
-- show me:
-- customer_id
-- average charge
-- internet service type id

-- query regarding monthly charges
SELECT
pay.customer_id,
AVG(pay.monthly_charges)
FROM customer_payments pay
GROUP BY customer_id;

-- query regarding subscription types:
SELECT 
	sub.customer_id,
    sub.internet_service_type_id,
    ist.internet_service_type AS int_type
FROM customer_subscriptions sub
JOIN internet_service_types ist
ON ist.internet_service_type_id = sub.internet_service_type_id;

-- link these two queries together
-- querying off of my own query:
SELECT 
	-- grab customer_id and mean charges
    -- from our avg_charges subquery (named below)
	avg_charges.customer_id,
	avg_charges.mean_charges,
    -- as well as our internet type from internet_customers
    internet_customers.int_type
FROM
	-- instead of a table in the schema,
    -- we define a subquery that we call avg_charges
	(
		-- this query returns a whole table
        -- that table 
        -- is aggregating based on customer id
        -- returning the avg monthly charges for each
        -- (returns two fields)
		SELECT
			pay.customer_id,
			AVG(pay.monthly_charges) AS mean_charges
		FROM customer_payments pay
		GROUP BY customer_id
	) 
-- it gets named as avg_charges after the parenthesis
AS avg_charges
-- avg_charges acts as our first table
-- so now we execute the join
JOIN
-- the join is with our second subquery
(
	-- the second subquery
    -- selects three different fields
    -- but we really only need two:
    -- customer id to link into avg_charges
    -- and internet_service_type to get the description
	SELECT 
		sub.customer_id,
		sub.internet_service_type_id,
		ist.internet_service_type AS int_type
	FROM customer_subscriptions sub
    -- this subquery requires a join
    -- in order to link the customer id to
    -- the internet service description
	JOIN internet_service_types ist
	ON ist.internet_service_type_id = sub.internet_service_type_id
)
-- the second query gets named as internet_customers 
AS internet_customers
-- we define the parameters of the join between the two queries
ON internet_customers.customer_id = avg_charges.customer_id
;



