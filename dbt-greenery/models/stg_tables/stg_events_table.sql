{{
  config(
    materialized='table'
  )
}}

with source as (

        select * from {{ source('greenery_events', 'events') }}
),

renamed as (

    select
        id,
        event_id,
        session_id,
        user_id,
        page_url,
        substring(page_url,30) as product_id,
        created_at as created_at_events,
        event_type

    from source

)

select * from renamed