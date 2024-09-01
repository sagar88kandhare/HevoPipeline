{{ config(materialized='table') }}

with source_data as (

    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        o.first_order,
        o.most_recent_order,
        o.number_of_orders,
        p.customer_lifetime_value
    FROM
    customers c
    join orders o on c.id = o.user_id
    join payments p on o.id = p.order_id;
)

select *
from source_data