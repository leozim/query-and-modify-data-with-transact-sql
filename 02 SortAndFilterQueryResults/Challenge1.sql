/* Retrieve data for transportations reports */

-- Retrieve a list of cities
SELECT
	DISTINCT City,
	StateProvince
FROM
	SalesLT.Address
ORDER BY City ASC;

-- Retrieve the heaviest products
SELECT 
	TOP(10) PERCENT WITH TIES
	Name,
	Weight
FROM
	SalesLT.Product
ORDER BY 
	Weight DESC;
