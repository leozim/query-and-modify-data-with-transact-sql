/* 
Challenge 1: Retrieve product price information

Adventure Works products each have a standard cost price that indicates the cost of manufacturing 
the product, and a list price that indicates the recommended selling price for the product. 
This data is stored in the SalesLT.Product table. Whenever a product is ordered, the actual 
unit price at which it was sold is also recorded in the SalesLT.SalesOrderDetail table.

You must use subqueries to compare the cost and list prices for each product with the unit prices 
charged in each sale.

Retrieve products whose list price is higher than the average unit price.
Retrieve the product ID, name, and list price for each product where the list price is higher than 
the average unit price for all products that have been sold.

Tip: Use the AVG function to retrieve an average value.
Retrieve Products with a list price of 100 or more that have been sold for less than 100.
Retrieve the product ID, name, and list price for each product where the list price is 100 or more, 
and the product has been sold for less than 100.
*/

SELECT
    p.ProductID,
    p.StandardCost AS Cost,
    p.ListPrice,
    od.UnitPrice
FROM
    SalesLT.Product AS p
INNER JOIN
    SalesLT.SalesOrderDetail AS od
    ON p.ProductID = od.ProductID;

SELECT
    p.ProductID,
    p.Name,
    p.ListPrice
FROM
    SalesLT.Product p
WHERE
    p.ListPrice > 
        (SELECT AVG(od.UnitPrice) AS UnitPrice
         FROM SalesLT.SalesOrderdetail AS od)
ORDER BY
    p.ProductID;


SELECT
    p.ProductID,
    p.Name,
    p.ListPrice
FROM
    SalesLT.Product AS p
WHERE
    p.ListPrice >= 100.00 AND
    p.ProductID IN (SELECT od.ProductID
     FROM SalesLT.SalesOrderDetail od
     WHERE od.UnitPrice < 100.00)
ORDER BY
    p.ProductID;












-- SOLUTIONS

 SELECT ProductID, Name, ListPrice
 FROM SalesLT.Product
 WHERE ListPrice >
     (SELECT AVG(UnitPrice)
      FROM SalesLT.SalesOrderDetail)
 ORDER BY ProductID;
-----------------------------------------------
  SELECT ProductID, Name, ListPrice
 FROM SalesLT.Product
 WHERE ProductID IN
     (SELECT ProductID
      FROM SalesLT.SalesOrderDetail
      WHERE UnitPrice < 100.00)
 AND ListPrice >= 100.00
 ORDER BY ProductID;