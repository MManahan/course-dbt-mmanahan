with user_orders as (
select 
        u.user_id, 
        count(o.order_id) as count_of_orders 

from 
        "stg_users_table" as u

join    "stg_orders_table" as o

on      u.user_id = o.user_id

group by u.user_id
),

repeat_users as (

select 
        sum(case when count_of_orders  > 1 then 1 else null end) as count_repeat,
        count(*) as count_all
FROM
        user_orders
)

select * from repeat_users

select * from stg_orders_table