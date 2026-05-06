-- Amazon Redshift DDL and COPY statements for BI360 curated KPI outputs.
-- The IAM role value is intentionally kept as a placeholder for security.

CREATE SCHEMA IF NOT EXISTS atliq_bi360;

DROP TABLE IF EXISTS atliq_bi360.executive_summary;

CREATE TABLE atliq_bi360.executive_summary (
    report_date VARCHAR(50),
    active_products BIGINT,
    active_customers BIGINT,
    active_markets BIGINT,
    total_sold_quantity BIGINT,
    total_forecast_quantity BIGINT,
    total_forecast_gap BIGINT,
    total_absolute_error BIGINT,
    overall_forecast_accuracy_pct DECIMAL(10,2)
);

COPY atliq_bi360.executive_summary
FROM 's3://atliq-bi360-analytics-seshi/curated/executive_summary/'
IAM_ROLE 'YOUR_REDSHIFT_IAM_ROLE_ARN'
FORMAT AS PARQUET
REGION 'us-east-1';

DROP TABLE IF EXISTS atliq_bi360.market_forecast_kpis;

CREATE TABLE atliq_bi360.market_forecast_kpis (
    report_date VARCHAR(50),
    region VARCHAR(100),
    sub_zone VARCHAR(100),
    market VARCHAR(100),
    total_sold_quantity BIGINT,
    total_forecast_quantity BIGINT,
    forecast_gap BIGINT,
    absolute_error BIGINT,
    forecast_accuracy_pct DECIMAL(10,2)
);

COPY atliq_bi360.market_forecast_kpis
FROM 's3://atliq-bi360-analytics-seshi/curated/market_kpis/'
IAM_ROLE 'YOUR_REDSHIFT_IAM_ROLE_ARN'
FORMAT AS PARQUET
REGION 'us-east-1';

DROP TABLE IF EXISTS atliq_bi360.product_forecast_kpis;

CREATE TABLE atliq_bi360.product_forecast_kpis (
    report_date VARCHAR(50),
    division VARCHAR(100),
    segment VARCHAR(100),
    category VARCHAR(100),
    product_code VARCHAR(100),
    product VARCHAR(300),
    variant VARCHAR(100),
    total_sold_quantity BIGINT,
    total_forecast_quantity BIGINT,
    forecast_gap BIGINT,
    absolute_error BIGINT,
    forecast_accuracy_pct DECIMAL(10,2)
);

COPY atliq_bi360.product_forecast_kpis
FROM 's3://atliq-bi360-analytics-seshi/curated/product_kpis/'
IAM_ROLE 'YOUR_REDSHIFT_IAM_ROLE_ARN'
FORMAT AS PARQUET
REGION 'us-east-1';

DROP TABLE IF EXISTS atliq_bi360.customer_channel_kpis;

CREATE TABLE atliq_bi360.customer_channel_kpis (
    report_date VARCHAR(50),
    customer VARCHAR(300),
    customer_code VARCHAR(100),
    platform VARCHAR(100),
    channel VARCHAR(100),
    market VARCHAR(100),
    total_sold_quantity BIGINT,
    total_forecast_quantity BIGINT,
    forecast_gap BIGINT,
    absolute_error BIGINT,
    forecast_accuracy_pct DECIMAL(10,2)
);

COPY atliq_bi360.customer_channel_kpis
FROM 's3://atliq-bi360-analytics-seshi/curated/customer_kpis/'
IAM_ROLE 'YOUR_REDSHIFT_IAM_ROLE_ARN'
FORMAT AS PARQUET
REGION 'us-east-1';

SELECT *
FROM atliq_bi360.executive_summary
LIMIT 20;

SELECT *
FROM atliq_bi360.market_forecast_kpis
ORDER BY total_sold_quantity DESC
LIMIT 20;
