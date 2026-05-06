-- Athena CTAS statements for curated Parquet KPI outputs.

DROP TABLE IF EXISTS curated_market_kpis;

CREATE TABLE curated_market_kpis
WITH (
    format = 'PARQUET',
    external_location = 's3://atliq-bi360-analytics-seshi/curated/market_kpis/'
) AS
SELECT *
FROM vw_market_forecast_kpis;

DROP TABLE IF EXISTS curated_product_kpis;

CREATE TABLE curated_product_kpis
WITH (
    format = 'PARQUET',
    external_location = 's3://atliq-bi360-analytics-seshi/curated/product_kpis/'
) AS
SELECT *
FROM vw_product_forecast_kpis;

DROP TABLE IF EXISTS curated_customer_kpis;

CREATE TABLE curated_customer_kpis
WITH (
    format = 'PARQUET',
    external_location = 's3://atliq-bi360-analytics-seshi/curated/customer_kpis/'
) AS
SELECT *
FROM vw_customer_channel_kpis;

DROP TABLE IF EXISTS curated_executive_summary;

CREATE TABLE curated_executive_summary
WITH (
    format = 'PARQUET',
    external_location = 's3://atliq-bi360-analytics-seshi/curated/executive_summary/'
) AS
SELECT *
FROM vw_executive_summary;
