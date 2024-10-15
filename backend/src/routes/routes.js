const express = require('express');
const adminRouter = require('./adminRouter');
const productRouter = require('./productRouter');
const producttypeRouter = require('./productypeRouter');
const userRouter = require('./userRouter');
const categorieRouter = require('./categoriesRouter');
const orderRouter = require('./orderRouter');
const cartRouter = require('./cartRouter');
const favouriteRouter = require('./favouriteRouter');
const paymentMethodController = require('./paymentMethodRouter');
const deliveryMethodRouter = require('./deliveryMethodRouter');
const couponRouter = require('./couponRouter');
const colorRouter = require('./colorRouter');
const sizesRouter = require('./sizesRouter');
const recentlysearchedRouter = require('./searchKeysRouter');
const checkoutRouter = require('./checkoutRouter');

const router = express.Router();

//here import all the routers that you will need
router.use(adminRouter)
router.use(productRouter)
router.use(producttypeRouter)
router.use(userRouter)
router.use(categorieRouter)
router.use(orderRouter)
router.use(cartRouter)
router.use(couponRouter)
router.use(favouriteRouter)
router.use(paymentMethodController)
router.use(deliveryMethodRouter)
router.use(colorRouter)
router.use(sizesRouter)
router.use(recentlysearchedRouter)
router.use(checkoutRouter)

router.all('*' , (req , res , next) => {
    console.log('u here');
    const err = new Error('end point ${req.url} not valid');
    err.statusCode = 404;
    next(err);
})

module.exports = router;