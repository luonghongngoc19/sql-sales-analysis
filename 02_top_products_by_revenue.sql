SELECT 
	TOP 10 p.ProductID,  
	ROUND(SUM(d.LineTotal),0) AS Revenue
FROM Sales.SalesOrderDetail d
JOIN Production.Product p ON p.ProductID = d.ProductID
JOIN Sales.SalesOrderHeader h ON h.SalesOrderID = d.SalesOrderID
WHERE h.ShipDate IS NOT NULL
GROUP BY p.ProductID, p.Name
ORDER BY Revenue DESC;
