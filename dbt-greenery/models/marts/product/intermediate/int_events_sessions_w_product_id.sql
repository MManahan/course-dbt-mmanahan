{{
  config(
    materialized='view'
  )
}}

with session_w_product_id as (

    select * from {{ref('stg_events_table')}}

    )

select 
      session_id,
      coalesce(product_id,'no product') as product_id

from 
      session_w_product_id
