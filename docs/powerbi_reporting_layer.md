# Power BI Reporting Layer

The Power BI dashboard is the business-facing reporting layer for the BI360 project.

## Dashboard Role

The dashboard communicates business insights using:

- Power Query transformations
- Calculated fields
- Table relationships
- KPI measures
- Business visuals
- Executive-level summary views

## Reporting Focus

The reporting layer focuses on:

- Sales performance
- Forecast performance
- Market performance
- Product performance
- Customer and channel performance
- Executive summary insights

## Relationship with AWS and Redshift

The AWS and Redshift workflow creates the data engineering and warehouse-ready reporting layer. The Power BI dashboard demonstrates how the curated business model can be translated into KPI visuals and stakeholder-ready insights.

The project does not need to claim a live Power BI refresh from Redshift unless that direct connection is configured. The safer interpretation is that Redshift represents the warehouse reporting layer, and the Power BI dashboard demonstrates the final reporting design and storytelling layer.
