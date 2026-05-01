-- Overall Branch Performance

SELECT
    branch_id,
    region,
    city,
    state_code,
    SUM(profit) AS total_profit,
    SUM(loan_amount) AS total_loans,
    SUM(deposit_amount) AS total_deposits,
    SUM(fee_income) AS total_fees,
    SUM(total_expenses) AS total_expenses
FROM branch_profitability
GROUP BY branch_id, region, city, state_code
ORDER BY total_profit DESC;


-- Profit trend

SELECT
    branch_id,
    city,
    state_code,
    date,
    SUM(profit) AS monthly_profit
FROM branch_profitability
GROUP BY branch_id, city, state_code, date
ORDER BY branch_id, date;


-- Yearly profit

SELECT
    branch_id,
    city,
    state_code,
    year,
    SUM(profit) AS yearly_profit
FROM branch_profitability
GROUP BY branch_id, city, state_code, year
ORDER BY branch_id, year;


-- Declining branches

SELECT
    branch_id,
    city,
    state_code,
    SUM(CASE WHEN year = 2023 THEN profit ELSE 0 END) AS profit_2023,
    SUM(CASE WHEN year = 2024 THEN profit ELSE 0 END) AS profit_2024,
    SUM(CASE WHEN year = 2024 THEN profit ELSE 0 END)
      - SUM(CASE WHEN year = 2023 THEN profit ELSE 0 END) AS profit_change
FROM branch_profitability
GROUP BY branch_id, city, state_code
ORDER BY profit_change ASC;


-- Revenue vs expense breakdown

SELECT
    branch_id,
    city,
    state_code,
    SUM(CASE WHEN year = 2023 THEN loan_amount ELSE 0 END) AS loans_2023,
    SUM(CASE WHEN year = 2024 THEN loan_amount ELSE 0 END) AS loans_2024,
    SUM(CASE WHEN year = 2023 THEN fee_income ELSE 0 END) AS fees_2023,
    SUM(CASE WHEN year = 2024 THEN fee_income ELSE 0 END) AS fees_2024,
    SUM(CASE WHEN year = 2023 THEN total_expenses ELSE 0 END) AS expenses_2023,
    SUM(CASE WHEN year = 2024 THEN total_expenses ELSE 0 END) AS expenses_2024,
    SUM(CASE WHEN year = 2023 THEN profit ELSE 0 END) AS profit_2023,
    SUM(CASE WHEN year = 2024 THEN profit ELSE 0 END) AS profit_2024
FROM branch_profitability
GROUP BY branch_id, city, state_code
ORDER BY profit_2024 - profit_2023 ASC;


-- Root cause classification

WITH yearly AS (
    SELECT
        branch_id,
        city,
        state_code,
        SUM(CASE WHEN year = 2023 THEN loan_amount ELSE 0 END) AS loans_2023,
        SUM(CASE WHEN year = 2024 THEN loan_amount ELSE 0 END) AS loans_2024,
        SUM(CASE WHEN year = 2023 THEN fee_income ELSE 0 END) AS fees_2023,
        SUM(CASE WHEN year = 2024 THEN fee_income ELSE 0 END) AS fees_2024,
        SUM(CASE WHEN year = 2023 THEN total_expenses ELSE 0 END) AS expenses_2023,
        SUM(CASE WHEN year = 2024 THEN total_expenses ELSE 0 END) AS expenses_2024,
        SUM(CASE WHEN year = 2023 THEN profit ELSE 0 END) AS profit_2023,
        SUM(CASE WHEN year = 2024 THEN profit ELSE 0 END) AS profit_2024
    FROM branch_profitability
    GROUP BY branch_id, city, state_code
),
changes AS (
    SELECT
        *,
        loans_2024 - loans_2023 AS loan_change,
        fees_2024 - fees_2023 AS fee_change,
        expenses_2024 - expenses_2023 AS expense_change,
        profit_2024 - profit_2023 AS profit_change
    FROM yearly
)
SELECT
    branch_id,
    city,
    state_code,
    profit_change,
    loan_change,
    fee_change,
    expense_change,
    CASE
        WHEN loan_change < 0 AND fee_change < 0 THEN 'Revenue decline'
        WHEN expense_change > 0 THEN 'Expense increase'
        WHEN loan_change < 0 THEN 'Loan activity decline'
        WHEN fee_change < 0 THEN 'Fee income decline'
        ELSE 'Mixed / needs deeper review'
    END AS likely_issue
FROM changes
ORDER BY profit_change ASC;


-- Region performance

SELECT
    region,
    year,
    SUM(profit) AS total_profit,
    SUM(loan_amount) AS total_loans,
    SUM(fee_income) AS total_fees,
    SUM(total_expenses) AS total_expenses
FROM branch_profitability
GROUP BY region, year
ORDER BY region, year;


-- Seasonality

SELECT
    season,
    SUM(profit) AS total_profit,
    SUM(loan_amount) AS total_loans,
    SUM(fee_income) AS total_fees,
    SUM(total_expenses) AS total_expenses
FROM branch_profitability
GROUP BY season
ORDER BY total_profit DESC;