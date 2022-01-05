/*
MS SQL Server
https://www.hackerrank.com/challenges/weather-observation-station-20/problem

A median is defined as a number separating the higher half of a data set from the lower half.
Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to decimal places.


 */

SELECT  CAST(LAT_N AS DECIMAL(10,4)) AS lat_median
FROM
(
    SELECT
        LAT_N,
        DENSE_RANK() OVER (ORDER BY LAT_N) AS lat_rank,
         (quan+1)/2 AS quan
    FROM
    (   SELECT DISTINCT LAT_N,
        (SELECT COUNT(DISTINCT LAT_N) FROM STATION) quan
        FROM STATION) t
               ) t2
WHERE lat_rank=quan;
