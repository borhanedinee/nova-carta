const db = require("../config/db")

const addColor = (req , res , next) => {
    try {
        const {color} = req.body
        const sql = 'INSERT INTO `colors`(`color`) VALUES (?)'
        db.query(sql , [color] , (err, result) => {
            if (err) return next(err)
            res.send({message: 'color added successfully', data: result})
        })
    } catch (error) {
        next(error)
    }
}
const deleteColor = (req , res , next) => {}
const fetchColors = (req , res , next) => {
    try {
        const sql = 'SELECT * FROM `colors`'
        db.query(sql , (err, result) => {
            if (err) return next(err)
            res.status(200).json({message: 'Sizes fetched successfully', data: result})
        })
    } catch (error) {
        next(error)
    }
}

module.exports = {addColor, deleteColor, fetchColors}