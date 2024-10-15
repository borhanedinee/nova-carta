const express = require('express');
const { fetchSizes, addSize, deleteSize } = require('../controllers/sizeController');
const { uploadproducts } = require('../Utils/uploadfile');

const sizesRouter = express.Router()


sizesRouter.get('/api/sizes/' , fetchSizes)
sizesRouter.post('/api/sizes/add' , uploadproducts.any() ,addSize)
sizesRouter.delete('/api/sizes/:id' , deleteSize)


module.exports = sizesRouter;