{{ config(materialized='view') }}

select
    manager,
    channel,
    discount_code,
    cost
from {{ ref('src_marketing') }}
where live_date <= current_date and (end_date is null or end_date >= DATE_TRUNC('year', CURRENT_DATE()))
