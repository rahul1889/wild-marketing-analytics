{{ config(materialized='view') }}


WITH orders AS (
    SELECT 
        discount_code,
        SUM(net_revenue) AS total_revenue,
        SUM(new_customer) AS new_customers
    FROM {{ ref('stg_orders') }}
    GROUP BY discount_code
),

marketing AS (
    SELECT
        discount_code,
        channel,
        manager,
        cost
    FROM {{ ref('stg_marketing') }}
)

SELECT 
    m.channel,
    m.manager,
    m.discount_code,
    m.cost,
    COALESCE(o.total_revenue, 0) AS total_revenue,
    COALESCE(o.new_customers, 0) AS new_customers,
    CASE 
        WHEN COALESCE(o.new_customers, 0) > 0 THEN m.cost / o.new_customers
        ELSE NULL
    END AS cac
FROM marketing m
LEFT JOIN orders o ON m.discount_code = o.discount_code
