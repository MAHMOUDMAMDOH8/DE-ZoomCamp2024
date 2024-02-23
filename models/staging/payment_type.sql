{{
    config(
        materialized='view'
    )
}}
with source as (
      select payment_type,sum(total_amount) as Total_amount
      from {{ source('staging', 'Green_tripdata') }}
      group by 1
),
renamed as (
    select payment_type ,Total_amount
    from source
    ORDER BY 2 desc
)
select * from renamed
  