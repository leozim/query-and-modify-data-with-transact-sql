/* 1 Retrieve customer details */
SELECT *
FROM
	SalesLT.Customer;

/* 2 Retrieve customer name data */
SELECT
	ISNULL(Title, '') + 
	FirstName + ' ' + 
	ISNULL(MiddleName, ' ') + 
	ISNULL(LastName, ' ') + 
	ISNULL(Suffix, '') AS Name
FROM
	SalesLT.Customer;

/* 3 Retrieve customer names and phone numbers */
SELECT
	SalesPerson,
	CASE
		WHEN 
			Title IS NOT NULL
		THEN 
			Title + ' ' + LastName
		ELSE
			LastName
	END AS CustomerName,
	Phone
FROM
	SalesLT.Customer;
