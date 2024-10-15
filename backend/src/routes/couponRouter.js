const express = require('express')
const { fetchCoupons, addCoupon, updateCoupon, deleteCoupon } = require('../controllers/couponController')

const couponRouter = express.Router()


couponRouter.get('/api/coupon/' , fetchCoupons)
couponRouter.post('/api/coupon/add' , addCoupon)
couponRouter.put('/api/coupon/:id' , updateCoupon)
couponRouter.delete('/api/coupon/:id' , deleteCoupon)


module.exports = couponRouter;