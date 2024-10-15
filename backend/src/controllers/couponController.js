const db = require("../config/db")


const fetchCoupons = (req , res , next) => {
    try {
        const sql = 'SELECT * FROM `coupon`'
        db.query(sql , (err, result) => {
            if (err) return next(err)
            res.send(result)
        })

    } catch (error) {
        next(error)
    }
}
const addCoupon = (req , res , next) => {
    try {
        const {label , pourcentage , period} = req.body
        const sql = 'INSERT INTO `coupon`(`couponlabel`, `pourcentage`, `period`) VALUES (? , ? , ?)'
        
        db.query(sql , [label , pourcentage , period] , (err, result) => {
            if (err) return next(err)
            res.send({message: 'coupon added successfully', data: result})
        })
    } catch (error) {
        next(error)
    }
}
const updateCoupon = (req , res) => {}
const deleteCoupon = (req , res , next) => {
    try {
        console.log(req.params.id);
        const sql = 'DELETE FROM `coupon` WHERE id = ?'
        db.query(sql, [req.params.id], (err, result) => {
            if(err) return next(err);
            res.status(200).json({message: 'Coupon deleted successfully'})
        })
    } catch (error) {
        
    }
}

module.exports = {fetchCoupons, updateCoupon, deleteCoupon , addCoupon, updateCoupon}