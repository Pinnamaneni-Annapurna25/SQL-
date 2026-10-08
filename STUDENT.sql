USE college;
CREATE TABLE student (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(50),
    Student_Department VARCHAR(50)
);
INSERT INTO student
(Student_ID, Student_Name, Student_Department)
VALUES
(1, 'Ravi', 'CSE'),
(2, 'Priya', 'ECE'),
(3, 'Rahul', 'EEE'),
(4, 'Anu', 'CSE'),
(5, 'Kiran', 'IT');
-- to update
SELECT * FROM student;
UPDATE student
SET Student_Department = 'IT'
WHERE Student_ID = 16;
-- delete
DELETE FROM student
WHERE Student_ID = 11;
-- sort
SELECT * FROM student
ORDER BY Student_Name;
-- groupby
SELECT Student_Department, COUNT(*) AS Total_Students
FROM student
GROUP BY Student_Department;
-- creating another table
CREATE TABLE student_Marks(
    Student_ID INT,
    Marks INT
);
INSERT INTO student_marks (Student_ID, Marks)
VALUES
(1, 85),
(2, 90),
(3, 78),
(4, 88),
(5, 95),
(20, 70);
-- Join 
SELECT
    student.Student_ID,
    student.Student_Name,
    student.Student_Department,
    student_marks.Marks
FROM student
JOIN student_marks
ON student.Student_ID = student_marks.Student_ID;
-- left join
SELECT
    student.Student_ID,
    student.Student_Name,
    student.Student_Department,
    student_marks.Marks
FROM student
LEFT JOIN student_marks
ON student.Student_ID = student_marks.Student_ID;
-- right join
SELECT
    student.Student_ID,
    student.Student_Name,
    student.Student_Department,
    student_marks.Marks
FROM student
RIGHT JOIN student_marks
ON student.Student_ID = student_marks.Student_ID;
-- alter a table

