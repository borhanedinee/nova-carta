const db = require('../config/db');

const fetchDeliveryMethod = (req , res , next) => {
    try {
        const sql = 'SELECT * FROM `delivery`'
        db.query(sql , (err, result) => {
            if (err) return next(err)
                console.log(result);
            res.status(200).json(result)
        })
    } catch (error) {
        next(error)
    }
}
const addDeliveryMethod = (req , res) => {
    try {
        const {deliverymethod} = req.body
        const sql = 'INSERT INTO `delivery`(`deliverymethod`) VALUES (? )'
        db.query(sql , [deliverymethod] , (err, result) => {
            if (err) return next(err)
            res.send({message: 'delivery method added successfully', data: result})
        })
    } catch (error) {
        next(error)
    }
}
const deleteDeliveryMethod = (req , res) => {}
const updateDeliveryMethod = (req , res) => {}


module.exports =  {fetchDeliveryMethod, addDeliveryMethod, deleteDeliveryMethod, updateDeliveryMethod}