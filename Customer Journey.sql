select * from plans
select * from subscriptions



/*  A. Customer Journey
Based off the 8 sample customers provided in the sample from the subscriptions table, write a brief description 
about each customer’s onboarding journey.
Try to keep it as short as possible - you may also want to run some sort of join to make your explanations a bit 
easier! */



# Distinct Customer_id in the Data-Set
select count(distinct (customer_id)) AS 'Unique Customers'
from subscriptions;



# Customer 1
select customer_id, plans.plan_id,plan_name, start_date
from subscriptions
join plans on plans.plan_id=subscriptions.plan_id
where customer_id = 1
/* > Customer 1 started the trial on 1st August 2020
   > Customer 1 subscribed to the basic monthly plan after the seven day trial period and 
   continued the subscription.
*/



# Customer 2
select customer_id, plans.plan_id,plan_name, start_date
from subscriptions
join plans on plans.plan_id=subscriptions.plan_id
where customer_id = 2
/* Customer 2 started the trial on 20th september 2020
Customer 2 then subscribed to pro annual subscription after the free trial.
*/




# Customer 11
select customer_id, plans.plan_id,plan_name, start_date
from subscriptions
join plans on plans.plan_id=subscriptions.plan_id
where customer_id = 11
/* Customer 11 started the trial on 19th November 2020
 Customer 11 then Cancelled and churned on 26th November 2020 
 */
 
 
 
 
# Customer 13
select customer_id, plans.plan_id,plan_name, start_date
from subscriptions
join plans on plans.plan_id=subscriptions.plan_id
where customer_id = 13
/* Customer 13 started the trial on 15th December 2020
 Customer 13 then subscribed to basic monthly subscription after free trial 
 and  then upgraded to the pro monthly plan after 3 months.
 */
 
 
 
 
 
# Customer 15
select customer_id, plans.plan_id,plan_name, start_date
from subscriptions
join plans on plans.plan_id=subscriptions.plan_id
where customer_id = 15
/* Customer 15 started the trial on 17th March 2020
 Customer 15 then subscribed to pro monthly subscription after the free trial
 and churned after that month on 29th April 2020 
 */




# Customer 16
select customer_id, plans.plan_id,plan_name, start_date
from subscriptions
join plans on plans.plan_id=subscriptions.plan_id
where customer_id = 16
/* Customer 16 started the trial on 31st May 2020
Customer 19 then upgraded to pro monthly on 7th June 2020 and then again
upgraded to pro annual on 21st October 2021
 */




# Customer 18
select customer_id, plans.plan_id,plan_name, start_date
from subscriptions
join plans on plans.plan_id=subscriptions.plan_id
where customer_id = 18
/* Customer 18 started the trial on 6th July 2020
Customer 18 then upgraded to pro monthly on 13th July 2020
 */


# Customer 19
select customer_id, plans.plan_id,plan_name, start_date
from subscriptions
join plans on plans.plan_id=subscriptions.plan_id
where customer_id = 19
/* Customer 19 started the trial on 22nd June 2020
Customer 19 then upgraded to pro monthly on 29th June 2020 and then again
upgraded to pro annual on 29th August 2020
 */
