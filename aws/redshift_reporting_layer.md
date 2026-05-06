# Redshift Reporting Layer

Amazon Redshift is used as the warehouse-ready reporting layer for curated sales and forecast KPI outputs.

## Schema

```text
atliq_bi360
```

## Reporting Tables

```text
atliq_bi360.executive_summary
atliq_bi360.market_forecast_kpis
atliq_bi360.product_forecast_kpis
atliq_bi360.customer_channel_kpis
```

## Loading Pattern

The Redshift layer loads curated Parquet outputs from S3 using `COPY`.

```text
S3 Curated Parquet Outputs → Redshift Reporting Tables
```

## Reporting Use Case

The Redshift tables are structured for dashboarding and downstream analytics. They provide business-ready KPI outputs for:

- Executive summary reporting
- Market-level forecast accuracy
- Product-level forecast gaps
- Customer/channel performance tracking

## Power BI Relationship

The Redshift layer represents the warehouse-ready reporting layer that can support Power BI or downstream analytics. The existing BI360 dashboard demonstrates the final reporting and storytelling layer around the same business model.
