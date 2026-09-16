--1. tổng doanh thu--
SELECT SUM(total_price) AS total_revenue FROM pizza_sales;
-- 2. Gía trị trung bình mỗi đơn hàng-
select sum(total_price)/count(distinct order_id)as Avg_order_value 
from pizza_sales
--3. tính tổng số lượng bán--
Select sum(quantity) as Total_pizza_sold from pizza_sales;
-- 4. tính tổng số lượng đơn đã order-- 
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
-- 5. tính trung bình số lượng pizza mỗi order--
SELECT 
    CAST(
        CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))
    AS DECIMAL(10,2)) 
    AS avg_pizza_per_order
FROM pizza_sales;
select datename (month, order_date)as month_name , count (distinct order_id) as total_orders
from pizza_sales 
group by datename (month, order_date)
order by total_orders DESC
SELECT 
    DAY(order_date) AS day_of_month,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAY(order_date)
ORDER BY total_orders DESC;
--6. thống kê các ngày trong từng tháng để xem ngày nào bán chạy nhất-- 
SELECT 
    MONTH(order_date) AS month_number,
    DAY(order_date) AS day_of_month,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY MONTH(order_date), DAY(order_date)
ORDER BY month_number ASC, total_orders DESC;
-- 7. tính % theo từng ngành hàng-- sắp xếp từ lớn đến nhỏ 
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category
order by PCT DESC
-- 8. tính % sales by pizza size-- 
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
order by PCT DESC
-- 9. tổng pizza sold by pizza Category-- 
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC
-- 10. top 5 sản phẩm pizza by Revenue- 
select top 5 pizza_name, sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenueX desc
-- top 5 sản phẩm thấp nhất by revenue-- 
select top 5 pizza_name, sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue asc
-- top 5 by Quantity-- 
select top 5 pizza_name, sum(quantity) as total_pizza_sold 
from pizza_sales
group by pizza_name
order by total_pizza_sold asc
-- bottom 5 pizza by quantity 
Select top 5 pizza_name, sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_name 
order by total_pizza_sold asc

-- top pizza by orders--
select top 5 pizza_name, count(distinct order_id) as total_orders
from pizza_sales
group by pizza_name
order by total_orders desc
-- bottom 5 pizza by orders-- 
select top 5 pizza_name, count(distinct order_id) as total_orders
from pizza_sales
group by pizza_name
order by total_orders asc
