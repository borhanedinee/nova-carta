
const db = require('../config/db'); // Your database connection




// Firebase configuration
const admin = require('firebase-admin');
const serviceAccount = require('C:/Users/abdo/Desktop/Flutter Projects/e-commerce/backend/serviceAccountKey.json'); // Update with the path to your downloaded JSON file


admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
});

// send push notification
const sendPushNotification = (token, message) => {

    const payload = {
        token: token,
        notification: {
            title: message.title,
            body: message.body,
        },
        data: {
            orderId: '12345', // Example of custom data
            // Add other custom data fields if needed
        },

    };

    console.log('borhan' + token);
    

    admin.messaging().send(payload)
        .then(response => {
            console.log("Successfully sent notification:", response);
        })
        .catch(error => {
            console.log("Error sending notification:", error);
        });
};


const checkout = (req, res, next) => {
    const { userid, fullname, phone, location, deliverymethod, paymentmethod, discount } = req.body;
    // Begin transaction
    db.query('START TRANSACTION', (err) => {
        if (err) {
            return res.status(500).json({ error: 'Transaction start failed' });
        }


        // 1. Fetch cart items
        db.query('SELECT * FROM cartinfo WHERE user = ?', [userid], (err, cartItems) => {
            if (err) {
                return db.query('ROLLBACK', () => {
                    next(err);

                });
            }


            if (cartItems.length === 0) {
                return db.query('ROLLBACK', () => {
                    const err = new Error('Cart is empty');
                    next(err);
                });
            }

            // 2. Insert order
            const inserToOrderInfoQuery = 'INSERT INTO `orderinfo`(`user`, `fullname`,`phone`, `location`, `deliverymethod`, `paymentmethod`,`discount`) VALUES (? , ? , ? , ? , ? , ? , ?)'
            db.query(inserToOrderInfoQuery, [userid, fullname, phone, location, deliverymethod, paymentmethod, discount], (err, result) => {

                if (err) {
                    return db.query('ROLLBACK', () => {

                        next(err);
                    });
                }


                const orderId = result.insertId;

                // 3. Insert order items
                let orderItemsCount = 0;
                cartItems.forEach((item) => {
                    const orderItemsSQL = 'INSERT INTO `orderproducts`(`product`, `orderinfo`, `quantity`, `color`, `size`) VALUES (? , ? , ? , ? , ?)'
                    db.query(orderItemsSQL, [item.product, orderId, item.quantity, item.color, item.size], (err) => {
                        if (err) {
                            return db.query('ROLLBACK', () => {
                                next(err);

                            });
                        }

                        orderItemsCount += 1;
                        if (orderItemsCount === cartItems.length) {
                            // 4. Clear cart
                            db.query('DELETE FROM cartinfo WHERE user = ?', [userid], (err) => {
                                if (err) {
                                    return db.query('ROLLBACK', () => {
                                        next(err);

                                    });
                                }
                                const fetchingAdminTokensQuery = 'SELECT `token` FROM `admintokens`'
                                db.query(fetchingAdminTokensQuery, (err, results) => {


                                    if (err) {
                                        return db.query('ROLLBACK', () => {
                                            res.status(500).json({ error: 'Transaction commit failed' });
                                        });
                                    }


                                    console.log(results);

                                    for (const token of results) {
                                        console.log(token.token);
                                        
                                        sendPushNotification(token.token, {
                                            title : 'New Order',
                                            body : 'A new order has been placed',
                                        });
                                    }
                                    
                                    // Commit transaction
                                    db.query('COMMIT', (err) => {
                                        if (err) {
                                            return db.query('ROLLBACK', () => {
                                                res.status(500).json({ error: 'Transaction commit failed' });
                                            });
                                        }



                                        res.status(200).json({ message: 'Order placed successfully' });
                                    });

                                })

                            });
                        }
                    });
                });
            });
        });
    });
};

module.exports = checkout;
