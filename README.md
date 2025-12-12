# DVD Store Visit Reporting (PostgreSQL)

This project is a SQL-based reporting system for analyzing customer visit behavior across DVD store locations. It uses PostgreSQL tables, functions, triggers, and a stored procedure to transform raw rental data into business-friendly reports.

## 🎯 Business Goal

Provide insight into questions like:

> How does customer visit behavior differ between store locations in terms of total visits, distinct customers, and repeat visits over time?

The system supports:
- Comparing how busy each store is
- Understanding how many **unique vs. repeat** customers visit each store
- Tracking customer engagement over time (new, occasional, frequent visitors)

## 🧱 Core Components

The solution is built around two main reporting tables:

1. **Detailed table** – `rpt_st_visit_detail`  
   - One row per customer visit
   - Includes visit date, store, customer, and a **visit label** (`New Customer`, `Occasional Visitor`, `Frequent Visitor`)

2. **Summary table** – `rpt_st_visit_summary`  
   - Aggregated by store and reporting period (e.g., month)
   - Includes:
     - Total visits
     - Distinct customers
     - Repeat visits
     - New customer visits
     - Count of frequent visitors

A custom function, trigger, and stored procedure keep these tables up to date.

## 🧰 Tech Stack

- **Database:** PostgreSQL
- **Objects used:**
  - Tables
  - User-defined function (`get_visit_label`)
  - Trigger function + trigger
  - Stored procedure
  - Daily job scheduling (e.g., pgAgent)

## 📂 Repository Structure

```text
schema/
  rpt_st_visit_detail.sql          -- Detailed reporting table
  rpt_st_visit_summary.sql         -- Summary reporting table

functions/
  get_visit_label.sql              -- Classifies customers by visit frequency

triggers/
  fn_update_st_visit_summary.sql   -- Trigger function to roll up summary data
  trg_update_st_visit_summary.sql  -- Trigger definition

procedures/
  sp_refresh_st_visit_report.sql   -- Full refresh of both reporting tables

queries/
  populate_rpt_st_visit_detail.sql -- Populates the detailed table from source DVD tables

docs/
  business_requirements.md         -- Business context and field definitions
