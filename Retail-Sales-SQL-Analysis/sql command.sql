select * from RETAIL_SALES_DATASET limit 10;
SHOW COLUMNS FROM retail_sales_dataset like '%Date%';
select count(*) as row_count from retail_sales_dataset;
## Clean the dataset
# Rename all the columns
aLter table retail_sales_dataset
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
select * from RETAIL_SALES_DATASET
where total_amount is null or customer_id is null;

# Check invalid values
select *
from RETAIL_SALES_DATASET
where price_per_unit < 0 or quantity < 0;


 
## Core Analyses
# Customer behavior by gender and age
select gender, avg(total_amount), avg(quantity) from RETAIL_SALES_DATASET
group by gender;
select 
  case
    when age < 25 then 'Under 25'
    when age between 25 and 40 then '25-40'
    when age between 41 and 60 then '41-60'
    else '60+'
  end as age_group,
  gender,
  count(*)                 as transactions,
  avg(quantity)            as avg_items,
  avg(total_amount)        as avg_product,
  sum(total_amount)        as revenue
from retail_sales_dataset
group by age_group, gender
order by age_group, gender;

# Monthly sales trend
select month(date) as month, sum(total_amount) as monthly_sales
from RETAIL_SALES_DATASET
group by month
order by monthly_sales desc;

# Top 1 product categories by sales
select product_category, sum(quantity) from RETAIL_SALES_DATASET
group by product_category
order by sum(quantity) desc
limit 1;

# Age × category preference (heatmap-ready)
select 
  case
    when age < 25 then 'Under 25'
    when age between 25 and 40 then '25-40'
    when age between 41 and 60 then '41-60'
	else '60+'
  end as age_group,
  product_category,
  sum(total_amount) as revenue
from retail_sales_dataset
group by age_group, product_category
order by age_group, revenue desc;

# Seasonal sales patterns
select 
  case
	when month(date) in (12,1,2) then 'winter'
	when month(date) in (3,4,5) then 'spring'
	when month(date) in (6,7,8) then 'summer'
	when month(date) in (9,10,11) then 'fall'
	end as season, sum(total_amount),product_category
from RETAIL_SALES_DATASET
group by season, product_category
order by season,sum(total_amount) desc;

#Basket-size behaviors (behaviors by item per transaction)
select quantity, count(*), 
       avg(total_amount)
from retail_sales_dataset
group by quantity
order by quantity;
select 
  case
    when quantity = 1 then '1'
    when quantity between 2 and 3 then '2-3'
    when quantity between 4 and 5 then '4-5'
    else '6+'
  end as qty_bucket,
  count(*),
  avg(total_amount),
  sum(total_amount)
from retail_sales_dataset
group by qty_bucket
order by field(qty_bucket,'1','2-3','4-5','6+');

# Price distribution within each category
select product_category, min(price_per_unit),max(price_per_unit),avg(price_per_unit)
from RETAIL_SALES_DATASET
group by product_category;
