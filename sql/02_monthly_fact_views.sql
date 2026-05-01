CREATE OR REPLACE VIEW monthly_expenses AS
SELECT
    branch_id,
    date_trunc('month', month)::date AS date,
    SUM(amount) AS total_expenses
FROM fact_expenses
GROUP BY branch_id, date_trunc('month', month)::date;

CREATE OR REPLACE VIEW monthly_loans AS
SELECT
    branch_id,
    date_trunc('month', month)::date AS date,
    SUM(loan_amount) AS loan_amount
FROM fact_loans
GROUP BY branch_id, date_trunc('month', month)::date;

CREATE OR REPLACE VIEW monthly_deposits AS
SELECT
    branch_id,
    date_trunc('month', month)::date AS date,
    SUM(deposit_amount) AS deposit_amount
FROM fact_deposits
GROUP BY branch_id, date_trunc('month', month)::date;

CREATE OR REPLACE VIEW monthly_fees AS
SELECT
    branch_id,
    date_trunc('month', month)::date AS date,
    SUM(fee_income) AS fee_income
FROM fact_fees
GROUP BY branch_id, date_trunc('month', month)::date;