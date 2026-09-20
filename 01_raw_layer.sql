 ============================================================
-- SALES & CUSTOMER SUPPORT ANALYTICS
-- RAW DATA LAYER
-- ============================================================
-- This layer represents the original synthetic source data.
-- No real customer or company data is used in this project.
--
-- Dataset size:
-- Customers        : 50,000
-- Products         : 1,000
-- Orders           : 500,000
-- Order Items      : 1,000,000
-- Support Tickets  : 300,000
-- ============================================================

CREATE SCHEMA IF NOT EXISTS raw;

-- Customers
CREATE TABLE IF NOT EXISTS raw.customers (
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    country VARCHAR(50),
    customer_segment VARCHAR(30),
    signup_date DATE
);

-- Products
CREATE TABLE IF NOT EXISTS raw.products (
    product_id VARCHAR,
    product_name VARCHAR,
    product_category VARCHAR,
    product_family VARCHAR,
    launch_date DATE
);

-- Orders
CREATE TABLE IF NOT EXISTS raw.orders (
    order_id VARCHAR,
    customer_id VARCHAR,
    order_date DATE,
    order_status VARCHAR,
    payment_method VARCHAR,
    sales_channel VARCHAR
);

-- Order Items
CREATE TABLE IF NOT EXISTS raw.order_items (
    order_item_id VARCHAR,
    order_id VARCHAR,
    product_id VARCHAR,
    quantity INTEGER,
    unit_price NUMERIC,
    discount_percent NUMERIC
);

-- Support Tickets
CREATE TABLE IF NOT EXISTS raw.support_tickets (
    ticket_id BIGINT,
    customer_id BIGINT,
    created_date TIMESTAMP,
    country VARCHAR,
    product_category VARCHAR,
    issue_type VARCHAR,
    priority VARCHAR,
    support_channel VARCHAR,
    agent_id INTEGER,
    status VARCHAR,
    resolution_hours NUMERIC,
    sla_target_hours INTEGER,
    customer_satisfaction INTEGER
);

-- Validate raw table row counts
SELECT 'Customers' AS dataset, COUNT(*) AS row_count
FROM raw.customers

UNION ALL

SELECT 'Products', COUNT(*)
FROM raw.products

UNION ALL

SELECT 'Orders', COUNT(*)
FROM raw.orders

UNION ALL

SELECT 'Order Items', COUNT(*)
FROM raw.order_items

UNION ALL

SELECT 'Support Tickets', COUNT(*)
FROM raw.support_tickets;
