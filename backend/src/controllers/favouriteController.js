const db = require('../config/db');

const addProductToFavourite = (req , res) => {
    try {
        const {favouriteid , productid} = req.body
        const sql = 'INSERT INTO `favouritesinfo`(`product`, `favourites`) VALUES (? , ?)'
        db.query(sql , [favouriteid , productid] , (err, result) => {
            if (err) return next(err)
            res.send({message: 'product added to cart successfully', data: result})
        })
    } catch (error) {
        next(error)
    }
}

const deleteAllFavoriteItems = (req ,res ,next) => {
    try {
        const {userid} = req.params
        const sql = 'DELETE FROM `favouritesinfo` WHERE user = ? '
        db.query(sql , [userid] , (err, result) => {
            if (err) return next(err)
            res.status(200).json({ message : ' deleted'})
        })
    } catch (error) {
        next(error)
    }
}

const deleteProductFromFavourite = (req , res) => {}


module.exports = { deleteAllFavoriteItems , addProductToFavourite, deleteProductFromFavourite}