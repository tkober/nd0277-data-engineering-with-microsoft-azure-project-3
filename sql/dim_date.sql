
SELECT DISTINCT
    date_format(a_date, 'yyyyMMdd') AS date_string,
    CAST(a_date AS date) AS date,
    year(a_date) AS year,
    quarter(a_date) AS quarter,
    month(a_date) AS month,
    weekofyear(a_date) AS week,
    day(a_date) AS day,
    dayofweek(a_date) AS weekday,
    date_format(a_date, 'EEEE') AS weekday_name,
    date_format(a_date, 'MMMM') AS month_name,
    trunc(a_date, 'YEAR') AS first_of_year,
    date_add(trunc(a_date, 'YEAR'), CASE 
        WHEN ((year(a_date) % 4 = 0 AND year(a_date) % 100 <> 0) OR year(a_date) % 400 = 0) THEN 366
        ELSE 365
    END - 1) AS last_of_year,
    trunc(a_date, 'QUARTER') AS first_of_quarter,
    last_day_of_quarter_udf(a_date) AS last_of_quarter,
    trunc(a_date, 'MONTH') AS first_of_month,
    last_day(a_date) AS last_of_month,
    ((year(a_date) % 4 = 0 AND year(a_date) % 100 <> 0) OR year(a_date) % 400 = 0) AS is_leap_year,
    (dayofweek(a_date) IN (1,7)) AS is_weekend
FROM (
    SELECT start_at AS a_date FROM Bronze_Trips
    UNION ALL
    SELECT ended_at AS a_date FROM Bronze_Trips
    UNION ALL
    SELECT date AS a_date FROM Bronze_Payments
) tmp
