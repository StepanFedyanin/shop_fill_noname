const express = require('express')
const mysql = require('mysql2')
const path = require('path');


const app = express();
app.use(express.json())
let User_id = null;



const connectionPool = mysql.createConnection({
    host: process.env.DB_HOST || '127.0.0.1',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASS || 'fedyanin2270',
    database: process.env.DB_NAME || 'clothes',
})
connectionPool.connect((err) => {
    if (err) {
        console.error('ошибка' + err)
    } else {
        console.log('Соедение установлено')
    }
})

app.get('/api/pruductlist', (reg, res) => {
    connectionPool.query('CALL clothes.getListProduct()', (err, data) => {
        if (err) {
            res.status(500)
        } else {
            res.json(data);
        }
    })

})
app.get('/api/filter_params', (reg, res) => {
    connectionPool.query('SELECT characteristics_material,characteristics_fasteners,characteristics_picture,characteristics_gender,characteristics_season,characteristics_type FROM clothes.characteristics GROUP BY characteristics_material,characteristics_fasteners,characteristics_picture,characteristics_gender,characteristics_season,characteristics_type ', (err, data) => {
        if (err) {
            res.status(500)
        } else {
            connectionPool.query('SELECT color_value,color_name FROM clothes.color GROUP BY color_value,color_name', (err2, data2) => {
                if (err2) {
                    res.status(500)
                } else {
                    res.json({params: data, color: data2});
                }
            })
        }
    })
})
app.post('/api/pruductlist_filter', (reg, res) => {
    console.log(reg.body)
    connectionPool.query('CALL clothes.getFilterList(\'\',\'\',\'\',\'\',\'\',\'\',\'\')', (err, data) => {
        if (err) {
            res.status(500)
        } else {
            res.json(data[0]);
        }
    })
})


app.get('/api/product/:id', (reg, res) => {
    connectionPool.query('CALL clothes.getProduct(' + User_id + ',' + reg.params.id + ')', (err, data) => {
        if (err) {
            res.status(500)
        } else {
            connectionPool.query('CALL clothes.getProductSize(' + reg.params.id + ')', (err2, data2) => {
                if (err2) {
                    res.status(500)
                } else {
                    res.json({content: data[0][0], sizeList: data2[0]})
                }
            })
        }
    })
})


app.get('/api/basket', (reg, res) => {
    connectionPool.query('call clothes.getListBasket(' + User_id + ')', (err, data) => {
        if (err) {
            res.status(500)
        } else {
            res.json(data[0]);
        }
    })
})
app.post('/api/add_basket', (reg, res) => {
    connectionPool.query('call clothes.addListBasket(' + reg.body.product_id + ',' + User_id + ',' + 1 + ',' + reg.body.size_id + ')', (err, data) => {
        if (err) {
            res.status(500)
        } else {
            res.json({})
        }
    })
})
app.post('/api/delete_basket_product', (reg, res) => {
    connectionPool.query('call clothes.delitListBasket(' + reg.body.basket_id + ')', (err, data) => {
        if (err) {
            res.status(500)
        } else {
            res.json({})
        }
    })
})
app.post('/api/update/quantity', (reg, res) => {
    connectionPool.query('call clothes.updateProductQuantity(' + reg.body.valueQuantity + ',' + reg.body.basket_id + ')', (err, data) => {
        if (err) {
            res.status(500)
        } else {
            res.json({})
        }
    })
})

app.get('/api/favorites', (reg, res) => {
    connectionPool.query('call clothes.getListFavorites(' + User_id + ')', (err, data) => {
        if (err) {
            res.status(500)
        } else {
            res.json(data[0]);
        }
    })
})
app.post('/api/add_favorites', (reg, res) => {
    connectionPool.query('call clothes.addListFavorites(' + User_id + ',' + reg.body.product_id + ');', (err, data) => {
        if (err) {
            res.status(500)
        } else {
            res.json({})
        }
    })
})
app.post('/api/delete_favorites_product', (reg, res) => {
    console.log(reg.body)
    connectionPool.query('call clothes.deliteListFavorites(' + reg.body.basket_id + ');', (err, data) => {
        if (err) {
            console.log(err)
            res.status(500);
        } else {
            res.json({})
        }
    })
})

app.get('/api/purchases', (reg, res) => {
    connectionPool.query('call clothes.getPurchases(' + User_id + ')', (err, data) => {
        if (err) {
            res.status(500)
        } else {
            res.json(data[0]);
        }
    })
})


const deleteBasket = (pro_list, res) => {
    for (const product of pro_list) {
        connectionPool.query('call clothes.delitListBasket(' + product.basket_id + ')', (err, data) => {
            if (err) {
                console.log(err);
            } else {
                res.status(200);
            }
        })
    }
}
app.post('/api/add_purchases', (reg, res) => {
    let resNext = res;
    console.log(reg.body.pro_list)
    for (const product of reg.body.pro_list) {
        connectionPool.query('call clothes.addPurchases(' + User_id + "," + product.product_id + "," + 1 + ',' + product.size_id + ');', (err, data) => {
            if (err) {
                console.log(err)
                res.status(500);
            }
        })
    }
    res.json({});
    deleteBasket(reg.body.pro_list, resNext);
})


const dataCheck = (dataUser, res) => {
    connectionPool.query('call clothes.UserEntry();', (err, data) => {
        if (err) {
            res.status(500);
        } else {
            let dataBD = null;
            data[0].map(user => {
                if (user.client_mail == dataUser.email & user.client_password == dataUser.password) {
                    User_id = user.client_id;
                    dataBD = user;
                }
            })
            if (User_id) {
                res.json({authorized: true, userInfo: dataBD});
            } else {
                res.json({authorized: false, userInfo: {}});
            }

        }
    })
}


app.post('/api/add_user', async (reg, res) => {
    const newUserObj = reg.body;
    connectionPool.query('call clothes.addUser(' + "'" + newUserObj.new_name + "','" + newUserObj.new_surname + "','" + newUserObj.new_patronymic + "','" + newUserObj.new_mail + "','" + newUserObj.new_pass + "','" + newUserObj.new_phone + "'" + ');', (err, data) => {
        if (err) {
            console.log(err)
            res.status(500);
        } else {
            res.json({
                pass: newUserObj.new_pass,
                mail: newUserObj.new_mail
            });
        }
    })
})

app.post('/api/user', async (reg, res) => {
    dataCheck(reg.body, res);
})
app.get('/api/user_exit', async (reg, res) => {
    User_id = null;
    res.json({authorized: false, userInfo: {}});
})


app.get('/api/user_update', (reg, res) => {
    connectionPool.query('call clothes.UpdateUser(' + User_id + ');', (err, data) => {
        if (err) {
            res.status(500)
        } else {
            res.json(data[0])
        }
    })
})
app.post('/api/user_update_address', (reg, res) => {
    connectionPool.query('call clothes.UpdateUserAddress(' + "'" + reg.body.region + "','" + reg.body.city + "','" + reg.body.street + "'," + reg.body.house + "," + reg.body.appartment + "," + reg.body.index + "," + reg.body.payment_method + "," + reg.body.snipping_method + ',' + User_id + ')', [], (err, data) => {
            if (err) {
                res.status(500)
            } else {
                res.json(true);
            }
        }
    )
})


app.use(express.static(path.join(__dirname, 'client/build')));
app.get('*', (reg, res) => {
    res.json(path.join(__dirname, 'client/build', 'index.html'))
})
app.listen(5000,()=>{
    console.log('запустилоьс')
})
console.log(path.join(__dirname, 'client/build'))


