select 
        user_id,
        count(distinct session_id) as num_of_sessions,
        sum(case when event_type = 'checkout' then 1 else 0 end) as count_of_purchases
from 
        "stg_events_table"
group by 
        user_id