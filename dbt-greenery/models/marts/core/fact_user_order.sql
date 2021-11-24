{{
  config(
    materialized='table'
  )
}}

with fact_user_orders_table as (

SELECT 
        user_id,
        first_name,
        last_name,
        count(order_id) as num_orders,
        sum(order_total) as ordered_total,
        round(cast(sum(order_total) / count(order_id) as numeric),2) as dollars_per_order

FROM 

        {{ref('user_orders__joined')}}

GROUP BY

        user_id,
        first_name,
        last_name
)

select * from fact_user_orders_table
