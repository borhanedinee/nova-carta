const db = require("../config/db")

const addOrder = (req, res) => { }
const deleteOrder = (req, res, next) => {
    try {
        const sql = 'DELETE FROM `orderinfo` WHERE id = ?'
        db.query(sql, [req.params.orderid], (err, result) => {
            if (err) return next(err);
            res.status(200).json({ message: 'Order deleted successfully' });
        });
    } catch (error) {
        next(error);
    }
}
const fetchOrdersOfSpecificUser = (req, res, next) => {
    try {
        const { userid } = req.params
        const sql = 'SELECT oi.id as orderinfoid , oi.phone , oi.location , oi.deliverymethod , oi.paymentmethod , oi.discount ,oi.createdat as orderedAt , oi.status , oi.fullname as orderOwner , u.avatar FROM `orderinfo` as oi JOIN `user` as u  ON oi.user = u.id WHERE oi.user = ?'
        db.query(sql, [userid], (err, result) => {
            if (err) return next(err);
            // HERE BEFORE SENDING THE RESPONSE
            // HANDLE FETCHING ORDER PRODUCTS BASED ON ORDERINFO ID
            // then format the response to be , orderinfo + corresponding products
            // >>>>>>>>>>>>>>>>>>>>>>>>>> done
            async function fetchOrderProducts(orders) {
                const fetchProductsForOrder = (order) => {
                    return new Promise((resolve, reject) => {
                        const sql2 = 'SELECT op.quantity , p.name as productName , p.description as productDescription , p.price as productPrice , p.discount as productDiscount , p.asset as productAsset , op.color as productColor , op.size as productSize , cat.categorylabel as productCategory , pt.type as productType FROM `orderproducts` as op JOIN `product` as p ON op.product = p.id JOIN `category` as cat ON cat.id = p.categorie JOIN `producttype` as pt ON pt.id = p.type  WHERE `orderinfo` = ? ';
                        db.query(sql2, [order.orderinfoid], (err, result2) => {
                            if (err) {
                                return reject(err);
                            }
                            order.products = result2;
                            console.log(result2);
                            resolve(order);
                        });
                    });
                };

                // Use Promise.all to wait for all product-fetching promises to resolve
                return Promise.all(orders.map(fetchProductsForOrder));
            }

            fetchOrderProducts(result)
                .then((ordersWithProducts) => {
                    // Handle the orders with their corresponding products
                    res.status(200).json(ordersWithProducts)
                })
                .catch((err) => {
                    // Handle the error
                    next(err);
                });
        })
    } catch (error) {
        next(error);
    }
}
const fetchallorders = (req, res, next) => {
    try {
        const sql = 'SELECT oi.id as orderinfoid , oi.phone , oi.location , oi.deliverymethod , oi.paymentmethod , oi.discount , oi.createdat as orderedAt , oi.status , u.username as orderOwner , u.avatar FROM `orderinfo` as oi JOIN `user` as u  ON oi.user = u.id '
        db.query(sql, (err, result) => {
            if (err) return next(err);
            // HERE BEFORE SENDING THE RESPONSE
            // HANDLE FETCHING ORDER PRODUCTS BASED ON ORDERINFO ID
            // then format the response to be , orderinfo + corresponding products
            // >>>>>>>>>>>>>>>>>>>>>>>>>> done
            async function fetchOrderProducts(orders) {
                const fetchProductsForOrder = (order) => {
                    return new Promise((resolve, reject) => {
                        const sql2 = 'SELECT op.quantity , p.name as productName , p.description as productDescription , p.price as productPrice , p.discount as productDiscount , p.asset as productAsset , op.color as productColor , op.size as productSize , cat.categorylabel as productCategory , pt.type as productType FROM `orderproducts` as op JOIN `product` as p ON op.product = p.id JOIN `category` as cat ON cat.id = p.categorie JOIN `producttype` as pt ON pt.id = p.type  WHERE `orderinfo` = ? ';
                        db.query(sql2, [order.orderinfoid], (err, result2) => {
                            if (err) {
                                return reject(err);
                            }
                            order.products = result2;
                            console.log(result2);
                            resolve(order);
                        });
                    });
                };

                // Use Promise.all to wait for all product-fetching promises to resolve
                return Promise.all(orders.map(fetchProductsForOrder));
            }

            fetchOrderProducts(result)
                .then((ordersWithProducts) => {
                    // Handle the orders with their corresponding products
                    res.status(200).json(ordersWithProducts)
                })
                .catch((err) => {
                    // Handle the error
                    next(err);
                });
        })
    } catch (error) {
        next(error);
    }
}




// Firebase configuration
const admin = require('firebase-admin');
const serviceAccount = require('C:/Users/abdo/Desktop/Flutter Projects/e-commerce/backend/serviceAccountKey.json'); // Update with the path to your downloaded JSON file


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

const updateOrder = (req, res, next) => {
    try {
        const { orderid, updateto } = req.body;
        const sql = `UPDATE orderinfo SET status =? WHERE id =?`
        db.query(sql, [updateto, orderid], (err, result) => {
            if (err) return next(err);
            const fetchIDOfOrderer = 'SELECT `user` FROM `orderinfo` WHERE `id` = ? '
            db.query(fetchIDOfOrderer, orderid, (err, result) => {
                if (err) return next(err);
                const userID = result[0].user

                const fetchTokenOfOrderer = 'SELECT `token` FROM `usertokens` WHERE `user` = ?'
                db.query(fetchTokenOfOrderer, userID, (err, result) => {
                    if (err) return next(err);
                    const token = result[0].token
                    sendPushNotification(token, { title: 'Order Status Update', body: `Your order status has been updated to ${updateto}` });
                    res.status(200).json({ message: "Order updated successfully" });
                })

            })

        });
    } catch (error) {
        next(error);
    }
}

const updateOrderClientSide = (req, res, next) => {
    try {
        console.log('wlsttt');
        
        const { orderid, updateto } = req.body;
        const sql = `UPDATE orderinfo SET status =? WHERE id =?`
        db.query(sql, [updateto, orderid], (err, result) => {
            if (err) return next(err);
            res.status(200).json({ message: "Order updated successfully" });


        });
    } catch (error) {
        next(error);
    }
}
const sortOrdersByStatus = (req, res) => { }
const fetchRecentOrders = (req, res, next) => {
    try {
        const sql = 'SELECT oi.id as orderinfoid , oi.phone , oi.location , oi.deliverymethod , oi.paymentmethod , oi.discount , oi.createdat as orderedAt , oi.status , u.username as orderOwner , u.avatar FROM `orderinfo` as oi JOIN `user` as u  ON oi.user = u.id WHERE oi.status = ? ORDER BY oi.createdat DESC'
        db.query(sql, ['pending'], (err, result) => {
            console.log('u here nnnnnnn');
            console.log(result);
            if (err) return next(err);
            // HERE BEFORE SENDING THE RESPONSE
            // HANDLE FETCHING ORDER PRODUCTS BASED ON ORDERINFO ID
            // then format the response to be , orderinfo + corresponding products
            // >>>>>>>>>>>>>>>>>>>>>>>>>> done
            async function fetchOrderProducts(orders) {
                const fetchProductsForOrder = (order) => {
                    return new Promise((resolve, reject) => {
                        const sql2 = 'SELECT op.quantity , p.name as productName , p.description as productDescription , p.price as productPrice , p.discount as productDiscount , p.asset as productAsset , op.color as productColor , op.size as productSize , cat.categorylabel as productCategory , pt.type as productType FROM `orderproducts` as op JOIN `product` as p ON op.product = p.id JOIN `category` as cat ON cat.id = p.categorie JOIN `producttype` as pt ON pt.id = p.type  WHERE `orderinfo` = ? ';
                        db.query(sql2, [order.orderinfoid], (err, result2) => {
                            if (err) {
                                return reject(err);
                            }
                            order.products = result2;
                            console.log(result2);
                            resolve(order);
                        });
                    });
                };

                // Use Promise.all to wait for all product-fetching promises to resolve
                return Promise.all(orders.map(fetchProductsForOrder));
            }

            fetchOrderProducts(result)
                .then((ordersWithProducts) => {
                    // Handle the orders with their corresponding products
                    res.status(200).json(ordersWithProducts)
                })
                .catch((err) => {
                    // Handle the error
                    next(err);
                });
        })
    } catch (error) {
        next(error);
    }
}
const searchOrder = (req, res) => { }
const decrementProductQuantity = (req, res, next) => {
    try {
        const productID = req.params.orderid
        const sql = 'UPDATE `cartinfo` SET quantity = quantity - 1 WHERE id =?'
        db.query(sql, [productID], (err, result) => {
            if (err) return next(err);
            res.status(200).json({ message: "Product quantity decremented successfully" });
        });
    } catch (error) {
        next(error);
    }
}
const incrementProductQuantity = (req, res, next) => {
    try {
        const productID = req.params.orderid
        const sql = 'UPDATE `cartinfo` SET quantity = quantity + 1 WHERE id =?'
        db.query(sql, [productID], (err, result) => {
            if (err) return next(err);
            res.status(200).json({ message: "Product quantity incremented successfully" });
        });
    } catch (error) {
        next(error);
    }
}


module.exports = { updateOrderClientSide , incrementProductQuantity, decrementProductQuantity, fetchOrdersOfSpecificUser, fetchallorders, addOrder, deleteOrder, updateOrder, sortOrdersByStatus, fetchRecentOrders, searchOrder, }
