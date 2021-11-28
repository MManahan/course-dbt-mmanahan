# Week 2 Questions

## Part 1

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

### Explain the marts models you added. Why did you organize the models in the way you did?

 - Core : Has int models to join users with addresses table and users with orders table. This resulted in a dim table providing users and their location (grouped by state) in order to provide a table detailing the location of users. There is also a int model to join users and orders table to create a fact table providing the number of orders, sum of order_total and cost/order aggregated at the user level. This will help answer which users have ordered the most items and the amount of money they spent per order

 - Marketing : Has an int model to join order_items and products which needed to be combined anyway if you wanted to see which products each user buys. I also have an int model to join the orders and promos model. These int models provided fact tables to find the products and promos aggregated to the order level. 

 - Product : Has an int model to aggregate the different event types to the user level. This is then joined with the user table to create a fact table to show how each user is behaving on the website. 

 ### DAG

 ![DAG](https://github.com/MManahan/course-dbt-mmanahan/blob/main/dbt-greenery/Answers_To_Questions/Manahan%20-%20DAG.png?raw=true)

 ## Part 2

 ### What assumptions are you making about each model? (i.e. why are you adding each test?)

 The tests I implemented are all on the staging models. If I found any issues in the int or dim/fact models, I added a test to the stage models assuming that the data gets caught earlier so the product team can work on how the data is collected. 

 ### Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

 Yes. For order_total on the orders table, there was one order that had a negative value. This made me add a poistive_values test to the orders staging model. I would need to talk to the product group to see if there was a reason a negative number was allowed to come through. I also found that there were some zip codes in the addresses table that failed to be 5 digits. I added a test to the addresses staging table to check to see if they were 5 digits. I did not make any changes/corrections for the model. I feel like these issues need to be handled upstream.

 ### Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

 The models will still run to provide the data, but there needs to be an exception report resulting from the failures found during the tests. Since our tests are sql queries that get the rows that failure the critiria, the results of those tests/queries can be published on a dashboard for the product/engineering team to address. This can be done by running the models and testing them everyday and publishing the results on a dashboard. 