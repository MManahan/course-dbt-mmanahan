{{
  config(
    materialized='table'
  )
}}

with source as (

        select * from {{ source('greenery_users', 'users') }}
),

renamed as (

    select
        id,
        user_id,
        first_name,
        last_name,
        email,
        phone_number,
        created_at as created_at_users,
        updated_at as updated_at_users,
        address_id

    from source

)

select * from renamed