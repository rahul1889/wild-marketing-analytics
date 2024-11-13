{{ config(materialized='view') }}

WITH src_orders AS (
    SELECT * FROM {{ ref('src_orders') }}
)

SELECT
    "Order ID" AS order_id,
    "Order Date" AS order_date,
    "Discount Code" AS discount_code,
    "Order Revenue" AS order_revenue,
    ("Order Revenue" - "Order Discount") AS net_revenue,
    CASE WHEN "Customer Order Number" = 1 THEN 1 ELSE 0 END AS new_customer
FROM src_orders
WHERE order_date >= DATE_TRUNC('year', CURRENT_DATE())
