-- Rate of Repeat Users 

with user_orders as (
select 
        u.user_id, 
        count(o.order_id) as count_of_orders 

from 
        "stg_users_table" as u

left join    "stg_orders_table" as o

on      u.user_id = o.user_id

group by u.user_idå

having count(o.order_id) > 0
),

repeat_users as (

select 
        count(case when count_of_orders > 1 then 1 else null end) as count_repeat,
        count(case when count_of_orders > 0 then 1 else null end) as count_all
FROM
        user_orders
)

select round((count_repeat::decimal / count_all)*100,1) from repeat_users
åç


