const express = require('express');
const { updateOrderClientSide ,  decrementProductQuantity , incrementProductQuantity, fetchRecentOrders, sortOrdersByStatus, searchOrder, addOrder, updateOrder, deleteOrder, fetchallorders, fetchOrdersOfSpecificUser } = require('../controllers/orderController');

const orderRouter = express.Router()


orderRouter.get('/api/orders/fetchrecentorders' , fetchRecentOrders)
orderRouter.get('/api/orders/fetchallorders' , fetchallorders)
orderRouter.get('/api/orders/fetchallorders/:userid' , fetchOrdersOfSpecificUser)
orderRouter.get('/api/order/sort/:status' , sortOrdersByStatus)
orderRouter.get('/api/order/search/:key' , searchOrder)
orderRouter.post('/api/order/add' , addOrder)
orderRouter.post('/api/orders/update' , updateOrder)
orderRouter.post('/api/orders/updateclientside' , updateOrderClientSide)
orderRouter.delete('/api/order/deleteorder/:orderid' , deleteOrder)
orderRouter.delete('/api/order/productquantity/increment/:orderid' , incrementProductQuantity)
orderRouter.delete('/api/order/productquantity/decrement/:orderid' , decrementProductQuantity)


module.exports = orderRouter;