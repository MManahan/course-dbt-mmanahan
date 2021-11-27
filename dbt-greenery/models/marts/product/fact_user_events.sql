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
        e.Add_to_Cart,
        e.Checkout,
        e.Delete_from_Cart,
        e.Package_Shipped,
        e.Page_View,
        e.Account_Created
from 
        users as u

left join 
        events_grouped as e

on 
        u.user_id = e.user_id
