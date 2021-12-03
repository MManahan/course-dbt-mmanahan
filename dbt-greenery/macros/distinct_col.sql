{% macro get_column_values(column_name, relation) %}

{% set relation_query %}
select distinct
{{ column_name }}
from {{ relation }}
order by 1
{% endset %}

{% set results = run_query(relation_query) %}

{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{% set results = (results_list) %}

{% for result in results_list %}
    sum(case when relation.event_type = result then 1 else 0 end) as {{result}}
{% endfor %}

{% endmacro %}

