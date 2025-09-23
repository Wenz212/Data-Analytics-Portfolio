Project Overview

This project analyzes a retail sales dataset using SQL and Excel.  
The goal is to uncover customer purchasing patterns, product performance, and seasonal trends.  
It demonstrates core skills in data cleaning, SQL querying, and business insights generation.

Dataset
- Source: [Kaggle Retail Sales Dataset] (https://www.kaggle.com/datasets/mohammadtalib786/retail-sales-dataset)  
- Records: ~1,000 transactions  
- Fields: Transaction ID, Date, Customer ID, Gender, Age, Product Category, Quantity, Price per Unit, Total Amount

Tools Used
- MySQL: Data cleaning, aggregation, and analysis  
- Excel: Pivot tables and charts for visualization  
- Tableau for dashboards

Business Objective
Retailers face challenges in understanding which products drive revenue, how customer demographics influence purchasing, and how seasonality impacts demand. This project aims to uncover patterns that directly inform inventory and marketing strategies.

Key analysis
- How does customer age and gender influence their purchasing behavior?
- Are there discernible patterns in sales across different time periods?
- Which product categories hold the highest appeal among customers?
- What are the relationships between age, spending, and product preferences?
- How do customers adapt their shopping habits during seasonal trends?
- Are there distinct purchasing behaviors based on the number of items bought per transaction?

Visualization
This project uses Tableau to visualize retail sales data after cleaning and transformation in SQL.
The dashboard includes several key analyses:
- Monthly Trend → Line chart showing sales performance across months.
- Seasonal Patterns → Pie/stacked bar charts summarizing revenue distribution across Winter, Spring, Summer, and Fall.
- Product Categories by Sales → Bar chart highlighting top-performing categories.
- Customer Behavior by Age × Category → Heatmap showing preferences of different age groups across product categories.
- Shopping Habits During Seasonal Changes → Stacked bar chart comparing how customers adapt spending in different seasons.
- Basket Size Behaviors → Box plots showing transaction value distribution based on quantity purchased.

All these charts are combined into an interactive dashboard that provides insights into customer purchasing behavior, seasonality, and product appeal.
Preview:
![Screen Recording 2025-09-11 at 12 28 58](https://github.com/user-attachments/assets/e2326741-ed91-43f7-9d2a-dc67f574f31d)


Insights:

1. How does customer age and gender influence their purchasing behavior?
- Analysis of customer demographics (see Fig: Customer Behavior by Age and Gender) shows that 25–40 and 41–60 year olds account for the majority of sales revenue.
- Female customers slightly outpace males in both frequency and total amount, particularly in Clothing and Beauty.
- Younger customers (Under 25) spend more per transaction, but contribute less overall revenue due to fewer purchases.

2. Are there discernible patterns in sales across different time periods?
- Monthly sales trends (see Fig: Month Trend Line) show clear peaks in May and December, reflecting holiday and promotional cycles.
- Seasonal aggregation (see Fig: Seasonal Pattern Pie Chart) confirms that Winter contributes the largest share of annual revenue (≈28%), while Summer lags behind (~24%).

3.Which product categories hold the highest appeal among customers?
- Clothing dominates transaction volume (see Fig: Categories by Sales), making it the most widely purchased.
- Electronics drive higher average spend per transaction, reflecting their premium nature.
- Beauty products are most popular with younger customers, who often make smaller basket-size purchases.

4. What are the relationships between age, spending, and product preferences?
-	The heatmap (see Fig: Age × Category Preference) highlights that:
-	25–40 year olds are the most valuable Clothing and Electronics buyers.
- 41–60 year olds spread their spending more evenly across categories.
- 60+ group contributes the least, with limited but consistent Beauty purchases.

5. How do customers adapt their shopping habits during seasonal trends?
- Seasonal breakdown by product category (see Fig: Shopping Habits During Seasonal Changes) shows:
-	Clothing peaks in Spring and Fall, aligned with seasonal wardrobe shifts.
-	Electronics peak in Winter, largely due to holiday gifting.
-	Beauty demand stays relatively steady, with slight increases in Summer.

6. Are there distinct purchasing behaviors based on the number of items bought per transaction?
-	Basket-size analysis (see Fig: Purchasing Behaviors by Basket Size) reveals that:
-	2–3 item baskets dominate, both in frequency and total revenue.
-	4–5 item baskets, while fewer, have the highest revenue per transaction.
-	Single-item purchases are common but yield limited financial impact.

Key Insights
	•	Top products/categories: e.g. “The top 3 categories (Clothing, Electronics, and Accessories) contribute ~65% of total revenue, with Product X alone generating 20%.”
	•	Seasonality: e.g. “Sales volume peaks in December (~2.5× monthly average), confirming strong holiday-driven demand.”
	•	Customer demographics: e.g. “Female customers account for ~60% of transactions, but male customers generate ~15% higher average basket value.”
	•	Regional/branch trends (如果有): e.g. “Branch B outperforms others with ~40% higher revenue, despite similar transaction counts.”

Conclusion
Across demographic, temporal, and behavioral dimensions, the most profitable customers are 25–40 year olds, particularly female shoppers purchasing Clothing and Electronics in Winter and Spring. Retailers can optimize revenue by focusing promotions on seasonal campaigns, cross-selling strategies for medium-sized baskets, and targeted category marketing by age group.
Business Implications

Business Implication
	•	“Retailers should ensure adequate stock levels for top-selling categories, especially Product X, to avoid stockouts and missed revenue opportunities.”
	•	“Holiday promotions should be scaled up in Q4, with bundled offers on electronics to capture peak demand.”
	•	“Marketing campaigns could target male customers with premium upsell opportunities, while volume promotions (discount bundles) may appeal more to younger or female customers.”
	•	“Underperforming branches should replicate strategies of Branch B (e.g., assortment, promotions) to close revenue gaps.”
