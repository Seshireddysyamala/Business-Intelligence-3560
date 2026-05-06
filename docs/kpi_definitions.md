# KPI Definitions

## Total Sold Quantity

Total actual units sold across the selected reporting grain.

```sql
SUM(sold_quantity)
```

## Total Forecast Quantity

Total forecasted units across the selected reporting grain.

```sql
SUM(forecast_quantity)
```

## Forecast Gap

Difference between actual sold quantity and forecast quantity.

```sql
SUM(sold_quantity) - SUM(forecast_quantity)
```

## Absolute Error

Absolute value of the forecast gap.

```sql
ABS(SUM(sold_quantity) - SUM(forecast_quantity))
```

## Forecast Accuracy Percentage

Forecast accuracy based on absolute error compared with forecast quantity.

```sql
100 - (ABS(SUM(sold_quantity) - SUM(forecast_quantity)) * 100.0 / SUM(forecast_quantity))
```

## Active Products

Number of distinct products included in a reporting period.

```sql
COUNT(DISTINCT product_code)
```

## Active Customers

Number of distinct customers included in a reporting period.

```sql
COUNT(DISTINCT customer_code)
```

## Active Markets

Number of distinct markets included in a reporting period.

```sql
COUNT(DISTINCT market)
```
