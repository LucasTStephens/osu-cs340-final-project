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

CREATE OR REPLACE TABLE Customers (
    customerID int(11) AUTO_INCREMENT,
    systemID int(11) NOT NULL,
    customerEmail varchar(255) NOT NULL,
    timeIn datetime NOT NULL,
    timeOut datetime NOT NULL,
    PRIMARY KEY (customerID),
    FOREIGN KEY (systemID) REFERENCES GameSystems(systemID),
    FOREIGN KEY (customerEmail) REFERENCES CustomerAccounts(customerEmail)
);

