WITH x AS (
	SELECT CustomerID, COUNT(DISTINCT SalesOrderID) AS Orders
	FROM Sales.SalesOrderHeader
	WHERE ShipDate IS NOT NULL
	GROUP BY CustomerID)
SELECT AVG(CASE WHEN Orders >= 2 THEN 1.0 ELSE 0.0 END) AS RepeatRate
FROM x;
