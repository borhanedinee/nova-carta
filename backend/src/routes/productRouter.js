const express = require('express');
const { fetchProduct, addProduct, updateProduct, deleteProduct, orderProductBy, fetchMenProducts, fetchWomenProducts, fetchKidsProducts, fetchSearchedProducts, fetchNewClothes, fetchProductsByCategoryAndType, addProductToFavourite, deleteProductFromFavourite, fetchProductsFromFavourite, fetchCartProducts, editProduct } = require('../controllers/productController');
const { uploadproducts } = require('../Utils/uploadfile');


const productRouter = express.Router()

productRouter.get('/api/product/fetchmen', fetchMenProducts)
productRouter.get('/api/product/fetchwomen', fetchWomenProducts)
productRouter.get('/api/product/fetchkids', fetchKidsProducts)
productRouter.get('/api/product/fetchnewclothes', fetchNewClothes)
productRouter.get('/api/cart/fetchcartproducts/:userid', fetchCartProducts)
productRouter.get('/api/product/getproductsfromfavourites/:userid', fetchProductsFromFavourite)
productRouter.get('/api/product/:category/:type', fetchProductsByCategoryAndType)
productRouter.get('/api/product/search/fetchsearch/:value', fetchSearchedProducts)
productRouter.post('/api/product/add', uploadproducts.single('product'), addProduct)
productRouter.post('/api/product/update/:productid', uploadproducts.single('product'), editProduct)
productRouter.put('/api/product/:id', uploadproducts.any(), updateProduct)
productRouter.put('/api/product/addproducttofavourite/:productid/:userid', addProductToFavourite)
productRouter.put('/api/product/deleteproductfromfavourite/:productid/:userid', deleteProductFromFavourite)
productRouter.delete('/api/product/:id', deleteProduct)
productRouter.post('/api/product/orderproductby', orderProductBy)



module.exports = productRouter;