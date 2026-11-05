
-- SQL PORTFOLIO - ZALSHA
-- Project 02: Sales Reporting
-- Database: MySQL / PostgreSQL

-- Assumes customers and orders tables from Project 01.

-- 1. Overall sales summary
SELECT
    COUNT(*) AS total_transactions,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS average_order_value
FROM orders
WHERE status = 'Completed';

-- 2. Sales summary by order status
SELECT
    status,
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_amount
FROM orders
GROUP BY status
ORDER BY total_orders DESC;

-- 3. Revenue by city
SELECT
    c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_revenue
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY c.city
ORDER BY total_revenue DESC;

-- 4. Monthly sales report
SELECT
    EXTRACT(YEAR FROM order_date) AS sales_year,
    EXTRACT(MONTH FROM order_date) AS sales_month,
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM orders
WHERE status = 'Completed'
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY sales_year, sales_month;

-- 5. Customers with completed purchases above 300000
SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) > 300000
ORDER BY total_spent DESC;
