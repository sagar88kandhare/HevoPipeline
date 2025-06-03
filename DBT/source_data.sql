{{ config(materialized='table') }}

Select 
        c.id,
        c.first_name,
        c.last_name,
        first_value(o.order_date) over (partition by o.user_id order by o.order_date) as first_order,
        first_value(o.order_date) over (partition by o.user_id order by o.order_date desc) as most_recent_order,
        count(o.id) over (partition by o.user_id order by o.order_date) as number_of_orders,
        sum(p.amount) over (partition by o.user_id order by p.order_id) as customer_lifetime_value
    From
    pc_hevodata_db.public.postgresdataload_raw_customers c
    left join pc_hevodata_db.public.postgresdataload_raw_orders o 
    on c.id = o.user_id
    left join pc_hevodata_db.public.postgresdataload_raw_payments p 
    on o.id = p.order_id
    group by c.id, c.first_name, c.last_name, o.id, o.user_id, o.order_date, p.amount, p.order_id
    qualify row_number() over (partition by o.user_id order by o.order_date desc) =1
    order by c.id