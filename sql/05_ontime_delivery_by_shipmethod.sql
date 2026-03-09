SELECT
  m.Name AS ShipMethod,
  COUNT(h.SalesOrderID) AS OrdersTotal,
  SUM(CASE WHEN h.ShipDate IS NOT NULL THEN 1 ELSE 0 END) AS OrdersShipped,
  CASE 
    WHEN SUM(CASE WHEN h.ShipDate IS NOT NULL THEN 1 ELSE 0 END) = 0 THEN 0
    ELSE SUM(CASE WHEN h.ShipDate <= h.DueDate THEN 1 ELSE 0 END) * 1.0
         / SUM(CASE WHEN h.ShipDate IS NOT NULL THEN 1 ELSE 0 END)
  END AS OnTimeRate
FROM Purchasing.ShipMethod m
LEFT JOIN Sales.SalesOrderHeader h ON h.ShipMethodID = m.ShipMethodID
GROUP BY m.Name
ORDER BY OnTimeRate DESC, m.Name;
