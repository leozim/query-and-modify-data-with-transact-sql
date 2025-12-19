/* CHALLENGE 02 */

-- 1 Retrieve a list of all customers and their orders
/*
The sales manager wants a list of all customer companies and their contacts (first name and last name), 
showing the purchase order number and total due for each order they have placed. 
Customers who have not placed any orders should be included at the bottom of the list with NULL values 
for the purchase order number and total due.
*/

SELECT
	c.CompanyName,
	c.FirstName + c.LastName AS FullName,
	oh.PurchaseOrderNumber,
	oh.TotalDue
FROM
	SalesLT.Customer AS c
LEFT OUTER JOIN
	SalesLT.SalesOrderHeader AS oh
		ON c.CustomerID = oh.CustomerID
ORDER BY
	oh.TotalDue DESC;

-- 2 Retrieve a list of customers with no address
/*
A sales employee has noticed that Adventure Works does not have address information for all customers. 
You must write a query that returns a list of customer IDs, company names, 
contact names (first name and last name), and phone numbers for customers 
with no address stored in the database.
*/
SELECT
	c.CustomerID,
	C.CompanyName,
	c.FirstName + ' ' + c.LastName,
	c.Phone
FROM
	SalesLT.Customer c
LEFT OUTER JOIN
	SalesLT.CustomerAddress ca
		ON c.CustomerID = ca.CustomerID
WHERE
	ca.AddressID IS NULL;
