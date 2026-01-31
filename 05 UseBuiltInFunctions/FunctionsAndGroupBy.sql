/* SCALAR FUNCTIONS */
SELECT
	SalesOrderID,
	OrderDate,
	YEAR(OrderDate) AS OrderYear,
	DATENAME(mm, OrderDate) AS OrderMonth,
	Day(OrderDate) AS OrderDay,
	DATENAME(dw, OrderDate) AS OrderWeekDay,
	DATEDIFF(yy, OrderDate, GETDATE()) AS YearsSinceOrder
FROM
	SalesLT.SalesOrderHeader;

/* SCALAR MATHEMATICAL FUNCTIONS */
SELECT
	TaxAmt,
	ROUND(TaxAmt, 0) AS Rounded,
	FLOOR(TaxAmt) AS Floor, -- Piso
	CEILING(TaxAmt) AS Ceiling, -- Teto
	SQUARE(TaxAmt) AS Squared,
	SQRT(TaxAmt) AS Root,
	LOG(TaxAmt) AS Log,
	TaxAmt * RAND() AS Randomized,
	RAND(TaxAmt) AS RandedSeed
FROM
	SalesLT.SalesOrderHeader;

/* STRING FUNCTIONS */
SELECT
	CompanyName,
	UPPER(CompanyName) AS UpperCase,
	LOWER(CompanyName) AS LowerCase,
	LEN(CompanyName) AS Length,
	REVERSE(CompanyName) AS Reversed,
	CHARINDEX(' ', CompanyName) AS FirstSpace,
	LEFT(CompanyName, CHARINDEX(' ', CompanyName)) AS FirstWord,
	SUBSTRING(CompanyName, CHARINDEX(' ', CompanyName) + 1, LEN(CompanyName)) AS RestOfName
FROM
	SalesLT.Customer;

/* LOGICAL FUNCTIONS */
SELECT
	AddressType,
	-- If AddresType = 'Main Office' então retorne 'Billing' se não 'Mailing'
	IIF(AddressType = 'Main Office', 'Billing', 'Mailing') AS UseAddressFor
FROM
	SalesLT.CustomerAddress;

SELECT
	SalesOrderID,
	Status,
	CHOOSE(Status, 'Ordered', 'Shipped', 'Delivered') AS OrderStatus
FROM
	SalesLT.SalesOrderHeader
ORDER BY
	Status;

UPDATE SalesLT.SalesOrderHeader
SET Status = ABS(CHECKSUM(NEWID())) % 3 + 1
WHERE Status = 5;

/* RANKING FUNCTIONS */
SELECT
	TOP 100 ProductID,
	Name,
	ListPrice,
	RANK() OVER(ORDER BY ListPrice DESC) AS RankByPrice
FROM
	SalesLT.Product AS p
ORDER BY
	RankByPrice;

/* RANKING OVER PARTITION FUNCTION */
SELECT
	c.Name AS Category,
	p.Name AS Product,
	ListPrice,
	Rank() OVER(PARTITION BY c.Name ORDER BY ListPrice DESC) AS RankByPrice
FROM
	SalesLT.Product p
INNER JOIN
	SalesLT.ProductCategory c
	ON p.ProductCategoryID = c.ProductCategoryID
ORDER BY
	Category, RankByPrice;

/* AGGREGATE FUNCTIONS */
SELECT 
	SUM(ListPrice) AS Total,
	AVG(ListPrice) AS AveragePrice,
    MIN(ListPrice) AS MinimumPrice,
    MAX(ListPrice) AS MaximumPrice
FROM 
	SalesLT.Product;

SELECT 
	   SUM(ListPrice) AS Total,
	   AVG(ListPrice) AS AveragePrice,
       MIN(ListPrice) AS MinimumPrice,
       MAX(ListPrice) AS MaximumPrice
FROM SalesLT.Product
WHERE ProductCategoryID = 15;

SELECT ProductCategoryID, SUM(ListPrice) AS Total,
AVG(ListPrice) AS AveragePrice,
MIN(ListPrice) AS MinimumPrice,
MAX(ListPrice) AS MaximumPrice
FROM SalesLT.Product
GROUP BY ProductCategoryID;

SELECT MIN(YEAR(OrderDate)) AS Earliest,
       MAX(YEAR(OrderDate)) AS Latest
FROM SalesLT.SalesOrderHeader;

SELECT ProductCategoryID, SUM(ListPrice) AS Total,
AVG(ListPrice) AS AveragePrice, -- pode resultar diferente q sum()/count() pois avg considera NULL
SUM(ListPrice)/COALESCE(COUNT(*), 0) AS Arithmetic,
MIN(ListPrice) AS MinimumPrice,
MAX(ListPrice) AS MaximumPrice
FROM SalesLT.Product
GROUP BY ProductCategoryID;

/* SUMMARIZE DATA  WITH GROUP BY */

SELECT
	CustomerID
FROM
	SalesLT.SalesOrderHeader
GROUP BY
	CustomerID;

-- equivalent to
SELECT DISTINCT CustomerID
FROM SalesLT.SalesOrderHeader;

/* GROUP BY NÃO GARANTE A ORDEM DOS RESULTADOS */
SELECT
	CustomerID,
	COUNT(*) AS OrderCount
FROM
	SalesLT.SalesOrderHeader
GROUP BY
	CustomerID
ORDER BY
	CustomerID;

/*
	THE CLAUSES IN A SELECT STATEMENT ARE APPLIED IN THE FOLLOWING ORDER:

	1. FROM
	2. WHERE
	3. GROUP BY
	4. HAVING
	5. SELECT
	6. ORDER BY

	YOU CAN REFERENCE A COLUMN ALIAS IN THE ORDER BY CLAUSE, BUT NOT IN THE
	GROUP BY CLAUSE. THE FOLLOWING QUERY WILL RESULT IN AN INVALID COLUMN NAME
	ERROR:
*/

SELECT CustomerID AS Customer,
       COUNT(*) AS OrderCount
FROM SalesLT.SalesOrderHeader
ORDER BY Customer;

SELECT CustomerID AS Customer,
       COUNT(*) AS OrderCount
FROM SalesLT.SalesOrderHeader
GROUP BY CustomerID
ORDER BY Customer;

SELECT CustomerID, PurchaseOrderNumber, COUNT(*) AS OrderCount
FROM SalesLT.SalesOrderHeader
GROUP BY CustomerID, PurchaseOrderNumber;

/* Filter groups with HAVING */
SELECT 
	CustomerID,
    COUNT(*) AS OrderCount
FROM SalesLT.SalesOrderHeader
GROUP BY CustomerID
HAVING COUNT(*) < 10;

SELECT SalesOrderID, CustomerID, OrderDate, PurchaseOrderNumber, TotalDue
INTO SalesLT.InvoiceS
FROM SalesLT.SalesOrderHeader;

SELECT *
FROM SalesLT.InvoiceS;

SELECT SalesOrderID, CustomerID, OrderDate, PurchaseOrderNumber, TotalDue
FROM SalesLT.SalesOrderHeader;
