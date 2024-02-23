{{
    config (MATERIALIZED = 'view')
}}
with source as (
      select * from {{ source('staging', 'yello_tripdata') }}
),
renamed as (
    select
        {{ adapter.quote("VendorID") }},
        {{ adapter.quote("tpep_pickup_datetime") }},
        {{ adapter.quote("tpep_dropoff_datetime") }},
        {{ adapter.quote("passenger_count") }},
        {{ adapter.quote("trip_distance") }},
        {{ adapter.quote("RatecodeID") }},
        {{ adapter.quote("store_and_fwd_flag") }},
        {{ adapter.quote("PULocationID") }},
        {{ adapter.quote("DOLocationID") }},
        {{ adapter.quote("payment_type") }},
        {{ get_payment(payment_type)}} as Payment_description,
        {{ adapter.quote("fare_amount") }},
        {{ adapter.quote("extra") }},
        {{ adapter.quote("mta_tax") }},
        {{ adapter.quote("tip_amount") }},
        {{ adapter.quote("tolls_amount") }},
        {{ adapter.quote("improvement_surcharge") }},
        {{ adapter.quote("total_amount") }},
        {{ adapter.quote("congestion_surcharge") }}

    from source
)
select Payment_description  ,sum(total_amount) as Total_amount 
from renamed
GROUP BY 1 
order by 2 desc
  