# Questions
 
### How many users do we have?

*130*

	select 
		count(user_id) 
	from 
		stg_users_table

### On average, how many orders do we receive per hour?

*8.51*
		
		select 
        		count(order_id) /
        		(
        		date_part('days', max(created_at) - min(created_at))*24 +
        		date_part('hours', max(created_at) - min(created_at))
        		)
		from 
				"stg_orders_table"

### On average, how long does an order take from being placed to being delivered?

{ "days": 3, "hours": 22, "minutes": 13, "seconds": 10, "milliseconds": 504.451 }

		select 
			AVG(delivered_at - created_at)
		from 
			stg_orders_table
		where 
			status = 'delivered'

### How many users have only made one purchase? Two purchases? Three+ purchases?

*- one purchase = 25*

*- two purchases = 22*

*- three+ purchases = 81*

		with grouped_users as (
		select
			stg_users_table.user_id,
			count(stg_orders_table.order_id) as num_purchases
		from
			stg_users_table
		left join
			stg_orders_table
		ON
			stg_users_table.user_id = stg_orders_table.user_id
		GROUP BY
			stg_users_table.user_id
		)
			select
				COUNT(CASE WHEN num_purchases = 1 then 1 ELSE NULL END) as "One Purchase",
				COUNT(CASE WHEN num_purchases = 2 then 1 ELSE NULL END) as "Two Purchases",
				COUNT(CASE WHEN num_purchases > 2 then 1 ELSE NULL END) as "Three or more Purchases"
			FROM
				grouped_users

### On average, how many unique sessions do we have per hour?

*0.1139*

	select count(DISTINCT(session_id))/(Date_Part('days',MAX(created_at) - MIN(created_at))*24 
			+ Date_Part('hours',MAX(created_at) - MIN(created_at))) 
	from stg_events_table