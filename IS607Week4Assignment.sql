-- Partial Organizational Chart of the US Department of Justice
-- Official Reference: http://www.justice.gov/agencies/chart

DROP TABLE IF EXISTS DOJemployees;

CREATE TABLE DOJemployees
(
  employeeID serial PRIMARY KEY, 
  name varchar (30) NOT NULL,
  title varchar (255) NOT NULL,
  overseerID int NULL
);

INSERT INTO DOJemployees (name,title,overseerID) 
VALUES 
    ('Eric Holder', 'Attorney General', NULL),
    ('Sally Quillian Yates', 'Deputy Attorney General', 1),
    ('Donald B. Verilli, Jr.', 'Solicitor General', 2),
    ('Tony West', 'Associate Attorney General', 2),
    ('James B. Comey', 'FBI Director', 2),
    ('Michele Leonhart', 'DEA Administrator', 2),
    ('Michael E. Horowitz', 'Inspector General', 2),
    ('Charles E. Samuels, Jr.', 'Director of Bureau of Prisons', 2),
    ('Preet Bharara', 'US Attorney for the Southern District of NY', 2),
    ('Stuart F. Delery', 'Civil Division', 4),
    ('William Baer', 'Antitrust', 4),
    ('Richard B. Zabel', 'Deputy US Attorney for the Southern District of NY', 9),
    ('Joon H. Kim', 'Chief of Criminal Division, Southern District of NY', 12),
    ('Sara L. Shudofsky', 'Chief of Civil Division, Southern District of NY', 12);

SELECT * FROM DOJemployees;

SELECT 
Employee.name AS "Employee",
Employee.title AS "Title",
Boss.name AS "Boss",
Boss.title AS "Boss Title"
FROM DOJemployees AS Employee
LEFT JOIN DOJemployees AS Boss
ON Employee.overseerid = Boss.employeeid
ORDER BY Employee.employeeid;
