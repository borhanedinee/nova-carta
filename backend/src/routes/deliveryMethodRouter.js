const express = require('express')
const { fetchDeliveryMethod, addDeliveryMethod, updateDeliveryMethod, deleteDeliveryMethod } = require('../controllers/deliveryMethodController')

const deliveryMethodRouter = express.Router()



deliveryMethodRouter.get('/api/delivery/fetchdeliverymethods' , fetchDeliveryMethod)
deliveryMethodRouter.post('/api/DeliveryMethod/add' , addDeliveryMethod)
deliveryMethodRouter.put('/api/DeliveryMethod/:id' , updateDeliveryMethod)
deliveryMethodRouter.delete('/api/DeliveryMethod/:id' , deleteDeliveryMethod)


module.exports = deliveryMethodRouter