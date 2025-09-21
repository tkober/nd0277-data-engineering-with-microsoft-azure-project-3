
SELECT 
    payment_id,
    to_char(date, 'yyyyMMdd') as payment_date,
    rider_id,
    amount
FROM Bronze_Payments
