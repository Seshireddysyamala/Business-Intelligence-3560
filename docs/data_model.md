# Data Model

The BI360 sales and forecast workflow uses a simple analytical model built from dimension and fact tables.

## Dimension Tables

### `dim_product`

Product hierarchy and product attributes.

Key columns:

```text
product_code
division
segment
category
product
variant
```

### `dim_customer`

Customer and channel mapping.

Key columns:

```text
customer
market
platform
channel
customer_code
```

### `dim_market`

Market geography mapping.

Key columns:

```text
market
sub_zone
region
```

## Fact Tables

### `fact_sales_monthly`

Monthly actual sold quantity.

Key columns:

```text
report_date
product_code
customer_code
market
platform
channel
sold_quantity
```

### `fact_forecast_monthly`

Monthly forecast quantity.

Key columns:

```text
report_date
product_code
customer_code
market
platform
channel
forecast_quantity
```

## Join Logic

Actual sales and forecast data are joined using:

```text
report_date
product_code
customer_code
market
platform
channel
```

This creates a base analytical view used for market, product, customer/channel, and executive KPI outputs.
