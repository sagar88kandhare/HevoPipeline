-- macros/calculate_avg.sql
{% macro calculate_avg(column) %}
    avg({{ column }})
{% endmacro %}
