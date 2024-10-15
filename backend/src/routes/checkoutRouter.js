const express = require('express');
const checkout = require('../controllers/checkoutController');
const checkoutRouter = express.Router();


checkoutRouter.post('/api/checkout' , checkout)


module.exports = checkoutRouter;