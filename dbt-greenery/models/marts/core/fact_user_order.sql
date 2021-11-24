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
        sum(order_total) as ordered_total

FROM 

        {{ref('user_orders__joined')}}

GROUP BY

        user_id,
        first_name,
        last_name
)

select * from fact_user_orders_table
