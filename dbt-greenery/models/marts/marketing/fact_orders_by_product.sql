{{
  config(
    materialized='table'
  )
}}

with fact_orders_by_product_table as (

SELECT 
        name,
        count(order_id) as num_orders

FROM 

        {{ref('order_items_products__joined')}}

GROUP BY

        name

ORDER BY
        num_orders DESC
)

select * from fact_orders_by_product_table
