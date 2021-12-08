
with bool_table as (

    SELECT
        session_id
         , case when event_type = 'page_view' then 1 else 0 end as has_page_view
         , case when event_type = 'add_to_cart' then 1 else 0 end as has_add_to_cart
         , case when event_type = 'checkout' then 1 else 0 end as has_checkout
    FROM
    "stg_events_table"

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
         , count(case when num_pv > 1 then 1 else 0 end) as page_views
         , count(case when num_atc > 1 then 1 else 0 end) as add_to_carts
         , count(case when num_cout > 1 then 1 else 0 end) as checkouts
    FROM
        agg_table
)
select * from final_table

