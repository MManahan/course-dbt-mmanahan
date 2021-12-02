{{
  config(
    materialized='table'
  )
}}

with fact_orders_by_product_table as (

SELECT 
        name,
        product_id,
        count(order_id) as num_orders

FROM 

        {{ref('order_items_products__joined')}}

GROUP BY

        name,
        product_id

ORDER BY
        num_orders DESC
)

select * from fact_orders_by_product_table
