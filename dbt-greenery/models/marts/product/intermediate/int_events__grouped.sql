
{{
  config(
    materialized='view'
  )
}}

with events as (

    select * from {{ref('stg_events_table')}}

    )

select 
      user_id,
      sum(CASE WHEN event_type = 'add_to_cart' then 1 ELSE 0 END) as Add_to_Cart,
      sum(CASE WHEN event_type = 'checkout' then 1 ELSE 0 END) as Checkout,
      sum(CASE WHEN event_type = 'delete_from_cart' then 1 ELSE 0 END) as Delete_from_Cart,
      sum(CASE WHEN event_type = 'package_shipped' then 1 ELSE 0 END) as Package_Shipped,
      sum(CASE WHEN event_type = 'page_view' then 1 ELSE 0 END) as Page_View,
      sum(CASE WHEN event_type = 'account_created' then 1 ELSE 0 END) as Account_Created

from 
      events

group by 
      user_id

