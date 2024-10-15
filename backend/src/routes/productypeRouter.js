const express = require('express')
const { fetchTypes, fetchType, addType, updateType, deleteType } = require('../controllers/producttypeController')

const producttypeRouter = express.Router()

producttypeRouter.get('/api/producttype/' , fetchTypes)
producttypeRouter.get('/api/producttype/:id' , fetchType)
producttypeRouter.post('/api/producttype/add' , addType)
producttypeRouter.put('/api/producttype/:id' , updateType)
producttypeRouter.delete('/api/producttype/:id' , deleteType)


module.exports = producttypeRouter