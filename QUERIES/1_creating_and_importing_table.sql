--1. to create the table
CREATE TABLE vendor_payments (
    payment_id TEXT, 
    vendor_name TEXT, 
    gstin TEXT,
    gl_account_code INT, 
    gl_account_name TEXT, 
    payment_date DATE, 
    payment_month INT, 
    day_of_week INT, 
    payment_mode TEXT, 
    payment_category TEXT, 
    amount_inr NUMERIC, 
    gst_rate_pct NUMERIC, 
    approved_by TEXT, 
    gst_amount_inr NUMERIC, 
    invoice_number TEXT, 
    vendor_risk_cluster INT
)

-- everything is in text and numeric for simplicity and creating the table but we have to update this later

--2. to import the data to the table
COPY vendor_payments
FROM 'C:\Users\salaz\My PostGres\1_SQL_PROJECT\dataset2_vendor_payments.csv'
DELIMITER ',' CSV HEADER;