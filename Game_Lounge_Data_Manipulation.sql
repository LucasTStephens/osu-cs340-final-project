SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;


-- READ query for CustomerAccounts Table
SELECT firstName, lastName, customerEmail, customerDOB FROM CustomerAccounts;

-- CREATE query for CustomerAccounts Table
INSERT INTO CustomerAccount( customerEmail, firstName, lastName,customer DOB)  
VALUES (:emailInput, :fnameInput, :lnameInput, :DOBInput);

-- DELETE query from CustomerAccounts Table
DELETE FROM CustomerAccounts WHERE customerEmail = :customerEmail ;

-- UPDATE query from CustomerAccounts Table
SELECT firstName, lastName, customerEmail, customerDOB FROM CustomerAccounts WHERE customerEmail = :customerEmail;
UPDATE customerAccounts  
SET fname = :fnameInput, lname= :lnameInput, customerEmail = :customerEmailInput, customerDOB = :customerDOBInput WHERE customerEmai = :customerEmail;


-- READ query for CustomerSales Table
SELECT salesID, systemID, customerEmail, timeIn, timeOut FROM CustomerAccounts;

-- CREATE query for CustomerSales Table
INSERT INTO CustomerSales(systemID, customerEmail, timeIn, timeOut)  
VALUES (:systemID, :customerEmail, :timeIn, :timeOut);

-- DELETE query from CustomerSales Table
DELETE FROM CustomerSales WHERE saleID = :saleID;

-- UPDATE query from CustomerSales Table
SELECT saleID, systemID, customerEmail, timeIn, timeOut FROM CustomerAccounts WHERE saleID = :saleID;
UPDATE customerSales 
SET systemID = :systemIDInput, customerEmail = :customerEmailInput, timeIn = :timeInInput, timeOut = timeOutInput WHERE saleID = :saleIDInput;


-- READ query for Consoles Table
SELECT consoleID, consoleType FROM Consoles;

-- CREATE query for Consoles Table
INSERT INTO Consoles(consoleType)  
VALUES (:consoleType);

-- DELETE query from Consoles Table
DELETE FROM Consoles WHERE consoleID = :consoleIDInput;

-- UPDATE query from Consoles Table
SELECT saleID, systemID, customerEmail, timeIn, timeOut FROM Consoles WHERE saleID = :saleID;
UPDATE Consoles
SET consoleType =:consoleTypeInput WHERE consoleID = :consoleIDInput;


-- READ query for GameSystems Table
SELECT systemID, loungeID, inUse, systemType FROM GameSystems;

-- CREATE query for GameSystems Table
INSERT INTO GameSystems(loungeID, inUse, systemType)  
VALUES (:loungeID, :inUse, :systemType);

-- DELETE query from GameSystems Table
DELETE FROM GameSystems WHERE systemID = :systemIDInput;

-- UPDATE query from GameSystems Table
SELECT systemID, loungeID, inUse, systemType FROM GameSystems WHERE systemID = :systemID;
UPDATE GameSystems
SET loungeID = :loungeIDInput, inUse = :inUseInput, systemType = :systemTypeInput WHERE systemID = :systemIDInput;


-- READ query for Lounges Table
SELECT loungeID, loungeLimit, activeConsoles FROM Lounges;

-- CREATE query for Lounges Table
INSERT INTO Lounges(loungeLimit, activeConsoles)  
VALUES (:loungeLimit, :activeConsoles);

-- DELETE query from Lounges Table
DELETE FROM Lounges WHERE loungeID = :loungeIDInput;

-- UPDATE query from Lounges Table
SELECT loungeID, loungeLimit, activeConsoles FROM Lounges WHERE loungeID = :loungeID;
UPDATE Lounges
SET loungeLimit = :loungeLimitInput, activeConsoles = :activeConsolesInput WHERE loungeID =loungeIDInput;


-- READ query for LoungesEmployees Table
SELECT rentalInvoiceID, loungeID, employeeID, dateinfo FROM LoungesEmployees;

-- CREATE query for LoungesEmployees Table
INSERT INTO LoungesEmployees(loungeID, employeeID, dateinfo)  
VALUES (:loungeID, :employeeID, dateinfo);

-- DELETE query from LoungesEmployees Table
DELETE FROM LoungesEmployees WHERE rentalInvoiceID = :rentalInvoiceIDInput;

-- UPDATE query from LoungesEmployees Table
SELECT rentalInvoiceID, loungeID, employeeID, dateinfo FROM LoungesEmployees WHERE rentalInvoiceID = :rentalInvoiceID;
UPDATE LoungesEmployees
SET loungeID = :loungeIDInput, employeeID = :employeeIDInput, dateinfo = :dateinfoInput WHERE rentalInvoiceID = :rentalInvoiceIDInput;


-- READ query for Employees Table
SELECT employeeID, statusIn, position, hourlyWage FROM Employees;

-- CREATE query for Employees Table
INSERT INTO Employees(statusIn, position, hourlyWage)  
VALUES (:statusIn, :position, :hourlyWage);

-- DELETE query from Employees Table
DELETE FROM Employees WHERE employeeID = :employeeIDInput;

-- UPDATE query from Employees Table
SELECT employeeID, statusIn, position, hourlyWage FROM Employees WHERE employeeID = :employeeID;
UPDATE Employees
SET statusIn = :statusInInput, position = :positionInput, hourlyWage = :hourlyWageInput WHERE employeeID = :employeeIDInput;




SET FOREIGN_KEY_CHECKS=1;
COMMIT;