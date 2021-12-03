{{
  config(
    materialized='table'
  )
}}

with users as (

    select * from {{ref('stg_users_table')}}

),

events_grouped as (

    select * from {{ref('int_events__grouped')}}

)

select 
        u.user_id,
        u.first_name,
        u.last_name,
        e.add_to_cart,
        e.checkout,
        e.delete_from_cart,
        e.package_shipped,
        e.page_View,
        e.account_created
from 
        users as u

left join 
        events_grouped as e

on 
        u.user_id = e.user_id
