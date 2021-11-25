{{
  config(
    materialized='table'
  )
}}

with fact_orders_by_promos_table as (

SELECT 
        promo_id,
        count(order_id) as num_orders,
        sum(order_total) as order_total

FROM 

        {{ref('order_promos__joined')}}

GROUP BY

        promo_id

ORDER BY
        num_orders DESC
)

select * from fact_orders_by_promos_table
