SELECT ProductID,Name,Color,ListPrice from Production.Product 
SELECT ProductID,Name,Color,ListPrice from Production.Product where ListPrice=0
SELECT ProductID,Name,Color,ListPrice from Production.Product where Color is NULL
SELECT ProductID,Name,Color,ListPrice from Production.Product where Color is not NULL
SELECT ProductID,Name,Color,ListPrice from Production.Product where Color is not NULL and ListPrice>0
SELECT Name,Color from Production.Product where Color is not NULL

SELECT Name,ProductID FROM Production.Product where ProductID BETWEEN 400 and 500
SELECT ProductID,Name,Color from Production.Product where Color IN('BLACK','BLUE')
SELECT Name from Production.Product where Name LIKE '%S'
SELECT Name,ListPrice from Production.Product where Name like 'S%' ORDER BY Name
SELECT Name,ListPrice FROM Production.Product where Name like 'S%' or Name like 'A%' ORDER BY Name
SELECT * FROM Production.Product WHERE Name LIKE 'SPO%' AND Name NOT LIKE '%K%' ORDER BY Name
SELECT distinct Color FROM Production.Product ORDER BY Color desc
SELECT DISTINCT ProductSubcategoryID,Color FROM Production.Product WHERE ProductSubcategoryID is not NULL and Color is not NULL ORDER BY ProductSubcategoryID 
-- 16
SELECT ProductSubcategoryID,left([Name],35) AS[Name],Color,ListPrice 
FROM Production.Product 
WHERE Color NOT IN ('red','black') or ListPrice between 1000 and 2000 or ProductSubcategoryID!=1 
ORDER BY ProductID

-- 17




