# AtliQ Hardware AWS Redshift Power BI Analytics Pipeline

**Dashboard Link:** https://shorturl.at/HpklT  
**Project Type:** Business Intelligence, Cloud Analytics, Data Warehousing, KPI Reporting  
**Domain:** Consumer Electronics, Sales, Finance, Supply Chain, Executive Analytics

---

## Project Overview

This project is an end-to-end analytics and business intelligence solution built around the AtliQ Hardware BI360 case study. The original version focused on Power BI reporting, data modeling, Power Query transformations, DAX measures, and executive dashboards. I enhanced the project by adding an AWS-based analytics layer using Amazon S3, AWS Glue Data Catalog, Amazon Athena, Amazon Redshift, SQL validation, Python profiling, and a PySpark-ready transformation script.

The goal of the project is to help AtliQ Hardware move from manual reporting and intuition-based decisions toward a structured analytics workflow where business users can monitor sales, forecast accuracy, customer performance, product profitability, supply chain risk, and executive KPIs from a single reporting solution.

---

## About AtliQ Hardware

AtliQ Hardware is a global electronics manufacturer operating across multiple markets, regions, customers, channels, and product categories. As the company expanded, business teams faced challenges with scattered Excel files, survey-based decisions, inconsistent KPI definitions, and limited visibility across Finance, Sales, Marketing, Supply Chain, and Executive reporting.

This BI360 solution was created to bring these business areas into one reporting framework so stakeholders can make faster and more reliable data-driven decisions.

---

## Business Problem

AtliQ Hardware needed a reporting solution that could answer important business questions such as:

- Which regions, markets, customers, and products are driving revenue?
- How are actual sales performing against benchmark and target values?
- Which products or segments are profitable and which are underperforming?
- Where is forecast accuracy strong or weak?
- Which customers or product groups are creating excess inventory or out-of-stock risk?
- How can executives track revenue, gross margin, net profit, forecast accuracy, and market share in one view?
- How can raw business files be organized into a scalable cloud analytics layer?

---

## Solution Summary

The solution combines Power BI reporting with a cloud-based analytics pipeline.

Raw sales, forecast, customer, product, and market files are organized in Amazon S3. Athena external tables are created on top of the S3 raw layer and registered through the AWS Glue Data Catalog. SQL queries validate the data, create KPI transformation views, and materialize curated Parquet outputs back into S3. These curated outputs are loaded into Amazon Redshift as warehouse-ready reporting tables. The Power BI dashboard represents the final business reporting layer using Power Query, relationships, calculated fields, DAX measures, and interactive visuals.

---

## Architecture Flow

```text
Raw CSV / Excel Files
        ↓
Amazon S3 Raw Data Layer
        ↓
AWS Glue Data Catalog + Amazon Athena External Tables
        ↓
Athena SQL Validation and KPI Transformation Views
        ↓
S3 Curated Parquet Outputs
        ↓
Amazon Redshift Reporting Tables
        ↓
Power BI Reporting Layer
        ↓
Business Insights and Executive Dashboards
```

---

## Tech Stack

### Cloud and Data Platform

- Amazon S3
- AWS Glue Data Catalog
- Amazon Athena
- Amazon Redshift

### Data Processing and Validation

- SQL
- Python
- Pandas
- PySpark-ready transformation logic

### Business Intelligence

- Power BI Desktop
- Power Query
- DAX
- DAX Studio

### Data Modeling

- Star schema modeling
- Fact and dimension tables
- KPI views
- Curated reporting tables
- Dashboard-level semantic modeling

---

## Dataset Overview

The project uses dimension and fact tables from the AtliQ Hardware BI360 business case.

### Dimension Tables

**dim_customer**  
Customer-level details including customer name, customer code, market, platform, and channel.

**dim_market**  
Market-level details including market, sub-zone, and region.

**dim_product**  
Product-level details including product code, product name, division, segment, category, and variant.

### Fact Tables

**fact_sales_monthly**  
Monthly actual sales quantity by date, product, customer, market, platform, and channel.

**fact_forecast_monthly**  
Monthly forecast quantity by date, product, customer, market, platform, and channel.

### Additional BI360 Reporting Components

The Power BI reporting layer also includes broader BI360 logic for finance, sales, marketing, supply chain, and executive reporting, including calculated measures for net sales, gross margin, net profit, forecast accuracy, net error, risk, and market share.

---

## AWS Implementation

### 1. Amazon S3 Raw Layer

Raw source files were uploaded into structured S3 folders:

```text
raw/dim_product/
raw/dim_customer/
raw/dim_market/
raw/fact_sales_monthly/
raw/fact_forecast_monthly/
```

This layer stores the original source files before transformation.

### 2. Athena and Glue Data Catalog

Amazon Athena external tables were created on top of the S3 raw folders. These tables are registered in the AWS Glue Data Catalog, making the raw files queryable using SQL without loading them into a database first.

Tables created:

- dim_product
- dim_customer
- dim_market
- fact_sales_monthly
- fact_forecast_monthly

### 3. SQL Data Validation

SQL validation queries were added to check:

- Row counts across source tables
- Duplicate product codes
- Duplicate customer codes
- Duplicate market records
- Missing product mappings
- Missing customer mappings
- Missing market mappings
- Invalid sales quantities
- Invalid forecast quantities
- Negative quantity values

These checks improve trust in the data before it is used for KPI reporting.

### 4. KPI Transformation Views

Athena SQL views were created to combine actual sales and forecast data and calculate reporting metrics.

KPI views include:

- Market-level forecast KPIs
- Product-level forecast KPIs
- Customer and channel-level KPIs
- Executive summary KPIs

Key calculated metrics include:

- Total sold quantity
- Total forecast quantity
- Forecast gap
- Absolute error
- Forecast accuracy percentage
- Active products
- Active customers
- Active markets

### 5. Curated S3 Parquet Layer

KPI outputs were materialized back into S3 as Parquet files to create a curated reporting layer.

Curated folders include:

```text
curated/market_kpis/
curated/product_kpis/
curated/customer_kpis/
curated/executive_summary/
```

### 6. Amazon Redshift Reporting Layer

The curated Parquet outputs were loaded from S3 into Amazon Redshift reporting tables. Redshift acts as the structured warehouse-ready layer for analytical querying and BI reporting.

Redshift tables include:

- executive_summary
- market_forecast_kpis
- product_forecast_kpis
- customer_channel_kpis

---

## Power BI Dashboard Pages

The Power BI report contains multiple business views designed for different stakeholder groups.

### Home / Navigation Page

The report begins with a BI360 landing page that allows users to navigate to Finance, Sales, Marketing, Supply Chain, Executive, Info, and Support views. The report includes a refresh date, business-value notation, and sales data loading information.

### Finance View

The Finance View provides a profit and loss reporting page for analyzing financial performance across customers, products, countries, and time periods.

Key elements include:

- Net Sales
- Gross Margin Percentage
- Net Profit Percentage
- Profit and Loss Statement
- Net Sales Performance Over Time
- Top and bottom products and customers by Net Sales
- Region and segment-level financial breakdowns

Example dashboard KPIs include Net Sales of **$3.74bn**, Gross Margin of **38.08%**, and Net Profit Percentage of **-13.98%** for the selected period.

### Sales View

The Sales View focuses on customer and product performance.

Key elements include:

- Customer Performance table
- Product Performance table
- Performance Matrix
- Unit Economics
- Net Sales and Gross Margin comparison
- Customer-level profitability and growth analysis

This page helps identify high-value customers, customer profitability, and sales contribution across regions and segments.

### Marketing View

The Marketing View focuses on product, region, market, and customer profitability.

Key elements include:

- Product Performance by segment
- Region, market, and customer performance
- Gross Margin and Total COGS comparison
- Net Profit waterfall analysis
- Performance Matrix by product division
- Unit Economics view

This view helps evaluate product profitability, operating expense impact, and market-level business performance.

### Supply Chain View

The Supply Chain View analyzes forecast accuracy, net error, absolute error, and inventory risk.

Key elements include:

- Forecast Accuracy
- Net Error
- Absolute Error
- Accuracy and Net Error Trend
- Key Metrics by Customer
- Key Metrics by Product
- Risk classification such as Excess Inventory and Out of Stock

Example dashboard KPIs include Forecast Accuracy of **81.17%**, Net Error of **-3472.7K**, and Absolute Error of **6899.0K** for the selected period.

### Executive View

The Executive View consolidates the most important business metrics for leadership.

Key elements include:

- Net Sales
- Gross Margin Percentage
- Net Profit Percentage
- Forecast Accuracy
- Revenue by Division
- Revenue by Channel
- Sub-zone performance
- Yearly trend by revenue, gross margin, net profit, and market share
- PC market share trend compared with competitors
- Top customers and top products by revenue

Example executive-level metrics include Net Sales of **$3.74bn**, Gross Margin of **38.08%**, Net Profit Percentage of **-13.98%**, and Forecast Accuracy of **81.17%**.

### Info Page

The Info page documents refresh and source-data rules:

- System data is refreshed every month on the fifth working day.
- Forecast, actuals, and historical forecast data are received from the global database.
- Non-system data such as target, operational expense, and market share are refreshed on request.

---

## Key KPIs

### Finance KPIs

- Gross Sales
- Pre-Invoice Deductions
- Net Invoice Sales
- Post-Invoice Deductions
- Net Sales
- Manufacturing Cost
- Freight Cost
- Total COGS
- Gross Margin
- Gross Margin Percentage
- Net Profit
- Net Profit Percentage

### Sales KPIs

- Customer Net Sales
- Customer Gross Margin
- Customer Gross Margin Percentage
- Product Net Sales
- Product Gross Margin
- Product Gross Margin Percentage
- Sales by Region
- Sales by Segment

### Supply Chain KPIs

- Forecast Accuracy
- Forecast Accuracy Last Year
- Net Error
- Net Error Percentage
- Absolute Error
- Excess Inventory Risk
- Out of Stock Risk

### Executive KPIs

- Net Sales
- Gross Margin Percentage
- Net Profit Percentage
- Forecast Accuracy
- Revenue Contribution Percentage
- Market Share Percentage
- Revenue by Division
- Revenue by Channel
- Top Customers by Revenue
- Top Products by Revenue

---

## Python Data Quality Script

A Python script was added to profile and validate the available source files before using them in the analytics workflow.

The script checks:

- Row count
- Column count
- Column names
- Missing values
- Duplicate records
- Invalid date values
- Invalid quantity values
- Negative quantity values

This supports a stronger data quality process before building dashboards or curated reporting layers.

---

## PySpark-Ready Transformation Script

A PySpark-ready script was added to show how the same sales and forecast transformation logic can scale for larger batch workloads.

The script performs:

- CSV loading from S3 paths
- Duplicate removal
- Quantity type casting
- Invalid value filtering
- Sales and forecast joining
- Executive summary KPI calculation
- Parquet output writing

This script is designed as a scalable AWS Glue-style transformation path for production-sized datasets.

---

## Repository Structure

```text
AtliQ-Hardware-AWS-Redshift-Analytics-Pipeline/
│
├── README.md
├── requirements.txt
├── .gitignore
│
├── BI360.png
├── Business_Insights_360_final.pdf
│
├── data/
│   └── sample/
│       ├── dim_product_BI360.csv
│       ├── dim_customer_BI360.csv
│       ├── dim_market_BI360.csv
│       ├── fact_sales_monthly_BI360.csv
│       └── fact_forecast_monthly_BI360.csv
│
├── aws/
│   ├── architecture_overview.md
│   ├── s3_folder_structure.md
│   ├── athena_glue_implementation.md
│   └── redshift_reporting_layer.md
│
├── sql/
│   ├── 01_athena_create_external_tables.sql
│   ├── 02_athena_validation_queries.sql
│   ├── 03_athena_kpi_views.sql
│   └── 04_athena_curated_parquet_outputs.sql
│
├── redshift/
│   └── 01_redshift_create_and_load_curated_tables.sql
│
├── python/
│   └── data_quality_checks.py
│
├── pyspark/
│   └── glue_pyspark_sales_forecast_job.py
│
├── docs/
│   ├── business_problem.md
│   ├── data_model.md
│   ├── kpi_definitions.md
│   └── powerbi_reporting_layer.md
│
└── dashboard/
    └── dashboard_notes.md
```

---

## Business Impact

This project helps AtliQ Hardware improve decision-making by:

- Reducing dependency on manual Excel-based reporting
- Improving KPI consistency across business teams
- Creating a cloud-ready analytics workflow
- Supporting sales and forecast performance tracking
- Identifying excess inventory and out-of-stock risk
- Enabling customer, product, market, and executive-level analysis
- Providing leadership with a consolidated business performance view

---

## Conclusion

This project combines business intelligence reporting with a modern AWS analytics workflow. It demonstrates how raw business files can be organized in S3, cataloged through Glue and Athena, validated with SQL, transformed into curated KPI outputs, loaded into Redshift, and represented through Power BI dashboards.

The final solution connects data engineering, data validation, cloud warehousing, KPI modeling, and executive reporting into one structured analytics project.
