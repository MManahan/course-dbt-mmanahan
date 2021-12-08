{{
  config(
    materialized='table'
  )
}}


with bool_table as (

    SELECT
        session_id
         , case when event_type = 'page_view' then 1 else 0 end as has_page_view
         , case when event_type = 'add_to_cart' then 1 else 0 end as has_add_to_cart
         , case when event_type = 'checkout' then 1 else 0 end as has_checkout
    FROM
    {{ref('stg_events_table')}}

),
agg_table as ( 

    SELECT
        session_id
         , sum(has_page_view) as num_pv
         , sum(has_add_to_cart) as num_atc
         , sum(has_checkout) as num_cout
    FROM
        bool_table
    GROUP BY  
        session_id
 ),

final_table as (
    
    SELECT
        count(session_id) as num_sessions
         , sum(case when num_pv > 0 then 1 else 0 end) as page_views
         , sum(case when num_atc > 0 then 1 else 0 end) as add_to_carts
         , sum(case when num_cout > 0 then 1 else 0 end) as checkouts
    FROM
        agg_table
)
SELECT
    num_sessions as total_sessions
     , round(((num_sessions-page_views)/num_sessions::decimal)*100,2) as dropoff_session_to_pv_percentage
     , round(((page_views-add_to_carts)/page_views::decimal)*100,2) as dropoff_pv_to_atc_percentage
     , round(((add_to_carts-checkouts)/add_to_carts::decimal)*100,2) as dropoff_atc_to_cout_percentage
FROM
    final_table
