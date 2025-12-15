/* Retrieve product data */
SELECT *
FROM
	SalesLT.Product;

-- 1 Retrieve product details for product model 1
SELECT
	Name,
	Color,
	Size
FROM
	SalesLT.Product
WHERE
	ProductModelID = 1;

-- 2 Filter products by color and size
SELECT
	ProductNumber,
	Name
FROM
	SalesLT.Product
WHERE
	Color IN ('Black', 'Red', 'White')
	AND Size IN ('S', 'M');

-- 3 Filter products by product number
SELECT
	ProductNumber,
	Name,
	ListPrice
FROM
	SalesLT.Product
WHERE
	ProductNumber LIKE 'BK-%';

-- 4 Retrieve specific products by product number
SELECT
	ProductNumber,
	Name,
	ListPrice
FROM
	SalesLT.Product
WHERE
	ProductNumber LIKE 'BK-[^R]%-[0-9][0-9]';
