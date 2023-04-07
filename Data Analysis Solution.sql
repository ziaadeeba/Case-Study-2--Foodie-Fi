select * from plans
select * from subscriptions


--1. How many customers has Foodie-Fi ever had?

select count(distinct customer_id) as total_customers
from subscriptions





--2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value.

select count(distinct customer_id) as monthly_distribution,month(start_date) as month
from plans p join subscriptions s on
p.plan_id=s.plan_id
where plan_name='trial'
group by month(start_date)





--3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name


select plan_name,count(*) count_of_events
from plans p 
join subscriptions s 
on p.plan_id=s.plan_id
where start_date>'2020-12-31'
group by plan_name



--4.What is the customer count and percentage of customers who have churned rounded to 1 decimal place?

with cte1 as (
select count(*) churn_count
from subscriptions s 
join plans p on s.plan_id=p.plan_id
where plan_name='churn'),
cte2 as (

select count(*) total_count
from subscriptions s 
join plans p on s.plan_id=p.plan_id)

select churn_count,round(churn_count*100.0/total_count,1) as percentage_churn
from cte1 cross join cte2





--5.How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?

with cte as (
select s.customer_id as id_customer,s.plan_id as plann,plan_name,
LEAD(s.plan_id,1) over (partition by customer_id order by start_date) as next_plan
from subscriptions s join plans p 
on s.plan_id=p.plan_id)
select count(id_customer) as churned_after_trial, 
round(count(id_customer)*100.0/(select count(distinct customer_id) from subscriptions),3) as pct
from cte where plann=0 and next_plan=4





--6.What is the number and percentage of customer plans after their initial free trial?

with cte as (
select s.customer_id as id_customer,s.plan_id as plann,plan_name,
LEAD(s.plan_id,1) over (partition by customer_id order by start_date) as next_plan
from subscriptions s join plans p 
on s.plan_id=p.plan_id)
select next_plan,count(*) as count_customer,count(*)*100/(select count(distinct customer_id) from subscriptions) as pct from cte 
where plann=0 and next_plan in (1,2,3,4)
group by next_plan





--7.What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?

with cte as (
select count(*) as plan_count,plan_name
from subscriptions s join plans p 
on s.plan_id=p.plan_id
where start_date<='2020-12-31'
group by plan_name )
select plan_name,plan_count,plan_count*100/(select sum(plan_count) from cte)  as pct_breakdown
from cte






--8.How many customers have upgraded to an annual plan in 2020?

SELECT COUNT(DISTINCT customer_id) AS annual_plan_customer_count
FROM subscriptions JOIN plans on plans.plan_id=subscriptions.plan_id
WHERE subscriptions.plan_id = 3
AND start_date <= '2020-12-31'









--9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?

with cte1 as (
select min(start_date) as join_date,customer_id from subscriptions
group by customer_id ),
cte2 as (
select min(start_date) annual_join_date,customer_id from subscriptions
where plan_id=3 
group by customer_id)
select avg(datediff(day,join_date,annual_join_date) ) as avg_days
from cte1 join cte2 on cte1.customer_id=cte2.customer_id




--10.Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)








--11.How many customers downgraded from a pro monthly to a basic monthly plan in 2020?
with cte as (
select plan_name,customer_id,start_date,
lead(plan_name) over (partition by customer_id order by start_date) as next_plan
from subscriptions s join plans p 
on s.plan_id=p.plan_id
)
select count(*) as customers_downgraded from cte 
where next_plan='basic monthly' and plan_name='pro monthly' and year(start_date)=2020


