const db = require("../config/db");

const addProduct = (req, res, next) => {
    console.log(req.body);
    try {
        //name , desc , stock , price , type , discoount , asset 
        // sizes
        const { name, desc, stock, price, type, discount, categorie } = req.body;
        const asset = req.file.filename;
        const sizes = JSON.parse(req.body.sizes)
        const colors = JSON.parse(req.body.colors)


        db.beginTransaction((err) => {
            if (err) return next(err);
            console.log('fff');

            const insertUserQuery = 'INSERT INTO `product` (`name`, `description`, `stock`, `price` , `type`, `discount` , `asset` , `categorie`) VALUES (?, ?, ?, ? , ? , ? , ? , ?)';
            db.query(insertUserQuery, [name, desc, stock, price, type, discount, asset, categorie], (err, result) => {
                if (err) {
                    return db.rollback(() => {
                        next(err);
                    });
                }

                const lastProductId = result.insertId;
                let i = 0;

                // Insert sizes
                for (const sizeId of sizes) {
                    console.log('nigga');
                    const sql2 = 'INSERT INTO productsizes (size, product) VALUES (?, ?)';
                    db.query(sql2, [sizeId, lastProductId], (err, result) => {
                        if (err) {
                            return db.rollback(() => {
                                next(err);
                            });
                        }

                        // Increment the counter after each query
                        i++;

                        // Commit transaction after the last query finishes
                        if (i === sizes.length) {



                            // insert product colors
                            let j = 0;
                            for (const colorID of colors) {
                                console.log('color');
                                const sql2 = 'INSERT INTO productcolors (product, color) VALUES (?, ?)';
                                db.query(sql2, [lastProductId, colorID], (err, result) => {
                                    if (err) {
                                        return db.rollback(() => {
                                            next(err);
                                        });
                                    }

                                    // Increment the counter after each query
                                    j++;

                                    // Commit transaction after the last query finishes
                                    if (j === colors.length) {
                                        db.commit((err) => {
                                            if (err) {
                                                return db.rollback(() => {
                                                    next(err);
                                                });
                                            }

                                            res.status(200).json({ message: 'User added successfully', data: result });
                                        });
                                    }
                                });
                            }

                        }
                    });
                }

            });
        });


    } catch (error) {
        next(error);
    }
}


const editProduct = (req , res , next) => {
    try {
        console.log('ak hnaaaa');
        res.status(200).json({success: true});
        // everything is set , u just need to implement le cote backend pour modifier le podduit :p 
    } catch (error) {
        
    }
}



const fetchNewClothes = (req, res, next) => {
    try {
        const sql = `SELECT 
    p.*, 
    sizes.sizes,
    colors.colors
FROM 
    product AS p
LEFT JOIN (
    SELECT 
        ps.product, 
        GROUP_CONCAT(s.size ORDER BY s.size SEPARATOR ', ') AS sizes
    FROM 
        productsizes AS ps
    JOIN 
        sizes AS s ON ps.size = s.id
    GROUP BY 
        ps.product
) AS sizes ON p.id = sizes.product
LEFT JOIN (
    SELECT 
        pc.product, 
        GROUP_CONCAT(c.color ORDER BY c.color SEPARATOR ', ') AS colors
    FROM 
        productcolors AS pc
    JOIN 
        colors AS c ON pc.color = c.id
    GROUP BY 
        pc.product
) AS colors ON p.id = colors.product
ORDER BY 
    p.createdat DESC;
`
        db.query(sql, (err, result) => {
            if (err) return next(err);
            console.log(result);
            res.status(200).json(result);
        })
    } catch (error) {

    }
}




const fetchSearchedProducts = (req, res, next) => {
    try {
        console.log('ccccccccc');
        const value = req.params.value
        const words = value.split(' ');

        const whereClauses = words.map(word => `(p.name LIKE ? OR p.description LIKE ? OR cat.categorylabel LIKE ?)`);
        const whereClause = whereClauses.join(' AND ');

        const sql = `
    SELECT 
        p.*, 
        cat.categorylabel,
        sizes.sizes,
        colors.colors
    FROM 
        product AS p
    LEFT JOIN (
        SELECT 
            ps.product, 
            GROUP_CONCAT(s.size ORDER BY s.size SEPARATOR ', ') AS sizes
        FROM 
            productsizes AS ps
        JOIN 
            sizes AS s ON ps.size = s.id
        GROUP BY 
            ps.product
    ) AS sizes ON p.id = sizes.product
    LEFT JOIN (
        SELECT 
            pc.product, 
            GROUP_CONCAT(c.color ORDER BY c.color SEPARATOR ', ') AS colors
        FROM 
            productcolors AS pc
        JOIN 
            colors AS c ON pc.color = c.id
        GROUP BY 
            pc.product
    ) AS colors ON p.id = colors.product
    JOIN 
        category AS cat ON cat.id = p.categorie 
    WHERE 
        ${whereClause}
    ORDER BY 
        p.createdat DESC;
  `;

        // Create an array of parameters to prevent SQL injection
        const parameters = [];
        words.forEach(word => {
            const likePattern = `%${word}%`;
            parameters.push(likePattern, likePattern, likePattern);
        });

        // const searchPattern = '%' + value + '%'
        db.query(sql, parameters, (err, result) => {
            if (err) return next(err);
            console.log(result);
            res.status(200).json(result);
        })

    } catch (error) {
        next(error);
    }
}

const fetchProducts = (req, res) => {
    res.json({
        message: 'Product fetched successfully',
        data: [
            {
                id: 1,
                name: 'Product 1',
                description: 'This is product 1',
                stock: 100,
                price: 10,
                type: 'Electronics',
                discount: 0,
                asset: 'product1.jpg',
                sizes: ['S', 'M', 'L']
            },
            {
                id: 2,
                name: 'Product 2',
                description: 'This is product 2',
                stock: 50,
                price: 20,
                type: 'Clothing',
                discount: 5,
                asset: 'product2.jpg',
                sizes: ['XS', 'S', 'M', 'L', 'XL']
            }
        ]
    })
}

const fetchMenProducts = (req, res, next) => {
    try {
        const sql = 'SELECT * FROM `category` WHERE `categorylabel` =?';
        db.query(sql, ['men'], (err, result) => {
            if (err) next(err);
            const categoryId = result[0].id;
            // const sql2 = 'SELECT * FROM `product` WHERE `categorie` =?';
            const sql2 = `SELECT 
    p.*, 
    sizes.sizes,
    colors.colors
FROM 
    product AS p
LEFT JOIN (
    SELECT 
        ps.product, 
        GROUP_CONCAT(s.size ORDER BY s.size SEPARATOR ', ') AS sizes
    FROM 
        productsizes AS ps
    JOIN 
        sizes AS s ON ps.size = s.id
    GROUP BY 
        ps.product
) AS sizes ON p.id = sizes.product
LEFT JOIN (
    SELECT 
        pc.product, 
        GROUP_CONCAT(c.color ORDER BY c.color SEPARATOR ', ') AS colors
    FROM 
        productcolors AS pc
    JOIN 
        colors AS c ON pc.color = c.id
    GROUP BY 
        pc.product
) AS colors ON p.id = colors.product
  WHERE p.categorie =?
ORDER BY 
    p.createdat DESC;
`;
            db.query(sql2, [categoryId], (err, result) => {
                if (err) next(err);
                res.status(200).json(result)
            });
        });
    } catch (error) {
        next(error);
    }
}

const fetchWomenProducts = (req, res, next) => {
    try {
        const sql = 'SELECT * FROM `category` WHERE `categorylabel` =?';
        db.query(sql, ['women'], (err, result) => {
            if (err) next(err);
            const categoryId = result[0].id;
            const sql2 = `SELECT 
    p.*, 
    sizes.sizes,
    colors.colors
FROM 
    product AS p
LEFT JOIN (
    SELECT 
        ps.product, 
        GROUP_CONCAT(s.size ORDER BY s.size SEPARATOR ', ') AS sizes
    FROM 
        productsizes AS ps
    JOIN 
        sizes AS s ON ps.size = s.id
    GROUP BY 
        ps.product
) AS sizes ON p.id = sizes.product
LEFT JOIN (
    SELECT 
        pc.product, 
        GROUP_CONCAT(c.color ORDER BY c.color SEPARATOR ', ') AS colors
    FROM 
        productcolors AS pc
    JOIN 
        colors AS c ON pc.color = c.id
    GROUP BY 
        pc.product
) AS colors ON p.id = colors.product
  WHERE p.categorie =?
ORDER BY 
    p.createdat DESC;
`;
            db.query(sql2, [categoryId], (err, result) => {
                if (err) next(err);
                res.status(200).json(result)
            });
        });
    } catch (error) {
        next(error);
    }
}

const fetchKidsProducts = (req, res, next) => {
    try {
        const sql = 'SELECT * FROM `category` WHERE `categorylabel` =?';
        db.query(sql, ['kids'], (err, result) => {
            if (err) next(err);
            const categoryId = result[0].id;
            const sql2 = `SELECT 
    p.*, 
    sizes.sizes,
    colors.colors
FROM 
    product AS p
LEFT JOIN (
    SELECT 
        ps.product, 
        GROUP_CONCAT(s.size ORDER BY s.size SEPARATOR ', ') AS sizes
    FROM 
        productsizes AS ps
    JOIN 
        sizes AS s ON ps.size = s.id
    GROUP BY 
        ps.product
) AS sizes ON p.id = sizes.product
LEFT JOIN (
    SELECT 
        pc.product, 
        GROUP_CONCAT(c.color ORDER BY c.color SEPARATOR ', ') AS colors
    FROM 
        productcolors AS pc
    JOIN 
        colors AS c ON pc.color = c.id
    GROUP BY 
        pc.product
) AS colors ON p.id = colors.product
  WHERE p.categorie =?
ORDER BY 
    p.createdat DESC;
`;
            db.query(sql2, [categoryId], (err, result) => {
                if (err) next(err);
                res.status(200).json(result)
            });
        });
    } catch (error) {
        next(error);
    }
}

const fetchProductsByCategoryAndType = (req, res, next) => {
    try {
        const sql = `
        SELECT 
    p.*, 
    sizes.sizes,
    colors.colors
FROM 
    product AS p
LEFT JOIN (
    SELECT 
        ps.product, 
        GROUP_CONCAT(s.size ORDER BY s.size SEPARATOR ', ') AS sizes
    FROM 
        productsizes AS ps
    JOIN 
        sizes AS s ON ps.size = s.id
    GROUP BY 
        ps.product
) AS sizes ON p.id = sizes.product
LEFT JOIN (
    SELECT 
        pc.product, 
        GROUP_CONCAT(c.color ORDER BY c.color SEPARATOR ', ') AS colors
    FROM 
        productcolors AS pc
    JOIN 
        colors AS c ON pc.color = c.id
    GROUP BY 
        pc.product
) AS colors ON p.id = colors.product
WHERE
p.categorie = ? AND p.type = ?
ORDER BY 
    p.createdat DESC;

        `
        db.query(sql, [req.params.category, req.params.type], (err, result) => {
            if (err) return next(err);
            console.log(result);
            res.status(200).json(result);
        })
    } catch (error) {
        next(error);
    }
}


const addProductToFavourite = (req, res, next) => {
    try {
        const sql = 'INSERT INTO `favouritesinfo`(`product`, `user`) VALUES (? , ?)'
        db.query(sql, [req.params.productid, req.params.userid], (err, result) => {
            if (err) return next(err);
            console.log(result);
            res.status(200).json(result);
        })
    } catch (error) {
        next(error);
    }
}

const deleteProductFromFavourite = (req, res, next) => {
    try {
        const sql = 'DELETE FROM `favouritesinfo` WHERE `product` = ? AND `user` = ?'
        db.query(sql, [req.params.productid, req.params.userid], (err, result) => {
            if (err) return next(err);
            console.log(result);
            res.status(200).json(result);
        })
    } catch (error) {
        next(error);
    }
}

const fetchProductsFromFavourite = (req, res, next) => {
    try {
        const sql = `
        SELECT 
    p.*, 
    sizes.sizes,
    colors.colors
FROM 
    product AS p
LEFT JOIN (
    SELECT 
        ps.product, 
        GROUP_CONCAT(s.size ORDER BY s.size SEPARATOR ', ') AS sizes
    FROM 
        productsizes AS ps
    JOIN 
        sizes AS s ON ps.size = s.id
    GROUP BY 
        ps.product
) AS sizes ON p.id = sizes.product
LEFT JOIN (
    SELECT 
        pc.product, 
        GROUP_CONCAT(c.color ORDER BY c.color SEPARATOR ', ') AS colors
    FROM 
        productcolors AS pc
    JOIN 
        colors AS c ON pc.color = c.id
    GROUP BY 
        pc.product
) AS colors ON p.id = colors.product
JOIN favouritesinfo AS fav ON fav.product = p.id
WHERE fav.user = ?
ORDER BY 
    p.createdat DESC;

        `
        db.query(sql, [req.params.userid], (err, result) => {
            if (err) return next(err);
            console.log('oui hna');
            console.log(result);
            res.status(200).json(result);
        })
    } catch (error) {
        next(error);
    }
}

const fetchCartProducts = (req, res, next) => {
    try {
        const sql = `
        
        SELECT 
    p.*, 
    cart.*,
    sizes.sizes,
    colors.colors
FROM 
    product AS p
LEFT JOIN (
    SELECT 
        ps.product, 
        GROUP_CONCAT(s.size ORDER BY s.size SEPARATOR ', ') AS sizes
    FROM 
        productsizes AS ps
    JOIN 
        sizes AS s ON ps.size = s.id
    GROUP BY 
        ps.product
) AS sizes ON p.id = sizes.product
LEFT JOIN (
    SELECT 
        pc.product, 
        GROUP_CONCAT(c.color ORDER BY c.color SEPARATOR ', ') AS colors
    FROM 
        productcolors AS pc
    JOIN 
        colors AS c ON pc.color = c.id
    GROUP BY 
        pc.product
) AS colors ON p.id = colors.product
JOIN cartinfo AS cart ON cart.product = p.id
WHERE cart.user = ?
ORDER BY 
    p.createdat DESC;
        `
        db.query(sql, [req.params.userid], (err, result) => {
            if (err) return next(err);
            console.log(result);
            res.status(200).json(result);
        })
    } catch (error) {
        next(error);
    }
}

const deleteProduct = (req, res) => { }
const updateProduct = (req, res) => { }
const orderProductBy = (req, res) => { }

module.exports = { editProduct , fetchCartProducts, fetchProductsFromFavourite, deleteProductFromFavourite, addProductToFavourite, fetchProductsByCategoryAndType, fetchNewClothes, fetchSearchedProducts, fetchKidsProducts, fetchWomenProducts, fetchMenProducts, addProduct, fetchProducts, deleteProduct, orderProductBy, updateProduct }