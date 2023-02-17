{{ config(materialized='view') }}

with dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select 
    trips_fhv.dispatching_base_num, 
    trips_fhv.pickup_locationid, 
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 
    trips_fhv.dropoff_locationid,
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone,  
    trips_fhv.pickup_datetime, 
    trips_fhv.dropoff_datetime, 
    trips_fhv.SR_Flag, 
    trips_fhv.Affiliated_base_number
from {{ ref('stg_fhv_tripdata') }} as trips_fhv
inner join dim_zones as pickup_zone
on trips_fhv.pickup_locationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on trips_fhv.dropoff_locationid = dropoff_zone.locationid