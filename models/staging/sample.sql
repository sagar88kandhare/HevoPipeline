{{
    config(
        materialized='table'
    )
}}

select * from {{ ref('model_name') }}

select * from {{ source('source_name', 'object_name') }}

