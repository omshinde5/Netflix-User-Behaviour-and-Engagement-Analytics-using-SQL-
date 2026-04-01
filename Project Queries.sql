USE netflix_project;

# 1. Top 10 Most Engaging Shows

SELECT 
n.Title,
n.Genre,
SUM(v.Watch_Time_Minutes) AS Total_Watch_Time
FROM Viewing_History v
JOIN Netflix_Content n 
ON v.Show_Id = n.Show_Id
GROUP BY n.Title, n.Genre
ORDER BY Total_Watch_Time DESC
LIMIT 10;

# 2. Customers Rank by Engagement Level

SELECT 
c.Customer_Id,
c.Name,
SUM(v.Watch_Time_Minutes) AS Total_Watch_Time,
RANK() OVER (ORDER BY SUM(v.Watch_Time_Minutes) DESC) AS Engaging_Customers_Rank
FROM Customers c
JOIN Viewing_History v 
ON c.Customer_Id = v.Customer_Id
GROUP BY c.Customer_Id, c.Name;

# 3. Monthly Watch Time Growth

SELECT 
Month,
Total_Watch_Hours,
Total_Watch_Hours - LAG(Total_Watch_Hours) 
OVER (ORDER BY month) AS Growth
FROM (
SELECT 
DATE_FORMAT(Watch_Date,'%Y-%m') AS Month,
SUM(Watch_Time_Minutes)/60 AS Total_Watch_Hours
FROM Viewing_History
GROUP BY Month
) t;

# 4. Top Shows Within Each Genre

SELECT *
FROM (
SELECT 
n.Genre,
n.Title,
SUM(v.Watch_Time_Minutes) AS Watch_Time,
RANK() OVER (
PARTITION BY n.Genre 
ORDER BY SUM(v.Watch_Time_Minutes) DESC
) AS Genre_Rank
FROM Viewing_History v
JOIN Netflix_Content n 
ON v.Show_Id = n.Show_Id
GROUP BY n.Genre, n.Title
) Ranked
WHERE Genre_Rank <= 1;

# 5. Calculate Customer Lifetime Value (CLV)

SELECT 
c.Customer_Id,
c.Name,
SUM(s.Monthly_Fee) AS lifetime_Value
FROM Customers c
JOIN Subscriptions s 
ON c.Customer_Id = s.Customer_Id
GROUP BY c.Customer_Id, c.Name
ORDER BY lifetime_Value DESC;

# 6. Identify Binge Watchers

SELECT 
Customer_Id,
Watch_Date,
SUM(Watch_Time_Minutes) AS Daily_Watch_Time
FROM Viewing_History
GROUP BY Customer_Id, Watch_Date
HAVING Daily_Watch_Time > 120;

# 7. Analyze Cancellation Rate

SELECT 
ROUND(
SUM(CASE WHEN Payment_Status='Cancelled' THEN 1 ELSE 0 END) 
* 100.0 / COUNT(*), 2
) AS Cancelled_Rate_Percentage
FROM Subscriptions;

