
-- SQL PORTFOLIO - ZALSHA
-- Project 01: SQL Query Practice
-- Database: MySQL / PostgreSQL
-- Dataset: Fictional online store

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(12,2),
    status VARCHAR(30),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

INSERT INTO customers VALUES
(1, 'Alya', 'Bandung'),
(2, 'Bima', 'Jakarta'),
(3, 'Citra', 'Bandung'),
(4, 'Doni', 'Surabaya');

INSERT INTO orders VALUES
(101, 1, '2026-10-01', 250000, 'Completed'),
(102, 2, '2026-10-02', 400000, 'Completed'),
(103, 1, '2026-10-05', 150000, 'Pending'),
(104, 3, '2026-10-06', 300000, 'Completed'),
(105, 2, '2026-10-08', 100000, 'Cancelled');

-- 1. Retrieve completed orders
SELECT *
FROM orders
WHERE status = 'Completed'
ORDER BY order_date;

-- 2. Display orders with customer information
SELECT
    o.order_id,
    c.customer_name,
    c.city,
    o.order_date,
    o.total_amount,
    o.status
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id;

-- 3. Calculate completed sales by customer
SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_sales
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_sales DESC;

-- 4. Find customers who have no orders
SELECT
    c.customer_id,
    c.customer_name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 5. Find orders above the average order amount
SELECT *
FROM orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM orders
);
