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