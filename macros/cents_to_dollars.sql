{% macro cents_to_dollars(amount, scale=2) %}
    ({{ amount }} / 100)::numeric(16, {{ scale }})
{% endmacro %}