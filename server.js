var path = require('path')
var express = require('express')
var exphbs = require('express-handlebars')
const mysql = require("mysql")
const dotenv = require('dotenv')

// Set up modules for serving
var app = express()

app.use(express.urlencoded({extended: 'false'}))
app.use(express.static(path.join(__dirname, 'static')))
app.use(express.json())

app.engine("handlebars", exphbs.engine({defaultLayout: null}))
app.set("view engine", "handlebars")

dotenv.config({ path: './.env'})

// Create database connection with credentials in .env
const db = mysql.createConnection({
    host: process.env.DATABASE_HOST,
    user: process.env.DATABASE_USER,
    password: process.env.DATABASE_PASSWORD,
    database: process.env.DATABASE
})

// output if connection was successful
db.connect((error) => {
    if(error) {
        console.log(error)
    } else {
        console.log("MySQL connected!")
    }
})

// functions for serving index
app.get("/", function(req, res){
    res.status(200).render("index")
});

app.get("/index", function(req, res){
    res.status(200).render("index")
});


// CUSTOMERACCOUNTS in order: READ, CREATE, UPDATE, DELETE
app.get("/customerAccounts", (req, res) => {
    db.query('SELECT firstName as "First Name", lastName as "Last Name", customerEmail as Email, customerDOB as "Date of Birth" FROM CustomerAccounts', async (error, ress) => {
        if(error){
            console.log(error)
        }
        if( ress.length > 0 ) {
            console.log(ress)
            return res.render('customerAccounts', {
                tableData: ress,
                message: 'Account info retrieved'
            })
        }
    })
});

app.post("/customerAccounts/create", (req, res) => {
    const email = req.body['email'];
    const fname = req.body['first-name'];
    const lname = req.body['last-name'];
    const dob = req.body['date-of-birth'];
    db.query('INSERT INTO CustomerAccounts (customerEmail, firstName, lastName,customerDOB) VALUES (?, ?, ?, ?)', [email, fname, lname, dob], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/customerAccounts');
        }
    })
});

app.post("/customerAccounts/update", (req, res) => {
    const email = req.body['email'];
    const fname = req.body['first-name'];
    const lname = req.body['last-name'];
    const dob = req.body['date-of-birth'];
    db.query('UPDATE CustomerAccounts SET firstName = ?, lastName= ?, customerDOB = ? WHERE customerEmail = ?', [fname, lname, dob, email], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/customerAccounts');
        }
    })
});

app.post("/customerAccounts/delete", (req, res) => {
    const email = req.body['email'];
    db.query('DELETE FROM CustomerAccounts WHERE customerEmail = ?', [email], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/customerAccounts');
        }
    })
});

// CUSTOMERSALES in order: READ, CREATE, UPDATE, DELETE
app.get("/customerSales", (req, res) => {
    db.query('SELECT saleID as "Sale Order #", systemID as "Game System #", customerEmail as "Customer Email", timeIn as "Checked In", timeOut as "Checked Out" FROM CustomerSales', async (error, ress) => {
        db.query('SELECT GameSystems.systemID as "Game System #" FROM GameSystems ORDER BY GameSystems.systemID ASC', async (error, resss) => {
            db.query('SELECT CustomerAccounts.customerEmail as "Customer Email" FROM CustomerAccounts ORDER BY CustomerAccounts.customerEmail ASC', async (error, ressss) => {
            if(error){
            console.log(error)
        }
        if( ress.length > 0 ) {
            console.log(ress)
            return res.render('customerSales', {
                tableData: ress,
                tableData2: resss,
                tableData3: ressss,
                message: 'Account info retrieved'
            })
        }
    })
})})});

app.post("/customerSales/create", (req, res) => {
    const systemID = req.body['systemID'];
    const email = req.body['email'];
    const timein = req.body['timein'];
    const timeout = req.body['timeout'];
    db.query('INSERT INTO CustomerSales(systemID, customerEmail, timeIn, timeOut) VALUES (?, ?, ?, ?)', [systemID, email, timein, timeout], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/customerSales');
        }
    })
});

app.post("/customerSales/update", (req, res) => {
    const systemID = req.body['systemID'];
    const email = req.body['email'];
    const timein = req.body['timein'];
    const timeout = req.body['timeout'];
    const saleID = req.body['saleID'];
    db.query('UPDATE CustomerSales SET systemID = ?, customerEmail = ?, timeIn = ?, timeOut = ? WHERE saleID = ?', [systemID, email, timein, timeout, saleID], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/customerSales');
        }
    })
});

app.post("/customerSales/delete", (req, res) => {
    const saleID = req.body['saleID'];
    db.query('DELETE FROM CustomerSales WHERE saleID = ?', [saleID], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/customerSales');
        }
    })
});


// CONSOLES in order: READ, CREATE, UPDATE, DELETE
app.get("/consoles", (req, res) => {
    db.query('SELECT consoleID as "Game System #", consoleType as "Game Console Type" FROM Consoles', async (error, ress) => {
        if(error){
            console.log(error)
        }
        if( ress.length > 0 ) {
            console.log(ress)
            return res.render('consoles', {
                tableData: ress,
                message: 'Account info retrieved'
            })
        }
    })
});

app.post("/consoles/create", (req, res) => {
    const consoleType = req.body['consoleType'];
    db.query('INSERT INTO Consoles(consoleType) VALUES (?)', [consoleType], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/consoles');
        }
    })
});

app.post("/consoles/update", (req, res) => {
    const consoleType = req.body['consoleType'];
    const consoleID = req.body['consoleID'];
    db.query('UPDATE Consoles SET consoleType = ? WHERE consoleID = ?', [consoleType, consoleID], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/consoles');
        }
    })
});

app.post("/consoles/delete", (req, res) => {
    const consoleID = req.body['consoleID'];
    db.query('DELETE FROM Consoles WHERE consoleID = ?', [consoleID], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/consoles');
        }
    })
});

// EMPLOYEES in order: READ, CREATE, UPDATE, DELETE
app.get("/employees", (req, res) => {
    db.query('SELECT employeeID as "Employee #", statusIn as "Clocked In", position as "Title", hourlyWage as "Wage ($/hr)" FROM Employees', async (error, ress) => {
        if(error){
            console.log(error)
        }
        if( ress.length > 0 ) {
            for (let i = 0; i < ress.length; i++) {
                if (ress[i]['Clocked In'] == 1) {
                    ress[i]['Clocked In'] = 'Yes'
                }
                else {
                    ress[i]['Clocked In'] = 'No'
                }
            }
            return res.render('employees', {
                tableData: ress,
                message: 'Account info retrieved'
            })
        }
    })
});

app.post("/employees/create", (req, res) => {
    let statusin = req.body['statusin'];
    const position = req.body['position'];
    const hourlywage = req.body['hourlywage'];
    if (statusin === 'Yes') {
        statusin = '1'
    }
    if (statusin === 'No') {
        statusin = '0'
    } 
    db.query('INSERT INTO Employees(statusIn, position, hourlyWage) VALUES (?, ?, ?)', [statusin, position, hourlywage], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/employees');
        }
    })
});

app.post("/employees/update", (req, res) => {
    const employeeID = req.body['employeeID'];
    let statusin = req.body['statusin'];
    const position = req.body['position'];
    const hourlywage = req.body['hourlywage'];
    if (statusin === 'Yes') {
        statusin = '1'
    }
    if (statusin === 'No') {
        statusin = '0'
    } 
    db.query('UPDATE Employees SET statusIn = ?, position = ?, hourlyWage = ? WHERE employeeID = ?', [statusin, position, hourlywage, employeeID], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/employees');
        }
    })
});

app.post("/employees/delete", (req, res) => {
    const employeeID = req.body['employeeID'];
    db.query('DELETE FROM Employees WHERE employeeID = ?', [employeeID], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/employees');
        }
    })
});

// GAMESYSTEMS in order: READ, CREATE, UPDATE, DELETE
app.get("/gameSystems", (req, res) => {
    db.query('SELECT GameSystems.systemID as "Game System #", GameSystems. loungeID as "Lounge #", GameSystems.inUse as "Rented?", Consoles.consoleType as "Game Console Type" FROM GameSystems INNER JOIN Consoles ON GameSystems.systemType = Consoles.consoleID;', async (error, ress) => {
        db.query('SELECT Consoles.consoleType as "Game Console Type" FROM Consoles ORDER BY Consoles.consoleType ASC;', async (error, resss) => {
            db.query('SELECT loungeID as "Lounge #" FROM Lounges ORDER BY Lounges.loungeID ASC', async (error, ressss) => { 
            if(error){
            console.log(error)
        }
        if( ress.length > 0 ) {
            // changes bool values to true/false
            for (let i = 0; i < ress.length; i++) {
                if (ress[i]['Rented?'] == 1) {
                    ress[i]['Rented?'] = 'Yes'
                }
                else {
                    ress[i]['Rented?'] = 'No'
                }
            }
            console.log(ress)
            console.log(resss)
            console.log(ressss)
            return res.render('gameSystems', {
                tableData: ress,
                tableData2: resss,
                tableData3: ressss,
                message: 'Account info retrieved'
            })
        }
    })
})})});

app.post("/gamesystems/create", (req, res) => {
    const loungeID = req.body['loungeID'];
    let inUse = req.body['inUse'];
    const systemType = req.body['systemType'];
    if (inUse === 'Yes') {
        inUse = '1'
    }
    if (inUse === 'No') {
        inUse = '0'
    }
    db.query('SELECT Consoles.consoleID FROM Consoles WHERE consoleType =  (?)', [systemType], async (error, resss) => {
           const systemID = String(resss[0]["consoleID"])
        db.query('INSERT INTO GameSystems(loungeID, inUse, systemType) VALUES (?, ?, ?)', [loungeID, inUse, systemID], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/gamesystems');
        }
    })
})});

app.post("/gamesystems/update", (req, res) => {
    const systemID = req.body['systemID'];
    const loungeID = req.body['loungeID'];
    let inUse = req.body['inUse'];
    const systemType = req.body['systemType'];
    if (inUse === 'Yes') {
        inUse = '1'
    }
    if (inUse === 'No') {
        inUse = '0'
    }
    db.query('SELECT Consoles.consoleID FROM Consoles WHERE consoleType =  (?)', [systemType], async (error, resss) => {
        const systemType2 = String(resss[0]["consoleID"])
        db.query('UPDATE GameSystems SET loungeID = ?, inUse = ?, systemType = ? WHERE systemID = ?', [loungeID, inUse, systemType2, systemID], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/gamesystems');
        }
    })
})});

app.post("/gamesystems/delete", (req, res) => {
    const systemID = req.body['systemID'];
    db.query('DELETE FROM GameSystems WHERE systemID = ?', [systemID], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/gamesystems');
        }
    })
});

// LOUNGES_EMPLOYEES in order: READ, CREATE, UPDATE, DELETE
app.get("/Lounges_Employees", (req, res) => {
    db.query('SELECT rentalInvoiceID as "Rental Invoice #", loungeID as "Lounge #", employeeID as "Employee #", dateinfo as "Date" FROM LoungesEmployees', async (error, ress) => {
        db.query('SELECT loungeID as "Lounge #" FROM Lounges ORDER BY Lounges.loungeID ASC', async (error, resss) => { 
            db.query('SELECT employeeID as "Employee #" FROM Employees ORDER BY Employees.employeeID ASC', async (error, ressss) => { 
        if(error){
            console.log(error)
        }
        if( ress.length > 0 ) {
            console.log(ress)
            return res.render('Lounges_Employees', {
                tableData: ress,
                tableData2: resss,
                tableData3: ressss,
                message: 'Account info retrieved'
            })
        }
    })
})})});

app.post("/Lounges_Employees/create", (req, res) => {
    const loungeID = req.body['loungeID'];
    const employeeID = req.body['employeeID'];
    const dateinfo = req.body['dateinfo'];
    db.query('INSERT INTO LoungesEmployees(loungeID, employeeID, dateinfo) VALUES (?, ?, ?)', [loungeID, employeeID, dateinfo], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/Lounges_Employees');
        }
    })
});

app.post("/Lounges_Employees/update", (req, res) => {
    const rentalInvoiceID = req.body['rentalInvoiceID'];
    const loungeID = req.body['loungeID'];
    const employeeID = req.body['employeeID'];
    const dateinfo = req.body['dateinfo'];
    db.query('UPDATE LoungesEmployees SET loungeID = ?, employeeID = ?, dateinfo = ? WHERE rentalInvoiceID = ?', [loungeID, employeeID, dateinfo, rentalInvoiceID], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/Lounges_Employees');
        }
    })
});

app.post("/Lounges_Employees/delete", (req, res) => {
    const rentalInvoiceID = req.body['rentalInvoiceID'];
    db.query('DELETE FROM LoungesEmployees WHERE rentalInvoiceID = ?', [rentalInvoiceID], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/Lounges_Employees');
        }
    })
});

// LOUNGES in order: READ, CREATE, UPDATE, DELETE
app.get("/lounges", (req, res) => {
    db.query('SELECT loungeID as "Lounge #" , loungeLimit as "Max Capacity", activeConsoles "Active Players" FROM Lounges', async (error, ress) => {
        if(error){
            console.log(error)
        }
        if( ress.length > 0 ) {
            console.log(ress)
            return res.render('lounges', {
                tableData: ress,
                message: 'Account info retrieved'
            })
        }
    })
});

app.post("/lounges/create", (req, res) => {
    const loungeLimit = req.body['loungeLimit'];
    const activeConsoles = req.body['activeConsoles'];
    db.query('INSERT INTO Lounges(loungeLimit, activeConsoles) VALUES (?, ?)', [loungeLimit, activeConsoles], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/lounges');
        }
    })
});

app.post("/lounges/update", (req, res) => {
    const loungeID = req.body['loungeID'];
    const loungeLimit = req.body['loungeLimit'];
    const activeConsoles = req.body['activeConsoles'];
    db.query('UPDATE Lounges SET loungeLimit = ?, activeConsoles = ? WHERE loungeID = ?', [loungeLimit, activeConsoles, loungeID], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/lounges');
        }
    })
});

app.post("/lounges/delete", (req, res) => {
    const loungeID = req.body['loungeID'];
    db.query('DELETE FROM Lounges WHERE loungeID = ?', [loungeID], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/lounges');
        }
    })
});




app.listen(3234, () => {
    console.log(`Server is running port 3234`);
});