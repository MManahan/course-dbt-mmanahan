{{
  config(
    materialized='view'
  )
}}

with events as (

    select * from {{ref('stg_events_table')}}

    )
,
sessions_w_product_id as (
select 
      session_id,
      product_id,
      event_type

from 
      events
group by 
      session_id,
      product_id,
      event_type
order by 
      session_id
)
select 
      s.session_id,
      s.product_id,
      p.name,
      s.event_type

from sessions_w_product_id as s
full outer join  {{ref('stg_products_table')}} as p 
on
      s.product_id = p.product_id
group by
      s.session_id,
      s.product_id,
      p.name,
      s.event_type
      
order by
      s.session_id


