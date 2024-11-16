-- CREDIT CARD ANALYSIS BY CLIEINT PAYMENT PATTERNS AND FEATURE ENGINEERING

-- Columns in the data set, column type and isnull values
SELECT 
  column_name, 
  data_type, 
  is_nullable
FROM 
   `bigquery-public-data.ml_datasets.INFORMATION_SCHEMA.COLUMNS`
WHERE 
  table_name = 'credit_card_default';


-- Looking at data distribution and std deviation
SELECT
  AVG(limit_balance) AS avg_limit_balance,
  MIN(limit_balance) AS min_limit_balance,
  MAX(limit_balance) AS max_limit_balance,
  STDDEV(limit_balance) AS stddev_limit_balance,
  AVG(age) AS avg_age,
  MIN(age) AS min_age,
  MAX(age) AS max_age,
  STDDEV(age) AS stddev_age
FROM `bigquery-public-data.ml_datasets.credit_card_default`;


-- Check for missing values
SELECT
  SUM(CASE WHEN limit_balance IS NULL THEN 1 ELSE 0 END) AS null_limit_balance,
  SUM(CASE WHEN sex IS NULL THEN 1 ELSE 0 END) AS null_sex,
  SUM(CASE WHEN education_level IS NULL THEN 1 ELSE 0 END) AS null_education_level,
  SUM(CASE WHEN marital_status IS NULL THEN 1 ELSE 0 END) AS null_marital_status
FROM `bigquery-public-data.ml_datasets.credit_card_default`;



-- Calculating the mean average balance
SELECT AVG(limit_balance) AS avg_limit_balance
FROM `bigquery-public-data.ml_datasets.credit_card_default`;



-- Looking at top and IQR, outliers for limit_balance
SELECT
  APPROX_QUANTILES(limit_balance, 4)[OFFSET(1)] AS Q1,
  APPROX_QUANTILES(limit_balance, 4)[OFFSET(3)] AS Q3
FROM `bigquery-public-data.ml_datasets.credit_card_default`;


-- Calculating the 'upper' and 'lower' bounds for limit_balance
SELECT
  Q1 - 1.5 * (Q3 - Q1) AS lower_bound,
  Q3 + 1.5 * (Q3 - Q1) AS upper_bound
FROM (
  SELECT
    APPROX_QUANTILES(limit_balance, 4)[OFFSET(1)] AS Q1,
    APPROX_QUANTILES(limit_balance, 4)[OFFSET(3)] AS Q3
  FROM `bigquery-public-data.ml_datasets.credit_card_default`
);



-- Handling the gender value
SELECT DISTINCT sex
FROM `bigquery-public-data.ml_datasets.credit_card_default`
WHERE sex NOT IN ('1', '2');




-- PAYMENT PATTERNS AND FEATURE ENGINEERING

-- Repayment patterns
SELECT pay_0, COUNT(*) AS count_sept
FROM `bigquery-public-data.ml_datasets.credit_card_default`
GROUP BY pay_0
ORDER BY pay_0;


-- Default payments
SELECT 
  default_payment_next_month, 
  AVG(limit_balance) AS avg_credit_limit, 
  AVG(bill_amt_1) AS avg_bill_sept
FROM `bigquery-public-data.ml_datasets.credit_card_default`
GROUP BY default_payment_next_month;


-- Montlhly payment consistency
SELECT 
  id,
  (bill_amt_1 - pay_amt_1) AS balance_sept,
  (bill_amt_2 - pay_amt_2) AS balance_aug
FROM `bigquery-public-data.ml_datasets.credit_card_default`;



-- Average payment delay by client

SELECT 
  id,
  AVG(
    SAFE_CAST(pay_0 AS FLOAT64) +
    SAFE_CAST(pay_2 AS FLOAT64) +
    SAFE_CAST(pay_3 AS FLOAT64) +
    SAFE_CAST(pay_4 AS FLOAT64) +
    SAFE_CAST(pay_5 AS FLOAT64) +
    SAFE_CAST(pay_6 AS FLOAT64)
  ) AS avg_payment_delay
FROM `bigquery-public-data.ml_datasets.credit_card_default`
GROUP BY id;


--- Current outstanding balance per client
SELECT
    (bill_amt_1 + bill_amt_2 + bill_amt_3 + bill_amt_4 + bill_amt_5 + bill_amt_6) AS total_outstanding_balance
FROM `bigquery-public-data.ml_datasets.credit_card_default`
ORDER BY total_outstanding_balance DESC;



-- Credit default by education_level and marriage

SELECT
    CASE 
        WHEN education_level = '1' THEN 'Graduate School'
        WHEN education_level = '2' THEN 'University'
        WHEN education_level = '3' THEN 'High School'
        WHEN education_level = '4' THEN 'Other'
        WHEN education_level IN ('5', '6') THEN 'Unknown'
        ELSE 'Unspecified'
    END AS education_level_label,
    
    CASE 
        WHEN marital_status = '1' THEN 'Married'
        WHEN marital_status = '2' THEN 'Single'
        WHEN marital_status = '3' THEN 'Other'
        ELSE 'Unknown'
    END AS marital_status_label,
    
    AVG(CAST(default_payment_next_month AS FLOAT64)) AS default_rate
FROM `bigquery-public-data.ml_datasets.credit_card_default`
GROUP BY education_level_label, marital_status_label
ORDER BY default_rate DESC;



-- HIGH RISK Clients based on prediction score
SELECT
    id,
    predicted_default_payment_next_month.tables.score AS predicted_default_score
FROM `bigquery-public-data.ml_datasets.credit_card_default`
WHERE predicted_default_score > 0.8
ORDER BY predicted_default_score DESC;




