const express = require('express');
const { deleteSingleCartItem , addProductToCart, deleteProductFromCart, deleteAllItemsFromCart } = require('../controllers/cartController');

const cartRouter = express.Router()


cartRouter.post('/api/product/addproducttocart' , addProductToCart)
cartRouter.post('/api/cart/deleteproduct' , deleteProductFromCart)
cartRouter.delete('/api/cart/deleteallitems/:userid' , deleteAllItemsFromCart)
cartRouter.delete('/api/cart/deletesingleitem/:userid/:productcartid' , deleteSingleCartItem)


module.exports = cartRouter;