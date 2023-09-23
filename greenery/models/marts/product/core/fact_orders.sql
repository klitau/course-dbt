with products_in_orders as (
    select
        order_id,
        count(product_id) as products_in_orders
    from {{ ref ('stg_postgres__order_items') }}
    group by 1
)
select
    o.order_id,
    o.user_id,
    o.promo_id,
    o.address_id,
    a.country,
    a.state,
    o.created_at,
    o.order_cost,
    o.shipping_cost,
    o.order_total,
    o.tracling_id,
    o.shipping_service,
    o.estimated_delivery_at,
    o.deliverd_at,
    o.order_status,
    p.products_in_orders
from {{ ref ('stg_postgres__orders') }} o
left join {{ ref ('stg_postgres__addresses') }} a on o.address_id=a.address_id 
left join products_in_orders p on o.order_id=p.order_id
