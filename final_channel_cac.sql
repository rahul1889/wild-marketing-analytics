{{ config(materialized='table') }}

WITH channel_performance AS (
    SELECT * FROM {{ ref('int_channel_performance') }}
)

SELECT 
    *,
    (SELECT 
         SUM(total_cost) / NULLIF(SUM(total_customers), 0) 
     FROM channel_performance) AS overall_cac
FROM channel_performance
