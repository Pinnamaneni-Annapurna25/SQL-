Create database Employee_1;
CREATE TABLE Employee_1 (ID INT ,Name VARCHAR(50),Salary DECIMAL(10,2),Department VARCHAR(50));
    SELECT * FROM Employee_1;
ALTER TABLE Employee_1
ADD position VARCHAR(50);
ALTER TABLE Employee_1
RENAME COLUMN department TO dept_name;
CREATE TABLE department (department_id INT PRIMARY KEY,department_name VARCHAR(50));
ALTER TABLE Employee_1
DROP COLUMN position;
DROP TABLE Employee_1;
INSERT INTO Employee_1 (ID, Name, Salary, Dept_Name)
VALUES (101, 'John', 50000, 'IT');
UPDATE Employee_1
SET Salary = 55000
WHERE ID = 101;
DELETE FROM Employee_1
WHERE ID = 101;
INSERT INTO Employee_1 (ID, Name, Salary, Dept_Name)
VALUES
(102, 'James', 65000, 'IT'),
(103, 'David', 45000, 'HR'),
(104, 'Jennifer', 70000, 'Finance'),
(105, 'Robert', 35000, 'IT'),
(106, 'Joseph', 80000, 'HR');
UPDATE Employee_1
SET Dept_Name = 'HR'
WHERE ID > 0;
DELETE FROM Employee_1
WHERE Salary < 40000;
INSERT INTO Department (Department_ID, Department_Name)
VALUES (1, 'HR');
-- clauses
UPDATE Department
SET Department_Name = 'Human Resources'
WHERE Department_ID = 1;
DELETE FROM Department
WHERE Department_ID = 1;

SELECT * FROM Employee_1;
SELECT Name FROM Employee_1;
 SELECT MAX(Salary) AS Highest_Salary FROM Employee_1;
 SELECT AVG(Salary) AS Average_Salary FROM Employee_1 WHERE Dept_Name = 'IT';
 SELECT * FROM Employee_1 WHERE Salary > 60000;
 SELECT * FROM Employee_1 WHERE Name LIKE 'J%';
 SELECT * FROM Employee_1 ORDER BY Salary DESC; 
 SELECT e.ID,e.Name,e.Salary,e.Dept_Name,d.Department_ID,d.Department_Name
FROM Employee_1 AS e
INNER JOIN Department AS d ON e.Dept_Name = d.Department_Name;



    

    
 

 
 
 




