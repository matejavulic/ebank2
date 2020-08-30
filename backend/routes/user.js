/*
 * License: The MIT License (MIT)
 * Author:E-bank IT team
 * Author email: @ebanka-it.com
 * Date: Fri Aug 23 2019
 * Description:
 * Main user back-end user handler.
 * Has the following methods:
 * 1. /signup -> hash user function,
 *            -> save user data in mongoDB
 *            -> create new bank client with random data and insert it into MySQL db
 *            -> get random user data (homeaddress, number...) from Django server and update user in MongoDB
 * 2. /login
 * 3. Functions to create/get bank client data and its transactions
 * 4. Current date/time stamp function
 */

const express = require("express");
const Mysqldb = require("../models/mysqldb");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const router = express.Router();
const checkAuth = require('../middleware/check-auth');
const fetch = require("node-fetch");

router.post("/signup", (req, res, next) => {

    //We hash password with salt value of 10 (recommended optimal value)
    bcrypt.hash(req.body.password, 10).then(hash => {
        let user = {
            //supplier: front-end
            email: req.body.email,
            password: hash,
            name: req.body.name,
            surname: req.body.surname,

            //supplier: Django API
            address: '',
            number: '',
            hnumber: ''
        }
        fetch('http://127.0.0.1:3002/randomUserData/random/').then(function(res) { // fetch random data from Django API
                return res.json();
            })
            .then(userPython => {
                user.address = userPython.address;
                user.number = userPython.number;
                user.hnumber = userPython.hnumber;
                return (user);
            }).catch(err => {
                if (err.code == "ECONNREFUSED")
                    return res.status(503).json({ message: "Service temporarily unavailable!" });
                else
                    return res.status(500).json({ message: "Internal server error (Django)!", err: err });
            }).then(user => {
                transactionCreateUserAccountCard(user).then(res => {
                    if (res == "23000_EMAIL") {
                        let err = new Error("existingEmail");
                        throw err;
                    } else if (res.includes("_INTER")) {
                        let err = new Error("internalDb");
                        throw err;
                    }
                }).then(() => {
                    return res.status(201).json({ message: "New user successfully created!" })
                }).catch(err => {
                    switch (err.message) {
                        case ("existingEmail"):
                            {
                                return res.status(409).json({ message: "Email already exists!" });
                            }
                        case ("internalDb"):
                            {
                                return res.status(500).json({ message: "Internal error DB!" })
                            }
                        default:
                            return res.status(500).json({ message: "Internal error!" });
                    }
                });
            });
    });
});

router.post("/login", (req, res, next) => {
    let fetchedUser;
    userFindByEmail(req.body.email).then(user => {
            if (user.length == 0) {
                let err = new Error("userNotFound");
                throw err;
            } else if (user.status == 'notVerified') {
                let err = new Error("userNotVerified");
                throw err;
            }
            fetchedUser = user[0];
            return bcrypt.compare(req.body.password, user[0].password);
        })
        .then(result => {
            if (!result) {
                let err = new Error("incorrectPassword");
                throw err;
            }
            const token = jwt.sign({ email: fetchedUser.email, userId: fetchedUser.userID },
                "MK@#E3neUXNyQCB%NwPj$W_Apa=uB^^Ebkh7&vVL4v@a8JR^&?@HqSy?XCkr+XkeD^dxQWXD^$t?MbT5VxTP?uUU@PUhZ+q$MHxJBMdafehExnwgDwDvnnSSRqCPxgG!hcPRkgvj6u?ua$-S*yJM63%r9Gf2q$t-GhtP?QRgUSpdCQ5@*KL?Dzxs7mH&dhs-6_m7KzWk_vg5#8c=DS*=WA#e4&KxFet3v7_*3E@W@3B@59Ts_RwUW^CursCCJY7C9X!kyxGy-LN!T", { expiresIn: '1h' });
            res.status(200).json({ token: token, expiresIn: 3600, userId: fetchedUser.userID });
            userUpdateLoginTime(fetchedUser.userID).then(res => {})
        }).catch(err => {
            switch (err.message) {
                case ("userNotFound"):
                    {
                        return res.status(401).json({ message: "User not found!" });
                    }
                case ("incorrectPassword"):
                    {
                        return res.status(401).json({ message: "Incorrect password!" })
                    }
                case ("userNotVerified"):
                    {
                        return res.status(200).json({ token: "User not verified!" })
                    }
                default:
                    return res.status(401).json({ message: "Login unsuccessful!" });
            }

        });
});
router.get('/dash/:id', checkAuth, (req, res, next) => {
    userFindById(req.params.id).then(user => {
        if (user) {
            accountFindFirstOneByUserId(req.params.id).then(resolution => {
                const userCombinedData = {
                    name: user.name,
                    surname: user.surname,
                    limitMonthly: resolution[0].limitMonthly,
                    usedLimit: resolution[0].usedLimit,
                    clientNumber: resolution[0].accountID,
                    branch: resolution[0].branch,
                    balance: resolution[0].currentBalance,
                    transactions: resolution.transactions
                }
                res.status(200).json(userCombinedData);
            });
        } else {
            res.status(404).json({ message: 'User not found!' });
        }
    });
});

var userUpdateLoginTime = function(userID) {
    return new Promise(function(resolve, reject) {
        let queryNode = `CALL update_login_time_user('${userID}')`;
        Mysqldb.query(queryNode, [userID], (err, results, fields) => {
            let res = results;
            if (err) {
                reject(console.log(err.message));
            }
            resolve(res);
        });
    });
}

var userCheckVerification = function(userEmail) {
    return new Promise(function(resolve, reject) {
        let queryNode = `CALL check_user_verification('${userEmail}')`
        Mysqldb.query(queryNode, [userEmail], (err, results, fields) => {
            if (err) {
                reject(console.log(err.message));
            }
            resolve(results[0]);
        });
    });
}
var userFindByEmail = function(userEmail) {
    return new Promise(function(resolve, reject) {
        userCheckVerification(userEmail).then(result => {
            if (result[0].isVerified == 0)
                resolve({ status: "notVerified" });
        })

        let queryNode = `CALL find_user_by_email('${userEmail}')`
        Mysqldb.query(queryNode, [userEmail], (err, results, fields) => {
            if (err) {
                reject(console.log(err.message));
            }
            if (results[0].length == 0) {
                resolve(results[0]);
            };
            resolve(results[0]);
        });
    });
}

var userFindById = function(userID) {
    return new Promise(function(resolve, reject) {
        let queryNode = `CALL find_user_by_id('${userID}')`;
        Mysqldb.query(queryNode, [userID], (err, results, fields) => { // the param. [userID] is the param. to be inserterd in query
            let res = results[0];
            if (err) {
                reject(console.log(err.message));
            }
            resolve(res[0]);
        });
    });
}

var transactionCreateUserAccountCard = function(user) {
    return new Promise(function(resolve, reject) {
        let queryNode = `CALL initialize_user(
          '${user.email}',
          '${user.password}',
          '${user.name}',
          '${user.surname}',
          '${user.number}',
          '${user.address}',
          '${user.hnumber}'
        )`;
        Mysqldb.query(queryNode, (err, results, fields) => {
            if (err) {
                reject(console.log(err.message));
            }
            let responseSQL = { "sqlState": results[0][0].SQL_STATE, "message": results[0][0].MESSAGE }
            switch (responseSQL.sqlState) {
                case ("369_OK"):
                    {
                        console.log("Register new user -> OK")
                        resolve(results);
                        break;
                    }
                case ("23000_EMAIL"):
                    {
                        console.log("Register new user -> DUPLICATE_EMAIL_ERROR");
                        resolve(responseSQL.sqlState)
                        break;
                    }
                    /* case (responseSQL.sqlState.("_INTER")):
                         {
                             console.log("Register new user -> INTERLNAL_ERROR");
                             reject(responseSQL.sqlState)
                             break;
                         }*/
                default:
                    {
                        console.log("Register new user -> UNKNOWN_ERROR");
                        resolve(responseSQL.sqlState);
                    }
            }
        });
    });
}

var accountFindFirstOneByUserId = function(userID) {
    return new Promise(function(resolve, reject) {
        let queryNode = `CALL get_first_account_by_user_id('${userID}')`;
        Mysqldb.query(queryNode, [userID], (err, results, fields) => { // the param. [userID] is the param. to be inserterd in query
            let res = results[0];
            if (err) {
                reject(console.log(err.message));
            }
            userGetTransactionsByAccountID(res[0].accountID).then(trans => {
                res = Object.assign({ transactions: { trans } }, res);
                resolve(res);
            }).catch(err => {
                console.log(err)
            });
        });
    });
}

var userGetTransactionsByAccountID = function(accountID) {
    return new Promise(function(resolve, reject) {
        let queryNode = `CALL get_transactions_by_account_id('${accountID}')`;
        Mysqldb.query(queryNode, [accountID], (err, results, fields) => {
            let res = results[0];
            if (err) {
                reject(console.log(err.message));
            }
            resolve(res);
        });
    });
}
module.exports = router;