-- Understanding who the customers are, how promotions influence spend and key factors that influence satisfaction

-- Previewing the full dataset
SELECT *
FROM customer;

-- Getting the range of customer ages

SELECT MIN(age), MAX(age)
FROM customer;

-- Add age buckets for segmentation (first version: broader buckets)

SELECT *, CASE
WHEN age between 12 and 17 THEN "12 - 17"
WHEN age between 18 and 22 THEN "18 - 22"
WHEN age between 23 and 29 THEN "23 - 29"
WHEN age between 30 and 39 THEN "30 - 39"
WHEN age between 40 and 50 THEN "40+"
END AS age_group
FROM customer;

-- Checking how many customers are above age 49 (used to validate groupings)

SELECT *
FROM customer
WHERE age > 49;

-- Count customers in each age group using broader bins

WITH group_age AS (
SELECT *, CASE
WHEN age between 12 and 17 THEN "12 - 18"
WHEN age between 18 and 22 THEN "18 - 22"
WHEN age between 23 and 29 THEN "23 - 29"
WHEN age between 30 and 39 THEN "30 - 39"
WHEN age between 40 and 50 THEN "40+"
END AS age_group
FROM customer)
SELECT age_group, COUNT(age_group)
FROM group_age
GROUP BY age_group
ORDER BY age_group;

-- Refining age groupings for a more detailed distribution

WITH group_age AS (
SELECT *, CASE
WHEN age between 12 and 17 THEN "12 - 18"
WHEN age between 18 and 23 THEN "18 - 23"
WHEN age between 24 and 29 THEN "24 - 29"
WHEN age between 30 and 34 THEN "30 - 34"
WHEN age between 35 and 39 THEN "35 - 39"
WHEN age between 40 and 50 THEN "40+"
END AS age_group
FROM customer)
SELECT age_group, COUNT(age_group)
FROM group_age
GROUP BY age_group
ORDER BY age_group;

-- 🧍‍♂️ Gender Distribution

-- Counting customers by gender

SELECT gender, COUNT(gender)
FROM customer
GROUP BY gender;


-- Calculating percentage split by gender

SELECT 100*SUM(CASE WHEN gender = "male" THEN 1 ELSE 0 END)/count(gender) AS male_perc,
100*SUM(CASE WHEN gender = "female" THEN 1 ELSE 0 END)/count(gender) AS female_perc
FROM customer;

-- Gender and Age Group Split — % of total base

WITH group_age AS (
SELECT *, CASE
WHEN age between 12 and 17 THEN "12 - 18"
WHEN age between 18 and 23 THEN "18 - 23"
WHEN age between 24 and 29 THEN "24 - 29"
WHEN age between 30 and 34 THEN "30 - 34"
WHEN age between 35 and 39 THEN "35 - 39"
WHEN age between 40 and 50 THEN "40+"
END AS age_group
FROM customer)
SELECT age_group, gender, COUNT(*) as group_count,COUNT(*)*100/SUM(COUNT(*)) OVER () AS perc
FROM group_age
GROUP BY age_group, gender
ORDER BY age_group;

-- Gender split within each age group

WITH group_age AS (
SELECT *, CASE
WHEN age between 12 and 17 THEN "12 - 18"
WHEN age between 18 and 23 THEN "18 - 23"
WHEN age between 24 and 29 THEN "24 - 29"
WHEN age between 30 and 34 THEN "30 - 34"
WHEN age between 35 and 39 THEN "35 - 39"
WHEN age between 40 and 50 THEN "40+"
END AS age_group
FROM customer)
SELECT age_group, gender, COUNT(*) as group_count,COUNT(*)*100/SUM(COUNT(*)) OVER (PARTITION BY age_group) AS perc
FROM group_age
GROUP BY age_group, gender
ORDER BY age_group;

-- 🎓 Education Level Analysis

-- Viewing distinct education levels

SELECT DISTINCT education
FROM customer;

-- Counting customers by education level

SELECT education, COUNT(education) AS count_education
FROM customer
GROUP BY education;

-- Average income by education level

SELECT education, AVG(INCOME) AS avg_income
FROM customer
GROUP BY education;

-- Average satisfaction score by education level

SELECT education, AVG(satisfaction_score) AS avg_score
FROM customer
GROUP BY education;

-- promotion usage rate within each education group

SELECT education, SUM(promotion_usage) as total_promo, COUNT(*) AS group_count, 100*SUM(promotion_usage)/COUNT(*) AS promo_perc
FROM customer
GROUP BY education;

-- Promotion usage percantage relative to total promo usage

SELECT education, SUM(promotion_usage) AS total_promo, COUNT(*) AS group_count, 100*SUM(promotion_usage)/COUNT(*) AS promo_rate_within_group,
100*SUM(promotion_usage)/SUM(SUM(promotion_usage)) OVER () AS promo_pct_of_total
FROM customer
GROUP BY education;

-- 🎯 Promotions & Satisfaction

-- How promotion usage affects satisfaction

SELECT promotion_usage, avg(satisfaction_score), MAX(satisfaction_score)
FROM customer
GROUP BY promotion_Usage;

SELECT promotion_usage, 
AVG(purchase_amount) AS avg_purchase,
AVG(satisfaction_score) AS avg_satisfaction
FROM customer
GROUP BY promotion_usage;


-- 🛍️ Promotion Effectiveness by Product Category

-- For each product category and promo use, show:
-- • Number of purchases
-- • Avg purchase amount
-- • Percentage of purchases within category

SELECT product_category, promotion_usage, COUNT(*) AS num_purchases,
AVG(purchase_amount) AS avg_purchase,
100*COUNT(*)/SUM(COUNT(*)) OVER(PARTITION BY product_category) as pct_of_category
FROM customer
GROUP BY product_category, promotion_usage
ORDER BY product_category, promotion_usage;

-- Analyze promotion usage by purchase frequency

SELECT purchase_frequency, SUM(promotion_usage) AS total_promo, COUNT(*) AS group_count, 100*SUM(promotion_usage)/COUNT(*) AS promo_rate_within_group,
100*SUM(promotion_usage)/SUM(SUM(promotion_usage)) OVER () AS promo_pct_of_total
FROM customer
GROUP BY purchase_frequency;

-- Measure average satisfaction score by purchase frequency

SELECT purchase_frequency, AVG(satisfaction_score) AS avg_score
FROM customer
GROUP BY purchase_frequency;

-- Determines each purchase frequency group's contribution to total revenue

SELECT purchase_frequency, COUNT(*) AS group_count,100*SUM(purchase_amount)/SUM(SUM(purchase_amount)) OVER () AS purchase_pct_of_total, SUM(purchase_amount) AS total_amount
FROM customer
GROUP BY purchase_frequency;

-- Explore income-level segmentation

SELECT 
ROUND(income, -3) AS income_group,
ROUND(AVG(purchase_amount),2) AS avg_spend,
AVG(promotion_usage) AS avg_promo_usage
FROM customer
GROUP BY income_group
ORDER BY income_group;

-- Compare spending and satisfaction by loyalty status

SELECT loyalty_status, 
AVG(purchase_amount) AS avg_spend,
AVG(satisfaction_score) AS avg_satisfaction
FROM customer
GROUP BY loyalty_status;










