# Branch Performance & Profitability Analysis

## 1. Business Problem
This project analyzes branch-level financial performance to identify underperforming branches and understand whether performance issues are driven by revenue decline, expense growth, or regional patterns.

## 2. Dataset Overview
The dataset contains multiple fact tables for loans, deposits, fees, and expenses, along with branch and date dimensions.

## 3. Data Modeling Approach
The final analytical grain was defined as one row per branch per month.

## 4. SQL Transformation
I created monthly fact views, a monthly date dimension, and a final branch_profitability view.

## 5. Analysis
The analysis focused on:
- overall branch profitability
- monthly profit trends
- year-over-year profit change
- revenue vs expense breakdown
- regional performance

## 6. Dashboard
Power BI was used to create:
- KPI cards
- profit by branch
- profit trend
- YoY profit change
- revenue vs expenses
- branch profitability map

## 7. Key Takeaways
This project demonstrates how SQL and Power BI can be used together to create a business-ready reporting solution.