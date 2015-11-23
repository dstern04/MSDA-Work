
CREATE TABLE EnergyCategories (
id serial PRIMARY KEY,
type VARCHAR (255) 
);
INSERT INTO EnergyCategories 
(type)
VALUES 
('Fossil'),
('Renewable');
CREATE TABLE EnergyTypes (
id serial PRIMARY KEY,
type VARCHAR (255),
categoryID integer
);
INSERT INTO EnergyTypes
(type, categoryID)
VALUES
('Electricity', 1),
('Fuel Oil', 1),
('Gas', 1),
('Solar', 2),
('Steam', 1),
('Wind', 2);

SELECT EnergyCategories.type "energycategory", EnergyTypes.type "energytype" 
FROM EnergyCategories
LEFT JOIN EnergyTypes
ON EnergyTypes.categoryID = EnergyCategories.id

CREATE TABLE Buildings (
tower VARCHAR (255),
categoryID integer
);
INSERT INTO Buildings
(tower, categoryID)
VALUES
('Borough of Manhattan Community College', 4),
('Borough of Manhattan Community College', 1),
('Borough of Manhattan Community College', 5),
('Chrysler Building', 5),
('Chrysler Building', 1),
('Empire State Building', 1),
('Empire State Building', 5),
('Empire State Building', 3);

SELECT Buildings.tower "building", EnergyTypes.type "energytype" 
FROM Buildings
INNER JOIN EnergyTypes
ON EnergyTypes.id = Buildings.categoryID

