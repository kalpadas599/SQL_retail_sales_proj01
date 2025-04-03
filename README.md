# Retail Sales Analysis Using SQL

## Overview

This project is focused on analyzing retail sales data using SQL. The dataset contains transactional data with details on customers, purchases, and sales trends. The project demonstrates SQL skills in data cleaning, exploratory data analysis (EDA), and business-driven insights.

### Key Highlights
- **Database Name**: `retail_sales_db`
- **Tech Stack**: PostgreSQL / MySQL
- **Dataset**: Retail sales transactions
- **Use Cases**: Business intelligence, customer insights, sales performance analysis

## Objectives

1. **Database Creation**: Setup and initialize a structured database for retail sales data.
2. **Data Cleaning**: Handle missing values and maintain data integrity.
3. **Exploratory Data Analysis (EDA)**: Perform SQL-based analysis to understand key metrics.
4. **Sales Insights**: Identify high-value customers, peak sales periods, and category performance.
5. **Report Generation**: Summarize findings in a structured format.

## Database Setup

### Creating the Database & Table Structure
```sql
CREATE DATABASE retail_sales_db;

CREATE TABLE retail_sales_tb (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(50),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

## Data Cleaning & Preparation

### Key Steps:
- **Handling Missing Values**: Remove rows with null data.
- **Standardizing Categories**: Ensure consistency in category names.
- **Checking Duplicates**: Identify and eliminate duplicate records.

```sql
DELETE FROM retail_sales WHERE
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR
    gender IS NULL OR age IS NULL OR category IS NULL OR
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

## Data Analysis & Insights

### Sample Queries & Analysis

1. **Total Sales by Category**:
```sql
SELECT 
	category,
	SUM(total_sale) as net_sale,
	count(*) as total_orders
FROM retail_sales_tb
GROUP BY 1
```

2. **Top 5 Customers by Sales**:
```sql
SELECT
	customer_id,
	SUM(total_sale) as total_sales
FROM retail_sales_tb
group by 1
order by 2 desc
```

3. **Peak Sales Hours: Create each shift and num of orders (Ex: Morning <= 12, Afternoon between 12 & Evening > 17)**:
```sql
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
```
Note: The all questions answers are here:`SQL_query_proj01.sql`.

## Reports & Findings
- **Top-selling categories**: Identify which product categories generate the most revenue.
- **Customer segmentation**: Analyze purchasing behavior based on age and gender.
- **Sales trends**: Detect seasonal spikes and peak hours.

## How to Use

1. **Clone the Repository**
```bash
git clone https://github.com/yourusername/retail-sales-analysis.git
```

2. **Set Up Database**
   - Run the SQL script to create and populate the database.

3. **Execute Queries**
   - Use SQL queries to extract meaningful insights.

4. **Modify & Expand**
   - Adapt queries to answer additional business questions.

## Author
This project is a demonstration of SQL capabilities for data analysis. If you have feedback or would like to collaborate, feel free to connect.

📌 **LinkedIn**: [https://www.linkedin.com/in/kalpadas/](#)  
📌 **GitHub**: [https://github.com/kalpadas599](#)

### Stay Connected & Keep Learning 🚀

