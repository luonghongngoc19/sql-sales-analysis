SELECT YEAR(OrderDate) AS [Year],
       COUNT(*) AS OrdersShipped,
       SUM(CASE WHEN ShipDate <= DueDate THEN 1 ELSE 0 END) AS OnTimeOrders,
       SUM(CASE WHEN ShipDate >  DueDate THEN 1 ELSE 0 END) AS LateOrders,
       SUM(CASE WHEN ShipDate <= DueDate THEN 1 ELSE 0 END)*1.0 / NULLIF(COUNT(*),0) AS OnTimeRate
FROM Sales.SalesOrderHeader
WHERE ShipDate IS NOT NULL
GROUP BY YEAR(OrderDate)
ORDER BY [Year];