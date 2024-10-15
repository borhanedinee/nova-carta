const express = require('express')
const { addProductToFavourite, deleteProductFromFavourite, deleteAllFavoriteItems } = require('../controllers/favouriteController')

const favouriteRouter = express.Router()


favouriteRouter.post('/api/favourite/addproduct' , addProductToFavourite)
favouriteRouter.post('/api/favourite/deleteproduct' , deleteProductFromFavourite)
favouriteRouter.delete('/api/favourites/deleteallitems/:userid' , deleteAllFavoriteItems)


module.exports = favouriteRouter