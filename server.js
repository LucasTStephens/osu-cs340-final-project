var path = require('path')
var express = require('express')
var exphbs = require('express-handlebars')
const mysql = require("mysql")
const dotenv = require('dotenv')


var app = express()

app.use(express.urlencoded({extended: 'false'}))
app.use(express.static(path.join(__dirname, 'static')))
app.use(express.json())

app.engine("handlebars", exphbs.engine({defaultLayout: null}))
app.set("view engine", "handlebars")

dotenv.config({ path: './.env'})

const db = mysql.createConnection({
    host: process.env.DATABASE_HOST,
    user: process.env.DATABASE_USER,
    password: process.env.DATABASE_PASSWORD,
    database: process.env.DATABASE
})

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


// CUSTOMERACCOUNTS
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

// CUSTOMERSALES
app.get("/customerSales", (req, res) => {
    db.query('SELECT saleID as "Sale Order #", systemID as "Game System #", customerEmail as "Customer Email", timeIn as "Checked In", timeOut as "Checked Out" FROM CustomerSales', async (error, ress) => {
        if(error){
            console.log(error)
        }
        if( ress.length > 0 ) {
            console.log(ress)
            return res.render('customerSales', {
                tableData: ress,
                message: 'Account info retrieved'
            })
        }
    })
});

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
    db.query('DELETE FROM customerSales WHERE saleID = ?', [saleID], async (error, ress) => {
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
    db.query('UPDATE customerSales SET systemID = ?, customerEmail = ?, timeIn = ?, timeOut = ? WHERE saleID = ?', [systemID, email, timein, timeout, saleID], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/customerSales');
        }
    })
});



// CONSOLES
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
    const consoleID = req.body['consoleType'];
    db.query('DELETE FROM Consoles WHERE consoleID = ?', [consoleID], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/consoles');
        }
    })
});

// EMPLOYEES
app.get("/employees", (req, res) => {
    db.query('SELECT employeeID as "Employee #", statusIn as "Clocked In", position as "Title", hourlyWage as "Wage ($/hr)" FROM Employees', async (error, ress) => {
        if(error){
            console.log(error)
        }
        if( ress.length > 0 ) {
            console.log(ress[1]['Clocked In'])
            return res.render('employees', {
                tableData: ress,
                message: 'Account info retrieved'
            })
        }
    })
});

app.post("/employees/create", (req, res) => {
    const statusin = req.body['statusin'];
    const position = req.body['position'];
    const hourlywage = req.body['hourlywage'];
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
    const employeeID = req.body['EmployeeID'];
    const statusin = req.body['statusin'];
    const position = req.body['position'];
    const hourlywage = req.body['hourlywage'];
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
    const employeeID = req.body['EmployeeID'];
    db.query('DELETE FROM Employees WHERE employeeID = ?', [employeeID], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/employees');
        }
    })
});

// GAMESYSTEMS
app.get("/gameSystems", (req, res) => {
    db.query('SELECT GameSystems.systemID as "Game System #", GameSystems. loungeID as "Lounge #", GameSystems.inUse as "Rented?", Consoles.consoleType as "Game Console Type" FROM GameSystems INNER JOIN Consoles ON GameSystems.systemType = Consoles.consoleID;', async (error, ress) => {
        if(error){
            console.log(error)
        }
        if( ress.length > 0 ) {
            console.log(ress)
            return res.render('gameSystems', {
                tableData: ress,
                message: 'Account info retrieved'
            })
        }
    })
});

app.post("/gamesystems/create", (req, res) => {
    const loungeID = req.body['loungeID'];
    const inUse = req.body['inUse'];
    const systemType = req.body['systemType'];
    db.query('INSERT INTO GameSystems(loungeID, inUse, systemType) VALUES (?, ?, ?)', [loungeID, inUse, systemType], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/gamesystems');
        }
    })
});

app.post("/gamesystems/update", (req, res) => {
    const systemID = req.body['systemID'];
    const loungeID = req.body['loungeID'];
    const inUse = req.body['inUse'];
    const systemType = req.body['systemType'];
    db.query('UPDATE GameSystems SET loungeID = ?, inUse = ?, systemType = ? WHERE systemID = ?', [loungeID, inUse, systemType, systemID], async (error, ress) => {
        if(error){
            console.log(error)
        }
        else {
            res.redirect('/gamesystems');
        }
    })
});

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

// LOUNGES_EMPLOYEES
app.get("/Lounges_Employees", (req, res) => {
    db.query('SELECT rentalInvoiceID as "Rental Invoice #", loungeID as "Lounge #", employeeID as "Employee #", dateinfo as "Date" FROM LoungesEmployees', async (error, ress) => {
        if(error){
            console.log(error)
        }
        if( ress.length > 0 ) {
            console.log(ress)
            return res.render('Lounges_Employees', {
                tableData: ress,
                message: 'Account info retrieved'
            })
        }
    })
});

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

// LOUNGES
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