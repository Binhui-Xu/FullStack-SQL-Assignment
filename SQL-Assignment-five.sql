/*
    1.	What is an object in SQL?
        An object type can represent any real-world entity. SQL objects are schemas, journals, catalogs, tables, 
        aliases, views,indexes,constrains, triggers,masks, permissions,sequences, stored procedures,user-defined functions,
        user-defined types, global variables, and SQL packages. SQL creates and maintain these objects as system objects
    2.	What is Index? What are the advantages and disadvantages of using Indexes?
        A sata structure that assists in accessing file records directly -- without scanning the file linearly. An index can 
        improve performance of queries substantially. the number of file blocks retrieved could sometimes by reduced from n/2 
        to just one.
        However, if the index is large and does not fit in memory, accessing the index blocks themselves incurs cost. And if
        the file is dynamic(records are added or deleted), then the index must be modified whenever the file is modified. 
    3.	What are the types of Indexes?
            --> primary(clustered) && secondary(unclustered) indeices
            --> sparse && dense indeices
            --> integerated && seperated indices
            --> single && multiple field indices
    4.	Does SQL Server automatically create indexes when a table is created? If yes, under which constraints?
        When define a primary key constraint on one or more columns, SQL Server automatically creates a unique, clustered index 
        if a clustered index does not already exist on the table or view. Howecer, you can override the default behavior and 
        define a unique, nonclustered index on the primary key 
    5.	Can a table have multiple clustered index? Why?
        No. An index on search key K is clusteredm if the database file is sorted on the search key. Because a file can only be 
        sorted in one way, there can be (at most) one clustered index. All other index are unclustered
    6.	Can an index be created on multiple columns? Is yes, is the order of columns matter?
        Yes. The multiple-field index which is an index on a combination of fields. 
        So the order of columns in a multi-column index definitely matters. One type of query may need a certain column order for 
        the index. If you have several types of queries, you might need several indexes to help them, with columns in different orders.
    7.	Can indexes be created on views?
        Yes. Creating a unique clustered index on a view imorives query performance because the view is sorted in the database in the same 
        way a table with a clustered index is sorted.
    8.	What is normalization? What are the steps (normal forms) to achieve normalization?
        The process of decomposing unsatisfactory "bad" relations by breaking up their attributes into smaller relations. The decomposition
        into several relations that satisfy various definitions of normal forms, each one more restrictive than the previous one.
        Normal form: condition using keys and FDs of a relation to certify whether a relation schema is in a particular normal form.
    9.	What is denormalization and under which scenarios can it be preferable?
        The process of storing the join of higher normal form relations as a base relation,which is in a lower normal form.
    10.	How do you achieve Data Integrity in SQL Server?
        Constriants let you define the way the SQL Server Database Engine automatically enforces the integrity of a database. 
    11.	What are the different kinds of constraint do SQL Server have?
        Constriants can be column constraints or table constraints. 
            --> not null
            --> unique
            --> primary key
            --> foreign key
            --> check constraint
    12.	What is the difference between Primary Key and Unique Key?
            --> PK not accept null value, but unique accept null value
            --> one table can only have one PK, but can have multiple unique
            --> PK will sort the data in ASC order by defualt, but unique will not
            --> PK by defualt clustered index, but unique create unclustered index
    13.	What is foreign key?
        A FK is a column or combination of columns that is used to establish and 
        enforce a link between the data in two tables.
    14.	Can a table have multiple foreign keys?
        Yes.
    15.	Does a foreign key have to be unique? Can it be null?
        The foreign key must have a value that is already present as a primary key, or may be null.
    16.	Can we create indexes on Table Variables or Temporary Tables?
        can only add unclustered index on temp tbale, but cannot add index on table variables.
    17.	What is Transaction? What types of transaction levels are there in SQL Server?
        A real-time database program that updates an online database when a real-world event occurs.
            --> read uncommitted
            --> read committed
            --> repeatable read
            --> serializable
            --> snapshot Isolation
*/

--1
CREATE TABLE Customer(cust_id int,iname varchar(50))
CREATE TABLE Order(order_id int, cust_id int, amount money,order_date smalldatetime)

CREATE PROCEDURE spShowCust
as
SELECT c.cust_id,c.iname,sum(order_id)
from Customer c JOIN Order o
ON c.cust_id=o.cust_id
GROUP BY c.cust_id,c.iname
WHERE YEAR(o.order_date)=2000
--2
CREATE TABLE Person(id int, firstname varchar(100),lastname varchar(100))

SELECT * FROM Person WHERE lastname like 'A%'
--3
CREATE TABLE Person(person_id int primary key,manager_is int not null,name carchar(100) not null)

CREATE VIEW vwMng as 
select person_id from Person where manager_id is NULL

select name,sum(p.person_id) as sum FROM Person p join Person m
on p.manager_id=m.person_id
where p.person_is in vwMng
--4
/* [insert|delete|update] */
--5


