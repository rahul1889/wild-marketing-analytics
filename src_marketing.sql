{{ config(materialized='view') }}

select * 
from {{ source('share_wild_cosmetics', 'all_influencer_results') }}
