/* ============================================================
   Formula 1 Driver Talent Evaluation Framework
   File: 06_final_framework.sql

   Purpose:
   Creates the final analytical dataset by combining talent,
   consistency and confidence metrics into a single view for
   dashboarding and analysis.

   Author: Adarsh Sharma
============================================================ */
/* ============================================================
   View: final_version

   Description:
   Final analytical dataset containing all performance, consistency 
   and confidence metrics required for dashboarding and ranking drivers.

   Metrics Included:
   - Driver Name
   - Talent Index
   - Overall Standard Deviation
   - Total Comparisons
   - Data Confidence Score
   - Confidence Band
   - Talent Rank --> Ranked drivers based om talent index
============================================================ */

CREATE OR REPLACE VIEW final_version AS

SELECT driver_name, talent_index, overall_std_dev, 
total_comparisons, data_confidence_score, confidence_band,

DENSE_RANK() OVER(ORDER BY talent_index DESC) AS talent_rank

FROM f1.driver_talent_index_v3
