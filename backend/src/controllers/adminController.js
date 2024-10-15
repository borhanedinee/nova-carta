const db = require("../config/db")

const fetchAdmin = (req, res) => {

}
const fetchAdmins = (req, res) => { }
const addAdmin = (req, res) => {
    try {
        console.log(req.body);

        const { username, password, token } = req.body
        const sql = 'INSERT INTO `admin`(`username`, `password`) VALUES (? , ?)'
        db.query(sql, [username, password], (err, result) => {
            if (err) return next(err)
            console.log('added successfully');
            console.log(result.insertId);
            var sql2 = 'INSERT INTO `admintokens`(`token`, `admin`) VALUES (? , ?)'
            db.query(sql2, [token, result.insertId], (err, result) => {
                if (err) return next(err)
                    console.log('success');
                    
                res.send({ message: 'Admin added successfully', data: result })
            })
        })
    } catch (error) {
        next(error)
    }
}
const deleteAdmin = (req, res) => { }
const updateAdmin = (req, res) => { }


module.exports = { fetchAdmin, fetchAdmins, addAdmin, deleteAdmin, updateAdmin }