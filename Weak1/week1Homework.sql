Which tag has the following text? - Automatically remove the container when it exits
--rm

----------------------------------------------------------------------------------------


root@452e2c418a5e:/# pip list
Package    Version
---------- -------
pip        23.0.1
setuptools 58.1.0
wheel      0.42.0

----------------------------------------------------------------------------------------
select count(*) as Total_trips
from green_tripdata 
where Date(lpep_pickup_datetime) = '2019-09-18' and Date(lpep_dropoff_datetime) = '2019-09-18'

total_trips
15612

----------------------------------------------------------------------------------------------
select max(trip_distance) as max_distance ,lpep_pickup_datetime::date
from green_tripdata 
group by lpep_pickup_datetime::date 
order by Max(trip_distance) DESC

max_distance	lpep_pickup_datetime
341.64	            9/26/2019
135.53	            9/21/2019
114.3	            9/16/2019

----------------------------------------------------------------------------------------------
select TZ."Borough" ,sum(GT."total_amount") as total_amount
from public.green_tripdata GT join public.taxi_zone TZ
on GT."PULocationID" = TZ."LocationID"
where DATE(GT."lpep_pickup_datetime") = '2019-09-18'
  AND GT."PULocationID" IS NOT NULL
GROUP BY tz."Borough"
having sum(GT."total_amount") > 50000
order by 2 desc
limit 3


Borough	       total_amount
Brooklyn	    96333.24
Manhattan	    92271.3
Queens	        78671.71

--------------------------------------------------------------------------------------------------
SELECT tz_dropoff."Zone" AS dropoff_zone, MAX(gtd."tip_amount") AS largest_tip
FROM public.green_tripdata gtd JOIN public.taxi_zone tz_pickup 
ON gtd."PULocationID" = tz_pickup."LocationID" JOIN public.taxi_zone tz_dropoff 
ON gtd."DOLocationID" = tz_dropoff."LocationID"
WHERE DATE(gtd."lpep_pickup_datetime") >= '2019-09-01'
  AND DATE(gtd."lpep_pickup_datetime") <= '2019-09-30'
  AND tz_pickup."Zone" = 'Astoria'
GROUP BY tz_dropoff."Zone"
ORDER BY largest_tip DESC
LIMIT 1;

dropoff_zone    largest_tip 
JFK Airport        62.31




