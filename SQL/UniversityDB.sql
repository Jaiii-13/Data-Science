IF DB_ID('UniversityDB') IS NOT NULL
DROP DATABASE UniversityDB;
GO

CREATE DATABASE UniversityDB;
GO

USE UniversityDB;
GO

CREATE TABLE Departments
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);
GO

CREATE TABLE Students
(
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID)
    REFERENCES Departments(DepartmentID)
);
GO

CREATE TABLE Courses
(
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    StudentID INT,
    FOREIGN KEY (StudentID)
    REFERENCES Students(StudentID)
);
GO

SELECT * FROM Departments;
SELECT * FROM Students;
SELECT * FROM Courses;

INSERT INTO Departments VALUES
(1,'Computer Science'),
(2,'Electronics'),
(3,'Mechanical'),
(4,'Civil'),
(5,'Information Technology');

INSERT INTO Students VALUES
(101,'Alice Johnson',20,1),
(102,'Bob Smith',21,2),
(103,'Charlie Brown',22,1),
(104,'Diana Miller',19,3),
(105,'Ethan Davis',23,5);

INSERT INTO Courses VALUES
(201,'Artificial Intelligence',101),
(202,'Database Management',101),
(203,'Data Structures',103),
(204,'Machine Learning',103),
(205,'Digital Electronics',102),
(206,'Thermodynamics',104),
(207,'Data Analytics',105);

SELECT s.StudentID,
       s.Name,
       s.Age,
       d.DepartmentName
FROM Students s
INNER JOIN Departments d
ON s.DepartmentID = d.DepartmentID;

SELECT s.Name
FROM Students s
INNER JOIN Courses c
ON s.StudentID = c.StudentID
WHERE c.CourseName = 'Artificial Intelligence';

SELECT d.DepartmentName,
       COUNT(s.StudentID) AS TotalStudents
FROM Departments d
LEFT JOIN Students s
ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentName;

SELECT c.CourseName
FROM Courses c
INNER JOIN Students s
ON c.StudentID = s.StudentID
WHERE s.Name = 'Alice Johnson';

SELECT s.StudentID,
       s.Name,
       COUNT(c.CourseID) AS NumberOfCourses
FROM Students s
INNER JOIN Courses c
ON s.StudentID = c.StudentID
GROUP BY s.StudentID, s.Name
HAVING COUNT(c.CourseID) > 1;

SELECT d.DepartmentName,
       AVG(CAST(s.Age AS DECIMAL(10,2))) AS AverageAge
FROM Departments d
INNER JOIN Students s
ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentName;

SELECT TOP 1
       d.DepartmentName,
       COUNT(s.StudentID) AS StudentCount
FROM Departments d
INNER JOIN Students s
ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentName
ORDER BY StudentCount DESC;

SELECT s.StudentID,
       s.Name
FROM Students s
LEFT JOIN Courses c
ON s.StudentID = c.StudentID
WHERE c.CourseID IS NULL;

SELECT s.StudentID,
       s.Name,
       COUNT(c.CourseID) AS TotalCourses
FROM Students s
LEFT JOIN Courses c
ON s.StudentID = c.StudentID
GROUP BY s.StudentID, s.Name;

SELECT DISTINCT s.Name
FROM Students s
INNER JOIN Departments d
ON s.DepartmentID = d.DepartmentID
INNER JOIN Courses c
ON s.StudentID = c.StudentID
WHERE d.DepartmentName = 'Computer Science'
AND c.CourseName LIKE '%Data%';