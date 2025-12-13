/* Retrieve customer contact names with middle names if known */
SELECT
	*
FROM
	SalesLT.Customer;

SELECT
	ISNULL(FirstName + ' ', '') +
	ISNULL(MiddleName + ' ', '') +
	ISNULL(LastName, '') AS FullName
FROM
	SalesLT.Customer;

/* Retrieve primary contact details */
SELECT
	CustomerID,
	EmailAddress, 
	Phone 
FROM
	SalesLT.Customer;

SELECT
	CustomerID,
	COALESCE(EmailAddress, Phone) AS PrimaryContact
FROM
	SalesLT.Customer;

/* 3 Retrieve shipping status */
  UPDATE SalesLT.SalesOrderHeader
  SET ShipDate = NULL
  WHERE SalesOrderID > 71899;

SELECT
	SalesOrderId,
	OrderDate,
	ShipDate
FROM
	SalesLT.SalesOrderHeader;


SELECT
	SalesOrderId,
	OrderDate,
	CASE
		WHEN
			ShipDate IS NULL
		THEN
			'Awaiting Shipment'
		ELSE
			'Shipped'
	END AS ShippingStatus
FROM
	SalesLT.SalesOrderHeader;
