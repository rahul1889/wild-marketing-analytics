{{ config(materialized='table') }}

select 
    manager,
    channel,
    discount_code,
    cac,
    row_number() over (partition by channel order by cac asc) as rank
from {{ ref('int_campaign_performance') }}
where cac is not null
qualify rank = 1
