# AWS Architecture Overview

This project uses a batch analytics architecture for the AtliQ Hardware BI360 sales and forecast use case.

## End-to-End Flow

```text
Raw BI360 CSV Files
   ↓
Amazon S3 Raw Zone
   ↓
Athena External Tables + AWS Glue Data Catalog
   ↓
Athena SQL Validation and KPI Transformations
   ↓
Amazon S3 Curated Parquet Zone
   ↓
Amazon Redshift Reporting Tables
   ↓
Power BI Reporting Layer
```

## AWS Components

### Amazon S3

S3 is used as the data lake storage layer. The source files are stored in raw folders by entity, and the reporting-ready outputs are stored in curated Parquet folders.

### AWS Glue Data Catalog

Athena external tables are registered in the Glue Data Catalog. This provides a central metadata layer for the raw source files and curated outputs.

### Amazon Athena

Athena is used for SQL-based analytics directly on S3. It supports the external table layer, validation queries, KPI views, and CTAS outputs into curated Parquet format.

### Amazon Redshift

Redshift is used as the warehouse-ready reporting layer. Curated Parquet outputs from S3 are loaded into Redshift tables for executive, market, product, and customer/channel analysis.

### Power BI

Power BI is used as the final business reporting layer. The dashboard demonstrates KPI storytelling through Power Query transformations, calculated fields, relationships, and visual reporting.

## Design Rationale

The architecture separates the workflow into raw, curated, and reporting layers. This makes the project easier to validate, maintain, and scale while keeping the dashboard layer focused on business storytelling.
