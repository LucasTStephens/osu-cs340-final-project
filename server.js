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
                // need to templatize the tables so data can be sent back
                message: 'Account info retrieved'
            })
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
                // need to templatize the tables so data can be sent back
                message: 'Account info retrieved'
            })
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
            console.log(ress)
            return res.render('employees', {
                // need to templatize the tables so data can be sent back
                message: 'Account info retrieved'
            })
        }
    })
});

// GAMESYSTEMS
app.get("/gameSystems", (req, res) => {
    db.query('SELECT systemID as "Game System #", loungeID as "Lounge #", inUse as "Rented?", systemType as "Game Console Type" FROM GameSystems', async (error, ress) => {
        if(error){
            console.log(error)
        }
        if( ress.length > 0 ) {
            console.log(ress)
            return res.render('gameSystems', {
                // need to templatize the tables so data can be sent back
                message: 'Account info retrieved'
            })
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
                // need to templatize the tables so data can be sent back
                message: 'Account info retrieved'
            })
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
                // need to templatize the tables so data can be sent back
                message: 'Account info retrieved'
            })
        }
    })
});






app.listen(3234, () => {
    console.log(`Server is running port 3234`);
});