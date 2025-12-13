SELECT
	Name,
	StandardCost,
	ListPrice,
	ListPrice - StandardCost
FROM
	SalesLT.Product AS p
ORDER BY
	p.ProductId ASC;


SELECT
	Name,
	ListPrice - StandardCost AS Markup
FROM
	SalesLT.Product;

SELECT
	ProductNumber,
	Color,
	Size,
	Color + ', ' + Size AS ProductDetails
FROM
	SalesLT.Product;

/* ERROR QUERY INVALID DATA TYPE OPERATION */
/* Msg 245, Level 16, State 1, Line 27 Conversion failed when converting the varchar value ': ' to data type int. */
SELECT
	ProductID + ': ' + Name AS ProductName
FROM
	SalesLT.Product;

/* USING CAST TO ABOVE QUERY */
/* ANSI standard function part of the SQL language */
SELECT
	CAST(ProductID AS varchar(5)) + ': ' + Name AS ProductName
FROM
	SalesLT.Product;

/* USING CONVERT INSTEAD CAST */
/* SQL Server specific function */
SELECT
	CONVERT(varchar(5), ProductID) + ': ' + Name AS ProductName
FROM
	SalesLT.Product;

/* ERROR: Conversion failed when converting the nvarchar value 'M' to data type int. */
SELECT
	CONVERT(Integer, Size)
FROM
	SalesLT.Product;

SELECT
	TRY_CONVERT(Integer, Size)
FROM
	SalesLT.Product;

/* CONVERT HAS A THIRD PARAMETER SMALLINT TYPE FOR FORMATTING DATE AND TIME VALUES */
SELECT 
	SellStartDate,
	CONVERT(nvarchar(30), SellStartDate) AS ConvertedDate,
	CONVERT(nvarchar(30), SellStartDate, 126) AS ISO8601FormatDate,
	CONVERT(nvarchar(30), SellStartDate, 101) AS USFormatDate
FROM
	SalesLT.Product;

/* ERROR TYPE */
/* Size has char values such as 'M', 'S', etc, to represent size instead numbers */
SELECT
	Name,
	CAST(Size AS Integer) AS NumericSize
FROM
	SalesLT.Product;

/* THERE IS NO ERROR BECAUSE WHEN IT HAS A ERROR TYPE IT'LL RETURN NULL */
/* The values that can be converted to a numeric data type are returned as decimal values, 
	and the incompatible values are returned as NULL, which is used to indicate that a value is unknown. */
SELECT
	Name,
	TRY_CAST(Size AS Integer) AS NumericSize
FROM
	SalesLT.Product;

/* PARSE: used to parse formatted string as a Datatype */
SELECT
	PARSE('05-12-2025' AS Date) AS DateValue,
	TRY_PARSE('$199.99' AS money) AS MoneyValue;

-- STR function converts a numeric value to a VARCHAR.
SELECT ProductID,  '$' + STR(ListPrice) AS Price
FROM SalesLT.Product;

/* ------------------- */
/* HANDLE NULL VALUES  */
/* ------------------- */
/* NULL IS GENERALLY USED TO DENOTE A VALUE THAT IS UNKNOW
   NOTE THAT IS NOT THE SAME AS SAYING THE VALUE IS NONE
*/
SELECT
	Name,
	ISNULL(TRY_CAST(Size as Integer), 0) AS NumericSize
FROM
	SalesLT.Product;

SELECT
	ProductNumber,
	ISNULL(Color, '') + ', ' + ISNULL(Size, '') AS ProductDetails
FROM
	SalesLT.Product;

/* ------------------- */
/* NULLIF TO REPLACE AN 
   EXPLICIT VALUE WITH 
   NULL 
 */
/* ------------------- */
SELECT
	NULLIF(Color, 'Multi') AS SingleColor
FROM
	SalesLT.Product;

SELECT
	Name,
	COALESCE(SellEndDate, SellStartDate) AS StatusLastUpdated
FROM
	SalesLT.Product;

SELECT
	Name,
	CASE
		WHEN 
			SellEndDate IS NULL
		THEN 
			'Currently for sale'
		ELSE
			'No longer available'
	END AS SalesStatus
FROM
	SalesLT.Product;

SELECT
	Name,
	CASE Size
		WHEN 'S' THEN 'Small'
		WHEN 'M' THEN 'Medium'
		WHEN 'L' THEN 'Large'
		WHEN 'XL' THEN 'Extra-Large'
		ELSE ISNULL(Size, 'n/a')
		-- ELSE COALESCE(Size, 'n/a')
	END AS ProductSize
FROM
	SalesLT.Product;


