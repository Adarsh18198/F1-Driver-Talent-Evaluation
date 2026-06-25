# 🏎️ Formula 1 Driver Talent Evaluation Framework

> **A SQL-based analytical framework to estimate Formula 1 driver talent while minimizing the influence of car performance using teammate-relative performance metrics (2000–2024).**

---

## 📌 Project Overview

Evaluating Formula 1 drivers is difficult because race outcomes depend heavily on the competitiveness of the car.

Traditional metrics such as:

* Race Wins
* Championships
* Podiums
* Points

often measure **car performance** as much as **driver performance**.

This project approaches the problem differently.

Instead of comparing drivers across different teams, it compares **teammates**, who compete using nearly identical machinery, to estimate individual driver talent.

The result is an explainable **Driver Talent Evaluation Framework** built entirely using SQL.

---

# 🎯 Problem Statement

**How can we estimate a Formula 1 driver's raw talent while minimizing the influence of car performance?**

Since teammates drive the same constructor during the same race weekend, teammate comparisons provide one of the fairest publicly available methods for evaluating individual driver performance.

---

# 🏗️ Methodology

The project follows the analytical pipeline below.

```text
Raw Formula 1 Dataset
            │
            ▼
Database Design
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
Talent Index Construction
            │
            ▼
Confidence Estimation
            │
            ▼
Final Analytical Framework
```

---

# 📊 Performance Metrics

### Qualifying

* Total Qualifying Comparisons
* Qualifying Win Rate
* Average Qualifying Gap
* Qualifying Standard Deviation

### Race

* Total Race Comparisons
* Race Win Rate
* Average Finish Gap
* Race Standard Deviation

---

# ⭐ Driver Talent Index

The Talent Index combines four teammate-relative KPIs.

| Metric                 | Weight |
| ---------------------- | -----: |
| Qualifying Win Rate    |    20% |
| Average Qualifying Gap |    20% |
| Race Win Rate          |    30% |
| Average Finish Gap     |    30% |

Race metrics receive greater weight because they capture a broader range of driver skills, including race execution, tyre management and adaptability.

---

# 📈 Final Driver Profile

Each driver is evaluated across three independent dimensions.

| Dimension      | Purpose                                                 |
| -------------- | ------------------------------------------------------- |
| 🏎️ Talent     | Measures teammate-relative performance                  |
| 📊 Reliability | Measures consistency using standard deviation           |
| 📚 Confidence  | Measures the amount of evidence supporting the estimate |

Keeping these dimensions separate avoids mixing driver ability with estimate reliability.

---

# 🛠️ Tech Stack

* **MySQL 8.0**
* SQL Views
* Joins
* Window Functions
* Aggregate Functions
* Statistical Normalization (Min-Max)
* Git & GitHub

**Planned**

* Power BI Dashboard
* Python (Visualization & Analysis)

---

# 📂 Repository Structure

```text
F1-Driver-Talent-Evaluation
│
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_data_preprocessing.sql
│   ├── 03_teammate_comparisons.sql
│   ├── 04_driver_performance_metrics.sql
│   ├── 05_talent_index.sql
│   ├── 06_final_framework.sql
│   └── README.md
│
├── docs/
│   ├── methodology.md
│   ├── assumptions.md
│   ├── limitations.md
│   
├── dashboard/
│
├── images/
│
└── data/
```

---

# 🚀 Key Features

* Modern Era Analysis (2000–2024)
* Teammate-relative performance framework
* Car performance minimization
* Explainable KPI engineering
* Weighted Driver Talent Index
* Confidence Score based on sample size
* Consistency metrics using standard deviation
* Fully documented SQL pipeline

---

# ⚠️ Current Limitations

* Teammate strength is not explicitly modeled.
* Team orders are not considered.
* Race pace is approximated using finishing position.
* Driver development over time is not modeled.
* Lap-time level telemetry is not included.

These limitations are documented in detail in `docs/limitations.md`.

---

# 🔮 Future Improvements

* Teammate strength adjustment
* Lap-time based driver pace analysis
* Season-by-season talent evolution
* Interactive Power BI dashboard
* Driver similarity clustering

---

# 📖 Documentation

Additional documentation is available in the `docs` folder.

* Methodology
* Assumptions
* Limitations

---

# 👨‍💻 Author

**Adarsh Sharma**

This project was built as part of my analytics portfolio to demonstrate SQL, data modeling, KPI engineering and analytical problem-solving through a real-world Formula 1 case study.
