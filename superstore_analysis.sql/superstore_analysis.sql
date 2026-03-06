-- CREATE DATABASE
create database project2;

use project2;

select * from superstore;

-- A. Basic Data Exploration
-- 1) List all distinct regions.
select distinct region from superstore;

-- 2)List all categories and Sub-Categories
SELECT category, `Sub-Category`
FROM superstore
LIMIT 0,10000;

-- 3)Find the total number of unique customers.
select distinct count('Customer ID') as totaluniquecutomers
from superstore;

-- B. Sales & Profit Analysis
-- 1)Total sales and profit in the dataset.
select sum(sales) as totalsales,
       sum(profit) as totalprofit
from superstore;

-- 2)Total sales and profit by category.
select category,
       sum(sales) as totalsales,
	   sum(profit) as totalprofit
from superstore
       group by category;
       
-- 3)Total sales and profit by region.
select region,
       sum(sales) as totalsales,
	   sum(profit) as totalprofit
from superstore
       group by region;
       
-- 4)Average sales per order.
select sales, avg(sales) as avgsales from superstore
group by sales;

-- 5)Orders that made negative profit.
SELECT *
FROM superstore
WHERE profit < 0;

-- C. Customer Analysis
-- 1)Top 10 customers by sales
select sales from superstore
order by 'customer name'
limit 10;

-- 2)Top 10 customers by profit.
select profit from superstore
order by 'customer name'
limit 10;

-- 3)Customers who made loss orders.
SELECT `Customer Name`
FROM superstore
WHERE Profit < 0;

-- 4) Count of customers in each segment
select segment,
       count(`customer id`) as customercount
from superstore
 group by segment;
 
-- D. Product Analysis
-- 1)Top 10 products by sales.
select sales from superstore
order by 'project name'
limit 10;

-- 2)Top 10 products by sales.
select profit from superstore
order by 'project name'
limit 10;

-- 3)Products causing losses.
select `product name` from superstore
where profit < 0;

-- 4)Total quantity sold by category.
select category,
       sum(Quantity) as totalQuantity
from superstore
group by category;

-- 5)Sub-categories with highest average profit per order.
select `sub-category`,
       avg(profit) as highestavgprofit
from superstore
group by `sub-category`
order by highestavgprofit desc;

-- E. Time-Based Analysis
-- 1)Monthly sales trends
     SELECT 
YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS year,
MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS month,
SUM(Sales) AS total_sales
FROM superstore
GROUP BY year, month
ORDER BY year, month;
-- ALTER
SELECT 
MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS month,
SUM(Sales) AS total_sales
FROM superstore
GROUP BY MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))
ORDER BY total_sales DESC;

-- 2)Find total profit each month.
SELECT 
MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS month,
SUM(profit) AS total_profit
FROM superstore
GROUP BY MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))
ORDER BY total_profit DESC;

-- 3)Number of Orders Each Year
SELECT 
YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS YEAR,
count(distinct `Order id`) as countoforders
FROM superstore
GROUP BY year(STR_TO_DATE(`Order Date`, '%m/%d/%Y'));

-- F. Shipping & Delivery Analysis
-- 1)Total orders by ship mode.
select `ship mode`,
count(distinct `Order id`) as totalorders
FROM superstore
GROUP BY `ship mode`;

-- 2)Average delivery time (ship_date – order_date)
select 
avg(datediff(STR_TO_DATE(`ship date`, '%m/%d/%Y'),
		STR_TO_DATE(`order date`, '%m/%d/%Y'))) as avgdeliverydates
from superstore

-- 3)Ship modes with highest profit and highest loss.
select `Ship Mode`,
       SUM(Profit) AS total_profit
FROM superstore
GROUP BY `Ship Mode`
ORDER BY total_profit DESC
LIMIT 1;
-- highest loss
SELECT `Ship Mode`,
       SUM(Profit) AS total_profit
FROM superstore
GROUP BY `Ship Mode`
ORDER BY total_profit asc
LIMIT 1;
