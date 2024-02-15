var path = require('path')
var express = require('express')

var app = express()

app.use(express.static(path.join(__dirname, 'static')))
app.use(express.json())

app.listen(3333, () => {
    console.log(`Server is running port 3333`);
});