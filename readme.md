Project Overview
The Marketing Analytics project provides comprehensive analysis on marketing campaigns, focusing on metrics such as Customer Acquisition Cost (CAC) across different channels, overall performance, and manager campaign effectiveness. The data comes from order and marketing campaign sources, which are processed and aggregated to provide quarterly insights.

Models Breakdown
1. stg_orders (Staging Model for Orders Data)
This staging model processes the raw orders data, including:

Order ID, Order Date, Discount Code, and Order Revenue
Calculates net_revenue by subtracting Order Discount from Order Revenue.
Identifies whether the order is from a new customer based on the Customer Order Number.
Key Output:

Total order revenue per discount code and customer data (new customer flag).

2. stg_marketing (Staging Model for Marketing Data)
This model processes the raw marketing campaign data. It filters campaigns based on the active date range for the current quarter and considers the live_date and end_date of each campaign.

Key Output:

Campaign details: manager, channel, discount_code, cost.
Only includes campaigns that are active in the current quarter.

3. int_campaign_performance (Campaign Performance Metrics)
Aggregates data from the stg_orders and stg_marketing models to calculate key campaign performance metrics:

Total revenue for each discount_code.
Calculates the Customer Acquisition Cost (CAC) by dividing the total cost of marketing by the number of new customers per discount code.
Key Output:

Campaign performance: revenue and CAC for each marketing campaign.

4. int_channel_performance (Channel Performance Metrics)
Aggregates and calculates the performance of different marketing channels by summarizing:

Total cost and total customers for each marketing channel.
Calculates the channel_cac (Customer Acquisition Cost per channel).
Additionally, an overall CAC is calculated for all channels combined, considering the total cost and total customers across all campaigns.

Key Output:

Channel-specific performance metrics.
Overall channel CAC calculation.

5. manager_top_campaign (Top Campaign per Manager)
This model ranks campaigns by total_revenue within each marketing channel and identifies the most successful campaign for each manager.

Uses ROW_NUMBER() to rank campaigns based on total revenue within each channel.
Filters to keep only the top campaign (highest revenue) for each manager.

Key Output:

The most successful campaign by revenue for each manager.
How to Run
To execute the dbt models, use the following command in your terminal:

bash
Copy code
dbt run
This will run all models and generate the necessary tables for analysis.

To Run Tests
After running your models, ensure that they pass all predefined tests to verify the integrity and accuracy of the data:

bash
Copy code
dbt test
Dependency Management
Ensure that all dependencies between models are respected. Each model in this project relies on the output of previous models, so they should be executed in order.

View Materializations
Models are configured as views or tables:

Staging Models: Configured as view to avoid excessive storage.
Aggregated Models: Configured as table to optimize performance for querying.
Example SQL Flow
Data Flow Example:
Extract: Raw orders data is fetched from src_orders (via the stg_orders model).
Process: Marketing campaign data is fetched and filtered in stg_marketing.
Aggregate: The int_campaign_performance model aggregates revenue and customer data.
Channel Metrics: The int_channel_performance model summarizes campaign data per channel.
Manager Performance: The manager_top_campaign model ranks campaigns by revenue for each manager.
