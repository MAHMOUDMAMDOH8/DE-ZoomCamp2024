
  create view "Dezoom"."puplic"."base_staging_Green_tripdata__dbt_tmp"
    
    
  as (
    
with source as (
      select EXTRACT(MONTH FROM lpep_pickup_datetime) as month ,sum(total_amount) as Total_amount
      from "Dezoom"."public"."Green_tripdata"
      group by 1
),
renamed as (
    select MONTH ,Total_amount
    from source
    ORDER BY 2 desc
)
select * from renamed
  );