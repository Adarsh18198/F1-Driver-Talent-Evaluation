# SQL Pipeline

This folder contains the complete SQL workflow used to build the **Formula 1 Driver Talent Evaluation Framework**.

The SQL scripts are organized as a sequential analytics pipeline, starting from raw database creation and ending with the final driver ranking dataset.

---

# Execution Order

Run the SQL files in the following order:

```
01_database_setup.sql
        ↓
02_data_preprocessing.sql
        ↓
03_teammate_comparisons.sql
        ↓
04_driver_performance_metrics.sql
        ↓
05_talent_index.sql
        ↓
06_final_framework.sql
```

Each file depends on the views created in the previous file.

---

# File Descriptions

## 01_database_setup.sql

**Purpose**

Creates the complete Formula 1 database schema.

### Includes

* Database creation
* Table creation
* Primary Keys
* Foreign Keys
* Relationships

---

## 02_data_preprocessing.sql

**Purpose**

Prepares the raw Formula 1 dataset for analysis.

### Includes

* Modern Era filtering (2000–2024)
* Data cleaning
* Race status categorization
* Removal of mechanically affected race comparisons
* Creation of reusable preprocessing views

### Output

* `modern_race_results`
* `race_comparison_status`
* `valid_race_comparisons`

---

## 03_teammate_comparisons.sql

**Purpose**

Creates head-to-head teammate comparisons.

Since teammates drive the same constructor in the same race, these comparisons significantly reduce the influence of car performance.

### Includes

* Qualifying teammate comparison
* Race teammate comparison
* Head-to-head outcome generation

### Output

* `teammate_comparisons`

---

## 04_driver_performance_metrics.sql

**Purpose**

Calculates all driver performance KPIs.

### Qualifying Metrics

* Total Qualifying Comparisons
* Qualifying Win Rate
* Average Qualifying Gap
* Qualifying Standard Deviation

### Race Metrics

* Total Race Comparisons
* Race Win Rate
* Average Finish Gap
* Race Standard Deviation

### Output

* `qualifying_summary`
* `race_result_view`
* `race_summary`
* `driver_performance_summary`

---

## 05_talent_index.sql

**Purpose**

Converts the performance metrics into a single Driver Talent Index.

### Includes

* Min-Max normalization
* Weighted Talent Index
* Data Confidence Score
* Confidence Band
* Overall Standard Deviation

### Output

* `normalized_driver_metrics`
* `driver_talent_index_v1`
* `driver_talent_index_v2`
* `driver_talent_index_v3`

---

## 06_final_framework.sql

**Purpose**

Creates the final analytical dataset used for reporting and dashboarding.

### Final Dataset Includes

* Driver Name
* Talent Index
* Overall Standard Deviation
* Total Comparisons
* Data Confidence Score
* Confidence Band
* Talent Rank

### Output

* `final_version`

---

# Overall SQL Workflow

```
   Raw Formula 1 Dataset
            │
            ▼
      Database Setup
            │
            ▼
Data Cleaning & Preprocessing
            │
            ▼
    Teammate Comparisons
            │
            ▼
  Performance KPI Engineering
            │
            ▼
T  alent Index Calculation
            │
            ▼
   Final Analytical Dataset
```

---

# Design Philosophy

Instead of ranking drivers using race wins or championships, this project evaluates **teammate-relative performance**.

Since teammates compete using nearly identical machinery, comparing them provides a better estimate of individual driver ability while minimizing the influence of car performance.

The final analytical framework separates three independent dimensions:

* **Talent** — How well the driver performs.
* **Consistency** — How repeatable the driver's performances are.
* **Confidence** — How much data supports the estimate.

Keeping these dimensions separate improves interpretability and avoids mixing performance with estimate reliability.

