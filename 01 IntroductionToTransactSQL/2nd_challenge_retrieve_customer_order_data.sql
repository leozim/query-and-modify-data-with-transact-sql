/* 1 Retrieve a list of customer companies */
SELECT
	TRY_CAST(CustomerID AS nvarchar(5)) + 
	': ' + 
	CompanyName AS CustomerCompanies
FROM
	SalesLT.Customer;

/* 2 Retrieve a list of sales order revisions */
SELECT *
FROM
	SalesLT.SalesOrderHeader;

SELECT
	PurchaseOrderNumber + 
	' (' +
	CONVERT(varchar(5), RevisionNumber) + 
	')' AS PurchaseOrderRevisionNumber,
	Convert(nvarchar(30), OrderDate, 101) AS OrderDate,
	Convert(nvarchar(30), OrderDate) AS DefaultOrderDate
FROM
	SalesLT.SalesOrderHeader;

