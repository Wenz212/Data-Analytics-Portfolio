SELECT * FROM RETAIL_SALES_DATASET limit 10;
SELECT COUNT(*) AS row_count FROM retail_sales_dataset;
## Clean the dataset
# Rename all the columns
ALter table retail_sales_dataset
rename column `Transaction ID` to transaction_id;
alter table RETAIL_SALES_DATASET
rename column `Customer ID` to customer_id;
alter table RETAIL_SALES_DATASET
rename column `Product Category` to product_category;
alter table RETAIL_SALES_DATASET
rename column `Price per Unit` to price_per_unit;
alter table RETAIL_SALES_DATASET
rename column `Total Amount` to total_amount;

# Remove duplicates
select transaction_id, count(*)
from RETAIL_SALES_DATASET
group by transaction_id
having count(*) > 1;

# Handle missing values
SELECT * FROM RETAIL_SALES_DATASET
where total_amount is null or customer_id is null;

# Check invalid values
select *
from RETAIL_SALES_DATASET
where price_per_unit < 0 or quantity < 0;

# Standardize date formats
select date(date) as date from RETAIL_SALES_DATASET;
 
## Core analyses
# Monthly sales trend
SELECT month(date) as month, sum(total_amount) AS monthly_sales
from RETAIL_SALES_DATASET
group by month
order by monthly_sales desc;

# Top 2 product categories by sales
select product_category, sum(quantity) from RETAIL_SALES_DATASET
group by product_category
order by sum(quantity) desc
limit 2;

# Costomer behavior by gender
select gender, avg(total_amount), avg(quantity) from RETAIL_SALES_DATASET
group by gender;

# Seasonal sales patterns
select case 
			when month(date) in (12,1,2) then 'winter'
			when month(date) in (3,4,5) then 'spring'
            when month(date) in (6,7,8) then 'summer'
			when month(date) in (9,10,11) then 'fall'
		end as season, 
        sum(total_amount)
from RETAIL_SALES_DATASET
group by season
order by sum(total_amount) desc;

# Price distribution within each category
select product_category, min(price_per_unit),max(price_per_unit),avg(price_per_unit)
from RETAIL_SALES_DATASET
group by product_category;




