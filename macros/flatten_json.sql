{% macro flatten_json(model_src, json_field, array_field) %}
{% set json_query_stmt %}
SELECT  f.key as fieldnames
FROM {{ model_src }}
,LATERAL FLATTEN(input => {{ json_field }}, path => '{{ array_field }}', recursive => true ,mode => 'BOTH') f
WHERE Key IS NOT NULL
{% endset %}
{% set results = run_query(json_query_stmt) %}

{% if execute %} {% set fieldlist = results.columns[0].values() %}
{% else %} {% set fieldlist = [] %}
{% endif %}

select
        {{ json_field }},
        {% for field in fieldlist %}
        {{ json_field }}:{{ array_field }}[0].{{ field }}::string as {{ field }}{% if not loop.last %},{% endif %}
        {% endfor %}
from {{ model_src }}
{% endmacro %}
