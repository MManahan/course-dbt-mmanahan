select 
        user_id,
        count(distinct session_id) as num_of_sessions,
        sum(case when event_type = 'checkout' then 1 else 0 end) as count_of_purchases
from 
        "stg_events_table"
group by 
        user_id

-- use the below code to extract product_id from URL

select 
        substring(page_url,30) as product_id
from 
        "stg_events_table"