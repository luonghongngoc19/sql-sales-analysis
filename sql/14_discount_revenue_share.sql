DECLARE @end   date = (SELECT MAX(OrderDate) FROM Sales.SalesOrderHeader);
DECLARE @start date = DATEADD(year, -1, @end);
SELECT 
    AVG(CASE WHEN d.UnitPriceDiscount > 0 THEN 1.0 ELSE 0.0 END) AS DiscountedLineRatio,
    SUM(CASE WHEN d.UnitPriceDiscount > 0 THEN d.LineTotal ELSE 0 END)
    / NULLIF(SUM(d.LineTotal), 0) AS DiscountedRevenueShare
FROM Sales.SalesOrderDetail d
JOIN Sales.SalesOrderHeader h ON h.SalesOrderID = d.SalesOrderID
WHERE h.ShipDate IS NOT NULL
  AND h.OrderDate BETWEEN @start AND @end;
