with source as (

    {#-
    if we need to use seeds to load
    our data in this project the use this - { ref('raw_customers') }
    #}
    select * from {{source('jaffle_shop','customers')}}

),
 
renamed as (

    select
        id as customer_id,
        first_name,
        last_name

    from source

)

select * from renamed
 