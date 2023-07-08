with Employee_flatten as(
{# macro usage #}
{{ flatten_json(      
    model_src = source('jaffle_shop','employees') ,
    json_field  = 'employee_data', 
    array_field = 'employees'
    ) }}
),
final as (
    select * from Employee_flatten
)
select * from final {# NO SEMICOLON #}
