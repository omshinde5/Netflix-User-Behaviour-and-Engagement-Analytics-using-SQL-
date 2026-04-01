# Netflix-User-Behaviour-and-Engagement-Analytics-using-SQL-
This project demonstrates data analysis using SQL to extract meaningful insights from structured datasets. It includes queries for data filtering, aggregation, and transformation to support data-driven decision-making.

## 🎯 Objectives
- Perform data extraction using SQL queries  
- Clean and preprocess raw data  
- Analyze data to identify trends and patterns  
- Generate insights for better decision-making  

---

## 🛠️ Tools & Technologies
- SQL (MySQL / PostgreSQL / SQLite)  
- Relational Database Management System (RDBMS)

---

## 📂 Dataset
The dataset consists of structured tables containing relevant information for analysis. It enables the use of joins, aggregations, and filtering techniques to derive meaningful insights.

---

## ⚙️ Key Features
- Data filtering using WHERE clause  
- Use of JOINs (INNER, LEFT, RIGHT)  
- Aggregation using GROUP BY and HAVING  
- Subqueries and nested queries  
- Sorting using ORDER BY  
- Use of aggregate functions (SUM, COUNT, AVG, etc.)

---

## 📊 Sample Query
```sql
-- Top 5 products by total sales
SELECT product_name, SUM(sales) AS total_sales
FROM sales_data
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 5;
