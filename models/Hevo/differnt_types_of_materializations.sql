{{
    config(
        materialized='view'
    )
}}

{{
    config(
        materialized='table'
    )
}}

{{
    config(
        materialized='incremental',
        unique_key='id'
    )
}}

{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where event_time > (select max(event_time) from {{ this }}) 
{% endif %}

{{
    config(
        materialized='ephemeral'
    )
}}


