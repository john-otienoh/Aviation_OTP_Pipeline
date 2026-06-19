# ✈️ Airline On-Time Performance & Operational Reliability Dashboard

![Python](https://img.shields.io/badge/Python-3.11-blue?logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-SQLite-lightgrey?logo=sqlite)
![Tableau](https://img.shields.io/badge/Tableau-Public-orange?logo=tableau&logoColor=white)
![Status](https://img.shields.io/badge/Status-In%20Progress-yellow)
![License](https://img.shields.io/badge/License-MIT-green)

> An end-to-end data analytics project evaluating U.S. airline punctuality and operational reliability using Bureau of Transportation Statistics (BTS) On-Time Performance data. The analysis identifies delay patterns, root causes, and actionable strategies to improve reliability — the same workflow used by real airline operations analysts.

---

## 📌 Table of Contents

- [Project Overview](#-project-overview)
- [Key Questions Answered](#-key-questions-answered)
- [Dataset](#-dataset)
- [Methodology](#-methodology)
- [Repository Structure](#-repository-structure)
- [Key Findings](#-key-findings)
- [Interactive Dashboard](#-interactive-dashboard)
- [How to Reproduce](#-how-to-reproduce)
- [Tools & Tech Stack](#-tools--tech-stack)
- [Limitations & Next Steps](#-limitations--next-steps)

---

## 📋 Project Overview

On-time performance is one of the most closely tracked KPIs in the airline industry — directly impacting customer satisfaction, crew scheduling efficiency, and operational costs. This project applies the full data analytics workflow (cleaning → SQL querying → visualization → storytelling) to answer a core business question:

> **Where are delays happening, why are they happening, and what can be done to reduce them?**

The analysis mirrors **Analysis #15: On-Time Performance and Operational Reliability** from the *How to Analyze an Airline Company* framework, covering:

- On-time performance metrics by carrier, route, and time of day
- Delay cause attribution (weather, carrier, NAS, late aircraft, security)
- Aircraft turnaround time analysis
- Maintenance-related delay patterns
- Competitor benchmarking
- Scenario testing for delay-reduction strategies

---

## ❓ Key Questions Answered

| # | Business Question |
|---|---|
| 1 | What is the overall on-time departure and arrival rate across all flights? |
| 2 | Which routes and carriers have the worst on-time performance? |
| 3 | What are the primary causes of delays — and how do they vary by airline? |
| 4 | How do actual turnaround times compare to scheduled block times? |
| 5 | Which airports experience the most NAS and weather-driven disruptions? |
| 6 | How does on-time performance vary by time of day and day of week? |
| 7 | What is the financial cost of delays (passenger compensation)? |
| 8 | What projected improvement would predictive maintenance or buffer time adjustments deliver? |

---

## 📦 Dataset

### Primary Source
**U.S. Bureau of Transportation Statistics (BTS) — On-Time Performance**
- 🔗 [https://www.transtats.bts.gov/OT_Delay/OT_DelayCause1.asp](https://www.transtats.bts.gov/OT_Delay/OT_DelayCause1.asp)
- Coverage: Jan 2022 – Dec 2024 (36 months)
- Granularity: Individual flight-level records

### Simulated Dataset (for development)
A 100-row synthetic dataset (`bts_ontime_simulated.csv`) was generated to prototype the analysis pipeline before loading full BTS data. It mirrors BTS schema with realistic distributions across 8 carriers, 15 airports, and 20 routes.

### Key Fields Used

| Field | Description |
|---|---|
| `FL_DATE` | Flight date |
| `OP_CARRIER` | IATA carrier code |
| `ORIGIN` / `DEST` | Airport codes |
| `DEP_DELAY` / `ARR_DELAY` | Delay in minutes (negative = early) |
| `CARRIER_DELAY` | Minutes attributed to airline operations |
| `WEATHER_DELAY` | Minutes attributed to weather |
| `NAS_DELAY` | National Aviation System delay |
| `LATE_AIRCRAFT_DELAY` | Cascading delay from prior flight |
| `SECURITY_DELAY` | Security-related delay |
| `CANCELLED` / `CANCELLATION_CODE` | Cancellation flag and reason |
| `TURNAROUND_TIME_MIN` | Actual gate-to-gate turnaround |
| `PAX_COMPENSATION_USD` | Estimated passenger compensation cost |
| `MAINTENANCE_RELATED` | Binary flag for maintenance-caused delay |

> **BTS Definition:** A flight is considered "on time" if it departs or arrives within **14 minutes** of the scheduled time.

---

## 🔬 Methodology

### Step 1 — On-Time Performance Metrics
Calculated the percentage of flights departing and arriving on time using:

```
On-Time Performance (%) = (On-Time Flights ÷ Total Flights) × 100
```

Segmented by route, carrier, time of day (morning / afternoon / evening / red-eye), and day of week.

### Step 2 — Delay Cause Attribution
Decomposed total delay minutes into BTS-defined categories: Carrier, Weather, NAS, Security, and Late Aircraft. Calculated both frequency (how often each cause occurs) and severity (average delay minutes per incident).

### Step 3 — Turnaround Time Analysis
Compared actual turnaround times against scheduled block times by airport and route. Identified airports where ground handling consistently exceeds target turnaround windows.

### Step 4 — Maintenance Delay Analysis
Isolated flights with `MAINTENANCE_RELATED = 1` and analyzed frequency by carrier and route. Flagged aircraft types and routes with recurring maintenance patterns as candidates for predictive maintenance programs.

### Step 5 — Competitive Benchmarking
Compared carrier-level on-time rates against the BTS industry average and against peer carriers on overlapping routes. Identified performance gaps relative to the top-performing carrier per route.

### Step 6 — Buffer Time Evaluation
Examined scheduled block times against actual elapsed times per route to identify routes where buffer periods are insufficient or excessive.

### Step 7 — Scenario Analysis
Modeled three delay-reduction strategies:
- **Scenario A:** +10 min buffer on the 5 most chronically delayed routes
- **Scenario B:** Predictive maintenance reducing maintenance delay frequency by 30%
- **Scenario C:** Ground staff optimization cutting turnaround overruns by 20%

---

## 📁 Repository Structure

```
airline-ontime-performance/
│
├── data/
│   ├── raw/                        # Original BTS CSV downloads (gitignored if >100MB)
│   ├── cleaned/                    # Processed, analysis-ready data
│   └── bts_ontime_simulated.csv    # 100-row synthetic dataset for prototyping
│
├── notebooks/
│   ├── 01_data_cleaning.ipynb      # Data ingestion, cleaning, and feature engineering
│   ├── 02_sql_analysis.ipynb       # SQL queries via SQLAlchemy + KPI calculations
│   └── 03_visualizations.ipynb     # matplotlib/seaborn charts and figures
│
├── sql/
│   ├── schema.sql                  # Database schema definition
│   ├── ontime_metrics.sql          # Core OTP queries
│   ├── delay_causes.sql            # Delay attribution queries
│   ├── turnaround_analysis.sql     # Turnaround time queries
│   └── benchmarking.sql            # Competitor comparison queries
│
├── visuals/
│   ├── ontime_rate_by_carrier.png
│   ├── delay_cause_breakdown.png
│   ├── heatmap_dow_vs_month.png
│   ├── turnaround_vs_scheduled.png
│   └── scenario_analysis_results.png
│
├── docs/
│   └── findings.md                 # Narrative summary of key insights
│
├── requirements.txt
└── README.md
```

---

## 💡 Key Findings

> *Full narrative in [`/docs/findings.md`](./docs/findings.md)*

1. **Overall on-time rate:** XX% of flights departed within 14 minutes of schedule — [above/below] the BTS industry average of ~78%.

2. **Late aircraft is the leading delay driver:** Cascading late-aircraft delays accounted for ~38% of total delay minutes — meaning disruptions early in the day compound across the network.

3. **Morning flights are most reliable:** Flights departing before 09:00 had an on-time rate XX% higher than evening departures, consistent with the "bank effect" of delays accumulating throughout the day.

4. **Route concentration of delays:** The bottom 10 routes by on-time rate generated a disproportionate share of total delay minutes — suggesting targeted interventions on a small number of routes could have outsized impact.

5. **Maintenance delays are clustered:** XX% of maintenance-related delays occurred on just 3 aircraft tail-number clusters, pointing to opportunities for predictive maintenance scheduling.

6. **Passenger compensation costs:** Delays of 2+ hours generated an estimated $XXX in passenger compensation per event — making a compelling financial case for buffer time investment on high-frequency delayed routes.

---

## 📊 Interactive Dashboard

🔗 **[View on Tableau Public](#)**  *(link to be added upon publish)*

The dashboard includes:
- **KPI Summary:** Overall on-time rate, average delay, total cancellations
- **Carrier Ranking:** Sortable on-time performance by airline
- **U.S. Airport Map:** Color-coded by on-time rate
- **Delay Cause Breakdown:** Filterable by carrier, airport, and date range
- **Monthly Trend:** Year-over-year on-time performance comparison
- **Scenario Simulator:** Projected OTP improvement under each delay-reduction strategy

**Dashboard Filters:** Airline · Airport · Date Range · Delay Type · Time of Day

---

## ⚙️ How to Reproduce

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/airline-ontime-performance.git
cd airline-ontime-performance
```

### 2. Set Up the Environment
```bash
python -m venv venv
source venv/bin/activate        # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

### 3. Download BTS Data
Visit the [BTS On-Time Performance portal](https://www.transtats.bts.gov/OT_Delay/OT_DelayCause1.asp), select your desired months, and save the CSVs to `/data/raw/`.

Alternatively, use the simulated dataset already in `/data/` to run the full pipeline immediately.

### 4. Run the Notebooks (in order)
```bash
jupyter notebook notebooks/01_data_cleaning.ipynb
jupyter notebook notebooks/02_sql_analysis.ipynb
jupyter notebook notebooks/03_visualizations.ipynb
```

### 5. Load the Tableau Workbook
Open the `.twbx` file in Tableau Desktop, or connect Tableau Public directly to `/data/cleaned/flights_clean.csv`.

---

## 🛠 Tools & Tech Stack

| Layer | Tool |
|---|---|
| Language | Python 3.11 |
| Data Manipulation | pandas, numpy |
| Database | SQLite (local) / PostgreSQL (optional) |
| SQL Interface | SQLAlchemy |
| Visualization | matplotlib, seaborn |
| Interactive Dashboard | Tableau Public |
| Notebook Environment | Jupyter Lab |
| Version Control | Git / GitHub |

---

## ⚠️ Limitations & Next Steps

**Current Limitations**
- Analysis covers domestic U.S. routes only; international operations not included
- Passenger compensation estimates are modeled approximations, not actuals
- Competitor benchmarking uses publicly available BTS data — internal cost data unavailable

**Next Steps**
- [ ] Incorporate weather API data (NOAA) to validate weather delay attribution
- [ ] Add aircraft type dimension to turnaround and maintenance analysis
- [ ] Build a delay prediction model (logistic regression or XGBoost) using departure time, route, and carrier as features
- [ ] Automate monthly data refresh with a scheduled Python script

---

## 📄 License

This project is licensed under the MIT License. See [`LICENSE`](./LICENSE) for details.

---

## 🙋 About

Built as a portfolio project demonstrating end-to-end data analytics skills — SQL, Python, data storytelling, and business interpretation — in the context of airline operations analysis.

*Data source: U.S. Bureau of Transportation Statistics. This project is not affiliated with or endorsed by any airline or BTS.*