{{
  config(
    materialized='view'
  )
}}

{%- set event_types = dbt_utils.get_column_values(
    table=ref('stg_events_table'),
    column='event_type'
) -%}

with events as (

    select * from {{ref('stg_events_table')}}

    )

select 
      session_id,
      {%- for event_type in event_types %}
      count(case when event_type = '{{event_type}}' then event_id end) as count_of_{{event_type}}
      {%- if not loop.last %},{% endif -%}
      {% endfor %}

--    The code below was replaced with the jinja above utilizing dbt.utils.get_column_values:
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
 