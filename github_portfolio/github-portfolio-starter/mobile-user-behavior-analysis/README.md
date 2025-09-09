# Mobile User Behavior Analysis

## Problem
Identify engagement, retention cohorts, and behavior patterns to inform product decisions.

## Data
Aggregated mobile events (public/anonymized).

## Methods
- SQL cohort queries (retention by install month)
- Python (Pandas) for feature engineering
- Power BI visuals: cohorts, funnels, LTV proxy

## Key Insights (examples)
- D7 retention improved +6% after onboarding change.
- Power users = top 10% sessions → 3× conversion rate.
- Weekend usage spikes; push timing adjusted.

## Files
- `sql/cohorts.sql`
- `notebooks/behavior_features.ipynb`
- `powerbi/mobile_behavior.pbix` (add outside git or via release)
- `reports/figures/`

## Reproduce
1. Load sample events into `data/raw/`.
2. Execute SQL transformations.
3. Refresh PBIX or run notebook.

## Preview
![cohorts](reports/figures/cohorts.png)