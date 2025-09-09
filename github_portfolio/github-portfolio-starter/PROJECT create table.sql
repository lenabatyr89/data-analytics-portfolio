use Northwind;
CREATE SCHEMA Lena;
--TABLE OF PROJECT STATUSES
CREATE TABLE Lena.ProjectStatuses (
	StatusId INT IDENTITY(1,1) PRIMARY KEY,
	StatusName NVARCHAR(255)
);

--TABLE OF THE TEAMS  WORKING ON PROJETS IN COMPANY
CREATE TABLE Lena.Teams(
	TeamId INT IDENTITY(1,1) PRIMARY KEY ,
	TeamName NVARCHAR(255),
	TeamLeader INT 
);

--TABLE OF EMLOYEES
CREATE TABLE Lena.Employees (
    EmployeesId INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(255),
    LastName NVARCHAR(255),
    DateOfHiring DATE,
    BirthDate DATE,
    Phone NVARCHAR(255),
    Email NVARCHAR(255) CHECK(Email LIKE '%@%'),
    TeamId INT FOREIGN KEY REFERENCES Lena.Teams(TeamId)
);

-- ADD NEW COLOMN TO THE TEAM TABLE
ALTER TABLE Lena.Teams
ADD CONSTRAINT
FK_Teams_TeamLeader FOREIGN KEY (TeamLeader)REFERENCES Lena.Employees(EmployeesId)
;

--TABLE OF PROJECTS
CREATE TABLE Lena.Projects (
    ProjectId INT IDENTITY(1,1) PRIMARY KEY,
    NameOfProject NVARCHAR(255),
    StartDate DATE,
    EndDate DATE,
    StatusId INT FOREIGN KEY REFERENCES Lena.ProjectStatuses(StatusId),
    ProjectType VARCHAR(10)	CHECK (ProjectType IN( 'WEB' , 'APP'))
);

--TABLE OF EMLOYEES WORKING ON PROJECTS
 CREATE TABLE Lena.ProjectAssignments(
	PRIMARY KEY (ProjectId, EmployeesId, TeamId),
	ProjectId INT FOREIGN KEY  REFERENCES Lena.Projects (ProjectId),
	EmployeesId INT FOREIGN KEY REFERENCES Lena.Employees(EmployeesId),
	TeamId INT FOREIGN KEY  REFERENCES Lena.Teams(TeamId),
	AssigneeDate DATE
);

-- TABLE OF THE DEVICES FOR TESTING
CREATE TABLE Lena.DevicesToTest(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	SerialNumber NVARCHAR(255),
	DeviceModel NVARCHAR(255),
	DeviceOSVersion INT,
	DeviceOS VARCHAR(10)CHECK (DeviceOS IN( 'ANDROID' , 'IOS')),
	ScreenSize INT,
	Resolution INT,
	EmployeesId INT FOREIGN KEY REFERENCES Lena.Employees(EmployeesId)	
);

-- INSERT DATE TO THE PROJECT STTSUS TABLE
INSERT INTO Lena.ProjectStatuses
VALUES('Characterization phase'),
    ('UI/UX'),
    ('Customer confirmation'),
    ('Developing'),
    ('Testing'),
    ('UAT'),
    ('Prod run'),
    ('Maintenance'),
    ('Close'),
    ('New version')
;
-- INSER DATE TO THE TEAMS TABLE
INSERT INTO Lena.Teams
VALUES 
    ('Designers', NULL),
    ('Product managers', NULL),
    ('Testers', NULL),
    ('WEB developers', NULL),
    ('IOS developers', NULL),
    ('Android developers', NULL),
    ('React native developers', NULL),
    ('BE developers', NULL)
;
--INSTART DATA TO THE EMPLOYEES TABLE
INSERT INTO Lena.Employees
VALUES 
    ('Elena', 'Kososnovsky', '2017-04-17', '1989-01-05', '0526517808', 'elena.kosonovsky@mintapp.co.il', 3),
    ('Eran', 'Geva', '2023-01-05', '1980-01-23', '0525692550', 'eran.geva@mintapp.co.il', 3),
    ('Meir', 'Ben Dor', '2020-01-28', '1990-02-28', '0526189735', 'meir.bendor@mintapp.co.il', 3),
    ('Gil', 'Bliman', '2015-03-24', '1986-03-27', '0522075158', 'gil.bliman@mintapp.co.il', 4),
    ('Raz', 'Cohen', '2019-05-29', '1991-04-02', '0523517808', 'raz.cohen@mintapp.co.il', 8),
    ('Lior', 'Shabo', '2014-01-01', '1983-05-30', '0525342792', 'lior.shabo@mintapp.co.il', 5),
    ('Alex', 'Fost', '2023-02-01', '1980-06-23', '0521245966', 'alex.fost@mintapp.co.il', 2),
    ('Ayana', 'Kovalsky', '2020-10-10', '1993-05-05', '0534578963', 'ayana.kovalsky@mintapp.co.il', 1),
    ('Noam', 'Amiran', '2014-01-01', '1983-06-07', '0532256981', 'noam.amiran@mintapp.co.il', 6),
    ('Maor', 'Hizkyahu', '2020-10-05', '1993-10-04', '05449865231', 'maor.hizkyahu@mintapp.co.il', 8),
    ('Ariel', 'Kitov', '2023-09-09', '1990-10-25', '0561245789', 'ariel.kitov@mintapp.co.il', 8),
    ('Mayan', 'Cohen', '2023-05-23', '1997-02-03', '0569865921', 'mayan.cohen@mintapp.co.il', 8),
    ('Amiti', 'Maimon', '2022-09-10', '1986-03-27', '0561245896', 'amiti.maimon@mintapp.co.il', 3),
    ('Tal', 'Talmond', '2023-10-23', '1990-10-23', '0523568963', 'tal.talmond@mintapp.co.il', 7),
    ('Pier', 'Ari', '2025-01-01', '1999-01-02', '0524455698', 'pier.ari@mintapp.co.il', 5),
    ('Akborn', 'Achmatov', '2023-01-10', '1998-10-25', '00998903347377', 'akborn.achmatov@mintapp.co.il', 6),
    ('Temor', 'Juraev', '2022-02-03', '1998-11-06', '00998881222332', 'temur.juraev@mintapp.co.il', 5),
    ('Sarvar', 'Abdurahimov', '2024-10-24', '1997-10-23', '00998123696545', 'sarvar.abdurahimov@mintapp.co.il', 7),
    ('Daniel', 'Azar', '2023-10-05', '2000-10-10', '0526396895', 'daniel.azar@mintapp.co.il', 1),
    ('Raz', 'Hanuka', '2022-02-15', '1995-12-12', '0523366985', 'raz.hanuka@mintapp.co.il', 1),
    ('Shachar', 'Nasi', '2023-05-06', '1997-03-25', '0524489654', 'shachar.nasi@mintapp.co.il', 1),
    ('Sagi', 'Ohayon', '2022-10-06', '1988-03-20', '0544859562', 'sagi.ohayon@mintapp.co.il', 2),
    ('Adi', 'Cohen Naiss', '2022-03-05', '1990-10-14', '0533696589', 'adi.cohennaiss@mintapp.co.il', 2),
    ('Oren', 'Regev', '2020-02-15', '1983-09-12', '0526699859', 'oren.regev@mintapp.co.il', 2),
    ('Max', 'Gleizer', '2022-03-04', '1990-10-10', '0544789596', 'max.gleizer@mintapp.co.il', 2),
    ('Rotem', 'Shoshany Shamia', '2023-02-01', '1990-10-23', '0522145963', 'rotem.shoshanyshamia@mintapp.co.il', 2)
;

-- UPDATE ID OF TEAM LEADR IN TEMS TABLE AFTER CRATING HE EMPLOYEES TABLE
UPDATE Lena.Teams
SET TeamLeader = CASE 
                    WHEN TeamName = 'Designers' THEN 8 
                    WHEN TeamName = 'Product managers' THEN 2 
                    WHEN TeamName = 'Testers' THEN 13 
                    WHEN TeamName = 'WEB developers' THEN 4 
                    WHEN TeamName = 'IOS developers' THEN 5 
                    WHEN TeamName = 'Android developers' THEN 6
                    WHEN TeamName = 'React native developers' THEN 7
                    WHEN TeamName = 'BE developers' THEN 8 
                    ELSE TeamLeader
                END;


--INSTER DATA TO PROJECTS TABEL
INSERT INTO Lena.Projects
VALUES ('Histadrut', '2019-10-10', NULL, 4, 'APP'),
		('Coca Cola','2020-01-02', NULL, 10, 'APP'),
		('Eldan', '2023-03-05', NULL, 10, 'WEB'),
		('Eldan App', '2024-10-10', '2025-01-01', 8, 'APP'),
		('Toyota', '2022-12-12', '2024-05-23', 9, 'APP'),
		('Geely', '2022-10-10', '2025-02-02', 9, 'WEB'),
		('Shtrauss', '2015-01-25', NULL, 5, 'APP'),
		('Paz App', '2015-01-01', NULL, 10, 'APP'),
		('Paz Corporate', '2024-01-03', '2025-03-12', 7, 'WEB'),
		('Central Park App', '2023-03-26', NULL, 6, 'APP'),
		('Central Park Web', '2024-02-23', '2024-12-12', 8, 'WEB'),
		('Ashturm', '2023-10-08', '2025-03-15', 8, 'WEB'),
		('Hfd', '2024-01-15', '2024-12-12', 8, 'APP'),
		('Mada', '2024-09-10', NULL, 6, 'APP'),
		('Tidhar', '2024-10-10', NULL, 7, 'APP'),
		('Mazda', '2018-02-14', '2024-01-01', 8, 'WEB'),
		('Delek App', '2025-01-01', NULL, 3, 'APP'),
		('Eged' ,'2025-02-25', NULL, 2, 'WEB'),
		('Band Hapoalim', '2024-12-12', NULL, 1, 'WEB'),
		('Rustic', '2024-10-15', NULL, 4, 'WEB'),
		('Macabiah App', '2025-01-01', NULL, 4, 'APP'),
		('Makabiah Web', '2025-01-01', NULL, 5, 'WEB'),
		('Bye Me', '2019-10-10', NULL, 3, 'APP')
;

--INSERT DATA TO EMLOYEES WORKING ON PROJECTS TABLE
INSERT INTO Lena.ProjectAssignments 
VALUES   (1, 1, 3, '2019-10-10'),
    (1, 20, 5, '2019-10-10'),
    (1, 16, 6, '2019-10-10'), 
    (1, 19, 2, '2019-10-10'), 
    (1, 24, 2, '2019-10-10'),
	(1, 5, 8, '2019-10-10'),
	(2, 1, 3, '2020-01-02'),
    (2, 20, 5, '2020-01-02'),
    (2, 14, 7, '2020-01-02'),
    (2, 16, 6, '2020-01-02'),
    (2, 10, 8, '2020-01-02'),
    (2, 19, 2, '2020-01-02'), 
    (2, 18, 2, '2020-01-02'),
    (3, 2, 3, '2023-03-05'),
    (3, 21, 2, '2023-03-05'),
    (3, 4, 4, '2023-03-05'),
    (3, 10, 8, '2023-03-05'),
    (3, 17, 1, '2023-03-05'),
    (4, 2, 3, '2024-10-10'),
    (4, 21, 2, '2024-10-10'),
    (4, 18, 7, '2024-10-10'),
    (4, 17, 1, '2024-10-10'),
    (5, 1, 3, '2015-01-25'),
    (5, 19, 2, '2015-01-25'),
    (5, 20, 5, '2015-01-25'),
    (5, 14, 7, '2015-01-25'),
    (5, 16, 6, '2015-01-25'),
    (5, 9, 6, '2015-01-25'),
    (5, 22, 1, '2015-01-25'),
    (6, 3, 3, '2015-01-01'),
    (6, 24, 2, '2015-01-01'),
    (6, 9, 6, '2015-01-01'),
    (6, 13, 7, '2015-01-01'),
    (6, 6, 5, '2015-01-01'),
    (6, 16, 6, '2015-01-01'),
    (6, 14, 7, '2015-01-01'),
    (7, 24, 2, '2024-01-03'),
    (7, 4, 4, '2024-01-03'),
    (8, 2, 3, '2023-03-26'),
    (8, 24, 2, '2023-03-26'),
    (8, 17, 1, '2023-03-26'),
    (8, 18, 7, '2023-03-26'),
    (9, 2, 3, '2024-02-23'),
    (9, 4, 4, '2024-02-23'),
    (9, 24, 2, '2024-02-23'),
    (9, 17, 1, '2024-02-23'),
    (10, 4, 4, '2023-10-08'),
    (10, 12, 3, '2023-10-08'),
    (11, 19, 2, '2024-01-15'),
    (11, 5, 8, '2024-01-15'),
    (12, 19, 2, '2024-09-10'),
    (12, 22, 1, '2024-09-10'),
    (12, 8, 8, '2024-09-10'),
    (12, 3, 3, '2024-09-10'),
    (13, 1, 3, '2024-10-10'),
    (13, 21, 2, '2024-10-10'),
    (13, 5, 8, '2024-10-10'),
    (13, 18, 7, '2024-10-10'),
    (13, 13, 7, '2024-10-10'),
    (14, 4, 4, '2018-02-14'),
    (14, 24, 2, '2018-02-14'),
    (14, 1, 3, '2018-02-14'),
    (14, 5, 8, '2018-02-14'),
    (15, 18, 7, '2025-01-01'),
    (15, 1, 3, '2025-01-01'),
    (15, 10, 8, '2025-01-01'),
    (16, 18, 7, '2025-02-25'),
    (16, 4, 4, '2025-02-25'),
    (17, 8, 5, '2024-10-15'),
    (17, 21, 2, '2024-10-15'),
    (18, 18, 7, '2025-01-01'),
    (18, 13, 7, '2025-01-01'),
    (18, 19, 2, '2025-01-01'),
    (18, 5, 8, '2025-01-01'),
    (19, 4, 4, '2025-01-01'),
    (19, 13, 7, '2025-01-01'),
    (19, 18, 7, '2025-01-01'),
    (19, 19, 2, '2025-01-01'),
    (19, 5, 8, '2025-01-01'),
    (20, 1, 3, '2019-10-10'),
    (20, 9, 6, '2019-10-10'),
    (20, 6, 5, '2019-10-10'),
    (20, 18, 7, '2019-10-10')
;

--INSERT DATA TO DEVICE TABLE
INSERT INTO Lena.DevicesToTest 
VALUES  ('SN12345', 'Samsung S23', 14, 'ANDROID', 6.1, 1080, 1),
    ('SN12346', 'iPhone 12 Pro', 15, 'IOS', 6.1, 1125, 1),
    ('SN12347', 'Samsung A54', 13, 'ANDROID', 6.4, 1080, 2),
    ('SN12348', 'iPhone 14', 16, 'IOS', 6.1, 1200, 2),
    ('SN12349', 'Google Pixel 7', 14, 'ANDROID', 6.3, 1080, 3),
    ('SN12350', 'iPhone 13', 15, 'IOS', 6.1, 1280, 3),
    ('SN12351', 'Samsung Galaxy Z Fold 5', 12, 'ANDROID', 7.6, 2208, 1), 
    ('SN12352', 'iPhone 12', 14, 'IOS', 6.1, 1125, 2),
    ('SN12353', 'OnePlus 11', 16, 'ANDROID', 6.7, 1200, 3),
    ('SN12354', 'iPhone SE', 13, 'IOS', 4.7, 750, 1)
;



