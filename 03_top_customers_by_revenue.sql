SELECT TOP 10
	c.CustomerID,
	ROUND(SUM(h.SubTotal),0) AS Revenue
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader h ON h.CustomerID = c.CustomerID
LEFT JOIN Person.Person pp ON pp.BusinessEntityID = c.PersonID
LEFT JOIN Sales.Store  s ON s.BusinessEntityID = c.StoreID
WHERE h.ShipDate IS NOT NULL
GROUP BY c.CustomerID
ORDER BY Revenue DESC;
