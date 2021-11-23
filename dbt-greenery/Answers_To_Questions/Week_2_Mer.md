# Questions

### What is our user repeat rate?
*80.5%*

		-- Rate of Repeat Users

		with user_orders as (
		
		select
				u.user_id,
				count(o.order_id) as count_of_orders
		from
				"stg_users_table" as u
		left join 
				"stg_orders_table" as o
		on 
				u.user_id = o.user_id
		group by 
				u.user_id
		having 
				count(o.order_id) > 0
		),

		repeat_users as (
		
		select
				count(case when count_of_orders > 1 then 1 else null end) as count_repeat,
				count(case when count_of_orders > 0 then 1 else null end) as count_all
		FROM
				user_orders
		)
		select 
				round((count_repeat::decimal / count_all)*100,1) 
		from 
				repeat_users


### What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

Based on the tables and the fields we have:
- I would like to get the repeat users and get data regarding how often they visit the website *sessions*, what items they bought *product_id*, the total cost of their order *order_total*, how often they make a purchases and if they use any of the promotional deals on the products. Based on these fields, we can get un understanding of a repeat customer and compare them to the customers that only bought once.
- We would be able to understand the volume and the frequency of purchases
- Through order_totals, we can see if price is not a limiting factor
- We can also see if promotional deals are factors into purchases comparing orders with promos vs without
- How often they visit the website

If we had more data, what features would we want to see:
- Based on the distinct product names, it seems like Greenery only sells plants and no accessories. Usually accessories that run out are what brings me back as a repeat customer ie Dollar Shave Club. Since we are only selling plants, the repeat customers are probably those that either really like have plants and therefore buy more, can't take care of their plants but they like them so they buy again, or they buy for their friends for gifts. 
- We can probably try to categorize these customers based on whether or not they buy for themselves or others  by shipping address
- We can also probably try to keep track of which plants the customer orders 
- I'd also want give these repeat customers a referral discount code to see if they get used to gain insight on how happy they are with the product.