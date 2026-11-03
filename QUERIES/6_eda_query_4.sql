/*
Q4. Which GL accounts account for the largest share of total recorded spending?
Expense category analysis
Largest cost drivers
*/

SELECT 
    svp.gl_account_code  account_code, 
    svp.gl_account_name  account_name, 
    SUM(svp.amount_inr)  total_payments, 
    ROUND(SUM(amount_inr) * 100 / 
    (SELECT SUM(amount_inr) 
    FROM staging_vendor_payments), 2)  spend_percentage
FROM 
    staging_vendor_payments  svp
GROUP BY 
    SVP.gl_account_code, svp.gl_account_name
ORDER BY 
    SUM(svp.amount_inr) DESC