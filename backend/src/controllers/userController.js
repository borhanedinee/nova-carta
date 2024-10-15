const db = require("../config/db");

const fetchUser = (req, res) => { }
const fetchUsers = (req, res) => { }
const addUser = (req, res, next) => {
    // if inserting user is successful , handle inserting new cart and new favourite
    try {
        db.beginTransaction((err) => {
            if (err) return next(err);
            const { username, password, email, token } = req.body
            const avatar = 'ffffffffffffffffffffffffffffff'

            console.log(token);

            // Insert the user

            const insertUserQuery = 'INSERT INTO `user` (`username`, `password`, `email`, `avatar`) VALUES (?, ?, ?, ?)';
            db.query(insertUserQuery, [username, password, email, avatar], (err, result) => {
                if (err) {
                    return db.rollback(() => {
                        next(err);
                    });
                }

                const lastUserId = result.insertId;
                console.log(lastUserId);


                const insertTokenQuery = 'INSERT INTO `usertokens`(`token`, `user`) VALUES (? , ?)'

                db.query(insertTokenQuery, [token, lastUserId], (err, result) => {
                    if (err) {
                        return db.rollback(() => {
                            next(err);
                        });
                    }

                    // Insert the user's cart
                    const insertCartQuery = 'INSERT INTO `cart` (`user`) VALUES (?)';
                    db.query(insertCartQuery, [lastUserId], (err, result) => {
                        if (err) {
                            return db.rollback(() => {
                                next(err);
                            });
                        }

                        // Insert the user's favorites
                        const insertFavouritesQuery = 'INSERT INTO `favourites` (`user`) VALUES (?)';
                        db.query(insertFavouritesQuery, [lastUserId], (err, result) => {
                            if (err) {
                                return db.rollback(() => {
                                    next(err);
                                });
                            }

                            // Commit the transaction
                            db.commit((err) => {
                                if (err) {
                                    return db.rollback(() => {
                                        next(err);
                                    });
                                }

                                res.send({ message: 'User added successfully', data: result });
                            });
                        });
                    });




                })


            });
        });
    } catch (error) {
        next(error)
    }
}
const updateUser = (req, res) => { }
const deleteUser = (req, res) => { }
const loginUser = (req, res, next) => {
    try {
        const { username, password } = req.body;
        const selectUserQuery = 'SELECT * FROM `user` WHERE `username` =? AND `password` =?';
        db.query(selectUserQuery, [username, password], (err, user) => {
            if (err) next(err);
            if (user.length === 0) {
                res.status(200).json({
                    fetch: 0,
                });
            } else {
                const fetchedUserID = user[0].id;
                const fetchTokenQuery = 'SELECT * FROM `usertokens` WHERE `user` = ? '
                db.query(fetchTokenQuery, fetchedUserID, (err, token) => {
                    if (err) next(err);
                    const fetchedToken = token[0].token
                    const fetchedUser = user[0]
                    fetchedUser.token = fetchedToken
                    console.log(fetchedUser);
                    
                    res.status(200).json({
                        fetch: 1,
                        user: fetchedUser
                    });

                })
            }
        });
    } catch (error) {
        next(error)
    }
}

module.exports = { fetchUser, fetchUsers, addUser, updateUser, deleteUser, loginUser }