1. How many users do we have?
select count(*) from dev_db.dbt_kristinalitauaudibenede.stg_postgres__users;
A: We have 130 users

2. On average, how many orders do we receive per hour?
select count(order_id) / count(distinct(DATE_TRUNC('HOUR', created_at))) as orders 
from dev_db.dbt_kristinalitauaudibenede.stg_postgres__orders; 
A: 7.5 per hour

3. On average, how long does an order take from being placed to being delivered?
select avg(datediff(day, created_at, delivered_at)) as avg_diff from dev_db.dbt_kristinalitauaudibenede.stg_postgres__orders;
A: 93 hours or 3.9 days

4. How many users have only made one purchase? Two purchases? Three+ purchases?
Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.
with prep as
(select user_id, count(*) as orders 
from dev_db.dbt_kristinalitauaudibenede.stg_postgres__orders 
group by 1
having count(*)=1 --adjust to 2 & 3
order by 1)
select count(*) from prep;
A: 25, 28 and 34

5. On average, how many unique sessions do we have per hour?
select count(distinct session_id) / count(distinct(DATE_TRUNC('HOUR', created_at))) 
from dev_db.dbt_kristinalitauaudibenede.stg_postgres__events;
A: around 10




