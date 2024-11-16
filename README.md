Here’s a template for a `README.md` file for your SQL project. This document will help outline the purpose, dataset, structure, and key insights of your project on GitHub.

---

# Credit Card Default Analysis using SQL on BigQuery

## Project Overview
This project analyses credit card default patterns using SQL, focusing on demographic factors and payment behaviour to identify trends associated with higher risks of default. The analysis is conducted on the [Credit Card Default dataset](https://console.cloud.google.com/marketplace/product/bigquery-public-data/ml_datasets) available on Google BigQuery.

Through various SQL queries, this project explores client characteristics, calculates default rates across different demographics, and examines payment histories.

## Dataset Information
The dataset used in this project is hosted in Google BigQuery:
- **Table ID**: `bigquery-public-data.ml_datasets.credit_card_default`
- **Rows**: 2,965
- **Columns**: 24

### Key Columns
| Column                     | Description                                                                                   |
|----------------------------|-----------------------------------------------------------------------------------------------|
| `id`                       | Unique identifier for each client                                                             |
| `limit_balance`            | Credit limit in NT dollars                                                                    |
| `sex`                      | Gender (1 = Male, 2 = Female)                                                                 |
| `education_level`          | Education level (1 = Graduate, 2 = University, 3 = High School, etc.)                        |
| `marital_status`           | Marital status (1 = Married, 2 = Single, 3 = Other)                                          |
| `age`                      | Client's age                                                                                  |
| `pay_0` to `pay_6`         | Payment delay status for the last six months (-1 = pay duly, 1-9 = months of delay)          |
| `bill_amt_1` to `bill_amt_6` | Bill statement amount over the last six months in NT dollars                             |
| `pay_amt_1` to `pay_amt_6` | Previous payment amounts over the last six months in NT dollars                              |
| `default_payment_next_month` | Default payment indicator for next month (1 = Yes, 0 = No)                               |

## Analysis and Key Queries
The analysis progresses from basic SQL queries to more advanced data processing techniques. Below are some highlights of the analysis:

1. **Demographic Distribution**:
   - Counts of clients by gender, marital status, and education level to understand the composition of the client base.
   
2. **Credit Limit and Age Analysis**:
   - Calculation of average credit limits by age and demographic factors to explore lending patterns.

3. **Default Rate by Demographic**:
   - Queries calculating default rates across education levels, marital status, and gender to assess risk factors.

4. **Payment Delay Analysis**:
   - Analysis of average payment delays and outstanding bill amounts to gauge payment behaviours that indicate risk.

### Example Query: Default Rate by Education Level and Marital Status
```sql
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
```

## Project Structure
- **SQL Queries**: All SQL queries are organized by their purpose and complexity.
- **Insights**: Insights generated from each query, with interpretations and visualizations (if applicable).
- **README.md**: Project documentation.

## Running the Analysis
1. **Prerequisites**:
   - Access to Google BigQuery.
   - Familiarity with SQL syntax and basic SQL operations.

2. **Steps**:
   - Run queries directly on BigQuery against the dataset `bigquery-public-data.ml_datasets.credit_card_default`.
   - Review each query’s results to interpret findings on credit card default patterns.

## Conclusion
This project provides insights into the demographic and behavioural factors associated with credit card default risk. The analysis highlights potential indicators that could guide banks in assessing client risk profiles and designing strategies to mitigate defaults.

## Future Improvements
- **Additional Features**: Incorporate time-series analysis for payment behaviour trends.
- **Machine Learning**: Extend analysis to predict default risk using SQL ML.

## Project documentation
For a detailed report showcasing SQL queries, visualizations, 
and insights from this analysis, please see the Notion Report.
[SQL - NOTION REPORT]("https://www.notion.so/SQL-CREDIT-RISK-ANALYSIS-14056e4be2ae80a5bd13c9274d93d529?pvs=4")

# Credit Card Default Analysis using SQL on BigQuery

## Project Overview
This project analyses credit card default patterns using SQL, focusing on demographic factors and payment behaviour to identify trends associated with higher risks of default. The analysis is conducted on the [Credit Card Default dataset](https://console.cloud.google.com/marketplace/product/bigquery-public-data/ml_datasets) available on Google BigQuery.

Through various SQL queries, this project explores client characteristics, calculates default rates across different demographics, and examines payment histories.

## Dataset Information
The dataset used in this project is hosted in Google BigQuery:
- **Table ID**: `bigquery-public-data.ml_datasets.credit_card_default`
- **Rows**: 2,965
- **Columns**: 24

### Key Columns
| Column                     | Description                                                                                   |
|----------------------------|-----------------------------------------------------------------------------------------------|
| `id`                       | Unique identifier for each client                                                             |
| `limit_balance`            | Credit limit in NT dollars                                                                    |
| `sex`                      | Gender (1 = Male, 2 = Female)                                                                 |
| `education_level`          | Education level (1 = Graduate, 2 = University, 3 = High School, etc.)                        |
| `marital_status`           | Marital status (1 = Married, 2 = Single, 3 = Other)                                          |
| `age`                      | Client's age                                                                                  |
| `pay_0` to `pay_6`         | Payment delay status for the last six months (-1 = pay duly, 1-9 = months of delay)          |
| `bill_amt_1` to `bill_amt_6` | Bill statement amount over the last six months in NT dollars                             |
| `pay_amt_1` to `pay_amt_6` | Previous payment amounts over the last six months in NT dollars                              |
| `default_payment_next_month` | Default payment indicator for next month (1 = Yes, 0 = No)                               |

## Analysis and Key Queries
The analysis progresses from basic SQL queries to more advanced data processing techniques. Below are some highlights of the analysis:

1. **Demographic Distribution**:
   - Counts of clients by gender, marital status, and education level to understand the composition of the client base.
   
2. **Credit Limit and Age Analysis**:
   - Calculation of average credit limits by age and demographic factors to explore lending patterns.

3. **Default Rate by Demographic**:
   - Queries calculating default rates across education levels, marital status, and gender to assess risk factors.

4. **Payment Delay Analysis**:
   - Analysis of average payment delays and outstanding bill amounts to gauge payment behaviours that indicate risk.

### Example Query: Default Rate by Education Level and Marital Status
```sql
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
```

## Project Structure
- **SQL Queries**: All SQL queries are organized by their purpose and complexity.
- **Insights**: Insights generated from each query, with interpretations and visualizations (if applicable).
- **README.md**: Project documentation.

## Running the Analysis
1. **Prerequisites**:
   - Access to Google BigQuery.
   - Familiarity with SQL syntax and basic SQL operations.

2. **Steps**:
   - Run queries directly on BigQuery against the dataset `bigquery-public-data.ml_datasets.credit_card_default`.
   - Review each query’s results to interpret findings on credit card default patterns.

## Conclusion
This project provides insights into the demographic and behavioural factors associated with credit card default risk. The analysis highlights potential indicators that could guide banks in assessing client risk profiles and designing strategies to mitigate defaults.

## Future Improvements
- **Additional Features**: Incorporate time-series analysis for payment behaviour trends.
- **Machine Learning**: Extend analysis to predict default risk using SQL ML.

