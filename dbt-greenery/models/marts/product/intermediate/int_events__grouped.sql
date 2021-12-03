
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
      user_id,
      {%- for event_type in event_types %}
      sum(case when event_type = '{{event_type}}' then 1 else 0 end) as {{event_type}}
      {%- if not loop.last %},{% endif -%}
      {% endfor %}

      --sum(CASE WHEN event_type = 'add_to_cart' then 1 ELSE 0 END) as Add_to_Cart,
      --sum(CASE WHEN event_type = 'checkout' then 1 ELSE 0 END) as Checkout,
      --sum(CASE WHEN event_type = 'delete_from_cart' then 1 ELSE 0 END) as Delete_from_Cart,
      --sum(CASE WHEN event_type = 'package_shipped' then 1 ELSE 0 END) as Package_Shipped,
      --sum(CASE WHEN event_type = 'page_view' then 1 ELSE 0 END) as Page_View,
      --sum(CASE WHEN event_type = 'account_created' then 1 ELSE 0 END) as Account_Created

from 
      events

group by 
      user_id

