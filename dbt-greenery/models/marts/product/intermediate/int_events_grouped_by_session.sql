{{
  config(
    materialized='view'
  )
}}

with events as (

    select * from {{ref('stg_events_table')}}

    )

select 
      session_id,
      {{get_column_values('event_type', {{ref('stg_events_table')}})}}
--      sum(CASE WHEN event_type = 'add_to_cart' then 1 ELSE NULL END) as Add_to_Cart,
--      sum(CASE WHEN event_type = 'checkout' then 1 ELSE NULL END) as Checkout,
--      sum(CASE WHEN event_type = 'delete_from_cart' then 1 ELSE NULL END) as Delete_from_Cart,
--      sum(CASE WHEN event_type = 'package_shipped' then 1 ELSE NULL END) as Package_Shipped,
--      sum(CASE WHEN event_type = 'page_view' then 1 ELSE NULL END) as Page_View,
--      sum(CASE WHEN event_type = 'account_created' then 1 ELSE NULL END) as Account_Created

from 
      events

group by 
      session_id
 