CREATE OR REPLACE VIEW branch_profitability AS
SELECT
    b.branch_id,
    b.region,
    b.city,
    b.state_name,
    b.state_code,
    m.date,
    m.year,
    m.month_number AS month,
    m.month_name,
    m.quarter,
    m.season,
    COALESCE(l.loan_amount, 0) AS loan_amount,
    COALESCE(d.deposit_amount, 0) AS deposit_amount,
    COALESCE(f.fee_income, 0) AS fee_income,
    COALESCE(e.total_expenses, 0) AS total_expenses,
    COALESCE(l.loan_amount, 0)
      + COALESCE(f.fee_income, 0)
      - COALESCE(e.total_expenses, 0) AS profit
FROM dim_branch b
CROSS JOIN dim_month m
LEFT JOIN monthly_loans l
    ON b.branch_id = l.branch_id
    AND m.date = l.date
LEFT JOIN monthly_deposits d
    ON b.branch_id = d.branch_id
    AND m.date = d.date
LEFT JOIN monthly_fees f
    ON b.branch_id = f.branch_id
    AND m.date = f.date
LEFT JOIN monthly_expenses e
    ON b.branch_id = e.branch_id
    AND m.date = e.date;