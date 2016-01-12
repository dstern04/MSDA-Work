
CREATE TABLE EnergyCategories (
type VARCHAR (255) 
);
INSERT INTO EnergyCategories 
(type)
VALUES 
('Fossil'),
('Renewable')
SELECT * FROM EnergyCategories
CREATE TABLE EnergyTypes (
type VARCHAR (255)
);
INSERT INTO EnergyTypes
(type)
VALUES
('Electricity'),
('Fuel Oil'),
('Gas'),
('Solar'),
('Steam'),
('Wind');
