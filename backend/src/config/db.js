const mysql = require('mysql2');

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'ecommerce',
    connectTimeout: 10000, // Wait up to 10 seconds for a connection to be established
});


module.exports = db;