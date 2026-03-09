WITH Rev_rank AS (
    SELECT YEAR(h.ShipDate) AS [Year],
           t.Name AS Territory,
           ROUND(SUM(h.SubTotal),0) AS Revenue,
           DENSE_RANK() OVER (PARTITION BY YEAR(h.ShipDate) ORDER BY SUM(h.SubTotal) DESC) AS rn
    FROM Sales.SalesOrderHeader h
    JOIN Sales.SalesTerritory t ON t.TerritoryID = h.TerritoryID
    WHERE h.ShipDate IS NOT NULL
    GROUP BY YEAR(h.ShipDate), t.Name
)
SELECT [Year], Territory, Revenue
FROM Rev_rank
WHERE rn <= 4
ORDER BY [Year], rn;
