const db = require('../config/db');

const fetchPaymentMethod = (req , res , next) => {
    try {
        const sql = 'SELECT * FROM `payment`'
        db.query(sql , (err, result) => {
            if (err) return next(err)
                console.log(result);

            res.status(200).json(result)
        })
    } catch (error) {
        next(error)
    }
 }

const addPaymentMethod = (req , res) => {
    try {
        const { paymentmethod} = req.body
        const sql = 'INSERT INTO `payment`( `paymentmethod`) VALUES ( ?)'
        db.query(sql , [paymentmethod] , (err, result) => {
            if (err) return next(err)
            res.send({message: 'paymentmethod added successfully', data: result})
        })
    } catch (error) {
        next(error)
    }
}
const deletePaymentMethod = (req , res) => {}
const updatePaymentMethod = (req , res) => {}


module.exports =  {fetchPaymentMethod, addPaymentMethod, deletePaymentMethod, updatePaymentMethod}