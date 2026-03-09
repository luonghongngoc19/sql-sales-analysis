DECLARE @asof  date = (SELECT MAX(OrderDate) FROM Sales.SalesOrderHeader);
DECLARE @start date = DATEADD(day, -90, @asof);
WITH offers AS (
    SELECT s.SpecialOfferID, s.Description, s.Category, s.Type, s.DiscountPct
    FROM Sales.SpecialOffer s
    WHERE s.DiscountPct > 0
        AND s.StartDate <= @asof
        AND (s.EndDate IS NULL OR s.EndDate >= @start)),
lines AS (SELECT d.SpecialOfferID, d.SalesOrderID, d.OrderQty, d.LineTotal
    FROM Sales.SalesOrderDetail d
    JOIN Sales.SalesOrderHeader h ON h.SalesOrderID = d.SalesOrderID
    WHERE h.OrderDate BETWEEN @start AND @asof)
SELECT 
    o.SpecialOfferID, 
    o.Description AS Campaign,
    COUNT(DISTINCT l.SalesOrderID) AS Orders,
    SUM(ISNULL(l.OrderQty,0)) AS Units,
    ROUND(SUM(ISNULL(l.LineTotal,0.0)),0) AS Revenue
FROM offers o
LEFT JOIN lines l ON l.SpecialOfferID = o.SpecialOfferID
GROUP BY o.SpecialOfferID, o.Description
ORDER BY Revenue DESC, Orders DESC;



