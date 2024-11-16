-- DATA DEMOGRAPHICS


-- Looking at Gender category for this data set
SELECT sex, COUNT(*) AS client_count
FROM `bigquery-public-data.ml_datasets.credit_card_default`
GROUP BY sex;



-- Labeling the 'gender' column for visualisation purposes
SELECT 
  CASE 
    WHEN sex = '1' THEN 'Male'
    WHEN sex = '2' THEN 'Female'
    ELSE 'Unknown'
  END AS gender,
  COUNT(*) AS client_count
FROM `bigquery-public-data.ml_datasets.credit_card_default`
GROUP BY gender;



-- Exploring client demographics with descriptive marital status labels
SELECT 
  CASE 
    WHEN marital_status = '1' THEN 'Married'
    WHEN marital_status = '2' THEN 'Single'
    WHEN marital_status = '3' THEN 'Other'
    ELSE 'Unknown'
  END AS marital_status_label,
  COUNT(*) AS client_marriage
FROM `bigquery-public-data.ml_datasets.credit_card_default`
GROUP BY marital_status_label;




-- Exploring client demographics with descriptive marital status labels
SELECT 
  CASE 
    WHEN education_level = '1' THEN 'Graduate School'
    WHEN education_level = '2' THEN 'University'
    WHEN education_level = '3' THEN 'High School'
    WHEN education_level = '4' THEN 'Other'
    WHEN education_level = '5' THEN 'Unknown'
    ELSE 'Unspecified'
  END AS education_label,
  COUNT(*) AS client_education
FROM `bigquery-public-data.ml_datasets.credit_card_default`
GROUP BY education_label;



-- Now looking at Credit Limit analysis
SELECT 
  AVG(limit_balance) AS avg_credit, 
  MIN(limit_balance) AS min_credit, 
  MAX(limit_balance) AS max_credit
FROM `bigquery-public-data.ml_datasets.credit_card_default`;




-- Looking at the max lending rate for individuals, grouped by their education
SELECT

  CASE 
    WHEN education_level = '1' THEN 'Graduate School'
    WHEN education_level = '2' THEN 'University'
    WHEN education_level = '3' THEN 'High School'
    WHEN education_level = '4' THEN 'Other'
    WHEN education_level = '5' THEN 'Unknown'
    ELSE 'Unspecified'
  END AS education_label,
  education_level,
  AVG(limit_balance) AS avg_credit
FROM `bigquery-public-data.ml_datasets.credit_card_default`
GROUP BY education_level
ORDER BY education_level;


