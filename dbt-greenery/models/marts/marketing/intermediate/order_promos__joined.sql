
{{
  config(
    materialized='view'
  )
}}

with orders as (

    select * from {{ref('stg_orders_table')}}
),

    promos as (

    select * from {{ref('stg_promos_table')}}
    )

select 
        o.order_id,
        o.user_id,
        o.order_total,
        coalesce(o.promo_id,'No Promo') as promo_id,
        coalesce(p.discount,0) as discount
from 
        orders as o
left join 
        promos as p
on      o.promo_id = p.promo_id