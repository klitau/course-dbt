# Week 3 questions and answers

## Part 1: What is our overall conversion rate? What is our conversion rate by product?
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
```

Conversion by Product
```
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
## Part 2: Create a macro to simplify part of a model
Created a macro "sum_of" that allows to write simple case statements based on the values available for the selected column and sum over the different values.

## Part 3: Add a post hook to your project to apply grants to the role “reporting”.
The posthook resided directly in the dbt_project.yml and grants rights to reporting in the whole greenery folder. Before that we had to create a macro -> "grant.sql"
https://github.com/klitau/course-dbt/blob/main/greenery/dbt_project.yml

## Part 4: Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project
we created a folder outside of the models folder called "packages.yml" that allows to import other dbt projects. The packages itself appear in dbt_packages folder, where we used the get_column_values function to improve our macro we created in part 2 and use in the fact_page_views model

## Part 5: Show (using dbt docs and the model DAGs) how you have simplified or improved a DAG using macros and/or dbt packages.
![DAG of week-3 project](https://github.com/klitau/course-dbt/blob/main/week-3%20dag.PNG)

## Part 6: dbt Snapshots
A: 4 products changed since the last snapshot: 
Philodendron,
Pothos,
Monstera,
String of pearls 