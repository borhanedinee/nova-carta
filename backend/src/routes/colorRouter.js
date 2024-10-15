const express = require('express')
const { fetchColors, addColor, deleteColor } = require('../controllers/colorsController')
const { uploadproducts } = require('../Utils/uploadfile')

const colorRouter = express.Router()

// Define color routes
colorRouter.get('/api/colors/' , fetchColors)
colorRouter.post('/api/colors/add' , uploadproducts.any() ,addColor)
colorRouter.delete('/api/colors/:id' , deleteColor)


module.exports = colorRouter