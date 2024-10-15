const db = require('../config/db');

const addProductToCart = (req, res , next) => {
    try {
        const {userid , productid , quantity , size , color} = req.body
        const sql = 'INSERT INTO `cartinfo`(`user`, `product`, `quantity`, `color`, `size`) VALUES (?,?,?,?,?)'
        db.query(sql , [userid , productid , quantity , color , size] , (err, result) => {
            if (err) return next(err)
            res.send({message: 'product added to cart successfully', data: result})
        })
    } catch (error) {
        next(error)
    }
}
const deleteAllItemsFromCart = (req, res , next) => {
    try {
        const {userid} = req.params
        const sql = 'DELETE FROM `cartinfo` WHERE user = ? '
        db.query(sql , [userid] , (err, result) => {
            if (err) return next(err)
            res.status(200).json({ message : ' deleted'})
        })
    } catch (error) {
        next(error)
    }
 }
const deleteProductFromCart = (req, res , next) => { }
const deleteSingleCartItem = (req, res , next) => { 
    try {
        const {userid , productcartid} = req.params
        console.log('ya bbbbbbbbbbb');
        console.log(userid);
        console.log(productcartid);

        
        const sql = 'DELETE FROM `cartinfo` WHERE user = ? AND product = ? '
        db.query(sql , [userid , productcartid] , (err, result) => {
            if (err) return next(err)
            res.status(200).json({ message : ' deleted'})
        })
    } catch (error) {
        next(error)
    }
}


module.exports = { deleteSingleCartItem , deleteAllItemsFromCart , addProductToCart, deleteProductFromCart}