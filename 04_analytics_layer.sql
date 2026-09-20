 ============================================================
-- ANALYTICS LAYER
-- Business-ready datasets for analysis and Power BI
-- ============================================================

CREATE SCHEMA IF NOT EXISTS analytics;

-- ============================================================
-- SALES ANALYTICS TABLE
-- Combines Customers, Orders, Order Items and Products
-- ============================================================

CREATE TABLE analytics.sales AS
SELECT
    customers.customer_id,
    orders.order_id,
    orders.order_date,
    customers.country,
    customers.customer_segment,
    products.product_id,
    products.product_name,
    products.product_category,
    order_items.quantity,
    order_items.unit_price,
    order_items.discount_percent
FROM staging.orders AS orders
INNER JOIN staging.customers AS customers
    ON orders.customer_id = customers.customer_id
INNER JOIN staging.order_items AS order_items
    ON orders.order_id = order_items.order_id
INNER JOIN staging.products AS products
    ON order_items.product_id = products.product_id;


-- Add Revenue column
ALTER TABLE analytics.sales
ADD COLUMN revenue NUMERIC(12,2);


-- Calculate Revenue
-- Revenue = Quantity × Unit Price × (1 - Discount %)

UPDATE analytics.sales
SET revenue = ROUND(
    quantity * unit_price * (1 - discount_percent / 100),
    2
);


-- ============================================================
-- CUSTOMER SUPPORT ANALYTICS TABLE
-- Standardize customer ID for analytics
-- Example: 25 → CUST000025
-- ============================================================

CREATE TABLE analytics.support AS
SELECT
    ticket_id,
    'CUST' || LPAD(customer_id::text, 6, '0') AS customer_id,
    created_date,
    country,
    product_category,
    issue_type,
    priority,
    support_channel,
    agent_id,
    status,
    resolution_hours,
    sla_target_hours,
    customer_satisfaction
FROM staging.support_tickets;


-- Add SLA classification
ALTER TABLE analytics.support
ADD COLUMN sla_status VARCHAR(20);


-- Determine whether each support ticket met its SLA
UPDATE analytics.support
SET sla_status =
    CASE
        WHEN resolution_hours <= sla_target_hours
            THEN 'SLA Met'
        ELSE 'SLA Missed'
    END;


-- ============================================================
-- VALIDATION
-- ============================================================

SELECT
    'Sales' AS dataset,
    COUNT(*) AS row_count
FROM analytics.sales

UNION ALL

SELECT
    'Support',
    COUNT(*)
FROM analytics.support;
