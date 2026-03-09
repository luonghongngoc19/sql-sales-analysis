WITH m AS (
  SELECT YEAR(ShipDate) AS Y, MONTH(ShipDate) AS M, SUM(SubTotal) AS Rev
  FROM Sales.SalesOrderHeader
  WHERE ShipDate IS NOT NULL
  GROUP BY YEAR(ShipDate), MONTH(ShipDate)),
h AS (
  SELECT m.Y, m.M,COUNT(DISTINCT edh.BusinessEntityID) AS Headcount
  FROM m
  JOIN HumanResources.EmployeeDepartmentHistory edh
    ON edh.StartDate <= DATEADD(day,-1, DATEADD(month,1, DATEFROMPARTS(m.Y,m.M,1)))
  GROUP BY m.Y, m.M),
yr AS (
  SELECT m.Y AS [Year],
    SUM(m.Rev) AS Revenue,
    AVG(h.Headcount*1.0) AS AvgHeadcount,
    SUM(m.Rev) / NULLIF(AVG(h.Headcount*1.0), 0) AS RevenuePerEmployee
  FROM m 
  JOIN h ON h.Y = m.Y AND h.M = m.M
  GROUP BY m.Y)
SELECT 
  cur.[Year], cur.Revenue, cur.AvgHeadcount,
  cur.RevenuePerEmployee,
  (cur.RevenuePerEmployee - prev.RevenuePerEmployee) * 1.0/ NULLIF(prev.RevenuePerEmployee, 0) AS RPE_YoY
FROM yr cur
LEFT JOIN yr prev ON prev.[Year] = cur.[Year] - 1
ORDER BY cur.[Year];
