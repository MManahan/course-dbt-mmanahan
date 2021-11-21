{{
  config(
    materialized='table'
  )
}}

with source as (

        select * from {{ source('greenery_order_items', 'order_items') }}
),

renamed as (

    select
        id,
        order_id,
        product_id,
        quantity

    from source

)

select * from renamed