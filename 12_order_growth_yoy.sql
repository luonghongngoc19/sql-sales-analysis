;WITH y AS (
  SELECT 
    YEAR(h.ShipDate) AS [Year],
    COUNT(*)         AS Orders
  FROM Sales.SalesOrderHeader h
  WHERE h.ShipDate IS NOT NULL         -- chỉ tính đơn đã giao
  GROUP BY YEAR(h.ShipDate)
)
SELECT 
  cur.[Year],
  cur.Orders,
  (cur.Orders - prev.Orders) * 1.0 / NULLIF(prev.Orders, 0)                        AS YoY_Growth
FROM y cur
LEFT JOIN y prev 
  ON prev.[Year] = cur.[Year] - 1
ORDER BY cur.[Year];
