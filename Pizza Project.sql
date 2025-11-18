use Pizza_DB
go

select * from pizza_sales

--All KPI's ::--
--Total Revenue
select sum(total_price) as Total_Revenue from pizza_sales

--Average Order Value
select sum(total_price) /count(distinct order_id) as Avg_Order_Value from pizza_sales

--Total Pizzas Sold
select sum(quantity) as Total_Pizzas_Sold from pizza_sales

--Total Order Placed
select count(distinct order_id) as Total_Orders from pizza_sales

--Average Pizzas Per Order
select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id)as decimal(10,2))as decimal(10,2)) as Avg_Pizzas_Per_Order from pizza_sales


--All Charts Requirements::--

--1. Daily Trends for Total Orders:
select DATENAME(dw,order_date) as Order_day,count(distinct order_id) as Total_Sales from pizza_sales
group by DATENAME(dw,order_date)

--2. Monthly Trend for Total Orders:
select datename(mm,order_date) as Month_Name,count(distinct order_id) as Total_Orders from pizza_sales
group by datename(mm,order_date),datepart(mm,order_date)
order by datepart(mm,order_date)

--3. Percentage of Sales by Pizza Category:
select pizza_category,sum(total_price)*100/(select sum(total_price) from pizza_sales) as Percentage_of_Sales
from pizza_sales
group by pizza_category

--4. Percentage of Sales by Pizza Size:
select pizza_size,cast(sum(total_price)*100/(select sum(total_price)
from pizza_sales)as decimal(10,2)) as Percentage_of_Sales
from pizza_sales
group by pizza_size
order by Percentage_of_Sales desc

--5. Total Pizzas Sold by Pizza Category
select pizza_category,sum(order_id)as[Total Pizzas Sold]  from pizza_sales
group by pizza_category

--6. Top 5 Best Sellers by Revenue,Total Quantity and Total Orders
select top 5 pizza_name,sum(total_price)Revenue, sum(quantity)as[Total Quantity],sum(order_id)as[Total Orders] from pizza_sales
group by pizza_name
order by Revenue desc

--7. Bottom 5 Best Sellers by Revenue
select top 5 pizza_name,sum(total_price)Revenue, sum(quantity)as[Total Quantity],sum(order_id)as[Total Orders] from pizza_sales
group by pizza_name
order by Revenue asc

--8. Top 5 seller wrt to quantity
select top 5 pizza_name,sum(quantity)Total_Quantity from pizza_sales
group by pizza_name
order by Total_Quantity desc



select pizza_name,count(*) from pizza_sales
group by pizza_name
order by count(*) desc











