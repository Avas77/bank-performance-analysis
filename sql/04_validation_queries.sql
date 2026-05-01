SELECT COUNT(*)
FROM branch_profitability;

SELECT *
FROM branch_profitability
ORDER BY branch_id, date
LIMIT 20;

SELECT
    branch_id,
    date,
    COUNT(*) AS row_count
FROM branch_profitability
GROUP BY branch_id, date
HAVING COUNT(*) > 1;

SELECT
    COUNT(*) AS total_rows,
    COUNT(loan_amount) AS loan_records,
    COUNT(deposit_amount) AS deposit_records,
    COUNT(fee_income) AS fee_records,
    COUNT(total_expenses) AS expense_records
FROM branch_profitability;