# ✈️ Airline On-Time Performance Dashboard — Project Roadmap

---

## Phase 1: Project Setup & Planning
- [x] Create a GitHub repository with a clear name (e.g., `airline-ontime-performance`)
- [x] Set up a virtual environment (venv or conda)
- [x] Install core dependencies: `pandas`, `numpy`, `sqlalchemy`, `matplotlib`, `seaborn`, `jupyter`
- [x] Create a folder structure: `/data`, `/notebooks`, `/sql`, `/visuals`, `/docs`
- [x] Write a draft README with project goals, tools, and dataset source

📦 **Deliverable:** Initialized GitHub repo with folder structure and draft README

---

## Phase 2: Data Acquisition
- [x] Visit the [BTS On-Time Performance portal](https://www.transtats.bts.gov/OT_Delay/OT_DelayCause1.asp)
- [x] Download at least 12 months of data (recommend 2022–2024 for recency)
- [x] Review the BTS data dictionary to understand all column definitions
- [x] Document which fields you'll use and why (e.g., `DEP_DELAY`, `CARRIER`, `ORIGIN`, `WEATHER_DELAY`)
- [x] Save raw files to `/data/raw` and commit them (or add to `.gitignore` if too large and use a data note)

📦 **Deliverable:** Raw CSVs downloaded, data dictionary reviewed and summarized in `/docs`

---

## Phase 3: Data Cleaning (Python / Pandas)
- [ ] Load all monthly files and concatenate into a single DataFrame
- [ ] Audit for nulls, duplicates, and inconsistent values
- [ ] Handle missing delay reason columns (BTS codes nulls as blank when flight is not delayed)
- [ ] Standardize column names to snake_case
- [ ] Create derived columns:
  - [ ] `is_delayed` (binary: delay > 15 mins per BTS definition)
  - [ ] `delay_category` (carrier, weather, NAS, security, late aircraft)
  - [ ] `month_name`, `day_of_week_name` for readability
- [ ] Filter out cancelled/diverted flights if not in scope
- [ ] Export cleaned data to `/data/cleaned`

📦 **Deliverable:** Cleaning notebook (`01_data_cleaning.ipynb`) with documented steps and a clean CSV/parquet file

---

## Phase 4: Database Setup & SQL Loading
- [ ] Choose your database: SQLite (simpler) or PostgreSQL (more impressive)
- [ ] Design your schema — at minimum one fact table (`flights`) and optional dimension tables (`airlines`, `airports`)
- [ ] Write a loader script to ingest the cleaned CSV into the database
- [ ] Verify row counts and spot-check a sample of records post-load
- [ ] Save all schema definitions as `.sql` files in `/sql`

📦 **Deliverable:** Populated local database + schema SQL files committed to GitHub

---

## Phase 5: SQL Analysis
Write and save queries for each of the following KPIs in `/sql`:

- [ ] **Overall on-time rate** by year and month
- [ ] **Worst and best performing carriers** by average delay minutes
- [ ] **Top 10 most delayed routes** (origin–destination pairs)
- [ ] **Delay cause breakdown** (% attributed to carrier, weather, NAS, etc.)
- [ ] **Busiest airports** vs. their on-time performance (volume vs. reliability trade-off)
- [ ] **Day-of-week and seasonal patterns** in delays
- [ ] **Late aircraft cascade effect** — share of delays caused by incoming late aircraft

📦 **Deliverable:** Analysis notebook (`02_sql_analysis.ipynb`) with SQL queries run via SQLAlchemy and results as DataFrames

---

## Phase 6: Python Visualizations (matplotlib / seaborn)
- [ ] Monthly on-time rate trend line (line chart)
- [ ] Carrier comparison bar chart (average delay by airline)
- [ ] Delay cause stacked bar chart (breakdown by category)
- [ ] Heatmap of delays by day of week × month
- [ ] Scatter plot: flight volume vs. on-time rate by airport
- [ ] Export all charts to `/visuals` as high-resolution PNGs
- [ ] Add clear titles, axis labels, and source annotations to every chart

📦 **Deliverable:** Visualization notebook (`03_visualizations.ipynb`) + exported chart images

---

## Phase 7: Interactive Dashboard (Tableau Public or Power BI)
- [ ] Connect Tableau/Power BI to your cleaned CSV or database export
- [ ] Build the following views:
  - [ ] KPI summary cards (overall on-time rate, avg delay, total flights)
  - [ ] Carrier performance ranking (sortable bar chart)
  - [ ] Map of U.S. airports colored by on-time rate
  - [ ] Delay cause breakdown (interactive filter by airline/airport)
  - [ ] Monthly trend with year-over-year comparison
- [ ] Add filters for: Airline, Airport, Date Range, Delay Type
- [ ] Polish layout with a consistent color scheme and dashboard title
- [ ] Publish to Tableau Public and copy the shareable URL

📦 **Deliverable:** Published interactive dashboard with public link saved in README

---

## Phase 8: Storytelling & Documentation
- [ ] Write a `findings.md` in `/docs` summarizing 5–7 key insights
- [ ] Frame findings as business insights, not just statistics (e.g., *"Late aircraft delays account for X% of total delay minutes — a cascading problem that compounds throughout the day"*)
- [ ] Update GitHub README with:
  - [ ] Project overview and motivation
  - [ ] Tools and tech stack
  - [ ] How to reproduce the analysis
  - [ ] Link to Tableau dashboard
  - [ ] Key findings summary
  - [ ] Screenshot of the dashboard
- [ ] Add a methodology note explaining BTS's 15-minute delay threshold

📦 **Deliverable:** Polished README + findings document

---

## Phase 9: Final Review & Publishing
- [ ] Review all notebooks for clean, commented code
- [ ] Confirm all notebooks run top-to-bottom without errors (Restart & Run All)
- [ ] Check that no sensitive or oversized files are committed
- [ ] Add a `requirements.txt` so others can reproduce your environment
- [ ] Pin the repo to your GitHub profile
- [ ] Share the Tableau Public link on LinkedIn with a short write-up of your findings

📦 **Deliverable:** Publication-ready GitHub repo + LinkedIn post

---

## Summary of All Deliverables

| # | Deliverable | Where |
|---|---|---|
| 1 | `01_data_cleaning.ipynb` | GitHub `/notebooks` |
| 2 | `02_sql_analysis.ipynb` | GitHub `/notebooks` |
| 3 | `03_visualizations.ipynb` | GitHub `/notebooks` |
| 4 | SQL schema + query files | GitHub `/sql` |
| 5 | Exported chart images | GitHub `/visuals` |
| 6 | Interactive dashboard | Tableau Public (linked in README) |
| 7 | `findings.md` | GitHub `/docs` |
| 8 | Polished `README.md` | GitHub root |