const express = require('express')
const { fetchPaymentMethod, addPaymentMethod, updatePaymentMethod, deletePaymentMethod } = require('../controllers/paymentMethodController')

const paymentMethodController = express.Router()



paymentMethodController.get('/api/payment/fetchpaymentmethods' , fetchPaymentMethod)
paymentMethodController.post('/api/paymentmethod/add' , addPaymentMethod)
paymentMethodController.put('/api/paymentmethod/:id' , updatePaymentMethod)
paymentMethodController.delete('/api/paymentmethod/:id' , deletePaymentMethod)


module.exports = paymentMethodController