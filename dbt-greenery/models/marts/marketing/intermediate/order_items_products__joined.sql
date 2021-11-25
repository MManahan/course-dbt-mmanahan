
{{
  config(
    materialized='view'
  )
}}

with order_items as (

    select * from {{ref('stg_order_items_table')}}
),

    products as (

    select * from {{ref('stg_products_table')}}
    )

select 
        oi.order_id,
        p.product_id,
        p.name,
        p.price,
        p.quantity
from 
        order_items as oi
left join 
        products as p
on      oi.product_id = p.product_id