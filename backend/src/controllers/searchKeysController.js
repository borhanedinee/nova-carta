const db = require('../config/db');

const fetchSearchKeys = (req, res, next) => { 
    try {
        const sql = 'SELECT * FROM `recentlysearched` WHERE `user` = ?'
        db.query(sql, [req.params.userid], (err, result) => {
            if (err) return next(err);
            console.log(result);
            res.json(result);
        });
    } catch (error) {
        next(error);
    }
}
const addSearchKey = (req, res, next) => { 
    try {
        console.log('herrrr');
        const sql = 'INSERT INTO `recentlysearched` (`user`, `searchkey`) VALUES (?,?)'
        db.query(sql, [req.body.userid, req.body.searchkey], (err, result) => {
            if (err) return next(err);
            console.log('added successfully');
            res.status(200).json(result);
        });
    } catch (error) {
        next(error);
    }
}



module.exports = {
    fetchSearchKeys,
    addSearchKey
}