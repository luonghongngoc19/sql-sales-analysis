SELECT 
	SUM(SubTotal) AS Revenue
FROM Sales.SalesOrderHeader
WHERE ShipDate IS NOT NULl
	AND YEAR(ShipDate) = 2013
	AND MONTH(ShipDate) <7