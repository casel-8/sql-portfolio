
-- SQL PORTFOLIO - ZALSHA
-- Project 03: Database Design
-- Database: MySQL / PostgreSQL
-- Scenario: Simple bookstore database

-- 1. Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    city VARCHAR(100)
);

-- 2. Create products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    price DECIMAL(12,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0
);

-- 3. Create orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- 4. Create order details table
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CHECK (quantity > 0),
    CHECK (unit_price >= 0)
);

-- 5. Insert sample data
INSERT INTO customers VALUES
(1, 'Nadia', 'nadia@example.com', 'Bandung'),
(2, 'Rafi', 'rafi@example.com', 'Jakarta');

INSERT INTO products VALUES
(101, 'Database Fundamentals', 120000, 20),
(102, 'Learning SQL', 95000, 15);

INSERT INTO orders VALUES
(1001, 1, '2026-10-10'),
(1002, 2, '2026-10-11');

INSERT INTO order_details VALUES
(1, 1001, 101, 2, 120000),
(2, 1001, 102, 1, 95000),
(3, 1002, 102, 2, 95000);

-- 6. Retrieve order details
SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    od.quantity,
    od.unit_price,
    od.quantity * od.unit_price AS subtotal
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN order_details od
    ON o.order_id = od.order_id
INNER JOIN products p
    ON od.product_id = p.product_id
ORDER BY o.order_id;
