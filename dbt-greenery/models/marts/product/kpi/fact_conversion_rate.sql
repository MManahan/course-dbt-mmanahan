{{
  config(
    materialized='table'
  )
}}

with checkout_sessions as (

select 
        sum(case when event_type = 'checkout' then 1 else 0 end) as num_sesh_checkout,
        count(distinct session_id) as num_sessions

from {{ref('stg_events_table')}}
)

select 
        round((num_sesh_checkout::decimal / num_sessions)*100,2) as conversion_rate
from 
        checkout_sessions