const db = require("../config/db");

const addCategorie = (req, res, next) => {
    try {
        // cat lable
        const { categorielabel } = req.body;
        const sql = 'INSERT INTO `category`(`categorylabel`) VALUES (?)'
        db.query(sql, [categorielabel], (err, result) => {
            if (err) return next(err);
            res.send(result);
        })

    } catch (error) {
        next(error);
    }
}
const deleteCategorie = (req, res) => { }
const updateCategorie = (req, res) => { }
const fetchCategories = (req, res , next) => {
    try {
        const sql = 'SELECT * FROM `category`'
        db.query(sql, (err, result) => {
            if (err) return next(err);
            res.status(200).json({ message: 'Categories fetched successfully', data: result })
        })
    } catch (error) {
        next(error);
    }
}

const fetchCategorie = (req, res) => { }


module.exports = { addCategorie, deleteCategorie, updateCategorie, fetchCategories, fetchCategorie }