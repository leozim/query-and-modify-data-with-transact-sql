SELECT SalesOrderID, ProductID, OrderQty,
    (SELECT AVG(OrderQty)
     FROM SalesLT.SalesOrderDetail) AS AvgQty
FROM SalesLT.SalesOrderDetail
WHERE SalesOrderID = 
    (SELECT MAX(SalesOrderID)
     FROM SalesLT.SalesOrderHeader);

-- The following example uses a correlated subquery to return the most recent order for each customer
SELECT SalesOrderID, CustomerID, OrderDate
FROM SalesLT.SalesOrderHeader AS o1
WHERE SalesOrderID =
    (SELECT MAX(SalesOrderID)
     FROM SalesLT.SalesOrderHeader AS o2
     WHERE o2.CustomerID = o1.CustomerID)
ORDER BY CustomerID, OrderDate;

-- following example, which will return any customer who has never placed an order
SELECT CustomerID, CompanyName, EmailAddress 
FROM SalesLT.Customer AS c 
WHERE NOT EXISTS
  (SELECT * 
   FROM SalesLT.SalesOrderHeader AS o
   WHERE o.CustomerID = c.CustomerID);

/* USE SIMPLE SUBQUERIES */
SELECT
    MAX(UnitPrice)
FROM
    SalesLT.SalesOrderDetail;

SELECT
    Name,
    ListPrice
FROM
    SalesLT.Product
WHERE
    ListPrice >
    (SELECT MAX(UnitPrice)
     FROM
        SalesLT.SalesOrderDetail);

SELECT 
    DISTINCT ProductID
FROM 
    SalesLT.SalesOrderDetail
WHERE 
    OrderQty >= 20;

SELECT
    Name
FROM
    SalesLT.Product
WHERE
    ProductID IN
    (SELECT
        DISTINCT ProductID
    FROM
        SalesLT.SalesOrderDetail
    WHERE
        OrderQty >= 20);

SELECT
    DISTINCT Name
FROM
    SalesLT.Product AS p
INNER JOIn
    SalesLT.SalesOrderDetail AS o
        ON p.ProductID = o.ProductID
WHERE
    OrderQty >= 20;

/* USE CORRELATED SUBQUERIES */
-- IN THIS TYPE OF QUERIES, THE INNER QUERY RUNS ONCE FOR EACH ROW RETURNED BY THE OUTER QUERY.
-- WHICH IS WHY CORRELATED SUBQUERIES ARE SOMETIMES REFERRED TO AS REPEATING SUBQUERIES.
SELECT
    od.SalesOrderDetailID,
    od.ProductID,
    od.OrderQty
FROM
    SalesLT.SalesOrderDetail AS od
WHERE
    od.OrderQty = 
        (SELECT 
            MAX(OrderQty)
         FROM
           SalesLT.SalesOrderDetail AS d
         WHERE
            od.ProductID = d.ProductID)
ORDER BY
    od.ProductID;


SELECT 
    o.SalesOrderID, 
    o.OrderDate,
    (SELECT CompanyName
    FROM SalesLT.Customer AS c
    WHERE c.CustomerID = o.CustomerID) AS CompanyName
FROM 
    SalesLT.SalesOrderHeader AS o
ORDER BY 
    o.SalesOrderID;