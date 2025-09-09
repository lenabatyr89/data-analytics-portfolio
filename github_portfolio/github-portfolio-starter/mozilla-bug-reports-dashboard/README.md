# Mozilla Bug Reports Dashboard (Power BI)

## Problem
Understand bug trends, severity distribution, and outliers to prioritize engineering efforts.

## Data
Public bug report dataset (or simulated). No PII.

## Methods
- SQL for extraction/cleaning
- Power BI for modeling & visuals
- Python (Pandas/Matplotlib) for anomaly checks

## Key Insights (examples)
- Severity "Major" increased by 18% QoQ.
- Median time-to-close improved from 12 → 9 days.
- 7 outlier components generate 40% of critical bugs.

## Files
- `powerbi/bug_reports_dashboard.pbix` (not included in git; add via release or link to Drive)
- `sql/queries.sql`
- `notebooks/anomaly_checks.ipynb`
- `reports/figures/` (screenshots)

## Reproduce
1. Place raw CSVs under `data/raw/`.
2. Run SQL to create cleaned tables.
3. Open PBIX and refresh.

## Preview
![dashboard preview](reports/figures/preview.png)