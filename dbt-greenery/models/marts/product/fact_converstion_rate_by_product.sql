{{
  config(
    materialized='table'
  )
}}


with product_by_session as (

SELECT 
        session_id,
        name, 
        product_id

FROM 
        {{ref('int_events_sessions_w_product_id')}}
),

has_conversion as (

SELECT 
        session_id, 
        case when event_type = 'checkout' then 1 else 0 end as has_conversion

FROM 
        {{ref('int_events_sessions_w_product_id')}}

GROUP BY
        session_id,
        has_conversion

),

session_products_w_conversion as (

select 
        p.session_id,
        p.name,
        p.product_id,
        h.has_conversion
from 
        product_by_session as p
left join 
        has_conversion as h
ON
        p.session_id = h.session_id

)

SELECT
        name,
        count(distinct session_id) as num_sessions,
        sum(case when has_conversion = '1' then 1 else 0 end) as num_sessions_w_conversion,
        round(((sum(case when has_conversion = '1' then 1 else 0 end))::decimal  / count(distinct session_id))*100,2) as conversion_rate_by_product
FROM
        session_products_w_conversion
GROUP BY
        name   