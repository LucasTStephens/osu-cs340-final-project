var path = require('path')
var express = require('express')
const mysql = require("mysql")
const dotenv = require('dotenv')

var app = express()

app.use(express.urlencoded({extended: 'false'}))
app.use(express.static(path.join(__dirname, 'static')))
app.use(express.json())

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
app.post("/customerAccounts/create", (req, res) => {
    const data = req.body["form-name"];

    db.query('INSERT INTO customerAccounts (attribute1, attribute2) VALUES (?, data2)', [data], async (error, ress) => {
        if(error){
            console.log(error)
        }
        if( ress.length > 0 ) {
            return res.render('customerAccounts', {
                message: 'New account added'
            })
        }
    })
})

app.listen(3233, () => {
    console.log(`Server is running port 3233`);
});