  {{
        config(
            materialized='view'
        )
    }}

with session_timing_agg as (select *
                            from {{ref('int_session_timing')}}
    )

{% set event_types = dbt_utils.get_column_values(
    table=ref('stg_postgres__events'),
    column='event_type'
) %}

select e.session_id,
       e.user_id,
       coalesce(e.product_id, oi.product_id)                             as product_id,

        {% for event_type in event_types %}
        {{sum_of('e.event_type',event_type) }} as {{ event_type }}s,
        {% endfor %}

       datediff('minute', session_started_at, session_ended_at)          as session_length_minutes
from {{ref ('stg_postgres__events') }} e
left join {{ref ('stg_postgres__order_items') }} oi on e.order_id=oi.order_id
left join session_timing_agg s on e.session_id=s.session_id
group by all