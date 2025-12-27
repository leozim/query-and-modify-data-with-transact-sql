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
AVG(ListPrice) AS AveragePrice,
SUM(ListPrice)/COALESCE(COUNT(*), 0) AS Arithmetic,
MIN(ListPrice) AS MinimumPrice,
MAX(ListPrice) AS MaximumPrice
FROM SalesLT.Product
GROUP BY ProductCategoryID;
