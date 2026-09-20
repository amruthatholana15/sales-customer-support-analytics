SYNTHETIC DATA GENERATION
-- Sales & Customer Support Analytics
-- ============================================================
-- Generates approximately 1.85 million synthetic records.
-- This dataset is created for learning and portfolio purposes.
-- No real customer or company data is used.
-- ============================================================


-- ============================================================
-- 1. CUSTOMERS - 50,000 ROWS
-- ============================================================

INSERT INTO raw.customers
(
    customer_id,
    customer_name,
    country,
    customer_segment,
    signup_date
)
SELECT
    'CUST' || LPAD(gs::text, 6, '0'),
    'Customer ' || gs,
    (ARRAY[
        'India',
        'Australia',
        'Singapore',
        'Malaysia',
        'Philippines',
        'Indonesia',
        'New Zealand'
    ])[1 + FLOOR(RANDOM() * 7)::int],
    (ARRAY[
        'Consumer',
        'SMB',
        'Enterprise'
    ])[1 + FLOOR(RANDOM() * 3)::int],
    CURRENT_DATE - (FLOOR(RANDOM() * 1825)::int)
FROM generate_series(1, 50000) AS gs;


-- ============================================================
-- 2. PRODUCTS - 1,000 ROWS
-- ============================================================

INSERT INTO raw.products
(
    product_id,
    product_name,
    product_category,
    product_family,
    launch_date
)
SELECT
    'PROD' || LPAD(gs::text, 5, '0'),
    'Product ' || gs,
    (ARRAY[
        'Laptop',
        'Desktop',
        'Printer',
        'Monitor',
        'Accessory'
    ])[1 + FLOOR(RANDOM() * 5)::int],
    (ARRAY[
        'Consumer',
        'Business',
        'Gaming',
        'Premium'
    ])[1 + FLOOR(RANDOM() * 4)::int],
    CURRENT_DATE - (FLOOR(RANDOM() * 1825)::int)
FROM generate_series(1, 1000) AS gs;


-- ============================================================
-- 3. ORDERS - 500,000 ROWS
-- ============================================================

INSERT INTO raw.orders
(
    order_id,
    customer_id,
    order_date,
    order_status,
    payment_method,
    sales_channel
)
SELECT
    'ORD' || LPAD(gs::text, 7, '0'),

    'CUST' || LPAD(
        (1 + FLOOR(RANDOM() * 50000))::int::text,
        6,
        '0'
    ),

    CURRENT_DATE - (FLOOR(RANDOM() * 365)::int),

    (ARRAY[
        'Completed',
        'Shipped',
        'Processing',
        'Cancelled',
        'Returned'
    ])[1 + FLOOR(RANDOM() * 5)::int],

    (ARRAY[
        'Credit Card',
        'Debit Card',
        'UPI',
        'Bank Transfer',
        'Digital Wallet'
    ])[1 + FLOOR(RANDOM() * 5)::int],

    (ARRAY[
        'Online',
        'Retail',
        'Partner'
    ])[1 + FLOOR(RANDOM() * 3)::int]

FROM generate_series(1, 500000) AS gs;


-- ============================================================
-- 4. ORDER ITEMS - 1,000,000 ROWS
-- ============================================================

INSERT INTO raw.order_items
(
    order_item_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    discount_percent
)
SELECT
    'ITEM' || LPAD(gs::text, 8, '0'),

    'ORD' || LPAD(
        (1 + FLOOR(RANDOM() * 500000))::int::text,
        7,
        '0'
    ),

    'PROD' || LPAD(
        (1 + FLOOR(RANDOM() * 1000))::int::text,
        5,
        '0'
    ),

    1 + FLOOR(RANDOM() * 5)::int,

    ROUND(
        (50 + RANDOM() * 1950)::numeric,
        2
    ),

    (ARRAY[
        0,
        5,
        10,
        15,
        20
    ])[1 + FLOOR(RANDOM() * 5)::int]

FROM generate_series(1, 1000000) AS gs;


-- ============================================================
-- 5. SUPPORT TICKETS - 300,000 ROWS
-- ============================================================

INSERT INTO raw.support_tickets
(
    ticket_id,
    customer_id,
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
)
SELECT
    gs,

    1 + FLOOR(RANDOM() * 50000)::bigint,

    CURRENT_TIMESTAMP
        - (RANDOM() * INTERVAL '365 days'),

    (ARRAY[
        'India',
        'Australia',
        'Singapore',
        'Malaysia',
        'Philippines',
        'Indonesia',
        'New Zealand'
    ])[1 + FLOOR(RANDOM() * 7)::int],

    (ARRAY[
        'Laptop',
        'Desktop',
        'Printer',
        'Monitor',
        'Accessory'
    ])[1 + FLOOR(RANDOM() * 5)::int],

    (ARRAY[
        'Hardware',
        'Software',
        'Connectivity',
        'Setup',
        'Performance'
    ])[1 + FLOOR(RANDOM() * 5)::int],

    (ARRAY[
        'Low',
        'Medium',
        'High',
        'Critical'
    ])[1 + FLOOR(RANDOM() * 4)::int],

    (ARRAY[
        'Phone',
        'Chat',
        'Email',
        'Web'
    ])[1 + FLOOR(RANDOM() * 4)::int],

    1 + FLOOR(RANDOM() * 100)::int,

    (ARRAY[
        'Open',
        'In Progress',
        'Resolved',
        'Closed'
    ])[1 + FLOOR(RANDOM() * 4)::int],

    ROUND(
        (1 + RANDOM() * 95)::numeric,
        2
    ),

    (ARRAY[
        4,
        8,
        24,
        48
    ])[1 + FLOOR(RANDOM() * 4)::int],

    1 + FLOOR(RANDOM() * 5)::int

FROM generate_series(1, 300000) AS gs;


-- ============================================================
-- VALIDATE GENERATED DATA
-- ============================================================

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
