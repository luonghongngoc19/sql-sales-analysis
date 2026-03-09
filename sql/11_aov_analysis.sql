SELECT YEAR(h.ShipDate) AS [Year],
       COUNT(*) AS Orders,
       AVG(h.SubTotal) AS AOV_SubTotal
FROM Sales.SalesOrderHeader h
WHERE h.ShipDate IS NOT NULL
GROUP BY YEAR(h.ShipDate)
ORDER BY [Year];



