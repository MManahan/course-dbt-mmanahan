
{{
  config(
    materialized='view'
  )
}}

with users as (

    select * from {{ref('stg_users_table')}}
),

    orders as (

    select * from {{ref('stg_orders_table')}}
    )

select 
        u.user_id,
        u.first_name,
        u.last_name,
        u.email,
        o.order_id,
        o.created_at_orders,
        o.order_total
from 
        users as u
left join 
        orders as o
on      u.user_id = o.user_id