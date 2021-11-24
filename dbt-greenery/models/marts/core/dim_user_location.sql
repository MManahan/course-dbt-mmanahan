{{
  config(
    materialized='table'
  )
}}

with dim_user_location_table as (

SELECT 
        state,
        user_id,
        first_name,
        last_name

FROM 

        {{ref('user_addresses__joined')}}

GROUP BY

        state,
        user_id,
        first_name,
        last_name

ORDER BY

        state
)

select * from dim_user_location_table