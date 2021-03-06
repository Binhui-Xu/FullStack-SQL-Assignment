/*
    1. what is a result set?
        The SQL statement that read data from database query, return the data in a result set. The SELECT statmement is the standard
        way to select rows from a database and view them in a result set.
    2.	What is the difference between Union and Union All?
        UNION ALL command is equal to UNION command, except that UNION ALL selects all the values. The difference between them is that 
        all will not eliminate dulpicate rows, instead it just pulls all the rows from all the tables fitting your query specifics and 
        combines them into a table
    3.	What are the other Set Operators SQL Server has?
        INTERSECT: all distinct rows selected by both queries
        MINUS: all distinct rows selected by the first query but not the second
    4.	What is the difference between Union and Join?
        JOIN combine data into new columns. If two tables are joined together, then the data from the first table is shown in one 
        set of column alongside the second table's column in the same row. UNION combine data into new rows. If two tables are UNION together, 
        then the data from the first table is in one set of rows, and the data from the second table in another set. The rows are in the table result
    5.	What is the difference between INNER JOIN and FULL JOIN?
        INNER JOIN returns only the matching rows between both the tables, non-matching rows are eliminated. FULL JOIN or FULL OUTER JOIN returns
        all rows from both the tables(left & right tables), including non-matching rows from both the tables
    6.	What is difference between left join and outer join
        LEFT JOIN fetches all the rows from the table on the left, unmatched data of the right table is lost. OUTER JOIN Fetches all the rows from 
        both the tables, no data is lost
    7.	What is cross join?
        A CROSS JOIN is a JOIN operation that produces the CARTESIAN product of two tables. Unlike other JOIN operators, it does not let you specify
        a join cluase. You may, however, specify a WHERE clause in the SELECT statement.
    8.	What is the difference between WHERE clause and HAVING clause?
        WHERE clause is used to filter the records from the table based on the specified condition. HAVING clause is used to filter record from the
        groups based on the specified condition
    9.	Can there be multiple group by columns?
        A GROUP BY clause can contain two or more columns, or in orther words, a grouping can consist of two or more columns
*/

--1
SELECT COUNT(ProductID) as NumOfProducts FROM Production.Product
--2
SELECT COUNT(ProductID) as ProdinSub
from Production.Product
where ProductSubcategoryID is not NULL
 --3
SELECT COUNT(p.ProductID) as countedProducts,p.ProductSubcategoryID
FROM  Production.Product p
where p.ProductSubcategoryID is not NULL
GROUP BY p.ProductSubcategoryID
--4
SELECT COUNT(productID) as result
from Production.Product p
WHERE p.ProductSubcategoryID is NULL
--5
SELECT SUM(Quantity) as sum
from Production.ProductInventory
GROUP BY ProductID 
--6
SELECT ProductID,SUM(Quantity) as TheSum
FROM Production.ProductInventory
WHERE LocationID=40 
GROUP BY ProductID
HAVING SUM(Quantity)<100
--7
SELECT Shelf,ProductID,SUM(Quantity) as TheSum
FROM Production.ProductInventory
WHERE LocationID=40 
GROUP BY ProductID,Shelf
HAVING SUM(Quantity)<100
--8
SELECT ProductID,AVG(Quantity) as avg
from Production.ProductInventory
WHERE LocationID=10
GROUP BY ProductID
--9
SELECT ProductID,AVG(Quantity) as TheAvg,Shelf
FROM Production.ProductInventory
GROUP BY ProductID,Shelf
--10
SELECT ProductID,AVG(Quantity) as TheAvg,Shelf
FROM Production.ProductInventory
WHERE Shelf <> 'N/A'
GROUP BY ProductID,Shelf
--11
SELECT Color, Class, COUNT(*) as TheCount, AVG(ListPrice) as AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL and Class IS NOT NULL
GROUP BY Color, Class
--12
SELECT c.Name as Country,s.Name as Province
FROM Person.CountryRegion c FULL JOIN Person.StateProvince s
ON c.CountryRegionCode=s.CountryRegionCode
--13
SELECT c.Name as Country,s.Name as Province
FROM Person.CountryRegion c FULL JOIN Person.StateProvince s
ON c.CountryRegionCode=s.CountryRegionCode
WHERE c.Name NOT IN('Germany','Canada')
--14(Northwind)
SELECT distinct p.*
from dbo.Orders o Full JOIN(select orderID,ProductID from dbo.[Order Details]) od
ON o.OrderID=od.OrderID
left JOIN dbo.Products p
on od.ProductID=p.ProductID
WHERE DATEDIFF(YYYY,o.OrderDate,CURRENT_TIMESTAMP) <25 
--15
SELECT top 5 o.ShipPostalCode,SUM(Quantity) as count
from dbo.Orders o FULL join dbo.[Order Details] od
ON o.OrderID=od.OrderID
WHERE o.ShipPostalCode IS NOT NULL
GROUP BY o.ShipPostalCode
ORDER BY count DESC
--16
SELECT top 5 o.shipPostalCode, SUM(Quantity) as COUNT
FROM dbo.Orders o FULL JOIN dbo.[Order Details] od
on o.OrderID=od.OrderID
where o.ShipPostalCode is not null and 
    DATEDIFF(year,GETDATE(),o.OrderDate)<21
GROUP by o.ShipPostalCode
ORDER BY count DESC
--17
SELECT city, COUNT(CustomerID) as numOfCustomers
FROM dbo.Customers
GROUP BY City
--18
SELECT city, COUNT(CustomerID) as numOfCustomers
FROM dbo.Customers
GROUP BY City
HAVING COUNT(CustomerID)>10
--19
SELECT distinct c.ContactName,o.OrderDate
FROM dbo.Orders o inner join dbo.Customers c
ON o.CustomerID=c.CustomerID
WHERE o.OrderDate>'1998-01-01'
--20
SELECT c.ContactName
FROM dbo.Orders o inner join Customers c
on o.CustomerID=c.CustomerID
where o.OrderDate IN(
select top 1 OrderDate
from Orders
WHERE OrderDate is not null
GROUP BY orderDate
order by OrderDate desc)
--21
SELECT Sum(Quantity) as count,c.ContactName
FROM dbo.Orders o RIGHT JOIN dbo.Customers c
ON o.CustomerID=c.CustomerID
INNER JOIN dbo.[Order Details] od
ON o.OrderID=od.OrderID
GROUP BY c.ContactName
--22
SELECT Sum(Quantity) as count,c.ContactName
FROM dbo.Orders o RIGHT JOIN dbo.Customers c
ON o.CustomerID=c.CustomerID
INNER JOIN dbo.[Order Details] od
ON o.OrderID=od.OrderID
GROUP BY c.ContactName
HAVING Sum(Quantity)>100 
--23
SELECT si.CompanyName,su.CompanyName
FROM dbo.Shippers si cross JOIN dbo.Suppliers su
--24
SELECT o.OrderDate,op.ProductName
FROM dbo.Orders o INNER JOIN 
(select p.ProductName,od.OrderID FROM dbo.[Order Details] od INNER join dbo.Products p on od.ProductID =p.ProductID) op
on o.OrderID=op.OrderID
ORDER BY o.OrderDate
--25
SELECT e1.LastName+' '+e1.FirstName as Employee1,e2.LastName+' '+e2.FirstName as Employee2, e1.Title
FROM dbo.Employees e1 INNER JOIN dbo.Employees e2
ON e1.Title=e2.Title
WHERE e1.FirstName <> e2.FirstName or e1.LastName <> e2.LastName
--26
SELECT e.FirstName+' '+LastName as Manager
FROM dbo.Employees e INNER JOIN
(SELECT COUNT(ReportsTo) as count,ReportsTo
FROM dbo.Employees
group by ReportsTo
HAVING COUNT(ReportsTo)>2) r
ON EmployeeID=r.ReportsTo
--27
SELECT c.City,c.ContactName, 'Customer' as Type
FROM dbo.Customers c
UNION ALL
SELECT s.City,s.ContactName,'Supplier' as Type
FROM dbo.Suppliers s
--28
SELECT * FROM F1 INNER JOIN F2
ON F1.T1=F2.T2
--29
SELECT * FROM F1 left JOIN F2
ON F1.T1=F2.T2
