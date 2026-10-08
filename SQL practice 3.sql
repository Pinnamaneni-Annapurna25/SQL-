create database Employees
-- Data Definition Language (DDL):
create  table Employees (EmployeeID int, FirstName varchar(50), LastName varchar(50), Department varchar(50), Salary decimal(10,2));
alter table Employees add HireDate date;
alter table Employees rename column Department to Dept;
alter table Employees drop column Salary;
create table Departments (DeptID int, DeptName varchar(50));
alter table Departments add primary key (DeptID);
alter table Employees add constraint foreign key (Dept) references Departments(DeptID);
-- Data Manipulation Language (DML):
insert into Employees (EmployeeID, FirstName, LastName, Dept, Salary, HireDate)
 values (101, 'John', 'Doe', 'IT', 60000, '2024-05-14');
select * from Employees;
update Employees set Salary = 65000 where EmployeeID = 101;
delete from Employees where EmployeeID = 101;
-- Constraints:

create table Students1(StudentID int, FirstName varchar(50), LastName varchar(50), DateOfBirth date);
use  students;
alter table Students modify FirstName varchar(50) not null;
alter table Students add constraint unique_studentid unique (StudentID);
alter table Students add constraint check_dob check (DateOfBirth <= curdate());
alter table Students alter LastName set default 'Doe';
