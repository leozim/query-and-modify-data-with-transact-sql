/* CHALLENGE 01 */

-- 1 RETRIEVE CUSTOMER ORDERS
SELECT
	c.FirstName,
	oh.PurchaseOrderNumber,
	oh.SubTotal + oh.TaxAmt + oh.Freight AS TotalDue,
	oh.TotalDue AS Total
FROM
	SalesLT.Customer AS c
INNER JOIN
	SalesLT.SalesOrderHeader AS oh
		ON c.CustomerID = oh.CustomerID;

-- 2 RETRIEVE CUSTOMER ORDERS WITH ADDRESSES
SELECT
	c.FirstName AS Name,
	oh.PurchaseOrderNumber,
	oh.SubTotal + oh.TaxAmt + oh.Freight AS TotalDue,
	oh.TotalDue AS Total,
	ad.AddressLine1 + ' ' + ISNULL(ad.AddressLine2, '') AS FullStreetAddress,
	ad.City,
	ad.StateProvince,
	ad.PostalCode,
	ad.CountryRegion,
	ca.AddressType
FROM
	SalesLT.Customer AS c
INNER JOIN
	SalesLT.SalesOrderHeader AS oh
		ON c.CustomerID = oh.CustomerID
INNER JOIN
	SalesLT.CustomerAddress AS ca
		ON c.CustomerID = ca.CustomerID 
INNER JOIN
	SalesLT.Address AS ad
		ON ca.AddressID = ad.AddressID
WHERE
	ca.AddressType = 'Main Office';
