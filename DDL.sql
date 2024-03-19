/*Group 111 SQL FILE
Authors: Lucas Stephens and Jesus Palapa*/

SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;
 
 /*Create tables for database*/
CREATE OR REPLACE TABLE Lounges (
    loungeID int(11) AUTO_INCREMENT,
    loungeLimit int(11) NOT NULL,
    activeConsoles int(11) NOT NULL,
    PRIMARY KEY (loungeID)
);

CREATE OR REPLACE TABLE Consoles (
    consoleID int(11) AUTO_INCREMENT,
    consoleType varchar(255) NOT NULL,
    PRIMARY KEY (consoleID)
);

CREATE OR REPLACE TABLE GameSystems (
    systemID int(11) AUTO_INCREMENT,
    loungeID int(11) NOT NULL,
    inUse boolean NOT NULL DEFAULT 0,
    systemType int(11) NOT NULL,
    PRIMARY KEY (systemID),
    FOREIGN KEY (loungeID) REFERENCES Lounges(loungeID) ON DELETE CASCADE,
    FOREIGN KEY (systemType) REFERENCES Consoles(consoleID) ON DELETE CASCADE
);

CREATE OR REPLACE TABLE CustomerAccounts (
    customerEmail varchar(255) NOT NULL,
    firstName varchar(255) NOT NULL,
    lastName varchar(255) NOT NULL,
    customerDOB date NOT NULL,
    PRIMARY KEY (customerEmail)
);

CREATE OR REPLACE TABLE Employees (
    employeeID int(11) NOT NULL AUTO_INCREMENT,
    statusIn boolean NOT NULL DEFAULT 0,
    position varchar(255) NOT NULL,
    hourlyWage decimal(5, 2),
    PRIMARY KEY (employeeID)
);

CREATE OR REPLACE TABLE CustomerSales (
    saleID int(11) AUTO_INCREMENT,
    systemID int(11) NOT NULL,
    customerEmail varchar(255) NOT NULL,
    timeIn datetime NOT NULL,
    timeOut datetime,
    PRIMARY KEY (saleID),
    FOREIGN KEY (systemID) REFERENCES GameSystems(systemID) ON DELETE CASCADE,
    FOREIGN KEY (customerEmail) REFERENCES CustomerAccounts(customerEmail) ON DELETE CASCADE
);

/*Intersection Table*/
CREATE OR REPLACE TABLE LoungesEmployees (
    rentalInvoiceID int(11) AUTO_INCREMENT,
    loungeID int(11) NOT NULL,
    employeeID int(11) NULL,
    dateinfo date NOT NULL,
    PRIMARY KEY (rentalInvoiceID),
    FOREIGN KEY (loungeID) REFERENCES Lounges(loungeID) ON DELETE CASCADE,
    FOREIGN KEY (employeeID) REFERENCES Employees(employeeID) ON DELETE SET NULL
);

/*Insert dummy variable into tables for database*/
INSERT INTO CustomerAccounts (customerEmail, firstName, lastName, customerDOB)
VALUES ('jonbovi@aol.com', 'Jon', 'Bovi', '1989-01-01'),
('cloud99@aol.com', 'Darcy', 'Wiggins', '1985-12-05'),
('dmenace@aol.com', 'Katy', 'Combs', '1996-03-28'),
('rssbob@aol.com', 'Shaun', 'Mitchell', '1976-04-04'),
('poohwin@aol.com', 'Nettie', 'Shannon', '2000-02-28');

INSERT INTO Employees (employeeID, statusIn, position, hourlyWage)
VALUES (1, 1, 'Manager', 25.50),
(2, 1, 'Lounge Worker', 20.00),
(3, 0, 'Lounge Worker', 20.00);

INSERT INTO Lounges (loungeID, loungeLimit, activeConsoles)
VALUES (1, 5, 2),
(2, 10, 2),
(3, 8, 1),
(4, 12, 0);

INSERT INTO Consoles(consoleID, consoleType)
VALUES (1, 'PS5'),
(2, 'XBOX'),
(3, 'PC'),
(4, 'Nintendo Switch'),
(5, 'Wii');

INSERT INTO GameSystems (systemID, loungeID, inUse, systemType)
VALUES (1, (SELECT loungeID FROM Lounges WHERE loungeID=1), 1,
(SELECT consoleID FROM Consoles WHERE consoleType='PS5')),
(2, (SELECT loungeID FROM Lounges WHERE loungeID=2), 1,
(SELECT consoleID FROM Consoles WHERE consoleType='XBOX')),
(3, (SELECT loungeID FROM Lounges WHERE loungeID=1), 0,
(SELECT consoleID FROM Consoles WHERE consoleType='PS5')),
(4, (SELECT loungeID FROM Lounges WHERE loungeID=2), 0,
(SELECT consoleID FROM Consoles WHERE consoleType='XBOX')),
(5, (SELECT loungeID FROM Lounges WHERE loungeID=3), 0,
(SELECT consoleID FROM Consoles WHERE consoleType='PC'));

INSERT INTO CustomerSales (systemID, customerEmail, timeIn, timeOut)
VALUES ((SELECT systemID FROM GameSystems WHERE systemID = 1), 
(SELECT customerEmail FROM CustomerAccounts WHERE customerEmail = 'jonbovi@aol.com'), 
'2024-02-08 11:00:00', NULL),
((SELECT systemID FROM GameSystems WHERE systemID = 2),
(SELECT customerEmail FROM CustomerAccounts WHERE customerEmail = 'cloud99@aol.com'),
'2024-02-08 15:00:00', '2024-02-08 19:00:00'),
((SELECT systemID FROM GameSystems WHERE systemID = 1),
(SELECT customerEmail FROM CustomerAccounts WHERE customerEmail = 'cloud99@aol.com'),
'2024-02-07 12:00:00', '2024-02-07 13:00:00');

/*Intersection Tabele Data*/
INSERT INTO LoungesEmployees (loungeID, employeeID, dateinfo)
VALUES ((SELECT loungeID FROM Lounges WHERE loungeID=1),
(SELECT employeeID FROM Employees WHERE employeeID=1),
'2024-02-08'),
((SELECT loungeID FROM Lounges WHERE loungeID=1),
(SELECT employeeID FROM Employees WHERE employeeID=1),
'2024-02-08'),
((SELECT loungeID FROM Lounges WHERE loungeID=3),
(SELECT employeeID FROM Employees WHERE employeeID=2),
'2024-02-08'),
((SELECT loungeID FROM Lounges WHERE loungeID=4),
(SELECT employeeID FROM Employees WHERE employeeID=3),
'2024-02-07');

SET FOREIGN_KEY_CHECKS=1;
COMMIT;
