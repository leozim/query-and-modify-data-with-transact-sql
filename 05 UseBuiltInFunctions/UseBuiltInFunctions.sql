/* SCALAR FUNCTIONS	*/

SELECT
	YEAR(SellStartDate) AS SellStartYear,
	ProductID,
	Name
FROM
	SalesLT.Product
ORDER BY
	SellStartDate;
---------------------------------------------------------
SELECT
	YEAR(SellStartDate) AS SellStartYear,
	DATENAME(mm, SellStartDate) AS SellStartMonth,
	DAY(SellStartDate) AS SellStartDay,
	DATENAME(dw, SellStartDate) AS SellStartWeekDay,
	DATEDIFF(yy, SellStartDate, GETDATE()) AS YearSold,
	ProductID,
	Name
FROM
	SalesLT.Product
ORDER BY
	SellStartYear;
---------------------------------------------------------
SELECT
	CONCAT(FirstName + ' ', LastName) AS FullName
FROM
	SalesLT.Customer;
---------------------------------------------------------
SELECT
	UPPER(Name) AS ProductName,
	ProductNumber,
	ROUND(Weight, 0) AS ApproxWeight,
	LEFT(ProductNumber, 2) AS ProductType,
	RIGHT(ProductNumber, 2) AS ProductTypeRight,
	ProductNumber,
	SUBSTRING(ProductNumber, CHARINDEX('-', ProductNumber) + 1, 4) AS ModelCode,
	SUBSTRING(
		ProductNumber, 
		LEN(ProductNumber) - CHARINDEX('-', REVERSE(RIGHT(ProductNumber, 3))) + 2,
		2) AS SizeCode
FROM
	SalesLT.Product;
---------------------------------------------------------
/* USE LOGICAL FUNCTIONS */
SELECT
	Name,
	Size AS NumericSize
FROM
	SalesLT.Product
WHERE
	ISNUMERIC(size) = 1;
---------------------------------------------------------
SELECT
	Name,
	IIF(ISNUMERIC(Size) = 1, 'Numeric', 'Non-Numeric') AS SizeType
FROM
	SalesLT.Product;
---------------------------------------------------------
SELECT
	prd.Name AS ProductName,
	cat.Name AS Category,
	CHOOSE(
		cat.ParentProductCategoryID, 
		'Bikes', 'Components', 'Clothing', 'Accessories'
		) AS ProductType
FROM
	SalesLT.Product AS prd
INNER JOIN
	SalesLT.ProductCategory AS cat
		ON prd.ProductCategoryID = cat.ProductCategoryID;
---------------------------------------------------------
/* Use aggregate functions */
SELECT COUNT(*) AS Products,
    COUNT(DISTINCT ProductCategoryID) AS Categories,
    AVG(ListPrice) AS AveragePrice
FROM SalesLT.Product;

SELECT COUNT(p.ProductID) AS BikeModels, AVG(p.ListPrice) AS AveragePrice
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory AS c
    ON p.ProductCategoryID = c.ProductCategoryID
WHERE c.Name LIKE '%Bikes';
---------------------------------------------------------
/* GROUP AGGREGATED RESULTS WITH THE GROUP BY CLAUSE */
SELECT Salesperson, COUNT(CustomerID) AS Customers
FROM SalesLT.Customer
GROUP BY Salesperson
ORDER BY Salesperson;

SELECT c.Salesperson, SUM(oh.SubTotal) AS SalesRevenue
FROM SalesLT.Customer c
JOIN SalesLT.SalesOrderHeader oh
    ON c.CustomerID = oh.CustomerID
GROUP BY c.Salesperson
ORDER BY SalesRevenue DESC;

SELECT c.Salesperson, ISNULL(SUM(oh.SubTotal), 0.00) AS SalesRevenue
FROM SalesLT.Customer c
LEFT JOIN SalesLT.SalesOrderHeader oh
    ON c.CustomerID = oh.CustomerID
GROUP BY c.Salesperson
ORDER BY SalesRevenue DESC;

SELECT Salesperson, COUNT(CustomerID) AS Customers
FROM SalesLT.Customer
GROUP BY Salesperson
HAVING COUNT(CustomerID) > 100
ORDER BY Salesperson;