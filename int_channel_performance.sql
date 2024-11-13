{{ config(materialized='table') }}

WITH campaign_performance AS (
    SELECT * FROM {{ ref('int_campaign_performance') }}
)

SELECT 
    channel,
    SUM(cost) AS total_cost,
    SUM(new_customers) AS total_customers,
    CASE 
        WHEN SUM(new_customers) > 0 THEN SUM(cost) / SUM(new_customers)
        ELSE NULL
    END AS channel_cac
FROM campaign_performance
GROUP BY channel
