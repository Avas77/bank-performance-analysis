CREATE OR REPLACE VIEW dim_month AS
SELECT DISTINCT
    date_trunc('month', date)::date AS date,
    year,
    month AS month_number,
    month_name,
    quarter,
    season
FROM dim_date;