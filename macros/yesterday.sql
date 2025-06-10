{%- macro yesterday(date=None) -%}
{{ dbt_date.n_days_ago(1, date) }}
{%- endmacro -%}