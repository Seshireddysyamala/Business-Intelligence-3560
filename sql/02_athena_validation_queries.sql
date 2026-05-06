-- Athena validation queries for the BI360 raw data layer.

-- Row count validation
SELECT 'dim_product' AS table_name, COUNT(*) AS row_count FROM dim_product
UNION ALL
SELECT 'dim_customer', COUNT(*) FROM dim_customer
UNION ALL
SELECT 'dim_market', COUNT(*) FROM dim_market
UNION ALL
SELECT 'fact_sales_monthly', COUNT(*) FROM fact_sales_monthly
UNION ALL
SELECT 'fact_forecast_monthly', COUNT(*) FROM fact_forecast_monthly;

-- Duplicate product code check
SELECT product_code, COUNT(*) AS record_count
FROM dim_product
GROUP BY product_code
HAVING COUNT(*) > 1;

-- Duplicate customer code check
SELECT customer_code, COUNT(*) AS record_count
FROM dim_customer
GROUP BY customer_code
HAVING COUNT(*) > 1;

-- Duplicate market check
SELECT market, COUNT(*) AS record_count
FROM dim_market
GROUP BY market
HAVING COUNT(*) > 1;

-- Missing product mapping check
SELECT COUNT(*) AS missing_product_mappings
FROM fact_sales_monthly s
LEFT JOIN dim_product p
    ON s.product_code = p.product_code
WHERE p.product_code IS NULL;

-- Missing customer mapping check
SELECT COUNT(*) AS missing_customer_mappings
FROM fact_sales_monthly s
LEFT JOIN dim_customer c
    ON s.customer_code = c.customer_code
WHERE c.customer_code IS NULL;

-- Missing market mapping check
SELECT COUNT(*) AS missing_market_mappings
FROM fact_sales_monthly s
LEFT JOIN dim_market m
    ON s.market = m.market
WHERE m.market IS NULL;

-- Invalid sold quantity check
SELECT *
FROM fact_sales_monthly
WHERE TRY_CAST(sold_quantity AS bigint) < 0
   OR sold_quantity IS NULL
   OR sold_quantity = '';

-- Invalid forecast quantity check
SELECT *
FROM fact_forecast_monthly
WHERE TRY_CAST(forecast_quantity AS bigint) < 0
   OR forecast_quantity IS NULL
   OR forecast_quantity = '';
