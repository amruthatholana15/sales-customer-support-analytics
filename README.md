# Sales & Customer Support Analytics

## Project Overview

This is an end-to-end data analytics portfolio project built using PostgreSQL, Supabase, SQL, and Power BI.

The project uses approximately 1.85 million synthetic business records across customers, products, orders, order items, and customer support tickets.

The objective of the project was to simulate a real-world analytics workflow by transforming raw data into clean, business-ready datasets and using them to analyze Sales and Customer Support performance.

## Project Files

- [Power BI Dashboard](Sales_Customer_Support_Analytics.pbix)
- [Raw Data Layer](01_raw_layer.sql)
- [Synthetic Data Generation](02_generate_synthetic_data.sql)
- [Staging & Data Cleaning](03_staging_layer.sql)
- [Analytics Layer](04_analytics_layer.sql)
- [Business Analysis & KPI Queries](05_business_analysis.sql)

## Data Pipeline

The project follows the following data flow:

Synthetic Data → Raw Layer → Staging Layer → Analytics Layer → Power BI

### Raw Layer
The Raw layer stores the original generated datasets before transformation.

- Customers: 50,000 records
- Products: 1,000 records
- Orders: 500,000 records
- Order Items: 1,000,000 records
- Support Tickets: 300,000 records

### Staging Layer
The Staging layer was used to clean and standardize the raw data.

Key transformations included:

- Removing unnecessary spaces using TRIM()
- Standardizing text and categorical values
- Standardizing customer ID formats
- Handling data-type inconsistencies
- Checking duplicate records
- Validating row counts

### Analytics Layer
The Analytics layer contains business-ready Sales and Customer Support datasets.

SQL JOINs were used to combine customers, orders, order items, and products into the Sales dataset.

Support ticket data was prepared for SLA, resolution-time, and customer-satisfaction analysis.

## Sales Analysis

Key KPIs:

- Total Revenue
- Total Orders
- Average Order Value
- Total Units Sold
- Monthly Revenue Trend
- Revenue by Country
- Revenue by Product Category
- Revenue by Customer Segment
- Top 10 Products by Revenue

Revenue was calculated as:

Revenue = Quantity × Unit Price × (1 - Discount % / 100)

## Customer Support & SLA Analysis

Key KPIs:

- Total Tickets
- SLA Performance %
- Average Resolution Hours
- Average Customer Satisfaction
- SLA Met vs SLA Missed
- SLA Performance by Priority
- SLA Performance by Country
- Monthly Support Ticket Trend

A ticket was classified as SLA Met when:

Resolution Hours <= SLA Target Hours

Otherwise, the ticket was classified as SLA Missed.

## Power BI Dashboards

Two interactive dashboards were developed:

### Sales Performance Dashboard
Provides insights into revenue, orders, sales trends, customer segments, countries, product categories, and top-performing products.

### Customer Support & SLA Dashboard
Provides insights into ticket volume, SLA performance, resolution time, customer satisfaction, priority performance, country performance, and monthly ticket trends.

## Tools & Technologies

- PostgreSQL
- Supabase
- SQL
- Power BI
- DAX
- Power Query

## Skills Demonstrated

- SQL Data Extraction
- Data Cleaning & Transformation
- Data Pipeline Concepts
- Data Validation
- SQL JOINs
- KPI Analysis
- Business Analysis
- SLA Analysis
- Power BI
- DAX
- Data Visualization
- Dashboard Development

## Key Business Insights

### Sales Performance
- The dataset generated approximately 2.77B in total revenue across approximately 432K distinct orders.
- Average Order Value was approximately 6.40K, with around 3M units sold.
- Accessories generated the highest revenue among the analyzed product categories.
- Revenue contribution was relatively balanced across customer segments and countries.
- Monthly revenue trends were analyzed to identify changes in sales performance over time.

### Customer Support Performance
- Approximately 300K customer support tickets were analyzed.
- Overall SLA performance was approximately 21.1%, indicating that a large proportion of tickets exceeded their assigned SLA target in the synthetic dataset.
- Average resolution time was approximately 48.4 hours.
- Average customer satisfaction was approximately 3.0 out of 5.
- SLA attainment was relatively similar across countries and priority levels.
- Average CSAT was also similar between SLA-met and SLA-missed tickets, suggesting no strong relationship between SLA attainment and CSAT in this synthetic dataset.

> **Note:** 

These insights are based on synthetically generated data and demonstrate the analytical process rather than actual company performance.

## Power BI Dashboard Preview

### Sales Performance Dashboard
![Sales Performance Dashboard](sales-dashboard.png.png)

### Customer Support & SLA Dashboard
![Customer Support SLA Dashboard](support-sla-dashboard.png.png)
