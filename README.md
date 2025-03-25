## SQL-projects
A collection of project showcasing SQL skills

# 1: Layoffs Data Analysis (2020 - 2023)

## Overview
This project analyzes global layoffs from March 2020 to March 2023, focusing on trends across various industries and countries. The dataset provides insights into workforce reductions during the COVID-19 pandemic and subsequent economic downturns.

Using SQL, the data has been cleaned, transformed, and analyzed to extract meaningful insights. The process involves rigorous data cleaning, handling missing values, and conducting an in-depth exploratory data analysis (EDA) using various SQL functionalities.

## Dataset Information
The dataset (`layoffs.csv`) contains information on layoffs across different companies, industries, and countries from March 2020 to March 2023. The key attributes in the dataset include:

- **Company Name**: Name of the company where layoffs occurred.
- **Industry**: The industry to which the company belongs (e.g., Tech, Retail, Finance).
- **Country**: The country where the layoff event took place.
- **Total Layoffs**: The number of employees laid off in a specific event.
- **Percentage of Workforce Laid Off**: The proportion of employees affected in relation to the company's total workforce.
- **Date of Layoff**: The month and year when the layoff event happened.
- **Stage**: The company's financial stage (e.g., Startup, Publicly Traded, Private).
- **Additional Information**: Any extra details about the layoff event.

## Data Cleaning Process
To ensure data consistency, integrity, and usability, the following cleaning steps were performed using SQL in `SQL-Project-Data cleaning.sql`:

1. **Creating a Backup**:
   - Used `CREATE TABLE AS` to duplicate the raw dataset before modifications.
   - This ensures data integrity in case of errors during cleaning.

2. **Removing Duplicates**:
   - Applied `DISTINCT` to identify duplicate records.
   - Used `DELETE FROM table WHERE rowid NOT IN (SELECT MIN(rowid) FROM table GROUP BY columns)` to remove redundant entries.

3. **Standardizing Data Formats**:
   - Used `UPDATE` with `LOWER()`, `UPPER()`, and `TRIM()` functions to ensure uniform text formatting.
   - Ensured consistent date formats using `STRFTIME()` and `CAST()` functions.

4. **Handling Null and Missing Values**:
   - Used `COUNT(*)` and `IS NULL` to assess missing values.
   - Applied `COALESCE()` and `CASE WHEN` statements to fill missing values where possible.
   - Removed records with excessive nulls using `DELETE WHERE column IS NULL`.

5. **Dropping Irrelevant Columns**:
   - Identified unnecessary columns using `PRAGMA table_info(table_name)`.
   - Removed columns with `ALTER TABLE DROP COLUMN` when deemed irrelevant.

## Exploratory Data Analysis (EDA)
The SQL script `SQL-Project-Data analyzing.sql` contains the analysis performed on the cleaned dataset. Various SQL functionalities were utilized to extract valuable insights. 

### 1. **Layoff Trends Analysis**
- **Yearly Layoff Trends**:
   - Used `GROUP BY YEAR(date_column)` and `SUM(total_layoffs)` to compute yearly trends.
   - Ordered results using `ORDER BY YEAR(date_column)`.

- **Monthly Layoff Trends**:
   - Extracted month using `STRFTIME('%m', date_column)`.
   - Aggregated layoffs per month with `GROUP BY` and `SUM()`.

- **Layoffs by Country**:
   - Used `GROUP BY country` and `SUM(total_layoffs)` to determine affected countries.
   - Sorted data using `ORDER BY SUM(total_layoffs) DESC`.

- **Layoffs by Industry**:
   - Applied `GROUP BY industry` with `SUM(total_layoffs)` to analyze industry impact.

### 2. **Top Layoff Events and Patterns**
- **Top 5 Countries with the Highest Layoffs**:
   - Used `LIMIT 5` after `ORDER BY SUM(total_layoffs) DESC`.

- **Top 5 Industries with the Highest Layoffs**:
   - Similar to country analysis but grouped by `industry`.

- **Top 5 Months with the Highest Layoffs**:
   - Applied `ORDER BY` on aggregated monthly layoffs.

- **Biggest Layoff Events**:
   - Used `ORDER BY total_layoffs DESC` to identify the largest single layoff events.

### 3. **SQL Techniques and Functionalities Used**
During the data cleaning and analysis process, multiple SQL functionalities were applied, including:
- `WHERE` clause to filter specific conditions (e.g., WHERE industry='Tech').
- `LIKE` statement for pattern matching (e.g., filtering company names containing 'Inc').
- `GROUP BY` and `ORDER BY` for summarizing and sorting data.
- `JOIN` and `UNION` to combine related datasets and enrich insights.
- **String Functions**:
   - `TRIM(column)`, `LOWER(column)`, `UPPER(column)` for text cleanup.
- **CASE Statements**:
   - Created new categorical insights (e.g., CASE WHEN total_layoffs > 1000 THEN 'High Impact' ELSE 'Low Impact' END).
- **Subqueries**:
   - Extracted specific insights using nested queries.
- **Window Functions**:
   - Used `RANK() OVER(PARTITION BY country ORDER BY total_layoffs DESC)` for ranking within groups.
- **Common Table Expressions (CTEs)**:
   - Simplified complex queries using `WITH cte_name AS (SELECT ...)`.
- **Temporary Tables**:
   - Created intermediate datasets using `CREATE TEMP TABLE`.

## Key Insights and Findings
After analyzing the dataset, several important trends were uncovered:

- **Layoffs peaked in 2020 and 2022**, aligning with major economic downturns and market corrections.
- **The tech industry was the most affected**, with large layoffs in major companies.
- **Countries like the USA, India, and the UK saw the highest number of layoffs**, primarily due to global market shifts and restructuring.
- **Certain months (e.g., January 2023) had exceptionally high layoffs**, possibly due to financial planning and restructuring.
- **The largest single layoff events were observed in major multinational companies**, particularly in the technology sector.

## Future Improvements and Next Steps
- **Integrating External Datasets**: Combining this dataset with macroeconomic indicators such as GDP trends and inflation rates could provide deeper insights into layoff patterns.
- **Visualization Dashboards**: Creating Power BI or Tableau dashboards to present interactive data visualizations.
- **Predictive Analysis**: Using machine learning models to predict future layoffs based on past trends and external factors.

## Conclusion
This project demonstrates how SQL can be used for data cleaning, transformation, and analysis to derive valuable business insights. By leveraging SQL techniques, we have uncovered critical patterns in workforce layoffs over a three-year period.

The insights gained from this analysis can be used by businesses, policymakers, and researchers to understand employment trends and prepare for future workforce challenges.

## Files
[Download Layoffs Dataset](https://github.com/movahed-abdolahi/SQL-projects/Files/layoffs.csv)

[SQL Cleaning Script](https://github.com/movahed-abdolahi/SQL-projects/Files/SQL-Project-Data%20cleaning.sql)

[SQL Analysis Script](https://github.com/movahed-abdolahi/SQL-projects/Files/SQL-Project-Data%20analyzing.sql)


## License
This project is licensed under the MIT License - see the LICENSE file for details.

---
### Author
**Movahed Abdolahi**

For any questions or collaborations, feel free to reach out!

