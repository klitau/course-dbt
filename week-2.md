# Part 1
## Q: What is our user repeat rate?

Repeat Rate = Users who purchased 2 or more times / users who purchased
```
with cnt_orders as (
    select
        user_id,
        count(order_id) as order_cnt
    from
        DEV_DB.DBT_KRISTINALITAUAUDIBENEDE.STG_POSTGRES__ORDERS
    group by
        1
),
user_buckets as (select
        user_id,
        (order_cnt >= 1)::int as has_one_plus_order,
            (order_cnt > 1)::int as has_two_plus_order
                from
                    cnt_orders)
select sum(has_two_plus_order) / sum(has_one_plus_order) as repeat_rate
from user_buckets;
```

Our Repeat Rate is ~0.798

## Q: What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.

## Q: Use the dbt docs to visualize your model DAGs to ensure the model layers make sense
![DAG of week-2 project](https://github.com/klitau/course-dbt/blob/main/dbt-dag.png)

# Part 3
## Q: Which products had their inventory change from week 1 to week 2?
A: 4 products: Pothos, Philodendron, Monstera, String of pearls
```
select * from DEV_DB.DBT_KRISTINALITAUAUDIBENEDE.products_snapshot 
    where dbt_valid_to is not null
```
