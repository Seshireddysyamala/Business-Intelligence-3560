from pyspark.sql import SparkSession
from pyspark.sql.functions import (
    col,
    sum as spark_sum,
    abs as spark_abs,
    round as spark_round,
    coalesce,
    lit,
    countDistinct,
)

spark = SparkSession.builder \
    .appName("AtliQ BI360 Sales Forecast Transformation") \
    .getOrCreate()

bucket = "atliq-bi360-analytics-seshi"

sales_path = f"s3://{bucket}/raw/fact_sales_monthly/"
forecast_path = f"s3://{bucket}/raw/fact_forecast_monthly/"

sales_df = spark.read.option("header", True).csv(sales_path)
forecast_df = spark.read.option("header", True).csv(forecast_path)

sales_clean = sales_df.dropDuplicates() \
    .withColumnRenamed("date", "report_date") \
    .withColumn("sold_quantity", col("sold_quantity").cast("long")) \
    .filter((col("sold_quantity").isNotNull()) & (col("sold_quantity") >= 0))

forecast_clean = forecast_df.dropDuplicates() \
    .withColumnRenamed("date", "report_date") \
    .withColumn("forecast_quantity", col("forecast_quantity").cast("long")) \
    .filter((col("forecast_quantity").isNotNull()) & (col("forecast_quantity") >= 0))

join_condition = (
    (sales_clean["report_date"] == forecast_clean["report_date"]) &
    (sales_clean["product_code"] == forecast_clean["product_code"]) &
    (sales_clean["customer_code"] == forecast_clean["customer_code"]) &
    (sales_clean["market"] == forecast_clean["market"]) &
    (sales_clean["platform"] == forecast_clean["platform"]) &
    (sales_clean["channel"] == forecast_clean["channel"])
)

base_df = sales_clean.alias("s").join(
    forecast_clean.alias("f"),
    join_condition,
    "full"
).select(
    coalesce(col("s.report_date"), col("f.report_date")).alias("report_date"),
    coalesce(col("s.product_code"), col("f.product_code")).alias("product_code"),
    coalesce(col("s.product"), col("f.product")).alias("product"),
    coalesce(col("s.division"), col("f.division")).alias("division"),
    coalesce(col("s.category"), col("f.category")).alias("category"),
    coalesce(col("s.market"), col("f.market")).alias("market"),
    coalesce(col("s.platform"), col("f.platform")).alias("platform"),
    coalesce(col("s.channel"), col("f.channel")).alias("channel"),
    coalesce(col("s.customer_code"), col("f.customer_code")).alias("customer_code"),
    coalesce(col("s.customer_name"), col("f.customer_name")).alias("customer_name"),
    coalesce(col("s.sold_quantity"), lit(0)).alias("sold_quantity"),
    coalesce(col("f.forecast_quantity"), lit(0)).alias("forecast_quantity"),
)

executive_summary = base_df.groupBy("report_date").agg(
    countDistinct("product_code").alias("active_products"),
    countDistinct("customer_code").alias("active_customers"),
    countDistinct("market").alias("active_markets"),
    spark_sum("sold_quantity").alias("total_sold_quantity"),
    spark_sum("forecast_quantity").alias("total_forecast_quantity"),
).withColumn(
    "forecast_gap",
    col("total_sold_quantity") - col("total_forecast_quantity"),
).withColumn(
    "absolute_error",
    spark_abs(col("forecast_gap")),
).withColumn(
    "forecast_accuracy_pct",
    spark_round(
        100 - ((col("absolute_error") * 100.0) / col("total_forecast_quantity")),
        2,
    ),
)

executive_summary.write.mode("overwrite").parquet(
    f"s3://{bucket}/curated_pyspark/executive_summary/"
)

spark.stop()
