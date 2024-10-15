const db = require("../config/db")

const fetchTypes = (req, res , next) => { 
    try {
        const sql = 'SELECT * FROM `producttype`'
        db.query(sql, (err, result) => {
            if (err) return next(err);
            res.status(200).json(result)
        })
    } catch (error) {
        next(error);
    }
}
const fetchType = (req, res) => { }
const addType = (req, res, next) => {
    try {
        
        // producttype , typecategorieid
        
        const { producttype } = req.body
        const sql = 'INSERT INTO `producttype`(`type`, `typecategory`) VALUES (?,?)'
        db.query(
            sql,
            [producttype],
            (err, result) => {
                if (err) return next(err);
                res.send({ message: 'Type added successfully', data: result })
            })
    } catch (error) {
        next(error)
    }
}
const updateType = (req, res) => { }
const deleteType = (req, res) => { }


module.exports = { fetchType, fetchType, addType, updateType, deleteType, fetchTypes }