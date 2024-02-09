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
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
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
    PRIMARY KEY (customerID),
    FOREIGN KEY (systemID) REFERENCES GameSystems(systemID),
    FOREIGN KEY (customerEmail) REFERENCES CustomerAccounts(customerEmail)
);

INSERT INTO CustomerAccounts (customerEmail, first_name, last_name, customerDOB)
VALUES ('jonbovi@aol.com', 'Jon', 'Bovi', '1989-01-01'),
('cloud99@aol.com', 'Darcy', 'Wiggins', '1985-12-05'),
('dmenace@aol.com', 'Katy', 'Combs', '1996-03-28'),
('rssbob@aol.com', 'Shaun', 'Mitchell', '1976-04-04'),
('poohwin@aol.com', 'Nettie', 'Shannon', '2000-02-28');

INSERT INTO CustomerSales (saleID, systemID,)
VALUES (),
(),
(),
(),
();

INSERT INTO Employees ()
VALUES (),
(),
(),
(),
();

INSERT INTO GameSystems ()
VALUES (),
(),
(),
(),
();

INSERT INTO Lounges ()
VALUES (),
(),
(),
(),
();