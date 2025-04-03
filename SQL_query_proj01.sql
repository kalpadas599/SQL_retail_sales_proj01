-- sql retail sales analysis -proj 01


-- CREATE TABLE:
create table retail_sales_tb
	(
		transactions_id	INT PRIMARY KEY,
		sale_date	DATE,
		sale_time	TIME,
		customer_id	INT,
		gender VARCHAR(15),
		age	INT,
		category VARCHAR(15),	
		quantiy	INT,
		price_per_unit	FLOAT,
		cogs	FLOAT,
		total_sale FLOAT
	)

SELECT * FROM retail_sales_tb
LIMIT 10;

SELECT * FROM retail_sales_tb
WHERE
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or 
	customer_id is null
	or
	age is null
	or 
	category is null
	or 
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null

--DELATION:

DELETE FROM retail_sales_tb
WHERE
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or 
	customer_id is null
	or 
	category is null
	or 
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null

SELECT COUNT(*) FROM retail_sales_tb

--Data Exploration->
--  HOW MANY SALES WE HAVE:
SELECT COUNT(*) AS total_sales FROM retail_sales_tb

-- how many customers we have:
SELECT COUNT(DISTINCT customer_id) AS total_sales FROM retail_sales_tb

SELECT DISTINCT category FROM retail_sales_tb

--DAta Analysis & Business Key Problems:
--Q1. Retrieve all column for sales made on 22-01-2022
SELECT * FROM retail_sales_tb
WHERE sale_date = '2022-11-05'
--Q2.all transactions where category is 'clothing', qty sold more than 10 in month nov-22
SELECT 
	category,
	SUM(quantiy)
FROM retail_sales_tb
WHERE category = 'Clothing'
GROUP BY 1

SELECT
	*
FROM retail_sales_tb
WHERE category = 'Clothing'
	AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND quantiy >= 4

-- Q3. Calculate total_sales(total_sale) for each category
SELECT 
	category,
	SUM(total_sale) as net_sale,
	count(*) as total_orders
FROM retail_sales_tb
GROUP BY 1

-- Q4. Find AVG age of customers purched from 'beauty' category. 
SELECT 
	ROUND(AVG(age),4) as avg_age 
FROM retail_sales_tb
WHERE category = 'Beauty'

--Q5. Find * where total_sale > 1000
SELECT 
	* 
FROM retail_sales_tb
WHERE total_sale > 1000

-- Q6. Find total transaction_id made by each gender in each category
SELECT 
	category,
	gender,
	COUNT(*) AS total_trans
FROM retail_sales_tb
GROUP BY category, gender
ORDER BY 1

-- Q7. find avg sale for each month , best selling month in each year *** interview
SELECT * FROM
(
SELECT 
	extract (YEAR FROM sale_date) as year,
	extract (MONTH FROM sale_date) as month,
	AVG(total_sale) as avg_sale,
	RANK() OVER(PARTITION BY extract (YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)
from retail_sales_tb
GROUP BY 1,2
--ORDER BY 1,3 DESC
) as t1 where rank = 1

-- Q8. find top 5 customer based on the highest total sales
SELECT
	customer_id,
	SUM(total_sale) as total_sales
FROM retail_sales_tb
group by 1
order by 2 desc
-- Q9. find num of unique customers who purchased items from each category
SELECT
	category,
	count(distinct customer_id) as unique_cust
FROM retail_sales_tb
group by category

--Q10. create each shift and num of orders (Ex: Morning <= 12, Afternoon between 12 & Evening > 17)
WITH hourly_sale
as
(
SELECT *,
	CASE 
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS shift
FROM retail_sales_tb
)
SELECT 
	shift,
	count(*) as total_orders
FROM hourly_sale
group by shift





