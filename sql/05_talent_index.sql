/* ============================================================
   Formula 1 Driver Talent Evaluation Framework
   File: 05_talent_index.sql

   Purpose:
   Using the previously calculated metrics in driver_performance_summary
   view to estimate driver talent, using a talent_index metric.

   Author: Adarsh Sharma
============================================================ */

/* ============================================================
   View: normalized_driver_metrics

   Description:
   Metrics have different scales (ex: percentages vs position gaps).
   To ensure fair weighting when combining them, Min-Max normalization is applied.

   Normalized Metrics Include:
   - Normalized Qualifying Win Rate
   - Normalized Qualifying Gap
   - Normalized Race Win Rate
   - Normalized Race Gap
============================================================ */

CREATE OR REPLACE VIEW normalized_driver_metrics AS

SELECT driver_name,
qual_comparisons, race_comparisons,
qual_win_rate, avg_qual_gap,
race_win_rate, avg_race_gap,
qual_std_dev, race_std_dev,

    ROUND(
        (qual_win_rate - MIN(qual_win_rate) OVER())
        /
        (MAX(qual_win_rate) OVER() - MIN(qual_win_rate) OVER()),
        4
    ) AS norm_qual_win_rate,

    ROUND(
        (avg_qual_gap - MIN(avg_qual_gap) OVER())
        /
        (MAX(avg_qual_gap) OVER() - MIN(avg_qual_gap) OVER()),
        4
    ) AS norm_qual_gap,

    ROUND(
        (race_win_rate - MIN(race_win_rate) OVER())
        /
        (MAX(race_win_rate) OVER() - MIN(race_win_rate) OVER()),
        4
    ) AS norm_race_win_rate,

    ROUND(
        (avg_race_gap - MIN(avg_race_gap) OVER())
        /
        (MAX(avg_race_gap) OVER() - MIN(avg_race_gap) OVER()),
        4
    ) AS norm_race_gap

FROM driver_performance_summary;

/* ============================================================
   View: driver_talent_index_v1

   Description:
   Combined the above 4 metrics together to create a weighted talent index.
   Since race performance capture a broader range of driver skills like race pace,
   tyre management, execution etc, therefore it recieves a higher weight than qualifying.

   Weights For Each Metric Were:
   - 20% = Normalized Qualifying Win Rate
   - 20% = Normalized Qualifying Gap
   - 30% = Normalized Race Win Rate
   - 30% = Normalized Race Gap
============================================================ */

CREATE OR REPLACE VIEW driver_talent_index_v1 AS

SELECT *,

    ROUND(
        (
            0.20 * norm_qual_win_rate
            + 0.20 * norm_qual_gap
            + 0.30 * norm_race_win_rate
            + 0.30 * norm_race_gap
        ) * 100,
        2
    ) AS talent_index

FROM normalized_driver_metrics;

/* ============================================================
   View: driver_talent_index_v2

   Description:
   Added a confidence layer using total number of comparisons.

   Metrics Includes:
   - Total Comparisons (Qualifying + Race Comparisons)
   - Data Confidence Score
   - Confidence Band
============================================================ */

CREATE OR REPLACE VIEW driver_talent_index_v2 AS

SELECT *, (qual_comparisons + race_comparisons) AS total_comparisons,

    ROUND(
        (
            (
                (qual_comparisons + race_comparisons)
                -
                MIN(qual_comparisons + race_comparisons) OVER()
            )
            /
            (
                MAX(qual_comparisons + race_comparisons) OVER()
                -
                MIN(qual_comparisons + race_comparisons) OVER()
            )
        ) * 100,
        2
    ) AS data_confidence_score,

    CASE
        WHEN (qual_comparisons + race_comparisons) >= 500
        THEN 'Very High'

        WHEN (qual_comparisons + race_comparisons) >= 250
        THEN 'High'

        WHEN (qual_comparisons + race_comparisons) >= 100
        THEN 'Medium'

        ELSE 'Low'
    END AS confidence_band

FROM driver_talent_index_v1;

/* ============================================================
   View: driver_talent_index_v3

   Description:
   Combined Qualifying Standard Deviation and Race Standard
   Devidation into a combined weighted Overall Standard Deviation.
   40% and 60% weight logic is same as before.

   Weight For Each Metrics Were:
   - 40% = Qualifying Standard Deviation
   - 60% = Race Standard Deviation
============================================================ */

CREATE OR REPLACE VIEW driver_talent_index_v3 AS

SELECT *,
ROUND(
    0.4 * qual_std_dev
    +
    0.6 * race_std_dev,
    2
) AS overall_std_dev
FROM f1.driver_talent_index_v2;
