/*
Q1. Which vendors receive the highest total payments?
Top vendors by spend
% share of total spend
*/

SELECT 
    svp.vendor_name, 
    SUM(svp.amount_inr)  total_amount, 
    ROUND(
        SUM(svp.amount_inr) * 100.0 / 
        (SELECT SUM(amount_inr)
        FROM staging_vendor_payments), 
        2
    )::TEXT || '%' AS spend_percentage
FROM 
    staging_vendor_payments  svp
GROUP BY 
    svp.vendor_name
ORDER BY 
    total_amount DESC
LIMIT 10;