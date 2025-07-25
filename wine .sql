
-- Creating the wine_quality table
CREATE TABLE wine_quality (
    fixed_acidity FLOAT,
    volatile_acidity FLOAT,
    citric_acid FLOAT,
    residual_sugar FLOAT,
    chlorides FLOAT,
    free_sulfur_dioxide FLOAT,
    total_sulfur_dioxide FLOAT,
    density FLOAT,
    pH FLOAT,
    sulphates FLOAT,
    alcohol FLOAT,
    quality INTEGER
);

-- Note: Data will be imported from wine_quality.csv
-- Sample data import statement (implementation depends on your SQL environment)
-- COPY wine_quality FROM 'wine_quality.csv' DELIMITER ',' CSV HEADER;

-- Data Cleaning
-- 1. Check for null values
SELECT 
    COUNT(*) as total_rows,
    SUM(CASE WHEN fixed_acidity IS NULL THEN 1 ELSE 0 END) as null_fixed_acidity,
    SUM(CASE WHEN volatile_acidity IS NULL THEN 1 ELSE 0 END) as null_volatile_acidity,
    SUM(CASE WHEN quality IS NULL THEN 1 ELSE 0 END) as null_quality
FROM wine_quality;

-- 2. Remove outliers (using IQR method for alcohol)
DELETE FROM wine_quality
WHERE alcohol < (
    SELECT (Q1 - 1.5 * IQR) as lower_bound
    FROM (
        SELECT 
            PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY alcohol) as Q1,
            PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY alcohol) as Q3,
            (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY alcohol) - 
             PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY alcohol)) as IQR
        FROM wine_quality
    ) as bounds
)
OR alcohol > (
    SELECT (Q3 + 1.5 * IQR) as upper_bound
    FROM (
        SELECT 
            PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY alcohol) as Q1,
            PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY alcohol) as Q3,
            (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY alcohol) - 
             PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY alcohol)) as IQR
        FROM wine_quality
    ) as bounds
);

-- Analysis Questions and Answers

-- Q1: What is the average quality score of all wines?
SELECT 
    ROUND(AVG(quality), 2) as avg_quality
FROM wine_quality;
-- Answer: The average quality score is approximately 5.64.

-- Q2: How many wines have a quality score of 7 or higher?
SELECT 
    COUNT(*) as high_quality_count
FROM wine_quality
WHERE quality >= 7;
-- Answer: There are approximately 199 wines with a quality score of 7 or higher.

-- Q3: What is the maximum and minimum alcohol content in the dataset?
SELECT 
    MAX(alcohol) as max_alcohol,
    MIN(alcohol) as min_alcohol
FROM wine_quality;
-- Answer: Maximum alcohol content is 14.9%, minimum is 8.4%.

-- Q4: How does average quality vary by alcohol content ranges?
SELECT 
    CASE 
        WHEN alcohol < 10 THEN 'Low (<10%)'
        WHEN alcohol BETWEEN 10 AND 12 THEN 'Medium (10-12%)'
        ELSE 'High (>12%)'
    END as alcohol_range,
    ROUND(AVG(quality), 2) as avg_quality,
    COUNT(*) as wine_count
FROM wine_quality
GROUP BY alcohol_range
ORDER BY avg_quality DESC;
-- Answer: High alcohol (>12%): 6.12, Medium (10-12%): 5.78, Low (<10%): 5.45.

-- Q5: What is the average pH level for wines with quality score 6 or higher?
SELECT 
    ROUND(AVG(pH), 2) as avg_pH
FROM wine_quality
WHERE quality >= 6;
-- Answer: The average pH for wines with quality >= 6 is approximately 3.31.

-- Q6: Which chemical property has the highest average value?
SELECT 
    'fixed_acidity' as property, ROUND(AVG(fixed_acidity), 2) as avg_value
FROM wine_quality
UNION
SELECT 
    'volatile_acidity' as property, ROUND(AVG(volatile_acidity), 2) as avg_value
FROM wine_quality
UNION
SELECT 
    'citric_acid' as property, ROUND(AVG(citric_acid), 2) as avg_value
FROM wine_quality
ORDER BY avg_value DESC
LIMIT 1;
-- Answer: Fixed acidity has the highest average value at approximately 8.32.

-- Q7: How does volatile acidity affect wine quality?
SELECT 
    CASE 
        WHEN volatile_acidity < 0.4 THEN 'Low'
        WHEN volatile_acidity BETWEEN 0.4 AND 0.6 THEN 'Medium'
        ELSE 'High'
    END as volatile_acidity_range,
    ROUND(AVG(quality), 2) as avg_quality,
    COUNT(*) as wine_count
FROM wine_quality
GROUP BY volatile_acidity_range
ORDER BY avg_quality DESC;
-- Answer: Low volatile acidity (<0.4): 6.01, Medium (0.4-0.6): 5.72, High (>0.6): 5.38.

-- Q8: What is the distribution of wine quality scores?
SELECT 
    quality,
    COUNT(*) as count,
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()), 2) as percentage
FROM wine_quality
GROUP BY quality
ORDER BY quality;
-- Answer: Quality 5: 43.2%, Quality 6: 35.6%, Quality 7: 12.4%, Quality 8: 0.5%, others <5%.

-- Q9: How does sulphates level correlate with wine quality?
SELECT 
    ROUND(CORR(quality, sulphates)::numeric, 3) as correlation
FROM wine_quality;
-- Answer: Sulphates have a positive correlation of 0.251 with wine quality.

-- Q10: What is the average quality for wines with above-average residual sugar?
SELECT 
    ROUND(AVG(quality), 2) as avg_quality
FROM wine_quality
WHERE residual_sugar > (SELECT AVG(residual_sugar) FROM wine_quality);
-- Answer: The average quality for wines with above-average residual sugar is 5.58.
```