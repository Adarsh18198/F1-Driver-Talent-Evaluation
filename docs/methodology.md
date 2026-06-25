# Methodology

## Problem Statement

In Formula 1, evaluating driver talent is challenging because race results depend heavily on the quality of the car.

Traditional performance indicators such as race wins, championships and podium finishes often reflect the competitiveness of the constructor as much as the driver's individual ability.

The objective of this project is to estimate **driver talent while minimizing the influence of car performance**.

---

# Proposed Solution

The core idea of this project is to compare drivers **only against their teammates**.

Teammates:

* Drive the same constructor
* Participate in the same race
* Experience similar weather conditions
* Operate under identical technical regulations

Since both drivers have access to nearly identical machinery, teammate comparisons provide one of the fairest publicly available methods for estimating individual driver performance.

---

# Analytical Pipeline

The complete methodology follows the pipeline below.

```text
   Raw Dataset
      ↓
Modern Era Filtering
      ↓
  Data Cleaning
      ↓
Valid Race Selection
      ↓
Teammate Comparisons
      ↓
Performance KPI Engineering
      ↓
Talent Index Construction
      ↓
Confidence & Consistency Estimation
      ↓
Final Analytical Framework
```

---

# Modern Era Selection

Only seasons from **2000–2024** were considered.

Reasons:

* Better data quality
* More consistent regulations
* Greater relevance to modern Formula 1
* Improved comparability between drivers

---

# Race Validation

Not every race is suitable for comparing teammates.

Mechanical failures can unfairly influence finishing positions.

Each race result was classified into:

* Valid Finish
* Driver Error
* Mechanical / External Failure

Only races where **both teammates recorded valid finishes** were used for race comparisons.

---

# Teammate Comparison Framework

Each race generates one head-to-head comparison between teammates.

Two independent analyses are performed.

## Qualifying

Compared using:

* Qualifying Position
* Qualifying Position Gap

---

## Race

Compared using:

* Finishing Position
* Finishing Position Gap

---

# KPI Engineering

The following performance metrics were created.

## Qualifying

* Total Qualifying Comparisons
* Qualifying Win Rate
* Average Qualifying Gap
* Qualifying Standard Deviation

---

## Race

* Total Race Comparisons
* Race Win Rate
* Average Finish Gap
* Race Standard Deviation

---

# Talent Index

Performance metrics are first normalized using Min-Max normalization.

The final Talent Index combines four metrics.

| Metric                 | Weight |
| ---------------------- | -----: |
| Qualifying Win Rate    |    20% |
| Average Qualifying Gap |    20% |
| Race Win Rate          |    30% |
| Average Finish Gap     |    30% |

Race metrics receive higher weight because they capture a broader range of driver skills, including race pace, tyre management, race execution and adaptability.

---

# Confidence Framework

Drivers with larger numbers of teammate comparisons produce more reliable estimates.

Instead of modifying the Talent Index, confidence is reported separately through:

* Total Comparisons
* Date Confidence Score
* Confidence Band

This keeps driver ability and estimate reliability as two independent dimensions.

---

# Final Framework

The final framework evaluates every driver across three independent dimensions.

## Talent

Measures performance relative to teammates.

---

## Reliability

Measured using standard deviation of teammate-relative performance.

---

## Confidence

Measures the amount of evidence supporting the estimated Talent Index.

Separating these three dimensions improves interpretability and avoids combining fundamentally different concepts into a single metric.
