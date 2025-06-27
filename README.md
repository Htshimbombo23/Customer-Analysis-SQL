# Customer-Analysis-SQL

🔍 Objectives
- Segment customers by age, gender, and education level.

- Analyze how promotions influence purchasing behavior and satisfaction.

- Evaluate purchase frequency and spending trends.

- Understand loyalty patterns and income-level behaviors.

🗂️ Dataset Overview

Table: customer

Key fields:

- age, gender, education, region

- purchase_amount, purchase_frequency, promotion_usage

- loyalty_status, income, satisfaction_score

- product_category

Note: This project assumes that a structured table named customer is available with the fields above. You can adapt the script to your own schema as needed.

🧩 Key Analyses Performed

1. Customer Demographics

- Age distribution with refined buckets

- Gender split and cross-tab by age group

- Education-level distribution and income comparisons

2. Purchasing Influences
   
- Purchase amount and frequency by:

  - Promotion usage

  - Education level

  - Income bands

  - Loyalty status

3. Promotion Effectiveness
   
- Promotion usage by:

- Product category

- Education level

- Purchase frequency

- Promotion’s influence on satisfaction and spending

4. Satisfaction Insights
Satisfaction scores by:

- Promotion usage

- Education and loyalty level

- Purchase frequency

📌 Sample Insights
- Most customers fall into the 24–34 age range.

- Gender distribution is fairly balanced across age groups.

- Promotions are particularly effective in encouraging spending among customers who purchase infrequently

- Approximately 30% of customers use promotions across all product categories, indicating that promotional offers have a consistent influence on purchasing behavior regardless of the product type

🛠️ Tools Used
- SQL (MySQL)

📎 How to Use
- Load your customer dataset into your SQL environment.

- Open customer_analysis.sql.

- Run section by section to explore the data and view insights.

- Optionally, export results or visualize using tools like Excel, Tableau, or Python (pandas/Matplotlib).

