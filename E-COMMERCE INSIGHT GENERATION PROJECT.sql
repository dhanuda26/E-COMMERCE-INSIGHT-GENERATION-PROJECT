create database sql_bi;

use sql_bi;

select * from orders;

select * from products;

select * from customers;

-- Basic SQL Questions:
-- Customer-Based Questions: 
-- 1.	How many unique customers placed orders?
select count(distinct customer_id) as unique_customers from orders;

-- 2.	List the top 5 cities with the most customers.
select city, count(*) as customer_count from customers group by city order by customer_count desc limit 5;

-- 3.	Write a query to find the customer who spent the most money on orders.
select c.customer_name, sum(o.total_amount) as total_spent
from orders o join customers c on o.customer_id = c.customer_id group by c.customer_name order by total_spent desc limit 1;

-- 4.	Write a query to get the customer who placed the highest number of orders.
select c.customer_name, count(*) AS order_count from orders o
join customers c on o.customer_id = c.customer_id group by c.customer_name order by order_count desc limit 1;

-- Revenue/Order-Based Questions: 
-- 5.	Write a query to calculate the total revenue generated from all orders.
select sum(total_amount) as total_revenue from orders;

-- 6.	Write a query to find the average order value (AOV).
select avg(total_amount) as average_order_value from orders;

-- 7.	Write a query to get the number of orders placed per month.
select extract(year from order_date) as year, extract(month from order_date) as month, 
count(*) as order_count from orders group by year, month order by year, month;

-- Product-Based Questions: 
-- 10.	Write a query to get the top 3 best-selling products based on quantity sold.
select p.product_name, sum(o.quantity) as total_quantity from orders o
join products p on o.product_id = p.product_id group by p.product_name order by total_quantity desc limit 3;

-- 11.	Write a query to identify the least sold product based on quantity.
select p.product_name, sum(o.quantity) as total_quantity from orders o
join products p on o.product_id = p.product_id group by p.product_name order by total_quantity asc limit 1;

-- Advanced SQL Questions:
-- 12.	Write a query to find the month with the highest total revenue.
select extract(year from order_date) as year, extract(month from order_date) as month,
sum(total_amount) as monthly_revenue from orders group by year, month order by monthly_revenue desc limit 1;

-- 13.	Write a query to find the product that generated the highest revenue.
select p.product_name, sum(o.total_amount) as revenue from orders o
join products p on o.product_id = p.product_id group by p.product_name order by revenue desc limit 1;

-- 14.	Write a query to find the product with the highest average selling price per unit.
select p.product_name, avg(o.total_amount / o.quantity) as avg_price_per_unit from orders o
join products p on o.product_id = p.product_id group by p.product_name order by avg_price_per_unit desc limit 1;

-- 15.	Write a query to calculate the percentage of total revenue contributed by each product.
with product_revenue as (select p.product_name, sum(o.total_amount) as revenue from orders o 
join products p on o.product_id = p.product_id group by p.product_name),
total_revenue as(select sum(revenue) as total from product_revenue)
select pr.product_name, pr.revenue, (pr.revenue / tr.total) * 100 as revenue_percentage
from product_revenue pr, total_revenue tr order by revenue_percentage desc;