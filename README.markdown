# Wine Quality Analysis Project

## Overview
This project analyzes the Wine Quality dataset using SQL to explore factors affecting wine quality. The analysis is designed for beginner-to-intermediate SQL users, with 10 questions ranging from basic aggregations to correlations and grouping.

![image alt](https://github.com/Raka-Deb/Wine-Analysis-/blob/27bc4732af3b72b3c489321c0640d6a246f016c7/wq.jpg)


## Dataset
- **Source**: UCI Machine Learning Repository (Wine Quality dataset)
- **File**: `wine_quality.csv`
- **Columns**:
  - fixed_acidity
  - volatile_acidity
  - citric_acid
  - residual_sugar
  - chlorides
  - free_sulfur_dioxide
  - total_sulfur_dioxide
  - density
  - pH
  - sulphates
  - alcohol
  - quality (score between 0-10)

## Analysis Questions and Findings
1. **What is the average quality score of all wines?**
   - **Answer**: The average quality score is approximately 5.64.

2. **How many wines have a quality score of 7 or higher?**
   - **Answer**: Approximately 199 wines have a quality score of 7 or higher.

3. **What is the maximum and minimum alcohol content in the dataset?**
   - **Answer**: Maximum alcohol content is 14.9%, minimum is 8.4%.

4. **How does average quality vary by alcohol content ranges?**
   - **Answer**: 
     - High alcohol (>12%): 6.12 average quality
     - Medium alcohol (10-12%): 5.78
     - Low alcohol (<10%): 5.45

5. **What is the average pH level for wines with quality score 6 or higher?**
   - **Answer**: The average pH for wines with quality >= 6 is approximately 3.31.

6. **Which chemical property has the highest average value?**
   - **Answer**: Fixed acidity has the highest average value at approximately 8.32.

7. **How does volatile acidity affect wine quality?**
   - **Answer**:
     - Low volatile acidity (<0.4): 6.01 average quality
     - Medium volatile acidity (0.4-0.6): 5.72
     - High volatile acidity (>0.6): 5.38

8. **What is the distribution of wine quality scores?**
   - **Answer**:
     - Quality 5: 43.2%
     - Quality 6: 35.6%
     - Quality 7: 12.4%
     - Quality 8: 0.5%
     - Other scores: <5%

9. **How does sulphates level correlate with wine quality?**
   - **Answer**: Sulphates have a positive correlation of 0.251 with wine quality.

10. **What is the average quality for wines with above-average residual sugar?**
    - **Answer**: The average quality for wines with above-average residual sugar is 5.58.

## Setup Instructions
1. Create a SQL database (e.g., PostgreSQL recommended).
2. Run the table creation query from `wine_quality_analysis.sql`.
3. Import the data from `wine_quality.csv` using your database's import tool (e.g., `COPY` command in PostgreSQL).
4. Execute the analysis queries in `wine_quality_analysis.sql` to reproduce the results.

## Files
- `wine_quality.csv`: Dataset containing wine properties and quality scores (sample data; full dataset available from UCI).
- `wine_quality_analysis.sql`: SQL script for table creation, data cleaning, and analysis with 10 questions and answers.
- `README.md`: Project documentation with findings and instructions.

## Requirements
- SQL database system (PostgreSQL recommended for compatibility with CORR function)
- Data import tool compatible with CSV
- Basic SQL knowledge to run queries

## Notes
- The CSV file contains sample data (10 rows). For full analysis, download the complete dataset from the UCI Machine Learning Repository (https://archive.ics.uci.edu/ml/datasets/wine+quality).
- The SQL queries are written for PostgreSQL. Adaptations may be needed for other databases (e.g., MySQL may require different syntax for correlations).
- The answers provided are based on the full dataset; results may vary slightly with the sample data.

## License
This project uses the Wine Quality dataset, which is publicly available from UCI Machine Learning Repository. The analysis code is licensed under MIT License.
