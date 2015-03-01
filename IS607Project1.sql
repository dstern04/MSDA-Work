-- Database: "Enrollments"

-- DROP DATABASE "Enrollments";

CREATE DATABASE "Enrollments"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'C'
       LC_CTYPE = 'C'
       CONNECTION LIMIT = -1;

DROP TABLE IF EXISTS Students;

CREATE TABLE Students
(
  studentID serial PRIMARY KEY, 
  firstname varchar (30) NOT NULL,
  surname varchar (30) NOT NULL,
  programID int NOT NULL,
  accepted boolean,
  enrolledCourse int NULL
);

INSERT INTO Students (firstname,surname,programID,accepted,enrolledCourse) 

VALUES 
    ('Jim','Earp',3,TRUE,5),
    ('Lena','Izquiero',2,TRUE,2),
    ('Mikhail','Miller',5,FALSE,NULL),
    ('Sofia','Pauls',1,FALSE,NULL),
    ('Raylan','Bing',3,TRUE,17),
    ('Pietro', 'Calvino', 4,TRUE,7);

SELECT * FROM Students;

DROP TABLE IF EXISTS Programs;

CREATE TABLE Programs
(
  programID serial PRIMARY KEY, 
  name varchar (30) NOT NULL,
  location varchar (30) NOT NULL,
  capacity int NOT NULL
);

INSERT INTO Programs (name,location,capacity) 

VALUES 
    ('Oxford Tradition','Oxford, England',400),
    ('Cambridge Tradition','Cambridge, England',300),
    ('St. Andrews Academy','St. Andrews, Scotland',100),
    ('Academia de Espana','Salamanca, Spain',70),
    ('Academie de France','Montpellier, France',70);

SELECT * FROM Programs;

DROP TABLE IF EXISTS Courses;

CREATE TABLE Courses
(
  courseID serial PRIMARY KEY, 
  name varchar (30) NOT NULL,
  programID int NULL,
  capacity int NULL
);

INSERT INTO Courses (name,programID,capacity) 

VALUES 
    ('Medical Science',1,15),
    ('Psychology',2,15),
    ('Art History',3,15),
    ('Photography',1,15),
    ('Criminology',3,15),
    ('Gastronomie',5,15),
    ('France a travers les Ages',5,15),
    ('Taller Literario',4,15),
    ('Math and Nature',2,15),
    ('Psychologie',5,15),
    ('Biologia',4,15),
    ('Photographie',5,15),
    ('Retorica',4,15),
    ('International Law',2,15),
    ('International Relations',2,15),
    ('Speech and Debate',1,15),
    ('Golf',3,15);

SELECT * FROM Courses;

DROP TABLE IF EXISTS CourseAvailability;

CREATE TABLE CourseAvailability
(
  courseID serial PRIMARY KEY, 
  studentsEnrolled int NOT NULL
);

INSERT INTO CourseAvailability (studentsEnrolled) 

VALUES 
    (10),
    (8),
    (4),
    (12),
    (12),
    (1),
    (3),
    (11),
    (7),
    (4),
    (9),
    (15),
    (8),
    (9),
    (10),
    (2),
    (15);

 SELECT * FROM CourseAvailability;

 SELECT 
 S.studentID,
 S.firstname,
 S.surname,
 P.name AS Program,
 S.accepted,
 C.name AS Course
 FROM
 Students AS S
 LEFT JOIN
 Programs AS P
 ON S.programID = P.programID 
 LEFT JOIN
 Courses AS C
 ON S.enrolledCourse = C.courseID;

 SELECT 
 P.name AS Program,
 C.name AS Course,
 A.studentsEnrolled AS SeatsTaken,
 C.capacity AS Capacity
 FROM
 Programs AS P
 LEFT JOIN 
 Courses AS C
 ON C.programID = P.programID
 LEFT JOIN 
 CourseAvailability AS A
 ON A.courseID = C.courseID;