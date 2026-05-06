-- Athena KPI views for sales and forecast analytics.

CREATE OR REPLACE VIEW vw_sales_forecast_base AS
SELECT
    COALESCE(s.report_date, f.report_date) AS report_date,
    COALESCE(s.product_code, f.product_code) AS product_code,
    COALESCE(s.product, f.product) AS product,
    COALESCE(s.division, f.division) AS division,
    COALESCE(s.category, f.category) AS category,
    COALESCE(s.market, f.market) AS market,
    COALESCE(s.platform, f.platform) AS platform,
    COALESCE(s.channel, f.channel) AS channel,
    COALESCE(s.customer_code, f.customer_code) AS customer_code,
    COALESCE(s.customer_name, f.customer_name) AS customer_name,
    TRY_CAST(s.sold_quantity AS bigint) AS sold_quantity,
    TRY_CAST(f.forecast_quantity AS bigint) AS forecast_quantity
FROM fact_sales_monthly s
FULL OUTER JOIN fact_forecast_monthly f
    ON s.report_date = f.report_date
   AND s.product_code = f.product_code
   AND s.customer_code = f.customer_code
   AND s.market = f.market
   AND s.platform = f.platform
   AND s.channel = f.channel;

CREATE OR REPLACE VIEW vw_market_forecast_kpis AS
SELECT
    b.report_date,
    m.region,
    m.sub_zone,
    b.market,
    SUM(COALESCE(b.sold_quantity, 0)) AS total_sold_quantity,
    SUM(COALESCE(b.forecast_quantity, 0)) AS total_forecast_quantity,
    SUM(COALESCE(b.sold_quantity, 0)) - SUM(COALESCE(b.forecast_quantity, 0)) AS forecast_gap,
    ABS(SUM(COALESCE(b.sold_quantity, 0)) - SUM(COALESCE(b.forecast_quantity, 0))) AS absolute_error,
    ROUND(
        CASE
            WHEN SUM(COALESCE(b.forecast_quantity, 0)) = 0 THEN NULL
            ELSE 100 - (
                ABS(SUM(COALESCE(b.sold_quantity, 0)) - SUM(COALESCE(b.forecast_quantity, 0))) * 100.0
                / SUM(COALESCE(b.forecast_quantity, 0))
            )
        END,
        2
    ) AS forecast_accuracy_pct
FROM vw_sales_forecast_base b
LEFT JOIN dim_market m
    ON b.market = m.market
GROUP BY
    b.report_date,
    m.region,
    m.sub_zone,
    b.market;

CREATE OR REPLACE VIEW vw_product_forecast_kpis AS
SELECT
    b.report_date,
    p.division,
    p.segment,
    p.category,
    b.product_code,
    p.product,
    p.variant,
    SUM(COALESCE(b.sold_quantity, 0)) AS total_sold_quantity,
    SUM(COALESCE(b.forecast_quantity, 0)) AS total_forecast_quantity,
    SUM(COALESCE(b.sold_quantity, 0)) - SUM(COALESCE(b.forecast_quantity, 0)) AS forecast_gap,
    ABS(SUM(COALESCE(b.sold_quantity, 0)) - SUM(COALESCE(b.forecast_quantity, 0))) AS absolute_error,
    ROUND(
        CASE
            WHEN SUM(COALESCE(b.forecast_quantity, 0)) = 0 THEN NULL
            ELSE 100 - (
                ABS(SUM(COALESCE(b.sold_quantity, 0)) - SUM(COALESCE(b.forecast_quantity, 0))) * 100.0
                / SUM(COALESCE(b.forecast_quantity, 0))
            )
        END,
        2
    ) AS forecast_accuracy_pct
FROM vw_sales_forecast_base b
LEFT JOIN dim_product p
    ON b.product_code = p.product_code
GROUP BY
    b.report_date,
    p.division,
    p.segment,
    p.category,
    b.product_code,
    p.product,
    p.variant;

CREATE OR REPLACE VIEW vw_customer_channel_kpis AS
SELECT
    b.report_date,
    c.customer,
    b.customer_code,
    b.platform,
    b.channel,
    b.market,
    SUM(COALESCE(b.sold_quantity, 0)) AS total_sold_quantity,
    SUM(COALESCE(b.forecast_quantity, 0)) AS total_forecast_quantity,
    SUM(COALESCE(b.sold_quantity, 0)) - SUM(COALESCE(b.forecast_quantity, 0)) AS forecast_gap,
    ABS(SUM(COALESCE(b.sold_quantity, 0)) - SUM(COALESCE(b.forecast_quantity, 0))) AS absolute_error,
    ROUND(
        CASE
            WHEN SUM(COALESCE(b.forecast_quantity, 0)) = 0 THEN NULL
            ELSE 100 - (
                ABS(SUM(COALESCE(b.sold_quantity, 0)) - SUM(COALESCE(b.forecast_quantity, 0))) * 100.0
                / SUM(COALESCE(b.forecast_quantity, 0))
            )
        END,
        2
    ) AS forecast_accuracy_pct
FROM vw_sales_forecast_base b
LEFT JOIN dim_customer c
    ON b.customer_code = c.customer_code
GROUP BY
    b.report_date,
    c.customer,
    b.customer_code,
    b.platform,
    b.channel,
    b.market;

CREATE OR REPLACE VIEW vw_executive_summary AS
SELECT
    report_date,
    COUNT(DISTINCT product_code) AS active_products,
    COUNT(DISTINCT customer_code) AS active_customers,
    COUNT(DISTINCT market) AS active_markets,
    SUM(COALESCE(sold_quantity, 0)) AS total_sold_quantity,
    SUM(COALESCE(forecast_quantity, 0)) AS total_forecast_quantity,
    SUM(COALESCE(sold_quantity, 0)) - SUM(COALESCE(forecast_quantity, 0)) AS total_forecast_gap,
    ABS(SUM(COALESCE(sold_quantity, 0)) - SUM(COALESCE(forecast_quantity, 0))) AS total_absolute_error,
    ROUND(
        CASE
            WHEN SUM(COALESCE(forecast_quantity, 0)) = 0 THEN NULL
            ELSE 100 - (
                ABS(SUM(COALESCE(sold_quantity, 0)) - SUM(COALESCE(forecast_quantity, 0))) * 100.0
                / SUM(COALESCE(forecast_quantity, 0))
            )
        END,
        2
    ) AS overall_forecast_accuracy_pct
FROM vw_sales_forecast_base
GROUP BY report_date;
