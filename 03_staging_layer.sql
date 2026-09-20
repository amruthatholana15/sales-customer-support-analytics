 ============================================================
-- STAGING LAYER - DATA CLEANING & STANDARDIZATION
-- ============================================================

CREATE SCHEMA IF NOT EXISTS staging;

-- Customers
CREATE TABLE staging.customers AS
SELECT
    customer_id,
    TRIM(customer_name) AS customer_name,
    INITCAP(TRIM(country)) AS country,
    INITCAP(TRIM(customer_segment)) AS customer_segment,
    signup_date
FROM raw.customers;

-- Products
CREATE TABLE staging.products AS
SELECT
    product_id,
    TRIM(product_name) AS product_name,
    INITCAP(TRIM(product_category)) AS product_category,
    INITCAP(TRIM(product_family)) AS product_family,
    launch_date
FROM raw.products;

-- Orders
CREATE TABLE staging.orders AS
SELECT
    order_id,
    customer_id,
    order_date,
    INITCAP(TRIM(order_status)) AS order_status,
    INITCAP(TRIM(payment_method)) AS payment_method,
    INITCAP(TRIM(sales_channel)) AS sales_channel
FROM raw.orders;

-- Order Items
CREATE TABLE staging.order_items AS
SELECT
    order_item_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    discount_percent
FROM raw.order_items;

-- Support Tickets
CREATE TABLE staging.support_tickets AS
SELECT
    ticket_id,
    customer_id,
    created_date,
    INITCAP(TRIM(country)) AS country,
    INITCAP(TRIM(product_category)) AS product_category,
    INITCAP(TRIM(issue_type)) AS issue_type,
    INITCAP(TRIM(priority)) AS priority,
    INITCAP(TRIM(support_channel)) AS support_channel,
    agent_id,
    INITCAP(TRIM(status)) AS status,
    resolution_hours,
    sla_target_hours,
    customer_satisfaction
FROM raw.support_tickets;

-- Validate staging row counts
SELECT 'Customers' AS dataset, COUNT(*) AS row_count
FROM staging.customers
UNION ALL
SELECT 'Products', COUNT(*) FROM staging.products
UNION ALL
SELECT 'Orders', COUNT(*) FROM staging.orders
UNION ALL
SELECT 'Order Items', COUNT(*) FROM staging.order_items
UNION ALL
SELECT 'Support Tickets', COUNT(*) FROM staging.support_tickets;
