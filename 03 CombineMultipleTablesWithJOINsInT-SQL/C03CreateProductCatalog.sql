/* CHALLENGE 03 */

-- 1 Retrieve product information by category
/*
	The product catalog will list products by parent category and subcategory, 
	so you must write a query that retrieves the parent category name, 
	subcategory name, and product name fields for the catalog.
*/

SELECT
	pc.Name,
	psca.Name AS SubcategoryName,
	p.Name AS ProductName
FROM
	SalesLT.ProductCategory pc
INNER JOIN
	SalesLT.ProductCategory psca
		ON pc.ProductCategoryID = psca.ParentProductCategoryID
INNER JOIN
	SalesLT.Product p
		ON psca.ProductCategoryID = p.ProductCategoryID
ORDER BY pc.Name, SubcategoryName, ProductName;
