-- models/my_incremental_model.sql

{{ config(
    materialized='incremental',  -- Specifies incremental model
    unique_key='id'              -- Unique key to identify changes
) }}

with source_data as (
    select * from customers
    where updated_at > (select max(updated_at) from {{ this }})
)

select 
    id,
    name,
    created_at,
    updated_at
from source_data

{% if is_incremental() %}
-- Include only new/updated records
where updated_at > (select max(updated_at) from {{ this }})
{% endif %}
