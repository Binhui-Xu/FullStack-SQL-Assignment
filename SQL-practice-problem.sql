--1
CREATE DATABASE CompanyMngProject
USE CompanyMngProject
CREATE TABLE Cities(CityName VARCHAR(30) primary key,Country VARCHAR(20))
CREATE TABLE Projects(ProjectCode int primary key identity,OfficeID int not null,Title VARCHAR(50) not null,StartTime datetime not null,EndTime datetime,Buget money null,Manager VARCHAR(20) not null, AffectCity VARCHAR(30) FOREIGN key REFERENCES Cities(CityName))
CREATE TABLE Offices(OfficeID int primary key identity, Country VARCHAR(30) not null,ProjectID int FOREIGN KEY REFERENCES Projects(ProjectCode))
CREATE TABLE Employees(EmployeeID int primary key,EmpName VARCHAR(20) not null,ProjectID int FOREIGN KEY REFERENCES Projects(ProjectCode))

--2
CREATE DATABASE LendCompany
USE LendCompany
CREATE TABLE Loan(LoanCode int primary key,Amount money not null,Deadline datetime not null,InterestRate decimal not null, Puepose varchar(100))
CREATE TABLE Lenders(LID int primary key, LName VARCHAR(20) not null, avaliableAmt money,Loan int FOREIGN key REFERENCES Loan(LoanCode),LoanAmt money)
CREATE TABLE Borrowers(BID int primary key,BName VARCHAR(20) not null,Company VARCHAR(30) not null,RiskValue decimal not null, Loan int foreign key REFERENCES Loan(LoanCode))

--3
CREATE DATABASE MenuOfRestaurant
USE MenuOfRestaurant
CREATE TABLE Course(Course VARCHAR(20) primary key,Description VARCHAR(50) not null,Photo varbinary(max),Price money,RecipeID int foreign key REFERENCES Recipes(RID))
CREATE TABLE Course_Category(Name VARCHAR(10) primary key, Description VARCHAR(50) not null,EmpName VARCHAR(20))
CREATE TABLE Recipes(RID int primary key, Ingredients VARCHAR(50) not null, ReqAmount int, Measurements decimal not null, CurrentAmt int not null)

