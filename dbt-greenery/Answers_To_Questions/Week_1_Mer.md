How many users do we have?
 - 130

 select count(user_id) from stg_users_table

On average, how many orders do we receive per hour?
 - 17

 select round(count(order_id)/date_part('hours', MAX(created_at) - MIN(created_at))) from stg_orders_table

On average, how long does an order take from being placed to being delivered?
  - { "days": 3, "hours": 22, "minutes": 13, "seconds": 10, "milliseconds": 504.451 }

select AVG(delivered_at - created_at) 
from stg_orders_table 
where status = 'delivered'

How many users have only made one purchase? Two purchases? Three+ purchases?