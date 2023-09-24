# Part 1
### Q: What is our user repeat rate?

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

### Q: What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question? NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.
### A: In fact_page_view we created new information that helps us to understand the customer behaviour based on the event type: page view, adding thing to a cart, etc during a session. In fact_user_orders we label frequent buyers and how mucht they spend as well as how many products they purchased. Based on these tables we can try to further segment our customers to for example understand: how the duration of a session and the associated events during that session can predict if the customer will buy the products. Frequent buyers will help us understand and calculate a predicted revenue.
### To provide even more transparency to our stakeholders, we could look what kind of demographic data we have available - for further customer segmentation, that can us help to understand the preferences for the different groups and tailor offers and promotions to them.

### Q: Explain the product mart models you added. Why did you organize the models in the way you did?
### A: I chose to put the intermediate layer outside of the marts layer to have a separate section just for intermediate models and to facilitate understandability but also orientation this way. Marts will have a core subfordeer for each domain, so it is also hopefully easier to find for anyone who wants to understand the model dependancies.

### Q: Use the dbt docs to visualize your model DAGs to ensure the model layers make sense
![DAG of week-2 project](https://github.com/klitau/course-dbt/blob/main/dbt-dag.png)

# Part 2
### Q: What assumptions are you making about each model? (i.e. why are you adding each test?) Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
### A: We added a couple of tests on the staging tables to make sure values such as: addresses and zip codes are not null, or that the user_id in the events table is also to find in the users table (relationship test). The accepted values test is also quite useful for columns with different values, where you want to be warned once a new or unespected value is generated and shows up in your source.

### Q: Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
### A: Ideally we set up the test before an incident occurs - but even if there was a failure once that was raised by our stakeholders, to assure that something like this won't happen we will set up prevention test and connect our model runs to e.g. slack so we can consistently monitor failures, alert stakeholders and go in to fix things asap.

# Part 3
### Q: Which products had their inventory change from week 1 to week 2?
### A: 4 products: Pothos, Philodendron, Monstera, String of pearls
```
select * from DEV_DB.DBT_KRISTINALITAUAUDIBENEDE.products_snapshot 
    where dbt_valid_to is not null
```
