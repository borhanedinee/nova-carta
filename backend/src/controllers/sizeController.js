const db = require("../config/db")

const addSize = (req , res , next) => {
    try {
        const {size} = req.body
        const sql = 'INSERT INTO `sizes`(`size`) VALUES ( ?)'
        db.query(sql , [size] , (err, result) => {
            if (err) return next(err)
            res.send({message: 'size added successfully', data: result})
        })
    } catch (error) {
        next(error)
    }
}
const deleteSize = (req , res , next) => {}
const fetchSizes = (req , res , next) => {
    try {
        const sql = 'SELECT * FROM `sizes`'
        db.query(sql , (err, result) => {
            if (err) return next(err)
            res.send({message: 'Sizes fetched successfully', data: result})
        })
    } catch (error) {
        next(error)
    }
}


module.exports = {addSize, deleteSize, fetchSizes}