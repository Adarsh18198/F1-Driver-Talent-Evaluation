/* ============================================================
   Formula 1 Driver Talent Evaluation Framework
   File: 04_driver_performance_metrics.sql

   Purpose:
   Using the previously created views to measure the driver's performance
   relative to his teammate, using various qualifying and race metrics.

   Author: Adarsh Sharma
============================================================ */

/* ============================================================
   View: qualifying_summary

   Description:
   Calculates qualifying performance metrics for each driver
   based on teammate head-to-head comparisons.

   Metrics:
   - Total Qualifying Comparisons
   - Qualifying Win Rate
   - Average Qualifying Gap
   - Qualifying Standard Deviation
============================================================ */

CREATE OR REPLACE VIEW qualifying_summary AS

SELECT driver_name, COUNT(*) AS qual_comparisons,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN qualifying_position < teammate_qualifying_position
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS qual_win_rate,

    ROUND(
        AVG(teammate_qualifying_position - qualifying_position),
        2
    ) AS avg_qual_gap,

    ROUND(
        STDDEV_POP( teammate_qualifying_position - qualifying_position),
        2
    ) AS qual_std_dev

FROM teammate_comparisons

WHERE (qualifying_position IS NOT NULL) AND (teammate_qualifying_position IS NOT NULL)

GROUP BY driver_name
HAVING COUNT(*) >= 30

/* ============================================================
   View: race_result_view

   Description:
   Writes logic for what is considered a WIN or LOSS for a driver
   based on various status category like VALID or DRIVER_ERROR,
   joined previously in valid_race_comparisons view.
============================================================ */

CREATE OR REPLACE VIEW race_result_view AS

SELECT *,
  
    CASE
        -- Driver finished, teammate made driver error
        WHEN (driver_category = 'VALID')
        AND (teammate_category = 'DRIVER_ERROR')
        THEN 'WIN'

        -- Driver made driver error, teammate finished
        WHEN (driver_category = 'DRIVER_ERROR')
        AND (teammate_category = 'VALID')
        THEN 'LOSS'

        -- Both valid finishes
        WHEN (driver_category = 'VALID')
        AND (teammate_category = 'VALID')
        THEN
            CASE
                WHEN (finish_position < teammate_finish_position)
                THEN 'WIN'
                ELSE 'LOSS'
            END

        -- Both driver errors
        WHEN (driver_category = 'DRIVER_ERROR')
        AND (teammate_category = 'DRIVER_ERROR')
        THEN
            CASE
                WHEN (finish_position < teammate_finish_position)
                THEN 'WIN'
                ELSE 'LOSS'
            END
    END AS race_result

FROM valid_race_comparisons;

/* ============================================================
   View: race_summary

   Description:
   Calculates race performance metrics for each driver
   based on teammate head-to-head comparisons.

   Metrics:
   - Total Race Comparisons
   - Race Win Rate
   - Average Race Gap
   - Race Standard Deviation
============================================================ */

CREATE OR REPLACE VIEW race_summary AS

SELECT driver_name, COUNT(*) AS race_comparisons,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN race_result = 'WIN'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS race_win_rate,

    ROUND(
        AVG(teammate_finish_position - finish_position),
        2
    ) AS avg_race_gap,

    ROUND(
        STDDEV_POP(teammate_finish_position - finish_position),
        2
    ) AS race_std_dev

FROM race_result_view

GROUP BY driver_name
HAVING COUNT(*) >= 30

/* ============================================================
   View: driver_performance_summary

   Description:
   Combines the qualifying_summary metrics and race_summary metrics
   into a master driver summary table containing all the quali and
   race metrics for a driver at one place for further analysis.

   Metrics:
   - Total Qualifying and Race Comparisons
   - Qualifying and Race Win Rate
   - Average Qualifying and Race Gap
   - Qualifying and Race Standard Deviation
============================================================ */

CREATE OR REPLACE VIEW driver_performance_summary AS

SELECT
q.driver_name, q.qual_comparisons, q.qual_win_rate, q.avg_qual_gap, q.qual_std_dev,
r.race_comparisons, r.race_win_rate, r.avg_race_gap, r.race_std_dev

FROM qualifying_summary as q

JOIN race_summary as r
ON q.driver_name = r.driver_name;
