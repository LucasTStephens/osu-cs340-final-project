CREATE OR REPLACE TABLE Lounges (
    loungeID int(11) AUTO_INCREMENT,
    loungeLimit int(11) NOT NULL,
    activeConsoles int(11) NOT NULL,
    PRIMARY KEY (loungeID)
);

CREATE OR REPLACE TABLE GameSystems (
    systemID int(11) AUTO_INCREMENT,
    loungeID int(11) NOT NULL,
    inUse boolean NOT NULL DEFAULT 0,
    consoleType varchar(255) NOT NULL,
    PRIMARY KEY (systemID),
    FOREIGN KEY (loungeID) REFERENCES Lounges(loungeID)
);

CREATE OR REPLACE TABLE CustomerAccounts (
    customerEmail varchar(255) NOT NULL,
    firstName varchar(255) NOT NULL,
    lastName varchar(255) NOT NULL,
    customerDOB date NOT NULL,
    PRIMARY KEY (customerEmail)
);

CREATE OR REPLACE TABLE Employees (
    employeeID int(11) AUTO_INCREMENT,
    statusIn boolean NOT NULL DEFAULT 0,
    position varchar(255) NOT NULL,
    hourlyWage decimal(3, 2),
    PRIMARY KEY (employeeID)
);

CREATE OR REPLACE TABLE CustomerSales (
    saleID int(11) AUTO_INCREMENT,
    systemID int(11) NOT NULL,
    customerEmail varchar(255) NOT NULL,
    timeIn datetime NOT NULL,
    timeOut datetime,
    PRIMARY KEY (saleID),
    FOREIGN KEY (systemID) REFERENCES GameSystems(systemID),
    FOREIGN KEY (customerEmail) REFERENCES CustomerAccounts(customerEmail)
);

CREATE OR REPLACE TABLE Lounges_Employees (
    rentalInvoiceID int(11) AUTO_INCREMENT,
    loungeID int(11) NOT NULL,
    employeeID int(11) NOT NULL,
    dateinfo date NOT NULL,
    PRIMARY KEY (rentalInvoiceID),
    FOREIGN KEY loungeID REFERENCES Lounges(loungeID),
    FOREIGN KEY employeeID REFERENCES Employees(employeeID)
);

INSERT INTO CustomerAccounts (customerEmail, firstName, lastName, customerDOB)
VALUES ('jonbovi@aol.com', 'Jon', 'Bovi', '1989-01-01'),
('cloud99@aol.com', 'Darcy', 'Wiggins', '1985-12-05'),
('dmenace@aol.com', 'Katy', 'Combs', '1996-03-28'),
('rssbob@aol.com', 'Shaun', 'Mitchell', '1976-04-04'),
('poohwin@aol.com', 'Nettie', 'Shannon', '2000-02-28');

INSERT INTO CustomerSales (systemID, customerEmail, timeIn, timeOut)
VALUES (1, 'jonbovi@aol.com', '2024-02-08 11:00:00', NULL),
(2, 'cloud99@aol.com', '2024-02-08 15:00:00', '2024-02-08 19:00:00'),
(1, 'cloud99@aol.com', '2024-02-07 12:00:00', '2024-02-07 13:00:00');

INSERT INTO GameSystems (loungeID, inUse, consoleType)
VALUES (1, 1, 'PS5'),
(2, 1, 'XBOX'),
(1, 0, 'PS5'),
(2, 0, 'XBOX'),
(3, 0, 'PC');

INSERT INTO Employees (statusIn, position, hourlyWage)
VALUES (1, 'Manager', 25.50),
(1, 'Lounge Worker', 20.00),
(0, 'Lounge Worker', 20.00);

INSERT INTO Lounges (loungeLimit, activeConsoles)
VALUES (5, 2),
(10, 2),
(8, 1),
(12, 0);

INSERT INTO Lounges_Employees (loungeID, employeeID, dateinfo)
VALUES (1, 1, '2024-02-08'),
(1, 1, '2024-02-08'),
(3, 2, '2024-02-08'),
(4, 3, '2024-02-08');
