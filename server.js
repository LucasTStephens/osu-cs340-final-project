var path = require('path')
var express = require('express')
const mysql = require("mysql")
const dotenv = require('dotenv')

var app = express()

app.use(express.urlencoded({extended: 'false'}))
app.use(express.static(path.join(__dirname, 'static')))
app.use(express.json())

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

// test case for createing new customer account, values not correct
app.get("/customerAccounts", (req, res) => {
    db.query('SELECT firstName, lastName, customerEmail, customerDOB FROM CustomerAccounts', async (error, ress) => {
        if(error){
            console.log(error)
        }
        if( ress.length > 0 ) {
            console.log(ress.data)
            return res.render('customerAccounts', {
                
                message: 'Account info retrieved'
            })
        }
    })
})

app.listen(3233, () => {
    console.log(`Server is running port 3233`);
});