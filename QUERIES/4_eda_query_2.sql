/*
Q2. What percentage of total spending goes to the top 10 vendors?
Risk assessment
Supplier dependency
*/

SELECT
    SUM(total_amount) AS top_10_spend,
    ROUND(
        SUM(total_amount) * 100.0 /
        (SELECT SUM(amount_inr)
         FROM staging_vendor_payments),
        2
    )::TEXT || '%' AS top_10_share_percentage
FROM (
    SELECT
        vendor_name,
        SUM(amount_inr) AS total_amount
    FROM staging_vendor_payments
    GROUP BY vendor_name
    ORDER BY total_amount DESC
    LIMIT 10
) AS top_vendors;
