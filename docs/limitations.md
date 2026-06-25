# Limitations

While the Driver Talent Evaluation Framework attempts to minimize the influence of car performance, it does not capture every factor affecting a Formula 1 driver's performance.

The following limitations should be considered when interpreting the results.

---

# 1. Teammate Strength Is Not Modeled

The framework assumes that every teammate comparison has equal difficulty.

For example:

* Beating Fernando Alonso by two positions
* Beating Nicholas Latifi by two positions

are treated equally by the model.

In reality, outperforming an elite teammate may provide stronger evidence of driver ability than outperforming a less competitive teammate.

This is one of the largest limitations of the framework.

---

# 2. Team Orders Are Not Considered

Formula 1 teams occasionally issue team orders that influence finishing positions.

Examples include:

* Holding position
* Swapping drivers
* Prioritizing one championship contender

Since this information is not available in the dataset, the framework assumes all finishing positions reflect competitive performance.

---

# 3. Driver Development Over Time

The framework evaluates a driver's entire modern-era career as a single body of work.

It does not distinguish between:

* Rookie seasons
* Peak performance years
* Late-career decline

---

# 4. Race Pace Is Not Directly Measured

Race performance is evaluated using finishing positions relative to teammates.

The framework does not incorporate:

* Average lap time
* Race pace
* Sector times
* Long-run performance

These metrics could provide a more detailed assessment of race pace.

---

# 5. Strategy Differences

Differences in race strategy can influence finishing positions.

Examples include:

* One-stop vs two-stop strategies
* Safety car timing
* Tyre selection

The framework assumes these effects average out over a driver's career.

---

# 6. Qualifying Position Is Used As A Proxy

Qualifying performance is represented using qualifying positions.

The framework does not use qualifying lap times.

A driver qualifying 0.02 seconds behind a teammate is treated similarly to a driver qualifying 0.30 seconds behind if both occupy adjacent positions.

---

# 7. Talent Is Estimated, Not Measured

Driver talent cannot be directly observed.

The Talent Index should therefore be interpreted as:

> A teammate-relative estimate of driver performance after minimizing the influence of car performance.

It should not be interpreted as an absolute ranking of the greatest Formula 1 drivers in history.

---

# Future Improvements

Potential future enhancements include:

* Teammate strength adjustment
* Lap-time based performance metrics
* Season-by-season talent evolution
* Driver peak-performance identification

---

# Conclusion

The framework successfully reduces one of the largest sources of bias in Formula 1 analytics—car performance—through teammate comparisons.

However, like all analytical models, it represents a simplified approximation of reality rather than a definitive measure of driver talent.

The project is intended to provide an explainable and data-driven estimate of teammate-relative performance, while clearly acknowledging the assumptions and limitations under which that estimate is produced.
