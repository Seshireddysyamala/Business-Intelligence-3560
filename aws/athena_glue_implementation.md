# Athena and Glue Implementation

Athena is used to query raw files in S3 and register the table metadata through the AWS Glue Data Catalog.

## Database

```text
atliq_bi360_db
```

## External Tables

The Athena layer includes external tables for:

```text
dim_product
dim_customer
dim_market
fact_sales_monthly
fact_forecast_monthly
```

## Validation Coverage

The validation SQL checks include:

- Row counts across all source tables
- Duplicate product codes
- Duplicate customer codes
- Duplicate market mappings
- Missing product mappings in the sales fact table
- Missing customer mappings in the sales fact table
- Missing market mappings in the sales fact table
- Invalid or negative sold quantity values
- Invalid or negative forecast quantity values

## KPI Views

The Athena layer creates the following analytical views:

```text
vw_sales_forecast_base
vw_market_forecast_kpis
vw_product_forecast_kpis
vw_customer_channel_kpis
vw_executive_summary
```

## Curated Outputs

Athena CTAS statements materialize the KPI views into S3 as Parquet tables:

```text
curated_market_kpis
curated_product_kpis
curated_customer_kpis
curated_executive_summary
```

These curated outputs represent the reporting-ready layer before loading into Redshift.
