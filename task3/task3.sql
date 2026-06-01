-- Q4. Orders with status = 'Delivered'
SELECT OrderID, CustomerID, Product, TotalPrice, OrderStatus
FROM orders
WHERE OrderStatus = 'Delivered';
 
-- Q5. Orders placed in 2024
SELECT OrderID, OrderDate, Product, TotalPrice
FROM orders
WHERE YEAR(OrderDate) = 2024;
 
-- Q6. Orders where TotalPrice is greater than 2000
SELECT OrderID, CustomerID, Product, TotalPrice
FROM orders
WHERE TotalPrice > 2000
ORDER BY TotalPrice DESC;
 
-- Q7. Laptop orders that were Shipped
SELECT OrderID, CustomerID, Quantity, UnitPrice, TotalPrice
FROM orders
WHERE Product = 'Laptop' AND OrderStatus = 'Shipped';
 
-- Q8. Orders paid by Credit Card or Debit Card
SELECT OrderID, CustomerID, Product, PaymentMethod, TotalPrice
FROM orders
WHERE PaymentMethod IN ('Credit Card', 'Debit Card')
ORDER BY TotalPrice DESC;
 
-- Q9. Cancelled or Returned orders
SELECT OrderID, CustomerID, Product, OrderStatus, TotalPrice
FROM orders
WHERE OrderStatus IN ('Cancelled', 'Returned');
 
-- Q10. Orders placed between 2023-01-01 and 2023-12-31
SELECT OrderID, OrderDate, Product, TotalPrice
FROM orders
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
ORDER BY OrderDate;
-- Q11. All orders sorted by TotalPrice descending (most expensive first)
SELECT OrderID, CustomerID, Product, TotalPrice
FROM orders
ORDER BY TotalPrice DESC;
 
-- Q12. Orders sorted by date (most recent first)
SELECT OrderID, OrderDate, CustomerID, Product, TotalPrice
FROM orders
ORDER BY OrderDate DESC;
 
-- Q13. Orders sorted by Product name, then by TotalPrice descending
SELECT OrderID, Product, Quantity, TotalPrice
FROM orders
ORDER BY Product ASC, TotalPrice DESC;
-- Q14. Total number of orders
SELECT COUNT(*) AS TotalOrders
FROM orders;

 
-- Q15. Total revenue across all orders
SELECT SUM(TotalPrice) AS TotalRevenue
FROM orders;

 
-- Q16. Average order value
SELECT ROUND(AVG(TotalPrice), 2) AS AvgOrderValue
FROM orders;

 
-- Q17. Number of orders per OrderStatus
SELECT OrderStatus,
       COUNT(*) AS OrderCount,
       ROUND(SUM(TotalPrice), 2) AS TotalRevenue
FROM orders
GROUP BY OrderStatus
ORDER BY OrderCount DESC;

 
-- Q18. Total quantity sold per product (most sold first)
SELECT Product,
       SUM(Quantity) AS TotalQtySold,
       COUNT(*) AS NumberOfOrders
FROM orders
GROUP BY Product
ORDER BY TotalQtySold DESC;

 
-- Q19. Average order value by Payment Method
SELECT PaymentMethod,
       COUNT(*) AS OrderCount,
       ROUND(AVG(TotalPrice), 2) AS AvgOrderValue,
       ROUND(SUM(TotalPrice), 2) AS TotalRevenue
FROM orders
GROUP BY PaymentMethod
ORDER BY AvgOrderValue DESC;

-- Q20. Revenue and order count by year
SELECT YEAR(OrderDate) AS OrderYear,
       COUNT(*) AS TotalOrders,
       ROUND(SUM(TotalPrice), 2) AS TotalRevenue,
       ROUND(AVG(TotalPrice), 2) AS AvgOrderValue
FROM orders
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;
 
-- Q21. Revenue by product
SELECT Product,
       COUNT(*) AS OrderCount,
       SUM(Quantity) AS TotalQtySold,
       ROUND(SUM(TotalPrice), 2) AS TotalRevenue,
       ROUND(AVG(TotalPrice), 2) AS AvgOrderValue
FROM orders
GROUP BY Product
ORDER BY TotalRevenue DESC;
 
-- Q22. Revenue by month (all years combined)
SELECT MONTH(OrderDate) AS Month,
       MONTHNAME(OrderDate) AS MonthName,
       COUNT(*) AS OrderCount,
       ROUND(SUM(TotalPrice), 2) AS TotalRevenue
FROM orders
GROUP BY MONTH(OrderDate), MONTHNAME(OrderDate)
ORDER BY Month;
 
-- Q23. Top 5 customers by total spend
SELECT CustomerID,
       COUNT(*) AS TotalOrders,
       ROUND(SUM(TotalPrice), 2) AS TotalSpend
FROM orders
GROUP BY CustomerID
ORDER BY TotalSpend DESC
LIMIT 5;

-- Q24. Orders per Payment Method per Status (cross-tab style)
SELECT PaymentMethod,
       OrderStatus,
       COUNT(*) AS OrderCount,
       ROUND(SUM(TotalPrice), 2) AS Revenue
FROM orders
GROUP BY PaymentMethod, OrderStatus
ORDER BY PaymentMethod, OrderStatus;
 
 

-- Q25. Revenue by product – Delivered orders only
SELECT Product,
       COUNT(*) AS DeliveredOrders,
       ROUND(SUM(TotalPrice), 2) AS Revenue
FROM orders
WHERE OrderStatus = 'Delivered'
GROUP BY Product
ORDER BY Revenue DESC;
 
-- Q26. Average unit price per product
SELECT Product,
       ROUND(AVG(UnitPrice), 2) AS AvgUnitPrice,
       ROUND(MIN(UnitPrice), 2) AS MinUnitPrice,
       ROUND(MAX(UnitPrice), 2) AS MaxUnitPrice
FROM orders
GROUP BY Product
ORDER BY AvgUnitPrice DESC;
 
-- Q27. Products with total quantity sold above 500
SELECT Product,
       SUM(Quantity) AS TotalQtySold
FROM orders
GROUP BY Product
HAVING SUM(Quantity) > 500
ORDER BY TotalQtySold DESC;
 
-- Q28. Payment methods with average order value above 1050
SELECT PaymentMethod,
       ROUND(AVG(TotalPrice), 2) AS AvgOrderValue
FROM orders
GROUP BY PaymentMethod
HAVING AVG(TotalPrice) > 1050
ORDER BY AvgOrderValue DESC;
 
-- Q29. Monthly revenue for year 2024
SELECT MONTH(OrderDate) AS Month,
       MONTHNAME(OrderDate) AS MonthName,
       COUNT(*) AS Orders,
       ROUND(SUM(TotalPrice), 2) AS Revenue
FROM orders
WHERE YEAR(OrderDate) = 2024
GROUP BY MONTH(OrderDate), MONTHNAME(OrderDate)
ORDER BY Month;
 
-- Q30. Cancelled orders revenue loss by product
SELECT Product,
       COUNT(*) AS CancelledOrders,
       ROUND(SUM(TotalPrice), 2) AS RevenueLost
FROM orders
WHERE OrderStatus = 'Cancelled'
GROUP BY Product
ORDER BY RevenueLost DESC;
 

 
-- Q31. Overall KPI Summary
SELECT
    COUNT(*)                         AS TotalOrders,
    ROUND(SUM(TotalPrice), 2)        AS TotalRevenue,
    ROUND(AVG(TotalPrice), 2)        AS AvgOrderValue,
    ROUND(MIN(TotalPrice), 2)        AS MinOrderValue,
    ROUND(MAX(TotalPrice), 2)        AS MaxOrderValue,
    SUM(Quantity)                    AS TotalItemsSold
FROM orders;
 
-- Q32. Most popular product (by quantity)
SELECT Product, SUM(Quantity) AS TotalQtySold
FROM orders
GROUP BY Product
ORDER BY TotalQtySold DESC
LIMIT 1;
-- Expected: Chair (562 units)
 
-- Q33. Least popular product (by quantity)
SELECT Product, SUM(Quantity) AS TotalQtySold
FROM orders
GROUP BY Product
ORDER BY TotalQtySold ASC
LIMIT 1;
-- Expected: Phone (411 units)
 
-- Q34. Order status distribution (percentage share)
SELECT OrderStatus,
       COUNT(*) AS OrderCount,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 2) AS Percentage
FROM orders
GROUP BY OrderStatus
ORDER BY OrderCount DESC;