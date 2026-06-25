/* ============================================================
   Formula 1 Driver Talent Evaluation Framework
   File: 03_teammate_comparisons.sql

   Purpose:
   Join the existing modern_race_results dataset with itself
   to create teammate level comparison for each grand prix.

   Author: Adarsh Sharma
============================================================ */

/* ============================================================
   View: teammate_comparisons

   Description:
   Creates one head-to-head qualifying and race results comparison 
   between teammates for every Grand Prix in the modern era.
============================================================ */

CREATE OR REPLACE VIEW teammate_comparisons AS

SELECT
a.year, a.raceId, a.race_name,
a.constructorId, a.constructor_name,
a.driverId, a.driver_name, 
b.driverId AS teammate_id, b.driver_name AS teammate_name,
a.grid, b.grid AS teammate_grid, 
a.qualifying_position, b.qualifying_position AS teammate_qualifying_position,
a.finish_position, b.finish_position AS teammate_finish_position,
a.points, b.points AS teammate_points,
a.statusId, b.statusId AS teammate_statusId

FROM modern_race_results AS a

JOIN modern_race_results AS b
ON (a.raceId = b.raceId) 
AND (a.constructorId = b.constructorId) 
AND (a.driverId <> b.driverId)
