# Business-Intelligence-3560

### Project Overview

**About AtliQ Hardware**

AtliQ Hardware is an electronics manufacturer with a global presence. Despite rapid growth, they faced significant losses in Latin America due to poor decision-making based on surveys, Excel sheets, and intuition.

To address this, AtliQ Hardware is adopting data analytics to make informed decisions. My role is to build reports and provide insights across various departments: Finance, Sales, Marketing, and Supply Chain. We will also create an Executive View to give a comprehensive overview of the business, helping stakeholders make data-driven decisions.

**Project Objective**

The goal of this project is to clarify the purpose and objectives of the data analytics initiative. The final report will help answer key questions about the company's performance and support effective decision-making, which is crucial for the company's success.

**Tech Stack**

1. SQL
2. Power BI Desktop
3. Excel
4. DAX (Data Analysis Expressions)
5. DAX Studio (for optimizing reports)
6. Project Charter File

**Dataset Overview**

- **Dimension Tables**: Static data such as customer and product details.
  - **dim_customer**: 75 unique customers, two platform types (Physical and Online), three sales channels (Retailer, Direct, Distributors).
  - **dim_market**: 27 markets, 7 sub-zones, 4 regions (APAC, EU, NAN, LATAM).
  - **dim_product**: Various product divisions, categories, and variants.

- **Fact Tables**:
  - **fact_forecast_monthly**: Forecasts customer needs to reduce costs and improve satisfaction.
  - **fact_sales_monthly**: Records actual sales quantities.

- **Miscellaneous Data**:
  - Freight costs, gross prices, manufacturing costs, and pre/post-invoice deductions.

**Data Import and Modeling**

1. **Import Data**: Connect and load data from MySQL and Excel/CSV files into Power BI.
2. **Data Modeling**:
   - Clean, format, and transform data using Power Query.
   - Establish relationships between tables using Star Schema or Snowflake Schema.
   - Validate data against stakeholder benchmarks.

**Tasks**

As a Data Analyst, my tasks include:

- Generating insights through reports for Finance, Sales, Marketing, Supply Chain, and an Executive View.
- Connecting to various data sources, cleansing and transforming data, creating relationships between tables, and defining calculations using DAX.
- Creating interactive visualizations and KPIs.

**Skills Required**

- **Technical Skills**: Connecting to data sources, data cleansing and transformation, creating relationships and measures, understanding DAX, and building visualizations.
- **Soft Skills**: Understanding financial statements, designing user-friendly reports, addressing stakeholder needs, and asking the right questions.

**Conclusion**

The reports will help AtliQ Hardware make data-driven decisions to improve revenue, customer experience, demand forecasting, inventory management, and campaign strategies. Power BI is preferred over Excel for its advanced analytics capabilities, making it a better tool for meaningful insights.
