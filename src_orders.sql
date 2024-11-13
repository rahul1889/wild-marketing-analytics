{{ config(materialized='view') }}

select * 
from {{ source('share_wild_cosmetics', 'final_orders') }}
