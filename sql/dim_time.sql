
SELECT DISTINCT
    date_format(a_timestamp, 'HHmmss') as time_string,
    CAST(a_timestamp AS timestamp) as time,
    hour(a_timestamp) as hour,
    minute(a_timestamp) as minute,
    second(a_timestamp) as second
FROM (
    SELECT start_at as a_timestamp FROM Bronze_Trips
    UNION ALL
    SELECT ended_at as a_timestamp FROM Bronze_Trips
) tmp
