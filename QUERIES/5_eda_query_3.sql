/*
Q3. Which months have the highest expenditures?
Monthly spending trend
Peak spending periods
*/
WITH monthly_payments AS (
    SELECT 
        svp.payment_month  "month", 
        SUM(svp.amount_inr)  "total_payments_made"
    FROM 
        staging_vendor_payments  svp
    GROUP BY 
        svp.payment_month   
    ORDER BY
        total_payments_made DESC
)

SELECT *, total_payments_made - MIN(total_payments_made) OVER ()  vs_lowest
FROM monthly_payments