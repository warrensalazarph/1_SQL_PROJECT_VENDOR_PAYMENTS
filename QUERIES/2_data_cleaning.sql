-- 1. to duplicate the table
-- we want to preserve the raw data
CREATE TABLE staging_vendor_payments
(LIKE vendor_payments INCLUDING ALL);

INSERT INTO staging_vendor_payments
SELECT *
FROM vendor_payments;

-- 2. the purpose of these queries is to find duplicates in the data set and upon running we can find none
-- to find the duplicates:
WITH duplicates AS (
    SELECT *,
        ROW_NUMBER ( ) OVER (PARTITION BY 
                                svp.payment_id,
                                svp.vendor_name,
                                svp.gstin,
                                svp.gl_account_code,
                                svp.gl_account_name,
                                svp.payment_date,
                                svp.payment_mode,
                                svp.payment_category,
                                svp.amount_inr,
                                svp.gst_rate_pct,
                                svp.approved_by,
                                svp.gst_amount_inr,
                                svp.invoice_number,
                                svp.vendor_risk_cluster) AS row_num
    FROM 
            staging_vendor_payments  svp
)

SELECT *
FROM 
    duplicates
WHERE 
    row_num > 1;
-- result: no duplicates were found


-- 3. the purpose of these queries is to standardized the dataset
-- to find if there are leading or trailing spaces in vendor names where naming issues might occur:
SELECT 
    COUNT(*)
FROM 
    staging_vendor_payments  svp
WHERE 
    svp.vendor_name <> TRIM(svp.vendor_name);
-- result: no leading/trailing spaces found in vendor_name

--to check capitalizations:
SELECT 
    svp.payment_mode
FROM 
    staging_vendor_payments  svp
GROUP BY 
    1;

SELECT 
    svp.payment_category
FROM 
    staging_vendor_payments  svp
GROUP BY 
    1;

SELECT 
    svp.gl_account_name
FROM 
    staging_vendor_payments  svp
GROUP BY 
    1;

SELECT 
    svp.approved_by
FROM 
    staging_vendor_payments  svp
GROUP BY 
    1;
-- result: no inconsistencies were found


/*
Data Quality Findings:

- No exact duplicate records found.
- No leading/trailing spaces found in vendor names.
- No capitalization inconsistencies found in key categorical fields.
- Missing values were retained because the field was not required for the primary spend analysis.
*/