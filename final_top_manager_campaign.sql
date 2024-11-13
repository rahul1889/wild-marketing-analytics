{{ config(materialized='table') }}

WITH campaign_performance AS (
    SELECT * FROM {{ ref('int_campaign_performance') }}
)

SELECT 
    manager,
    channel,
    discount_code,
    total_revenue
FROM (
    SELECT 
        manager,
        channel,
        discount_code,
        total_revenue,
        ROW_NUMBER() OVER (ORDER BY total_revenue DESC) AS revenue_rank
    FROM campaign_performance
)
WHERE revenue_rank = 1
