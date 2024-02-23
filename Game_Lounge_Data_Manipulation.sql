SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;


-- READ query for CustomerAccounts Table
SELECT firstName as "First Name", lastName as "Last Name", customerEmail as Email, customerDOB as "Date of Birth" FROM CustomerAccounts;

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
SELECT salesID as "Sale Order #", systemID as "Game System #", customerEmail as "Customer Email", timeIn as "Checked In", timeOut as "Checked Out" FROM CustomerAccounts;

-- CREATE query for CustomerSales Table
INSERT INTO CustomerSales(systemID, customerEmail, timeIn, timeOut)  
VALUES (:systemID_from_dropdown, :customerEmail_from_dropdown, :timeIn, :timeOut);

-- DELETE query from CustomerSales Table
DELETE FROM CustomerSales WHERE saleID = :saleID;

-- UPDATE query from CustomerSales Table
SELECT saleID, systemID, customerEmail, timeIn, timeOut FROM CustomerAccounts WHERE saleID = :saleID;
UPDATE customerSales 
SET systemID = :systemID_from_dropdown, customerEmail = :customerEmail_from_dropdown, timeIn = :timeInInput, timeOut = timeOutInput WHERE saleID = :saleIDInput;


-- READ query for Consoles Table
SELECT consoleID as "Game System #", consoleType as "Game Console Type" FROM Consoles;

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
SELECT systemID as "Game System #", loungeID as "Lounge #", inUse as "Rented?", systemType as "Game Console Type" FROM GameSystems;

-- CREATE query for GameSystems Table
INSERT INTO GameSystems(loungeID, inUse, systemType)  
VALUES (:loungeID_from_dropdown, :inUse, :systemType_from_dropdown);

-- DELETE query from GameSystems Table
DELETE FROM GameSystems WHERE systemID = :systemIDInput;

-- UPDATE query from GameSystems Table
SELECT systemID, loungeID, inUse, systemType FROM GameSystems WHERE systemID = :systemID;
UPDATE GameSystems
SET loungeID = :loungeID_from_dropdown, inUse = :inUseInput, systemType = :systemType_from_dropdown WHERE systemID = :systemIDInput;


-- READ query for Lounges Table
SELECT loungeID as "Lounge #" , loungeLimit as "Max Capacity", activeConsoles "Active Players" FROM Lounges;

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
SELECT rentalInvoiceID as "Rental Invoice #", loungeID as "Lounge #", employeeID as "Employee #", dateinfo as "Date" FROM LoungesEmployees;

-- CREATE query for LoungesEmployees Table
INSERT INTO LoungesEmployees(loungeID, employeeID, dateinfo)  
VALUES (:loungeID_from_dropdown, :employeeID_from_dropdown, dateinfo);

-- DELETE query from LoungesEmployees Table
DELETE FROM LoungesEmployees WHERE rentalInvoiceID = :rentalInvoiceIDInput;

-- UPDATE query from LoungesEmployees Table
SELECT rentalInvoiceID, loungeID, employeeID, dateinfo FROM LoungesEmployees WHERE rentalInvoiceID = :rentalInvoiceID;
UPDATE LoungesEmployees
SET loungeID = :loungeID_from_dropdown, employeeID = :employee_from_dropdown, dateinfo = :dateinfoInput WHERE rentalInvoiceID = :rentalInvoiceIDInput;


-- READ query for Employees Table
SELECT employeeID as "Employee #", statusIn as "Clocked In", position as "Title", hourlyWage as "Wage ($/hr)" FROM Employees;

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