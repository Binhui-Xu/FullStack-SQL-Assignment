/*
    1.	What is View? What are the benefits of using views?
        A view is a virtual table based on the result-set of an SQL statement. A view contains rows and 
        columns, just like a real table. The fields in a view are fields from one or more real tables in 
        the database. You can add SQL statements and functions to a view and present the date as if the data
        were from one single table.
            --> a view can limit the degree of exposure of the underlying to the outer wrold
            --> view can join and simplify multiple tables into a single virtual table
            --> view can act as aggregated tables, where the database engine aggregate data and present the 
                calculated results as part of the data
            --> views can hide complexity of data
            --> view takes very little space to store; the database contains only the definition of view, not 
                a copy of all the data that it presents
            --> view can provide extra security
    2.	Can data be modified through views?
        You can't directly modify data in views based on union queries. You can't modify data in views that use
        GROUP BY or DISTINCT statements. All columns being modified are subject to the same restrictions as if 
        the statements were being executed directly against the base table.
    3.	What is stored procedure and what are the benefits of using it?
        A stored procedures is a set of SQL statements with an assigned name, which are stored in a relational database
        management system as a group, so it can be resued and shared by multiple programs.
            --> A stored procudures preserves data integrity because information is entered in a consistent manner. It improves
                productivity because statements in a stored procudure only must be written once
            --> Stored producures offer advantages over embedding queries in a GUI.
            --> Use of stored procedures can reduce network traffic between clients and servers, because the commands are executed
                as a single batch of code.
    4.	What is the difference between view and stored procedure?
        View is simple showcasing data stored in the database tables whereas a stored producre is group of statements that can 
        be executed. a view is faster as it displays data from the tables referenced whereas a store procedure executes sql statement.
    5.	What is the difference between stored procedure and functions?
        Stored producures and functions can be used to accomplish the same task. Both can be custom-defined as part of any application,
        but functions are designed to send their output to a query or T-SQL statement. Stored producures are designed to return outputs
        to the application, while a user-defined function returns table variables and connot change the server envirionment or operating
        system environment.
    6.	Can stored procedure return multiple result sets?
        Most stored procedures return multiple result sets. Such a stored procedure usually includes one or more select statements.
    7.	Can stored procedure be executed as part of SELECT Statement? Why?
        Stored producre are typically executed with an EXEC statement. However, you can execute a stored producure implicity from
        within a SELECT statement, provide that the storedprocedure returns a result set.
    8.	What is Trigger? What types of Triggers are there?
        A trigger is a stored producure in database which automatocally invokes whenever a special event in the database occurs.
            --> Data Definition Language(DDL) Trigger 
            --> Data Manipulation Language(DML) Trigger
            --> Common Language Runtime(CLR) Trigger
            --> Logon Trigger
    9.	What are the scenarios to use Triggers?
        Auditing and enforcing business rules
    10.	What is the difference between Trigger and Stored Procedure?
        Stored procedures are a pieces of the code in written in PL/SQL to do some specific task. Stored procedures can be invoked
        explicitly by the user. It's like a java program , it can take some input as a parameter then can do some processing and can return values.
        On the other hand,  trigger is a stored procedure that runs automatically when various events happen (eg update, insert, delete). 
        Triggers are more like an event handler they run at the specific event. Trigger can not take input and they can’t return values.
*/

--1
INSERT into dbo.Region VALUES('Middle Earth')
INSERT into dbo.Territories  VALUEs('Gondor')
INSERT into dbo.Employees VALUES('Aragorn King')
--2
UPDATE dbo.Territories set TerritoryDescription='Arnor' WHERE TerritoryDescription='Gondor'
--3
DELETE from Region where RegionDescription='Middle Earth'
--4
CREATE VIEW view_product_order_xu AS
SELECT distinct productID,sum(Quantity) totoalOrdered
FROM Orders o JOIN [Order Details] od
ON o.OrderID=od.OrderID
GROUP BY ProductID;
--5
CREATE PROCEDURE sp_product_order_quantity_xu @productid int
AS
SELECT sum(quantity) from [Order Details] where productID=@productid GROUP BY ProductID
GO
EXEC sp_product_order_quantity_xu
--6
CREATE PROCEDURE sp_product_order_city_xu @productname nvarchar(30)
AS 
SELECT top 5 o.shipcity,p.ProductName,sum(quantity) total
FROM [Order Details] od JOIN Products p
ON od.ProductID=p.ProductID
JOIN Orders o
ON od.OrderID=o.OrderID
WHERE p.ProductName='Chai'
GROUP BY ShipCity,ProductName
ORDER BY sum(Quantity) DESC
GO
EXEC sp_product_order_city_xu
--7
CREATE PROCEDURE sp_move_employees_xu 
AS
select * FROM Employees e JOIN Region r on e.Region=r.RegionID JOIN Territories t on r.RegionID=t.RegionID
WHERE TerritoryDescription='Tory'

--8

--9
create table people_xu (id int primary key,city VARCHAR(30) not null)
INSERT INTO people_xu(id,city) VALUES(1,'Seattle')
INSERT INTO people_xu(id,city) VALUES(2,'Green Bay')
CREATE TABLE city_xu(id int primary key, name varchar(20),city int)
INSERT into city_xu(id,name,city) VALUES(1,'Aaron Rodgers',2)
INSERT into city_xu(id,name,city) VALUES(2,'Russell Wilson',1)
INSERT into city_xu(id,name,city) VALUES(3,'Jody Nelson',2)

CREATE VIEW Packers_binhuixu AS
SELECT c.name FROM people_xu p JOIN city_xu c
ON p.id=c.city
WHERE p.city='Green Bay'
--10
CREATE PROCEDURE sp_birthday_employees_xu 
as 
SELECT * into birthday_employees_xu FROM Employees e where 1=0
INSERT into birthday_employees_xu 
SELECT * FROM Employees e
WHERE Month(e.BirthDate)=2
GO
EXEC sp_birthday_employees_xu

drop table birthday_employees_xu
--11.1
CREATE PROCEDURE sp_xu_1 
AS
SELECT distinct City from Customers
WHERE CustomerID in (
SELECT distinct customerID
FROM Orders o join [Order Details] od
ON o.OrderID=od.OrderID
GROUP BY o.CustomerId,od.ProductID
HAVING COUNT(*)<=1
)
GROUP BY City
HAVING count(CustomerID)>=2
GO
EXEC sp_xu_1
--11.2
create PROCEDURE sp_xu_2 
AS

--12
select * FROM table1
EXCEPT
select * from table2

--14
SELECT [First Name]+' '+[Last Name]+' '+[Middle Name]+'.' as [Full Name]
FROM table1
WHERE [Middle Name] is not null
--15
SELECT top 1 marks,RANK() over(order by marks desc) as rnk from table2
where sex='F'
ORDER BY rnk 
--16
SELECT *,rank() OVER(partion by sex border by marks desc) as rnk from table2
