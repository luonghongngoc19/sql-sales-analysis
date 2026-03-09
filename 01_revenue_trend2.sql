SELECT 
	YEAR(ShipDate) AS [Year], 
	SUM(SubTotal) AS Revenue
FROM Sales.SalesOrderHeader
WHERE ShipDate IS NOT NULL
GROUP BY YEAR(ShipDate)
ORDER BY [Year]
