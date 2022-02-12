---- Virtual Internship Program ----
----------- by AINE AI -------------
---------January 2022-----------



'''
1. Establish connection with SQL servers

If you are able to write an SQL query, that means you have already established a connection with SQL Server. If still facing any issue, please reach out to the trainer.
'''

-- To Describe the table Structure
EXEC sp_help '[SalesLT].[Customer]';


-- Display all columns for all customers
SELECT * FROM [SalesLT].[Customer]

-- Display Specific fields - customer name fields
SELECT Title, FirstName, MiddleName, LastName, Suffix
FROM SalesLT.Customer;

-- Dispaly customer name and phone number
SELECT FirstName, LastName, Phone
FROM SalesLT.Customer;

-- Each customer has an assigned salesperson. write a query to create a call sheet that lists: 
• The salesperson 
• A column named CustomerName that displays how the customer contact should be greeted (for example, “Mr Smith”) 
• The customer’s phone
SELECT salesperson, CONCAT(Title,' ', FirstName,' ', MiddleName,' ', LastName,' ', Suffix) AS CustomerName, Phone AS 'Phone Number'
FROM SalesLT.Customer;

-- Retrieve a list of customer companies 
SELECT CustomerID ,CompanyName
FROM SalesLT.Customer;

-- Retrieve a list of sales order revisions 
The SalesLT.SalesOrderHeader table contains records of sales orders. retrieve data for a report that shows: 
SELECT * FROM [SalesLT].[SalesOrderHeader]

-- Retrive the sales order number and revision number 
SELECT CONCAT(SalesOrderNumber,' ','(',(RevisionNumber),')') As SalesOrderRevisions
FROM  [SalesLT].[SalesOrderHeader]

-- Retrive the OrderDate
SELECT FORMAT(OrderDate, 'yyyy-mm-dd')AS Orderdate
FROM SalesLT.SalesOrderHeader

-- Retrieve customer contact names with middle names
SELECT CONCAT(FirstName,' ',MiddleName,' ',LastName) As CustomerContactName
FROM [SalesLT].[Customer]

-- Retrieve primary contact details
SELECT CustomerID,(case when EmailAddress = null then Phone
                    else EmailAddress
                    end) As PrimeryContactDetails
FROM [SalesLT].[Customer]

-- Retrieve shipping status 
SELECT SalesOrderID,FORMAT(OrderDate,'yyyy.MM.dd') As OrderDate,(case when OrderDate = null then 'Awaiting Shipment'
                    else 'Shipped'
                    end) As ShippingStatus 
FROM  [SalesLT].[SalesOrderHeader]

-- Retrieve a list of cities 
SELECT * FROM [SalesLT].[Address]


SELECT City, StateProvince INTO #temp7 FROM [SalesLT].[Address]
;WITH CTE([City], [StateProvince],Duplicatecount)
AS (SELECT [City], [StateProvince], ROW_NUMBER() OVER (PARTITION BY [City],[StateProvince] order by  City) AS DuplicateCount FROM #temp7)
DELETE FROM CTE WHERE DuplicateCount > 1
SELECT * FROM #temp7

--Retrieve the heaviest products 
SELECT * FROM [SalesLT].[Product]
--Retrieve the heaviest 100 products not including the heaviest ten 
SELECT TOP(10) PERCENT
Name, Weight 
FROM [SalesLT].[Product]
Order by Weight DESC

SELECT TOP (110) Name, Weight into #flag4
FROM [SalesLT].[Product]
order by Weight DESC
DELETE TOP (10)
FROM #flag4
SELECT * FROM #flag4

--Retrieve product details for product model 1 

SELECT Name, Color, Size, ProductModelID into #abc
FROM [SalesLT].[Product]

--Filter products by color and size 
SELECT * FROM #abc
Where Color in ('Black', 'Red', 'White') AND Size in ('S','M');

SELECT Name, ProductNumber, Color, Size, ProductModelID into #abc1
FROM [SalesLT].[Product]

--Filter products by product number 
SELECT * FROM #abc1
Where ProductNumber LIKE 'BK%';

--Retrieve customer orders to generate invoice reports

SELECT CompanyName, SalesOrderID, TotalDue into #Flag2 FROM [SalesLT].[Customer]  
JOIN [SalesLT].[SalesOrderHeader] 
ON [SalesLT].[SalesOrderHeader].CustomerID = [SalesLT].[Customer].CustomerID 
SELECT * FROM #Flag2

--Retrieve customer orders with addresses 
SELECT CompanyName, AddressLine1, AddressLine2, City, StateProvince, CountryRegion, PostalCode FROM [SalesLT].[Address]
JOIN [SalesLT].[Customer]
ON  [SalesLT].[Address].ModifiedDate = [SalesLT].[Customer].ModifiedDate

--Retrieve a list of all customers and their orders 
SELECT CompanyName, FirstName, LastName, SalesOrderID, TotalDue FROM [SalesLT].[Customer]  
JOIN [SalesLT].[SalesOrderHeader] 
ON [SalesLT].[SalesOrderHeader].CustomerID = [SalesLT].[Customer].CustomerID


SELECT * FROM [SalesLT].[Customer]


--Retrive all data from Address
SELECT * FROM [SalesLT].[Address]

--Retrieve a list of customers with no address 
select * from [SalesLT].[Customer] where rowguid not in (SELECT rowguid from [SalesLT].[Address] );

--Retrieve a list of customers and products without orders 
SELECT CustomerID, CompanyName, FirstName, LastName, Phone from  [SalesLT].[Customer] 
where CustomerID not in (select CustomerID from [SalesLT].[CustomerAddress]);

SELECT COUNT(distinct(CustomerID)) from [SalesLT].[SalesOrderHeader];

SELECT CustomerID, ProductID=NULL from  [SalesLT].[Customer] 
where CustomerID not in (select h.CustomerID from [SalesLT].[SalesOrderHeader] as h join [SalesLT].[SalesOrderDetail] as d on h.SalesOrderID = d.SalesOrderID)
union SELECT CustomerID=NULL, ProductID from  [SalesLT].[Product] 
where ProductID not in (select h.ProductID from [SalesLT].[SalesOrderDetail] as h join [SalesLT].[SalesOrderHeader] as d on h.SalesOrderID = d.SalesOrderID)

Select ProductID, Name, ListPrice From [SalesLT].[Product] 
where ListPrice > (SELECT AVG(UnitPrice) FROM [SalesLT].[SalesOrderDetail] )

SELECT Product.ProductID, Name, ListPrice FROM [SalesLT].[SalesOrderDetail] as detail join [SalesLT].[Product] as product
on detail.ProductID = product.ProductID
Where product.ListPrice > 99 AND detail.LineTotal <101;

--Retrieve products that have an average selling price that is lower than the cost 

SELECT ProductID,Name,ListPrice,  (SELECT AVG(d.UnitPrice) FROM [SalesLT].[SalesOrderDetail] as d where  d.ProductID = p.ProductID) 
AS AVG_UnitPrice
FROM [SalesLT].[Product] as p










