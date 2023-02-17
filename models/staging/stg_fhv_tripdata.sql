{{ config(materialized='view') }}

select
    dispatching_base_num,
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropOff_datetime as timestamp) as dropoff_datetime,
    cast(PUlocationID as integer) as pickup_locationid,
    cast(DOlocationID as integer) as dropoff_locationid,
    SR_Flag,
    Affiliated_base_number
from {{ source('staging', 'external_trip_data') }}

-- dbt run -m stg_green_tripdata.sql --var 'is_test: false'
{% if var('is_test', default=true) %}

    limit 100

{% endif %}
