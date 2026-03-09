WITH y AS (
  SELECT YEAR(ShipDate) AS Y, SUM(SubTotal) AS Rev
  FROM Sales.SalesOrderHeader
  WHERE ShipDate IS NOT NULL
  GROUP BY YEAR(ShipDate))
SELECT curr.Y,
       curr.Rev,
       ROUND((curr.Rev - prev.Rev) * 1.0 / NULLIF(prev.Rev, 0),4) AS YoY
FROM y AS curr
LEFT JOIN y AS prev
  ON prev.Y = curr.Y - 1
ORDER BY curr.Y;
