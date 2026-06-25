/* ============================================================
   Formula 1 Driver Talent Evaluation Framework
   File: 02_data_preprocessing.sql

   Purpose:
   Cleans and filters the raw Formula 1 dataset to create
   analysis-ready views for the modern era (2000–2024).

   Author: Adarsh Sharma
============================================================ */

/* ============================================================
   View: modern_race_results

   Description:
   Filters Formula 1 race data to the modern era (2000–2024)
   and combines race, driver, constructor and status information.
============================================================ */

CREATE OR REPLACE VIEW modern_race_results AS

SELECT
r.year, r.raceId, r.name AS race_name,
d.driverId, CONCAT(d.forename, ' ', d.surname) AS driver_name,
c.constructorId, c.name AS constructor_name,
q.position AS qualifying_position,
res.grid, res.positionOrder AS finish_position, res.points, res.statusId
FROM results AS res
  
JOIN races AS r
ON res.raceId = r.raceId

JOIN drivers AS d
ON res.driverId = d.driverId

JOIN constructors AS c
ON res.constructorId = c.constructorId

LEFT JOIN qualifying AS q
ON (res.raceId = q.raceId) AND res.driverId = q.driverId

WHERE r.year BETWEEN 2000 AND 2024;
