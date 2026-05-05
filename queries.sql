-- =========================================
-- PROJECT: E-Commerce SQL Analysis
-- =========================================


-- 1. TOTAL REVENUE
-- Objective: Calculate total revenue generated from all orders

SELECT SUM(amount) AS total_revenue
FROM orders;



-- 2. REVENUE PER CITY
-- Objective: Analyze which city generates more revenue

SELECT city,
       SUM(amount) AS total_revenue
FROM orders
GROUP BY city;



-- 3. TOP CUSTOMER
-- Objective: Identify the customer with highest spending

SELECT customer_id,
       SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 1;



-- 4. REPEAT CUSTOMERS
-- Objective: Find customers who placed more than one order

SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;



-- 5. TOTAL ORDERS PER CITY
-- Objective: Count number of orders in each city

SELECT city,
       COUNT(*) AS total_orders
FROM orders
GROUP BY city;



-- 6. DAILY REVENUE TREND
-- Objective: Analyze revenue generated per day

SELECT order_date,
       SUM(amount) AS daily_revenue
FROM orders
GROUP BY order_date
ORDER BY order_date;



-- 7. REVENUE CHANGE COMPARED TO PREVIOUS DAY
-- Objective: Identify increase/decrease in revenue

SELECT a.order_date,
       a.revenue,
       b.revenue AS prev_day,
       a.revenue - b.revenue AS change
FROM (
    SELECT order_date,
           SUM(amount) AS revenue
    FROM orders
    GROUP BY order_date
) a
LEFT JOIN (
    SELECT order_date,
           SUM(amount) AS revenue
    FROM orders
    GROUP BY order_date
) b
ON b.order_date = (
    SELECT MAX(order_date)
    FROM orders o2
    WHERE o2.order_date < a.order_date
);



-- 8. TOTAL REVENUE PER CUSTOMER
-- Objective: Calculate how much each customer has spent

SELECT customer_id,
       SUM(amount) AS total_revenue
FROM orders
GROUP BY customer_id;



-- 9. CUSTOMERS WITH MORE THAN 2 ORDERS
-- Objective: Identify frequent customers

SELECT customer_id,
       COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 2;



-- 10. TOP CITY BY REVENUE
-- Objective: Find city generating highest revenue

SELECT city,
       SUM(amount) AS total_revenue
FROM orders
GROUP BY city
ORDER BY total_revenue DESC
LIMIT 1;