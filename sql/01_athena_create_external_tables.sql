-- Athena DDL for BI360 source files stored in Amazon S3.
-- This script defines the raw external tables registered through the AWS Glue Data Catalog.

CREATE DATABASE IF NOT EXISTS atliq_bi360_db;

DROP TABLE IF EXISTS dim_product;

CREATE EXTERNAL TABLE dim_product (
    product_code string,
    division string,
    segment string,
    category string,
    product string,
    variant string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = "\""
)
STORED AS TEXTFILE
LOCATION 's3://atliq-bi360-analytics-seshi/raw/dim_product/'
TBLPROPERTIES ('skip.header.line.count'='1');

DROP TABLE IF EXISTS dim_customer;

CREATE EXTERNAL TABLE dim_customer (
    customer string,
    market string,
    platform string,
    channel string,
    customer_code string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = "\""
)
STORED AS TEXTFILE
LOCATION 's3://atliq-bi360-analytics-seshi/raw/dim_customer/'
TBLPROPERTIES ('skip.header.line.count'='1');

DROP TABLE IF EXISTS dim_market;

CREATE EXTERNAL TABLE dim_market (
    market string,
    sub_zone string,
    region string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = "\""
)
STORED AS TEXTFILE
LOCATION 's3://atliq-bi360-analytics-seshi/raw/dim_market/'
TBLPROPERTIES ('skip.header.line.count'='1');

DROP TABLE IF EXISTS fact_sales_monthly;

CREATE EXTERNAL TABLE fact_sales_monthly (
    report_date string,
    division string,
    category string,
    product_code string,
    product string,
    market string,
    platform string,
    channel string,
    customer_code string,
    customer_name string,
    sold_quantity string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = "\""
)
STORED AS TEXTFILE
LOCATION 's3://atliq-bi360-analytics-seshi/raw/fact_sales_monthly/'
TBLPROPERTIES ('skip.header.line.count'='1');

DROP TABLE IF EXISTS fact_forecast_monthly;

CREATE EXTERNAL TABLE fact_forecast_monthly (
    report_date string,
    division string,
    category string,
    product_code string,
    product string,
    market string,
    platform string,
    channel string,
    customer_code string,
    customer_name string,
    forecast_quantity string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = "\""
)
STORED AS TEXTFILE
LOCATION 's3://atliq-bi360-analytics-seshi/raw/fact_forecast_monthly/'
TBLPROPERTIES ('skip.header.line.count'='1');
