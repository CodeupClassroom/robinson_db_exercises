use farmers_market;

select distinct customer_first_name
from customer;

select customer_first_name
from customer
group by customer_first_name;

select *
from customer_purchases;

select customer_id, count(*) as n_purchases
from customer_purchases
group by customer_id
having n_purchases > 200;

