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
   and combines race, qualifying, driver, constructor, result and status information.
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

/* ============================================================
   View: race_comparison_status

   Description:
   Puts the status information into 3 categories : VALID, DRIVER_ERROR
   and MECHNICAL ERRORS and combines it with existing racing data
============================================================ */

CREATE OR REPLACE VIEW race_comparison_status AS

SELECT tc.*,
s1.status AS driver_status, s2.status AS teammate_status,

    CASE
        WHEN (s1.status = 'Finished') OR (s1.status LIKE '+%Lap%') OR (s1.status LIKE '+%Laps%')
        THEN 'VALID'
   
        WHEN s1.status IN (
            'Accident',
            'Collision',
            'Collision damage',
            'Spun off',
            'Damage',
            'Broken wing',
            'Front wing',
            'Rear wing',
            'Handling',
            'Debris',
            'Puncture',
            'Tyre puncture'
        )
        THEN 'DRIVER_ERROR'

        ELSE 'MECHANICAL_OR_OTHER'
    END AS driver_category,

    CASE
        WHEN (s2.status = 'Finished') OR (s2.status LIKE '+%Lap%')  OR (s2.status LIKE '+%Laps%')
        THEN 'VALID'

        WHEN s2.status IN (
            'Accident',
            'Collision',
            'Collision damage',
            'Spun off',
            'Damage',
            'Broken wing',
            'Front wing',
            'Rear wing',
            'Handling',
            'Debris',
            'Puncture',
            'Tyre puncture'
        )
        THEN 'DRIVER_ERROR'

        ELSE 'MECHANICAL_OR_OTHER'
    END AS teammate_category

FROM teammate_comparisons as tc

JOIN status as s1
ON tc.statusId = s1.statusId

JOIN status as s2
ON tc.teammate_statusId = s2.statusId;

/* ============================================================
   View: valid_race_comparisons

   Description:
   Removes the MECHANICAL ERROR races, from the dataset, keeping
   only VALID and DRIVER_ERROR races for futher analysis
============================================================ */

CREATE OR REPLACE VIEW valid_race_comparisons AS

SELECT *
FROM race_comparison_status

WHERE (driver_category <> 'MECHANICAL_OR_OTHER')
AND (teammate_category <> 'MECHANICAL_OR_OTHER')
