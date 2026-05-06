import pandas as pd
from pathlib import Path

DATA_DIR = Path("data/sample")

FILES = [
    "dim_product_BI360.csv",
    "dim_customer_BI360.csv",
    "dim_market_BI360.csv",
    "fact_sales_monthly_BI360.csv",
    "fact_forecast_monthly_BI360.csv",
]


def validate_file(file_name: str) -> None:
    file_path = DATA_DIR / file_name

    if not file_path.exists():
        print(f"Missing file: {file_path}")
        return

    df = pd.read_csv(file_path)

    print("=" * 90)
    print(f"File: {file_name}")
    print(f"Rows: {len(df):,}")
    print(f"Columns: {len(df.columns)}")
    print(f"Column names: {list(df.columns)}")

    print("\nMissing values:")
    print(df.isnull().sum())

    print("\nDuplicate rows:")
    print(df.duplicated().sum())

    if "date" in df.columns:
        parsed_dates = pd.to_datetime(df["date"], errors="coerce")
        invalid_dates = parsed_dates.isna().sum()
        print(f"\nInvalid date values: {invalid_dates}")

    quantity_columns = [col for col in df.columns if "quantity" in col.lower()]

    for col in quantity_columns:
        numeric_series = pd.to_numeric(df[col], errors="coerce")
        invalid_numeric = numeric_series.isna().sum()
        negative_values = (numeric_series < 0).sum()

        print(f"\nValidation for {col}:")
        print(f"Invalid numeric values: {invalid_numeric}")
        print(f"Negative values: {negative_values}")

    if "product_code" in df.columns:
        duplicate_product_codes = df["product_code"].duplicated().sum()
        print(f"\nDuplicate product_code values: {duplicate_product_codes}")

    if "customer_code" in df.columns:
        duplicate_customer_codes = df["customer_code"].duplicated().sum()
        print(f"Duplicate customer_code values: {duplicate_customer_codes}")


def main() -> None:
    print("AtliQ BI360 Data Quality Validation Report")
    print("Python/Pandas source-file profiling")

    for file_name in FILES:
        validate_file(file_name)


if __name__ == "__main__":
    main()
