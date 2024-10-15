const express = require('express')
const { fetchCategories, fetchCategorie, addCategorie, updateCategorie, deleteCategorie } = require('../controllers/categorieController')

const categorieRouter = express.Router()

categorieRouter.get('/api/categorie/' , fetchCategories)
categorieRouter.get('/api/categorie/:id' , fetchCategorie)
categorieRouter.post('/api/categorie/add' , addCategorie)
categorieRouter.put('/api/categorie/:id' , updateCategorie)
categorieRouter.delete('/api/categorie/:id' , deleteCategorie)



module.exports = categorieRouter        