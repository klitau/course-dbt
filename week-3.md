# Week 3 questions and ansers

## Part 1: 
A: Overall Conversion Rate is 62.5% and the converison rate by product
```
select
    count(
        distinct case
            when checkouts > 0 then session_id
        end
    ) / count(distinct session_id) as conversion_rate
from
    dev_db.dbt_kristinalitauaudibenede.fact_page_views;


select
    pv.product_id,
    p.product_name,
    count(
        distinct case
            when checkouts > 0 then session_id
        end
    ) / count(distinct session_id) as conversion_rate
from
    dev_db.dbt_kristinalitauaudibenede.fact_page_views as pv
    left join dev_db.dbt_kristinalitauaudibenede.stg_postgres__products as p on pv.product_id=p.product_id
    group by 1,2;
```
## Part 6:
A: 4 products changed since the last snapshot: 
Philodendron
Pothos
Monstera
String of pearls 