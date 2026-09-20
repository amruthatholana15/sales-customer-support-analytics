 BUSINESS ANALYSIS & KPI QUERIES
-- Sales and Customer Support Analytics
-- ============================================================


-- ============================================================
-- SALES KPIs
-- ============================================================

-- 1. Total Revenue
SELECT
    ROUND(SUM(revenue), 2) AS total_revenue
FROM analytics.sales;


-- 2. Total Orders
SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM analytics.sales;


-- 3. Average Order Value
SELECT
    ROUND(
        SUM(revenue) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM analytics.sales;


-- 4. Total Units Sold
SELECT
    SUM(quantity) AS total_units_sold
FROM analytics.sales;


-- ============================================================
-- SALES PERFORMANCE ANALYSIS
-- ============================================================

-- 5. Revenue by Country
SELECT
    country,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM analytics.sales
GROUP BY country
ORDER BY total_revenue DESC;


-- 6. Revenue by Product Category
SELECT
    product_category,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM analytics.sales
GROUP BY product_category
ORDER BY total_revenue DESC;


-- 7. Revenue by Customer Segment
SELECT
    customer_segment,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM analytics.sales
GROUP BY customer_segment
ORDER BY total_revenue DESC;


-- 8. Top 10 Products by Revenue
SELECT
    product_name,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM analytics.sales
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 10;


-- 9. Monthly Revenue Trend
SELECT
    DATE_TRUNC('month', order_date) AS month,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM analytics.sales
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;


-- ============================================================
-- CUSTOMER SUPPORT KPIs
-- ============================================================

-- 10. Total Support Tickets
SELECT
    COUNT(*) AS total_tickets
FROM analytics.support;


-- 11. SLA Performance %
SELECT
    ROUND(
        COUNT(*) FILTER (WHERE sla_status = 'SLA Met')
        * 100.0 / COUNT(*),
        2
    ) AS sla_performance_percentage
FROM analytics.support;


-- 12. Average Resolution Time
SELECT
    ROUND(AVG(resolution_hours), 2)
        AS average_resolution_hours
FROM analytics.support;


-- 13. Average Customer Satisfaction
SELECT
    ROUND(AVG(customer_satisfaction), 2)
        AS average_csat
FROM analytics.support;


-- ============================================================
-- SUPPORT PERFORMANCE ANALYSIS
-- ============================================================

-- 14. SLA Distribution
SELECT
    sla_status,
    COUNT(*) AS ticket_count
FROM analytics.support
GROUP BY sla_status
ORDER BY ticket_count DESC;


-- 15. SLA Performance by Priority
SELECT
    priority,
    COUNT(*) AS total_tickets,
    ROUND(
        COUNT(*) FILTER (WHERE sla_status = 'SLA Met')
        * 100.0 / COUNT(*),
        2
    ) AS sla_percentage
FROM analytics.support
GROUP BY priority
ORDER BY sla_percentage DESC;


-- 16. SLA Performance by Country
SELECT
    country,
    COUNT(*) AS total_tickets,
    ROUND(
        COUNT(*) FILTER (WHERE sla_status = 'SLA Met')
        * 100.0 / COUNT(*),
        2
    ) AS sla_percentage
FROM analytics.support
GROUP BY country
ORDER BY sla_percentage DESC;


-- 17. CSAT by SLA Status
SELECT
    sla_status,
    ROUND(AVG(customer_satisfaction), 2)
        AS average_csat
FROM analytics.support
GROUP BY sla_status;


-- 18. Monthly Support Ticket Trend
SELECT
    DATE_TRUNC('month', created_date) AS month,
    COUNT(*) AS total_tickets
FROM analytics.support
GROUP BY DATE_TRUNC('month', created_date)
ORDER BY month;
