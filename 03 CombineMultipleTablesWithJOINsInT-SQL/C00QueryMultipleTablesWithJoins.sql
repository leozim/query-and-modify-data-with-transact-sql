
/* INNER JOIN */

SELECT
	SalesLT.Product.Name AS ProductName,
	SalesLT.ProductCategory.Name AS Category
FROM
	SalesLT.Product
INNER JOIN
	SalesLT.ProductCategory
	ON SaLesLT.Product.ProductCategoryID = SalesLT.ProductCategory.ProductCategoryID;

-- SAME RESULT BECAUSE IT IS AN INNER JOIN. THE ORDER OF THE INSTANCES TABLE DOESN'T CARE!

SELECT
	SalesLT.Product.Name AS ProductName,
	SalesLT.ProductCategory.Name AS Category
FROM
	SalesLT.ProductCategory
INNER JOIN
	SalesLT.Product
	ON SalesLT.ProductCategory.ProductCategoryID = SaLesLT.Product.ProductCategoryID;

-- THE RESULT SHOULD BE THE SAME ONCE 'INNER' IS DEFAULT WHEN JOINs TABLES

SELECT
	SalesLT.Product.Name AS ProductName,
	SalesLT.ProductCategory.Name AS Category
FROM
	SalesLT.Product
JOIN
	SalesLT.ProductCategory
	ON SaLesLT.Product.ProductCategoryID = SalesLT.ProductCategory.ProductCategoryID;

-- STILL RETURN THE SAME RESULT. JUST USING ALIAS QUERYING

SELECT
	p.Name AS ProductName,
	c.Name AS Category
FROM
	SalesLT.Product AS p
INNER JOIN
	SalesLT.ProductCategory AS c
	ON p.ProductCategoryID = c.ProductCategoryID;
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
SELECT
	oh.OrderDate,
	oh.PurchaseOrderNumber,
	p.Name AS ProductName,
	od.OrderQty,
	od.UnitPrice,
	od.OrderQty * od.UnitPrice AS TotalPrice
FROM 
	SalesLT.SalesOrderHeader AS oh
JOIN
	SalesLT.SalesOrderDetail AS od
		ON od.SalesOrderID = oh.SalesOrderID
JOIN
	SalesLT.Product AS p
		ON od.ProductID = p.ProductID
ORDER BY
	oh.OrderDate,
	oh.SalesOrderID,
	od.SalesOrderDetailID;
----------------------------------------------------------------------------------

/* OUTER JOIN */
SELECT
	c.FirstName,
	c.LastName,
	oh.PurchaseOrderNumber
FROM
	SalesLT.Customer AS c
LEFT OUTER JOIN
	SalesLT.SalesOrderHeader AS oh
		ON c.CustomerID =  oh.CustomerID
ORDER BY
	c.CustomerID;

-- SHOULD RETURN SAME RETURN AS ABOVE
SELECT
	c.FirstName,
	c.LastName,
	oh.PurchaseOrderNumber
FROM
	SalesLT.Customer AS c
LEFT JOIN
	SalesLT.SalesOrderHeader AS oh
		ON c.CustomerID =  oh.CustomerID
ORDER BY
	c.CustomerID;

-- RETURN ONLY THE CUSTOMERS WHO HAVEN'T PLACED ANY ORDERS.
SELECT
	c.FirstName,
	c.LastName,
	oh.PurchaseOrderNumber
FROM
	SalesLT.Customer AS c
LEFT JOIN
	SalesLT.SalesOrderHeader AS oh
		ON c.CustomerID = oh.CustomerID
WHERE
	oh.SalesOrderNumber IS NULL
ORDER BY
	c.CustomerID;

-- RETRIEVE DATA FROM THREE TABLES
-- WHEN AN OUTER JOIN IS USED, THE REMAINING OUTER JOINS
-- SHOULD BE IN THE SAME DIRECTION(LEFT, RIGHT) OF THE
-- FIRST OUTER JOIN.
SELECT
	p.Name AS ProductName,
	oh.PurchaseOrderNumber
FROM
	SalesLT.Product AS p
LEFT JOIN
	SalesLT.SalesOrderDetail AS od
		ON p.ProductID = od.ProductID
LEFT JOIN
	SalesLT.SalesOrderHeader AS oh
		ON od.SalesOrderID = oh.SalesOrderID
ORDER BY
	p.ProductID;

-- USING INNER JOIN AT THEN END OF OUTER JOINs
SELECT
	p.Name AS ProductName,
	c.Name AS Category,
	oh.PurchaseOrderNumber
FROM
	SalesLT.Product AS p
LEFT OUTER JOIN
	SalesLT.SalesOrderDetail AS od
		ON p.ProductID = od.ProductID
LEFT OUTER JOIN
	SalesLT.SalesOrderHeader AS oh
		ON od.SalesOrderID = oh.SalesOrderID
INNER JOIN
	SalesLT.ProductCategory AS c
		ON p.ProductCategoryID = c.ProductCategoryID
ORDER BY
	p.ProductID;

/* CROSS JOIN */
-- RETURN MORE THAN 260K OF ROWS. IT'S USEFUL WHEN WE WANT SEND
-- AN EMAIL FOR EVERY PRODUCT TO EVERY CUSTOMER
-- FULL CARTESIAN PRODUCT
SELECT
	p.Name,
	c.FirstName,
	c.LastName,
	c.EmailAddress
FROM
	SalesLT.Product AS p
CROSS JOIN
	SalesLT.Customer AS c;

/* SELF JOIN */
-- IT ISN'T A SPECIFIC KIND OF JOIN. IT'S JUST A TECHNIQUE TO JOIN
-- THE SAME TABLE TO ITSELF.
-- THIS APPROACH CAN BE USEFUL WHEN A TABLE HAS A FOERIGN REFERENCES
-- A PRIMARY KEY OF THE SAME TABLE.
/*
for example in a table of employees where an employee’s manager is also an employee, 
or a table of product categories where each category might be 
a subcategory of another category.
*/
SELECT
	pcat.Name AS ParentCategory,
	cat.Name AS SubCategory
FROM
	SalesLT.ProductCategory AS cat
INNER JOIN
	SalesLT.ProductCategory AS pcat
		ON cat.ParentProductCategoryID = pcat.ProductCategoryID
ORDER BY
	ParentCategory, SubCategory;

