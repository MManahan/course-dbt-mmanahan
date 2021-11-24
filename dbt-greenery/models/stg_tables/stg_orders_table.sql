{{
  config(
    materialized='table'
  )
}}

with source as (

        select * from {{ source('greenery_orders', 'orders') }}
),

renamed as (

    select
        id,
        order_id,
        user_id,
        promo_id,
        address_id,
        created_at as created_at_orders,
        order_cost,
        shipping_cost,
        round(cast (order_total as numeric),2) as order_total,
        tracking_id,
        shipping_service,
        estimated_delivery_at,
        delivered_at,
        status as status_orders

    from source

)

select * from renamed