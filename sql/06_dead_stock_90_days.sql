DECLARE @MaxDate date = (SELECT MAX(OrderDate) FROM Sales.SalesOrderHeader);
WITH inv AS (	SELECT ProductID, SUM(Quantity) AS OnHand
	FROM Production.ProductInventory
	GROUP BY ProductID),
sales90 AS (SELECT d.ProductID, SUM(d.OrderQty) AS SoldLast90d
	FROM Sales.SalesOrderDetail d
	JOIN Sales.SalesOrderHeader h ON h.SalesOrderID = d.SalesOrderID
	WHERE h.OrderDate >= DATEADD(day, -90, @MaxDate)
	GROUP BY d.ProductID)
SELECT p.ProductID, p.Name, i.OnHand
FROM Production.Product p
JOIN inv i ON i.ProductID = p.ProductID
LEFT JOIN sales90 s ON s.ProductID = p.ProductID
WHERE i.OnHand > 0 AND ISNULL(s.SoldLast90d,0) = 0
ORDER BY i.OnHand DESC;
