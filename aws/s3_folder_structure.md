# S3 Folder Structure

The AWS data lake uses separate raw, curated, and query-result zones.

## Raw Zone

```text
s3://atliq-bi360-analytics-seshi/raw/dim_product/
s3://atliq-bi360-analytics-seshi/raw/dim_customer/
s3://atliq-bi360-analytics-seshi/raw/dim_market/
s3://atliq-bi360-analytics-seshi/raw/fact_sales_monthly/
s3://atliq-bi360-analytics-seshi/raw/fact_forecast_monthly/
```

## Athena Query Results

```text
s3://atliq-bi360-analytics-seshi/athena-results/
```

## Curated Zone

```text
s3://atliq-bi360-analytics-seshi/curated/market_kpis/
s3://atliq-bi360-analytics-seshi/curated/product_kpis/
s3://atliq-bi360-analytics-seshi/curated/customer_kpis/
s3://atliq-bi360-analytics-seshi/curated/executive_summary/
```

## PySpark Curated Output

```text
s3://atliq-bi360-analytics-seshi/curated_pyspark/executive_summary/
```

## Source File Mapping

| Source File | S3 Raw Folder |
|---|---|
| `dim_product_BI360.csv` | `raw/dim_product/` |
| `dim_customer_BI360.csv` | `raw/dim_customer/` |
| `dim_market_BI360.csv` | `raw/dim_market/` |
| `fact_sales_monthly_BI360.csv` | `raw/fact_sales_monthly/` |
| `fact_forecast_monthly_BI360.csv` | `raw/fact_forecast_monthly/` |
