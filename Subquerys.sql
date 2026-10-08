create database data1
-- Creating tables
CREATE TABLE Departments1 (
   DepartmentID INT PRIMARY KEY,
   DepartmentName VARCHAR(50)
);
CREATE TABLE Employees_1 (
   EmployeeID INT PRIMARY KEY,
   Name VARCHAR(50),
   Age INT,
   DepartmentID INT,
   Salary DECIMAL,
   ManagerID INT
);
 
INSERT INTO Employees_1 (EmployeeID, Name, Age, DepartmentID, Salary, ManagerID) VALUES
(1, 'Alice', 30, 1, 60000, NULL),
(2, 'Bob', 45, 1, 80000, 1),
(3, 'Charlie', 28, 2, 40000, 1),
(4, 'David', 35, 2, 50000, 2),
(5, 'Eve', 40, 3, 90000, NULL),
(6, 'Frank', 25, 3, 45000, 5);

 
INSERT INTO Departments1 (DepartmentID, DepartmentName) VALUES
(1, 'Sales'),
(2, 'Engineering'),
(3, 'HR');
 
CREATE TABLE Projects (
   ProjectID INT PRIMARY KEY,
   ProjectName VARCHAR(50),
   DepartmentID INT
);
 
INSERT INTO Projects (ProjectID, ProjectName, DepartmentID) VALUES
(1, 'Project A', 1),
(2, 'Project B', 2),
(3, 'Project C', 3);
INSERT INTO Projects (ProjectID, ProjectName, DepartmentID) VALUES (4,Null,Null)
CREATE  TABLE ProjectAssignments (
   ProjectID INT,
   EmployeeID INT,
   PRIMARY KEY (ProjectID, EmployeeID)
);
 INSERT INTO ProjectAssignments (ProjectID, EmployeeID) VALUES
(1, 1),
(2, 3),
(2, 4),
(3, 5),
(3, 6);

CREATE TABLE Customers (
   CustomerID INT PRIMARY KEY,
   CustomerName VARCHAR(50),
   City VARCHAR(50)
);
 
INSERT INTO Customers (CustomerID, CustomerName, City) VALUES
(1, 'Customer A', 'New York'),
(2, 'Customer B', 'Los Angeles'),
(3, 'Customer C', 'Chicago');

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(1, 1, '2023-01-10', 500),
(2, 1, '2023-02-15', 1200),
(3, 2, '2023-03-05', 700),
(4, 3, '2023-04-20', 1500);
 
CREATE TABLE OrderDetails1 (
   OrderDetailID INT PRIMARY KEY,
   OrderID INT,
   ProductID INT,
   Quantity INT,
   UnitPrice DECIMAL
);
 
INSERT INTO OrderDetails1 (OrderDetailID, OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 1, 2, 250),
(2, 2, 2, 3, 400),
(3, 3, 1, 1, 700),
(4, 4, 3, 5, 300);
 
CREATE TABLE Products (
   ProductID INT PRIMARY KEY,
   ProductName VARCHAR(50),
   Price DECIMAL
);
 
INSERT INTO Products (ProductID, ProductName, Price) VALUES
(1, 'Product X', 250),
(2, 'Product Y', 400),
(3, 'Product Z', 300);
 
-- checking the tables
 
select * from Employees_1
select * from Departments1
select * from Customers
select *  from OrderDetails1
select * from Orders
select * from Projects
select * from ProjectAssignments
select * from Products
-- subquerys
-- Find the employees working in the 'Sales' department
select * from Employees_1
select * from Departments1
select * from Employees_1 where DepartmentID=1;
select * from Employees_1 where DepartmentID=(select  DepartmentID from Departments1 where DepartmentName="Sales");
-- Find the departments with the highest average salary

SELECT DepartmentID, AVG(Salary) AS AvgSalary
FROM Employees_1
GROUP BY DepartmentID
HAVING AVG(Salary) = (
   SELECT Max(AvgSalary)
   FROM (SELECT AVG(Salary) AS AvgSalary FROM Employees_1 GROUP BY DepartmentID) AS DeptavgSalaries)
 -- List the projects that have no employees assigned
 select * from Projects
 select * from ProjectAssignments
select * from Employees_1
select * from Projects where ProjectID NOT IN (SELECT ProjectID from ProjectAssignments );
-- Customers who have placed orders worth more than $1000
select * from Customers
select * from Orders
select * from orders where customerid in (select customerid from orders group by CustomerID having sum(totalamount) > 1000);
select CustomerID,sum(TotalAmount) as Total_orders_value from orders group by CustomerID ;
-- List employees who work on more than one project
select * from Employees_1
select * from Projects
select * from ProjectAssignments
insert into ProjectAssignments values(1,3)
select EmployeeID,count(EmployeeID) as Totalprojects from ProjectAssignments group by EmployeeID
having count(EmployeeID)>1;
-- Find the average salary of employees who are older than the average age
select from Salary  avg(Salary) as average_salary from Employees_1;
select  avg(Age) as average_age from Employees_1;
Select avg(salary)   from Employees_1 where Age >(select  avg(Age) as average_age from Employees_1 as employee_avg_age);

