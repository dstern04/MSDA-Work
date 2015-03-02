-- Database: "Enrollments"

-- DROP DATABASE "Enrollments";

-- This database is drawn from my work experience - it demonstrates student enrollment in various study abroad programs. There are programs in a variety of locations, in the UK
-- France, and Spain. Each program offers multiple courses and some courses are offered on multiple programs. Students may only enroll in one course one on program.
-- This database will include information on enrollment status (in the Students table), course offerings and course availability (each in their own tables), and total student capacity
-- for each program (in the Programs table). Keeping enrollment data up-to-date is very important, as students can only enroll in courses and programs that still have availability.

-- The Students Table will include all students that applied, whether or not they were admitted. Students who haven't been accepted will not be enrolled in a course.

DROP TABLE IF EXISTS Students CASCADE;

CREATE TABLE Students
(
  studentID serial PRIMARY KEY, 
  firstname varchar (30) NOT NULL,
  surname varchar (30) NOT NULL,
  programID int NOT NULL references Programs(programID),
  accepted boolean,
  enrolledCourse int NULL,
  backUpCourse int NULL
);

INSERT INTO Students (firstname,surname,programID,accepted,enrolledCourse,backUpCourse) 

VALUES 
    ('Jim','Earp',3,TRUE,5,3),
    ('Lena','Izquiero',2,TRUE,2,15),
    ('Mikhail','Miller',5,FALSE,NULL,NULL),
    ('Sofia','Pauls',1,FALSE,NULL,NULL),
    ('Raylan','Bing',3,TRUE,17,5),
    ('Pietro', 'Calvino', 4,TRUE,8,12);

SELECT * FROM Students;

DROP TABLE IF EXISTS Programs CASCADE;

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

DROP TABLE IF EXISTS Courses CASCADE;

CREATE TABLE Courses
(
  courseID serial PRIMARY KEY, 
  name varchar (30) NOT NULL,
  programID int NULL references Programs(programID),
  capacity int NULL
);

INSERT INTO Courses (name,programID,capacity) 

VALUES 
    ('Medical Science',1,15),
    ('Psychology',2,15),
    ('Art History',3,15),
    ('Photography',1,15),
    ('Criminology',3,15),
    ('Medical Science',5,15),
    ('France a travers les Ages',5,15),
    ('Taller Literario',4,15),
    ('Math and Nature',2,15),
    ('Psychology',5,15),
    ('Biologia',4,15),
    ('Photography',5,15),
    ('Retorica',4,15),
    ('International Law',2,15),
    ('International Law',4,15),
    ('Speech and Debate',1,15),
    ('Golf',3,15);

SELECT * FROM Courses;

DROP TABLE IF EXISTS CourseAvailability CASCADE;

CREATE TABLE CourseAvailability
(
  courseID serial PRIMARY KEY references Courses(courseID), 
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

-- The following query will demonstrate a one-to-many relationship between students and courses. Each student will enroll in a course and have a backup class.

 SELECT 
 S.studentID,
 S.firstname,
 S.surname,
 P.name AS Program,
 S.accepted,
 C.name AS EnrolledCouse,
 B.name AS backUpCourse
 FROM
 Students AS S
 LEFT JOIN
 Programs AS P
 ON S.programID = P.programID 
 LEFT JOIN
 Courses AS C
 ON S.enrolledCourse = C.courseID
 LEFT JOIN Courses AS B
 ON S.backUpCourse = B.courseID;

-- The following statement demonstrates a many-to-many relationship. Each program contains multiple courses and each course may be offered on multiple programs.

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
 ON A.courseID = C.courseID
 ORDER BY Program;

-- The next query will return all of the courses on The Oxford Tradition:

 SELECT
 C.name AS Course,
 A.studentsEnrolled AS SeatsTaken,
 C.capacity AS Capacity
 FROM
 Courses AS C
 LEFT JOIN 
 CourseAvailability AS A
 ON A.courseID = C.courseID
 WHERE C.programID = 1;

 -- And this query will show all of the programs a particular course is offered on:

 SELECT
 P.name AS Program
 FROM
 Programs AS P
 LEFT JOIN 
 Courses AS C
 ON C.programID = P.programID
 WHERE C.name = 'Medical Science';