create database E_Commerce;
drop table if exists Ecommerce_sales;
create table Ecommerce_sales( order_id varchar(10),
				customer_id	varchar(10),
				product_id	varchar(10),
				category varchar(20),
				price decimal(10,2),
				discount decimal(4,2),
				quantity int ,	
				payment_method	varchar(20),
				order_date	date,
				delivery_time_days int,	
				region	varchar(20),
				returned varchar(3)	,
				total_amount decimal(10,2),	
				shipping_cost	decimal(10,2),
				profit_margin	decimal(10,2),
				customer_age int,
				customer_gender varchar(10)
);

select * from ecommerce_sales;

---- cleaning part

--- 01 renaming the Total_amount to Item_amount 
--- total_amount currently = price × qty × (1 - discount). It does NOT include shipping.

alter table ecommerce_sales
rename column total_amount to Item_amount;

---- 02 To add the true revenue (Item_amount + shiping_cost) as Revenue
alter table ecommerce_sales
add column Revenue decimal(10,2);

UPDATE ecommerce_sales
SET revenue = item_amount + shipping_cost;

--- 03 To Add year, month, and quarter columns for easy time-series analysis and GROUP BY.
alter table ecommerce_sales
add column Order_Year int ,
add column Order_Month int ,
add column Order_Quarter int;

update ecommerce_sales
set 
order_year = extract(year from order_date),
order_month = extract(month from order_date),
order_quarter = extract(quarter from order_date);

select * from ecommerce_sales;

---- 04 To Convert discount from decimal (0.15) to readable percentage (15%), and flag the 6,104 orders where profit_margin is negative.
alter table ecommerce_sales
add column Discount_pct decimal(5,2);

update ecommerce_sales
set
Discount_pct = discount * 100;
select * from ecommerce_sales;

----- Loss flag
ALTER TABLE ecommerce_sales ADD COLUMN is_loss BOOLEAN;
UPDATE ecommerce_sales
SET is_loss = CASE WHEN profit_margin < 0 THEN TRUE ELSE FALSE END;

-- remove the extra spaces 
update ecommerce_sales 
set 
category = initcap(trim(category)),
payment_method = lower(trim(payment_method)),
region = initcap(trim(region)),
customer_gender = initcap(trim(customer_gender));
select * from ecommerce_sales;

--- checking duplicates
select order_id ,
count(*) as count
from ecommerce_sales
group by order_id
having count(*) >1;

-- data explorations 
-- 1. Revenue Performance Analysis
--- Q1: What is the total revenue generated?

select round(sum(revenue)) as Total_Revenue from ecommerce_sales;

--- 02 Which category generates the highest revenue?
select category ,
sum(revenue) as Total_Revenue
from ecommerce_sales
group by category
order by Total_Revenue desc;

-- 2. Regional Business Analysis
--- 03 Which region performs best?
select region ,
round(sum(revenue)) as Revenue
from ecommerce_sales
group by region
order by Revenue desc;

--- 3. Delivery Performance
-- Q4: What is the average delivery time?
select round(avg(delivery_time_days)) as Avg_Delivery_Days
from ecommerce_sales;

-- 05 Does delivery time impact returns?
select returned ,
round(avg(delivery_time_days),2) as avg_delivery
from ecommerce_sales
group by returned;

--4. Return Analysis
--- Q6: What is the return rate?
SELECT 
    COUNT(*) FILTER (WHERE returned = 'Yes') * 100.0 / COUNT(*) AS return_rate
FROM ecommerce_sales;

--- Q7 Which category has highest returns?
SELECT category,
COUNT(*) FILTER (WHERE returned = 'Yes') AS returns
FROM ecommerce_sales
GROUP BY category
ORDER BY returns DESC;

-- 5. Profitability Analysis 
--- Q8: Which category is most profitable?
SELECT category,
SUM(profit_margin) AS total_profit
FROM ecommerce_sales
GROUP BY category
ORDER BY total_profit DESC;

-- 10 How many loss-making orders?
SELECT COUNT(*) 
FROM ecommerce_sales
WHERE is_loss = TRUE;

--- 11 : Why are we making losses? (higher discount <<< lower profit)
SELECT 
    category,
   round(AVG(discount_pct),2) AS avg_discount,
    round(AVG(profit_margin),2) AS avg_profit
FROM ecommerce_sales
GROUP BY category;

--- 6. Customer Analysis
---  Q12: Who are the top customers?
SELECT customer_id,
SUM(revenue) AS total_spent
FROM ecommerce_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Q13 Sales by Gender
SELECT customer_gender,
round(SUM(revenue),2) AS revenue
FROM ecommerce_sales
GROUP BY customer_gender;

-- Q14 Age Group Analysis
SELECT 
CASE 
    WHEN customer_age < 25 THEN 'Young'
    WHEN customer_age BETWEEN 25 AND 45 THEN 'Adult'
    ELSE 'Senior'
END AS age_group,
SUM(revenue) AS revenue
FROM ecommerce_sales
GROUP BY age_group;

-- 15 Which payment method is most used?
SELECT payment_method,
COUNT(*) AS total_orders
FROM ecommerce_sales
GROUP BY payment_method
ORDER BY total_orders DESC;

--- 16 Monthly Revenue Trend
SELECT order_year, order_month,
SUM(revenue) AS revenue
FROM ecommerce_sales
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

---- 17 Which region has highest loss?
SELECT region,
SUM(profit_margin) AS profit
FROM ecommerce_sales
GROUP BY region
ORDER BY profit ASC;

-- 18 High discount but low profit products
SELECT category,
AVG(discount_pct) AS avg_discount,
AVG(profit_margin) AS avg_profit
FROM ecommerce_sales
GROUP BY category
HAVING AVG(discount_pct) >5;

------ KPIS
--- 01 Total revenue
select sum(revenue) as total_revenu
from ecommerce_sales;

--- 02 Total quantity
select sum(quantity) as Total_quantity
from ecommerce_sales;

---- 03 total profit_margin
select sum(profit_margin) as Total_profit
from ecommerce_sales;

--- 04 Total customers
select count(customer_id) as Total_customer
from ecommerce_sales;

--- 05 avg discount
SELECT round(AVG(discount_pct),2) AS avg_discount
FROM ecommerce_sales;

--- 06 Avg delivery time days
SELECT round(AVG(delivery_time_days),2) AS avg_delivery_time
FROM ecommerce_sales;

--- 07 % of order returned
SELECT 
COUNT(*) FILTER (WHERE returned = 'Yes') * 100.0 / COUNT(*) AS return_rate
FROM ecommerce_sales;

--- 08 Avg revenue per customer
SELECT SUM(revenue) / COUNT(DISTINCT customer_id) AS revenue_per_customer
FROM ecommerce_sales;

----------------------- END OF THE PROJECT >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>