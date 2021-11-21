{{
  config(
    materialized='table'
  )
}}

with source as (

        select * from {{ source('greenery_products', 'products') }}
),

renamed as (

    select
        id,
        product_id,
        name,
        price,
        quantity

    from source

)

select * from renamed