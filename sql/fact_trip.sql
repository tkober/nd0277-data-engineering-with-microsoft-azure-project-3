
SELECT
    bt.trip_id,
    br.rider_id,
    bt.start_station_id,
    bt.end_station_id,
    date_format(bt.start_at, 'yyyyMMdd') AS start_date,
    date_format(bt.ended_at, 'yyyyMMdd') AS end_date,
    date_format(bt.start_at, 'HHmmss') AS start_time,
    date_format(bt.ended_at, 'HHmmss') AS end_time,
    bt.rideable_type,
    (unix_timestamp(bt.ended_at) - unix_timestamp(bt.start_at)) AS trip_duration_seconds,
    floor(months_between(bt.ended_at, br.birthday) / 12) AS rider_age
FROM Bronze_Trips bt
JOIN Bronze_Riders br
    ON bt.rider_id = br.rider_id
