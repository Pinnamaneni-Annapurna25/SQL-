-- Data Definition Language (DDL)
CREATE DATABASE Students;
CREATE TABLE Students (StudentID INT ,FirstName VARCHAR(50),LastName VARCHAR(50),Age INT);
select * from Students;
alter table Students add Gender varchar(20);
alter table Students rename column Age TO StudentAge;
alter table Students drop column Gender;

-- Data Manipulation Language (DML)
insert into Students(StudentID, FirstName, LastName, StudentAge) values(1, 'John', 'Doe', 25);
select * from Students;
update Students set StudentAge = 26 where StudentID = 1;
delete from Students where StudentID = 1;
insert into Students (StudentID, FirstName, LastName, StudentAge)
values
(1, 'John', 'Doe', 26),
(2, 'eesha', 'Smith', 22),
(3, 'sai', 'charan', 16),
(4, 'rohit', 'Sharma', 19),
(5, 'Anu', 'Wilson', 27);
update Students set FirstName = 'Smith' where FirstName = 'John';
delete from Students where StudentAge < 18;
create table Courses(CourseID int ,CourseName VARCHAR(100),Instructor VARCHAR(100));
insert into Course(CourseID, CourseName, Instructor) values(1, 'Mathematics', 'Professor X');
update Courses set Instructor = 'Professor Y' where CourseID = 1;
delete from Courses where CourseID = 1;
truncate table Students;
drop table courses;
-- Retrieval
select * from Students;
select FirstName, LastName from Students;
select distinct  LastName from Students;
select * from Students where StudentAge >= 20;
select * from Students where LastName like 'S%';
select * from Students where FirstName like '%a%';
select * from  Students order by StudentAge DESC;
select COUNT(*) as Student_Count from Students;
select StudentAge, COUNT(*) as Student_Count from Students group by StudentAge;
select avg(StudentAge)as Average_Age from Students;
select * from Students order by StudentAge ASC;
select * from Students order by StudentAge DESC;
select * from Students order by StudentAge DESC LIMIT 5;
select * from Students order by StudentAge ASC LIMIT 10;
select * from Students where StudentAge between 20 and 30;
select count(*) as Student_Count from Students;
select count(*) as Course_Count from Courses;
select avg(StudentAge) as Average_Age from Students;
select max(StudentAge) as Maximum_Age from Students;
select min(StudentAge) as Minimum_Age from Students;
select studentage, count(*) as student_count from students group by studentage;
select instructor, count(*) as course_count from courses group by instructor;
select c.coursename, avg(s.studentage) as average_age from students s join enrollments e on s.studentid = e.studentid 
join courses c on e.courseid = c.courseid group by c.coursename;
select c.coursename, max(s.studentage) as oldest_age from students s join enrollments e on s.studentid = e.studentid 
join courses c on e.courseid = c.courseid group by c.coursename;
select c.coursename, min(s.studentage) as youngest_age from students s join enrollments e on s.studentid = e.studentid 
join courses c on e.courseid = c.courseid group by c.coursename;
select gender, count(*) as student_count from students group by gender;
select count(*) as student_count from students where studentage < 25;
select count(*) as student_count from students where studentage between 20 and 30;
select avg(studentage) as average_age from students where lastname like 's%';
select count(*) as student_count from students where firstname like '%a%';













