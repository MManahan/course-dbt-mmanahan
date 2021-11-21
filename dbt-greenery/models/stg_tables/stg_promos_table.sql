{{
  config(
    materialized='table'
  )
}}

with source as (

        select * from {{ source('greenery_promos', 'promos') }}
),

renamed as (

    select
        id,
        promo_id,
        discout as discount,
        status as status_promo

    from source

)

select * from renamed