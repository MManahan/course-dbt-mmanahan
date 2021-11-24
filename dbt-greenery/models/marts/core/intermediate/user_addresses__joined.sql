{{
  config(
    materialized='view'
  )
}}

with users as (

    select * from {{ref('stg_users_table')}}
),

    addresses as (

    select * from {{ref('stg_addresses_table')}}
    )

select 
        u.user_id,
        u.first_name,
        u.last_name,
        u.created_at_users,
        a.address,
        a.zipcode,
        a.state,
        a.country

from 
        users as u
left join 
        addresses as a 
on 
        u.address_id = a.address_id