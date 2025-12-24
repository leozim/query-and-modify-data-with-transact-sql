/*
Challenge 2: Analyze profitability
The standard cost of a product and the unit price at which it is sold determine its profitability. 
You must use correlated subqueries to compare the cost and average selling price for each product.

Retrieve the cost, list price, and average selling price for each product
Retrieve the product ID, name, cost, and list price for each product along with the average unit price 
for which that product has been sold.

Retrieve products that have an average selling price that is lower than the cost.
Filter your previous query to include only products where the cost price 
is higher than the average selling price.
*/

SELECT
    p.ProductID,
    p.Name,
    p.StandardCost AS Cost,
    p.ListPrice,
    (SELECT AVG(od.UnitPrice) 
     FROM SalesLT.SalesOrderDetail od 
     WHERE p.ProductID = od.ProductID) AS AvgUnitPrice
FROM
    SalesLT.Product AS p
ORDER BY
    ProductID;


SELECT
    p.ProductID,
    p.Name,
    p.StandardCost AS Cost,
    p.ListPrice,
    (SELECT AVG(od.UnitPrice) 
     FROM SalesLT.SalesOrderDetail od 
     WHERE p.ProductID = od.ProductID) AS AvgUnitPrice
FROM
    SalesLT.Product AS p
WHERE
    p.StandardCost > (SELECT AVG(od.UnitPrice) 
     FROM SalesLT.SalesOrderDetail od 
     WHERE p.ProductID = od.ProductID)
ORDER BY
    ProductID;   
























-- SOLUTIONS

 SELECT p.ProductID, p.Name, p.StandardCost, p.ListPrice,
     (SELECT AVG(o.UnitPrice)
      FROM SalesLT.SalesOrderDetail AS o
      WHERE p.ProductID = o.ProductID) AS AvgSellingPrice
 FROM SalesLT.Product AS p
 ORDER BY p.ProductID;
----------------------------------------------------------
 SELECT p.ProductID, p.Name, p.StandardCost, p.ListPrice,
     (SELECT AVG(o.UnitPrice)
     FROM SalesLT.SalesOrderDetail AS o
     WHERE p.ProductID = o.ProductID) AS AvgSellingPrice
 FROM SalesLT.Product AS p
 WHERE StandardCost >
     (SELECT AVG(od.UnitPrice)
      FROM SalesLT.SalesOrderDetail AS od
      WHERE p.ProductID = od.ProductID)
 ORDER BY p.ProductID;