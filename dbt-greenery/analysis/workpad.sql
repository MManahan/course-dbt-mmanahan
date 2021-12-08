
with agg_table as (

    SELECT
        session_id
         , count(case when event_type = 'page_view' then 1 else 0 end) as has_page_view
         , count(case when event_type = 'add_to_cart' then 1 else 0 end) as has_add_to_cart
         , count(case when event_type = 'checkout' then 1 else 0 end) as has_checkout
FROM
    "stg_events_table"
GROUP BY
    session_id

),
bool_table as ( 

SELECT
    count(session_id) as num_sessions
     , count(case when has_page_view > 0 then 1 else 0 end) as num_pv
     , count(case when has_add_to_cart > 0 then 1 else 0 end) as num_atc
     , count(case when has_checkout > 0 then 1 else 0 end) as num_cout
FROM
    agg_table
)
select * from bool_table