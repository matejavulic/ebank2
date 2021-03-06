/*
 * License: The MIT License (MIT)
 * Author:E-bank IT team
 * Author email: @ebanka-it.com
 * Date: Fri Aug 23 2019
 * Description:
 * Main user back-end user handler.
 * Has the following methods:
 * 1. /signup -> hash user function,
 *            -> save user data in MySQL db
 *            -> create new bank client with random data and insert it into MySQL db
 *            -> get random user data (homeaddress, number...) from API and update user in MySQL
 *            -> get current exchange list from exchangeList API
 * 2. /login
 * 3. Functions to create/get bank client data and its transactions
 * 4. Current date/time stamp function
 */

const express = require("express");
const Mysqldb = require("../models/mysqldb");
const bcrypt = require("bcrypt");
const crypto = require("crypto")
const jwt = require("jsonwebtoken");
const router = express.Router();
const checkAuth = require('../middleware/check-auth');
const fetch = require("node-fetch");
const nodemailer = require('nodemailer');

const path = require('path')
require('dotenv').config({ path: path.resolve(__dirname, '../.env') })

/*Temporary! */
var request = require('request');

/* .env variables */
const apiDjangoUrl = process.env.NODE_ENV === 'production' ? process.env.PRO_API_DJANGO : process.env.DEV_API_DJANGO;
const homeUrl = process.env.NODE_ENV === 'production' ? process.env.PRO_FE_SERVER : process.env.DEV_FE_SERVER;
const backendUrl = process.env.NODE_ENV === 'production' ? process.env.PRO_BE_SERVER : process.env.DEV_BE_SERVER;
const apiSmsUrl = process.env.API_SMS;

const emailUsername = process.env.EMAIL_USERNAME;
const emailPassword = process.env.EMAIL_PASSWORD;
const emailHost = process.env.EMAIL_HOST;
const emailPort = process.env.EMAIL_PORT;
const emailSecure = process.env.EMAIL_SECURE;

router.post("/signup", (req, res, next) => {
    generateToken().then(verifToken => {
        bcrypt.hash(verifToken, 10).then(hashedToken => {
            let tokens = { 'hash': hashedToken, 'raw': verifToken };
            return tokens;
        }).then((tokens) => {
            //We hash password with salt value of 10 (recommended optimal value)
            bcrypt.hash(req.body.password, 10).then(hash => {
                let user = {
                    //supplier: front-end
                    email: req.body.email,
                    password: hash,
                    name: req.body.name,
                    surname: req.body.surname,
                    number: req.body.number,

                    //supplier: Django API
                    address: '',
                    //number: '',
                    hnumber: '',

                    //supplier Node
                    token: tokens.hash,
                    rawToken: tokens.raw
                }
                return user;
            }).then(user => {
                fetch(apiDjangoUrl + 'randomUserData/random/').then(function(apiRes) { // fetch random data from Django API
                        console.log(apiDjangoUrl + 'randomUserData/random/');
                        return apiRes.json();
                    }).catch(err => {
                        if (err.code == "ECONNREFUSED")
                            return res.status(503).json({ message: "Service temporarily unavailable!" });
                        else
                            return res.status(500).json({ message: "Internal server error (API Django)!", err: err })
                    })
                    .then(userPython => {
                        user.address = userPython.address;
                        //user.number = userPython.number;
                        user.hnumber = userPython.hnumber;
                        return user;
                    }).then(user => {
                        return user
                    }).then(user => {
                        transactionCreateUserAccountCard(user).then(dbRes => {
                            if (dbRes == "23000_EMAIL") {
                                let err = new Error("existingEmail");
                                throw err;
                            } else if (dbRes.includes("_INTER")) {
                                let err = new Error("internalDb");
                                throw err;
                            }
                        }).then(() => {
                            sendVerifMail(user.email, user.name, user.rawToken);
                            user.rawToken = "";
                            return res.status(201).json({ message: "New user successfully created." });
                        }).catch(err => {
                            switch (err.message) {
                                case ("existingEmail"):
                                    {
                                        return res.status(409).json({ message: "This email already exists. Do you want to login instead?" });
                                    }
                                case ("internalDb"):
                                    {
                                        return res.status(500).json({ message: "Internal error. Please try later." })
                                    }
                                default:
                                    return res.status(500).json(err.message);
                            }
                        });
                    });
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
                process.env.TOKEN_SIGN, { expiresIn: '1h' });
            res.status(200).json({ token: token, expiresIn: 3600, userId: fetchedUser.userID });
            userUpdateLoginTime(fetchedUser.userID).then(loginTimeStatus => {})
        }).catch(err => {
            switch (err.message) {
                case ("userNotFound"):
                    {
                        return res.status(401).json({ message: "User not found. Please check entered e-mail." });
                    }
                case ("incorrectPassword"):
                    {
                        return res.status(401).json({ message: "Incorrect password. Please check entered password." })
                    }
                case ("userNotVerified"):
                    {
                        return res.status(401).json({ message: "User not verified. Please check your verification e-mail." })
                    }
                default:
                    return res.status(401).json({ message: "Login unsuccessful. PLease try later." });
            }
        });
});
router.get("/verify", (req, res, next) => { // post?
    verifyUser(req.query.code, req.query.id).then(resp => {
        if (resp == 1) {
            res.redirect(homeUrl);
        } else if (resp == 0) {
            let err = new Error("User not found");
            throw err;
        } else if (resp == 2) {
            let err = new Error("User already verified");
            throw err;
        } else {
            let err = new Error();
            throw err;
        }
    }).catch(err => {
        if (err == "User not found") {
            console.log(err);
            res.redirect(homeUrl + 'login');
        } else if (err == "User already verified") {
            console.log(err);
            res.redirect(homeUrl + 'login');
        } else {
            console.log(err);
            res.redirect(homeUrl + 'login');
        }
    })
});
router.get("/reset", (req, res, next) => { // post?
    resetUserPassword(req.query.code, req.query.id).then(resp => {
        if (resp == 1) {
            // napravi slucajan broj, hesuj, upisi u bazu
            generateTokenNumber().then(tempPass => {
                console.log("Temporary password: ", tempPass);
                sendSms(req.query.id, tempPass).then(smsStatus => {
                    if (smsStatus == 0) {
                        let err = new Error("SMS error");
                        throw err;
                    }
                }).then(() => {
                    bcrypt.hash(tempPass, 10).then(hashedTempPass => {
                        return new Promise(function(resolve, reject) {
                            let queryNode = `CALL set_temp_pass_id(?,?)`;
                            Mysqldb.query(queryNode, [req.query.id, hashedTempPass], (err, results, fields) => {
                                let dbResPass = results;
                                if (err) {
                                    let err = new Error();
                                    throw err;
                                }
                                resolve(dbResPass);
                            });
                        })
                    })
                })
            }).then(() => {
                return new Promise(function(resolve, reject) {
                    let queryNode1 = `DROP EVENT IF EXISTS reset_temp_pass_event_${req.query.id}`;
                    Mysqldb.query(queryNode1, [req.query.id], (err, results, fields) => {
                        let resEvent1 = results;
                        if (err) {
                            reject(err);
                        } else {
                            let queryNode2 = `CREATE EVENT reset_temp_pass_event_${req.query.id} ON SCHEDULE AT ADDTIME(CURRENT_TIMESTAMP,200) DO UPDATE ebank.user SET temporaryPassword = null WHERE userID =${req.query.id};`;
                            // If event does not run, it means it is disabled after mysql restart! (SET GLOBAL event_scheduler = ON;)
                            Mysqldb.query(queryNode2, (err, results, fields) => {
                                let resEvent2 = results;
                                if (err) {
                                    reject(err);
                                } else {
                                    resolve(res);
                                }
                            });
                        }
                    });
                });
            }).catch(err => {
                console.log(err);
            }).then(() => {
                return res.redirect(homeUrl);
            })
        } else if (resp == 0) {
            let err = new Error("User not found");
            throw err;
        } else if (resp == 3) {
            let err = new Error("Password reset expired");
            throw err;
        } else {
            let err = new Error();
            throw err;
        }
    }).catch(err => {
        if (err == "User not found") {
            console.log(err);
            res.redirect(homeUrl + 'login');
        } else if (err == "Password reset expired") {
            console.log(err);
            res.redirect(homeUrl + 'login');
        } else {
            console.log(err);
            res.redirect(homeUrl + 'login');
        }
    })
});
router.post("/resend", (req, res, next) => { // post?
    generateToken().then(verifToken => {
        bcrypt.hash(verifToken, 10).then(hashedToken => {
            return new Promise(function(resolve, reject) {
                let queryNode = `CALL find_user_by_email('${req.body.email}')`;
                Mysqldb.query(queryNode, [req.body.email], (err, results, fields) => {
                    let res = results;
                    if (err) {
                        let err = new Error();
                        throw err;
                    }
                    resolve(res[0][0].userID);
                });
            }).then(userID => {
                let queryNode = `CALL set_new_verification_token('${userID}','${hashedToken}')`;
                Mysqldb.query(queryNode, [req.body.email], (err, results, fields) => {
                    let res = results;
                    if (err) {
                        let err = new Error();
                        throw err;
                    }
                });
                try {
                    sendVerifMail(req.body.email, req.body.userName, verifToken);
                    return res.status(201).json({ message: "New verification e-mail successfully sent." });
                } catch (error) {
                    return res.status(500).json({ message: "Internal server error - please try later." });
                }
            });
        });
    });
});
router.post("/reset", (req, res, next) => { // post?
    generateToken().then(resetToken => {
        bcrypt.hash(resetToken, 10).then(hashedToken => {
            return new Promise(function(resolve, reject) {
                let queryNode = `CALL find_user_by_email('${req.body.email}')`;
                Mysqldb.query(queryNode, [req.body.email], (err, results, fields) => {
                    let res = results;
                    if (err) {
                        let err = new Error("Unknown email!");
                        throw err;
                    }
                    if (res[0].length == 0) {
                        reject(res);
                    } else
                        resolve(res[0][0].userID);
                })
            }).catch(() => {}).then(userID => {
                return new Promise(function(resolve, reject) {
                        let queryNode = `CALL set_new_password_reset_token('${userID}','${hashedToken}')`;
                        Mysqldb.query(queryNode, (err, results, fields) => {
                            let res = results;
                            if (err) {
                                reject(err);
                            } else
                                resolve();
                        })
                    })
                    .then(() => {
                        sendPasswordResetMail(req.body.email, resetToken);
                        return res.status(201).json({ message: "New password reset e-mail successfully sent." });
                    }).catch((err) => {
                        if (err.message = "Unknown email!")
                            return res.status(500).json({ message: "We cannot find entered email. Please try again." });
                        return res.status(500).json({ message: "Internal server error - please try later." });
                    });
            });
        });
    });
})
router.get('/dash/:id', checkAuth, (req, res, next) => {
    userFindById(req.params.id).then(user => {
        if (user) {
            accountFindFirstOneByUserId(req.params.id).then(resolution => {
                fetch(apiDjangoUrl + 'exchangelist/eur/').then(function(res) { // fetch random data from Django API
                        return res.json();
                    }).catch(err => {
                        if (err.code == "ECONNREFUSED")
                            return res.status(503).json({ message: "Service temporarily unavailable. PLease try later." });
                        else
                            return res.status(500).json({ message: "Internal server error (Django). Please try later.", err: err })
                    })
                    .then(exchangeList => {
                        const userCombinedData = {
                            name: user.name,
                            surname: user.surname,
                            limitMonthly: resolution[0].limitMonthly,
                            usedLimit: resolution[0].usedLimit,
                            clientNumber: resolution[0].accountID,
                            branch: resolution[0].branch,
                            balance: resolution[0].currentBalance,
                            transactions: resolution.transactions,
                            exchangeList: exchangeList
                        }
                        res.status(200).json(userCombinedData);
                    });
            });
        } else {
            res.status(404).json({ message: 'User not found.' });
        }
    });
});

const transporter = nodemailer.createTransport({
    host: emailHost,
    port: emailPort,
    secure: emailSecure,
    auth: {
        user: emailUsername,
        pass: emailPassword,
    },
});
const sendVerifMail = function(userEmail, userName, userRawToken) {
    getVerifToken(userEmail).then(result => {
        let token = userRawToken;
        let currentVerifCode = result[0].verificationCode;
        let userID = result[0].userID;
        if (currentVerifCode != null) {
            const baseurl = backendUrl + 'api/user';
            const repourl = backendUrl + 'repository/images/'
            const link = `${baseurl}/verify/?code=${token}&id=${userID}`;
            const mailOptions = {
                from: '"E-Bank" <test1aplikacija@gmail.com>',
                to: 'bblog@gmx.com',
                subject: 'E-Bank Account Verification',
                html: `<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional //EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

            <html xmlns="http://www.w3.org/1999/xhtml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:v="urn:schemas-microsoft-com:vml">
            <head>
            <!--[if gte mso 9]><xml><o:OfficeDocumentSettings><o:AllowPNG/><o:PixelsPerInch>96</o:PixelsPerInch></o:OfficeDocumentSettings></xml><![endif]-->
            <meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
            <meta content="width=device-width" name="viewport"/>
            <!--[if !mso]><!-->
            <meta content="IE=edge" http-equiv="X-UA-Compatible"/>
            <!--<![endif]-->
            <title></title>
            <!--[if !mso]><!-->
            <!--<![endif]-->
            <style type="text/css">
                body {
                  margin: 0;
                  padding: 0;
                }

                table,
                td,
                tr {
                  vertical-align: top;
                  border-collapse: collapse;
                }

                * {
                  line-height: inherit;
                }

                a[x-apple-data-detectors=true] {
                  color: inherit !important;
                  text-decoration: none !important;
                }
              </style>
            <style id="media-query" type="text/css">
                @media (max-width: 660px) {

                  .block-grid,
                  .col {
                    min-width: 320px !important;
                    max-width: 100% !important;
                    display: block !important;
                  }

                  .block-grid {
                    width: 100% !important;
                  }

                  .col {
                    width: 100% !important;
                  }

                  .col>div {
                    margin: 0 auto;
                  }

                  img.fullwidth,
                  img.fullwidthOnMobile {
                    max-width: 100% !important;
                  }

                  .no-stack .col {
                    min-width: 0 !important;
                    display: table-cell !important;
                  }

                  .no-stack.two-up .col {
                    width: 50% !important;
                  }

                  .no-stack .col.num4 {
                    width: 33% !important;
                  }

                  .no-stack .col.num8 {
                    width: 66% !important;
                  }

                  .no-stack .col.num4 {
                    width: 33% !important;
                  }

                  .no-stack .col.num3 {
                    width: 25% !important;
                  }

                  .no-stack .col.num6 {
                    width: 50% !important;
                  }

                  .no-stack .col.num9 {
                    width: 75% !important;
                  }

                  .video-block {
                    max-width: none !important;
                  }

                  .mobile_hide {
                    min-height: 0px;
                    max-height: 0px;
                    max-width: 0px;
                    display: none;
                    overflow: hidden;
                    font-size: 0px;
                  }

                  .desktop_hide {
                    display: block !important;
                    max-height: none !important;
                  }
                }
              </style>
            </head>
            <body class="clean-body" style="margin: 0; padding: 0; -webkit-text-size-adjust: 100%; background-color: #f8f8f9;">
            <!--[if IE]><div class="ie-browser"><![endif]-->
            <table bgcolor="#f8f8f9" cellpadding="0" cellspacing="0" class="nl-container" role="presentation" style="table-layout: fixed; vertical-align: top; min-width: 320px; Margin: 0 auto; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #f8f8f9; width: 100%;" valign="top" width="100%">
            <tbody>
            <tr style="vertical-align: top;" valign="top">
            <td style="word-break: break-word; vertical-align: top;" valign="top">
            <!--[if (mso)|(IE)]><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td align="center" style="background-color:#f8f8f9"><![endif]-->
            <div class="block-grid" style="Margin: 0 auto; min-width: 320px; max-width: 640px; overflow-wrap: break-word; word-wrap: break-word; word-break: break-word; background-color: #1aa19c;">
            <div style="border-collapse: collapse;display: table;width: 100%;background-color:#1aa19c;">
            <!--[if (mso)|(IE)]><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#1aa19c;"><tr><td align="center"><table cellpadding="0" cellspacing="0" border="0" style="width:640px"><tr class="layout-full-width" style="background-color:#1aa19c"><![endif]-->
            <!--[if (mso)|(IE)]><td align="center" width="640" style="background-color:#1aa19c;width:640px; border-top: 0px solid transparent; border-left: 0px solid transparent; border-bottom: 0px solid transparent; border-right: 0px solid transparent;" valign="top"><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 0px; padding-left: 0px; padding-top:0px; padding-bottom:0px;"><![endif]-->
            <div class="col num12" style="min-width: 320px; max-width: 640px; display: table-cell; vertical-align: top; width: 640px;">
            <div style="width:100% !important;">
            <!--[if (!mso)&(!IE)]><!-->
            <div style="border-top:0px solid transparent; border-left:0px solid transparent; border-bottom:0px solid transparent; border-right:0px solid transparent; padding-top:0px; padding-bottom:0px; padding-right: 0px; padding-left: 0px;">
            <!--<![endif]-->
            <table border="0" cellpadding="0" cellspacing="0" class="divider" role="presentation" style="table-layout: fixed; vertical-align: top; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;" valign="top" width="100%">
            <tbody>
            <tr style="vertical-align: top;" valign="top">
            <td class="divider_inner" style="word-break: break-word; vertical-align: top; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;" valign="top">
            </td>
            </tr>
            </tbody>
            </table>
            <!--[if (!mso)&(!IE)]><!-->
            </div>
            <!--<![endif]-->
            </div>
            </div>
            <!--[if (mso)|(IE)]></td></tr></table><![endif]-->
            <!--[if (mso)|(IE)]></td></tr></table></td></tr></table><![endif]-->
            </div>
            </div>
            </div>
            <div style="background-color:transparent;">
            <div class="block-grid" style="Margin: 0 auto; min-width: 320px; max-width: 640px; overflow-wrap: break-word; word-wrap: break-word; word-break: break-word; background-color: #800000;">
            <div style="border-collapse: collapse;display: table;width: 100%;background-color:#800000;">
            <!--[if (mso)|(IE)]><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#fff;"><tr><td align="center"><table cellpadding="0" cellspacing="0" border="0" style="width:640px"><tr class="layout-full-width" style="background-color:#800000"><![endif]-->
            <!--[if (mso)|(IE)]><td align="center" width="640" style="background-color:#800000;width:640px; border-top: 0px solid transparent; border-left: 0px solid transparent; border-bottom: 0px solid transparent; border-right: 0px solid transparent;" valign="top"><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 0px; padding-left: 0px; padding-top:0px; padding-bottom:0px;"><![endif]-->
            <div class="col num12" style="min-width: 320px; max-width: 640px; display: table-cell; vertical-align: top; width: 640px;">
            <div style="width:100% !important;">
            <!--[if (!mso)&(!IE)]><!-->
            <div style="border-top:0px solid transparent; border-left:0px solid transparent; border-bottom:0px solid transparent; border-right:0px solid transparent; padding-top:0px; padding-bottom:0px; padding-right: 0px; padding-left: 0px;">
            <!--<![endif]-->
            <div align="center" class="img-container center fixedwidth" style="padding-right: 0px;padding-left: 0px;">
            <!--[if mso]><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr style="line-height:0px"><td style="padding-right: 0px;padding-left: 0px;" align="center"><![endif]--><img align="center" alt="E-Bank" border="0" class="center fixedwidth" src="${repourl}logo2.PNG" style="text-decoration: none; -ms-interpolation-mode: bicubic; height: auto; border: 0; width: 100%; max-width: 224px; display: block;" title="Alternate text" width="224"/>
            <!--[if mso]></td></tr></table><![endif]-->
            </div>
            <!--[if (!mso)&(!IE)]><!-->
            </div>
            <!--<![endif]-->
            </div>
            </div>
            <!--[if (mso)|(IE)]></td></tr></table><![endif]-->
            <!--[if (mso)|(IE)]></td></tr></table></td></tr></table><![endif]-->
            </div>
            </div>
            </div>
            <div style="background-color:transparent;">
            <div class="block-grid" style="Margin: 0 auto; min-width: 320px; max-width: 640px; overflow-wrap: break-word; word-wrap: break-word; word-break: break-word; background-color: #ffffff;">
            <div style="border-collapse: collapse;display: table;width: 100%;background-color:transparent;">
            <!--[if (mso)|(IE)]><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:transparent;"><tr><td align="center"><table cellpadding="0" cellspacing="0" border="0" style="width:640px"><tr class="layout-full-width" style="background-color:#ffffff"><![endif]-->
            <!--[if (mso)|(IE)]><td align="center" width="640" style="background-color:#ffffff;width:640px; border-top: 0px solid transparent; border-left: 0px solid transparent; border-bottom: 0px solid transparent; border-right: 0px solid transparent;" valign="top"><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 0px; padding-left: 0px; padding-top:5px; padding-bottom:5px;"><![endif]-->
            <div class="col num12" style="min-width: 320px; max-width: 640px; display: table-cell; vertical-align: top; width: 640px;">
            <div style="width:100% !important;">
            <!--[if (!mso)&(!IE)]><!-->
            <div style="border-top:0px solid transparent; border-left:0px solid transparent; border-bottom:0px solid transparent; border-right:0px solid transparent; padding-top:5px; padding-bottom:5px; padding-right: 0px; padding-left: 0px;">
            <!--<![endif]-->
            <table border="0" cellpadding="0" cellspacing="0" class="divider" role="presentation" style="table-layout: fixed; vertical-align: top; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;" valign="top" width="100%">
            <tbody>
            <tr style="vertical-align: top;" valign="top">
            <td class="divider_inner" style="word-break: break-word; vertical-align: top; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; padding-top: 20px; padding-right: 20px; padding-bottom: 20px; padding-left: 20px;" valign="top">
            <table align="center" border="0" cellpadding="0" cellspacing="0" class="divider_content" role="presentation" style="table-layout: fixed; vertical-align: top; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-top: 0px solid #BBBBBB; width: 100%;" valign="top" width="100%">
            <tbody>
            <tr style="vertical-align: top;" valign="top">
            </tr>
            </tbody>
            </table>
            </td>
            </tr>
            </tbody>
            </table>
            <!--[if (!mso)&(!IE)]><!-->
            </div>
            <!--<![endif]-->
            </div>
            </div>
            <!--[if (mso)|(IE)]></td></tr></table><![endif]-->
            <!--[if (mso)|(IE)]></td></tr></table></td></tr></table><![endif]-->
            </div>
            </div>
            </div>
            <div style="background-color:transparent;">
            <div class="block-grid" style="Margin: 0 auto; min-width: 320px; max-width: 640px; overflow-wrap: break-word; word-wrap: break-word; word-break: break-word; background-color: #fff;">
            <div style="border-collapse: collapse;display: table;width: 100%;background-color:#fff;">
            <!--[if (mso)|(IE)]><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:transparent;"><tr><td align="center"><table cellpadding="0" cellspacing="0" border="0" style="width:640px"><tr class="layout-full-width" style="background-color:#fff"><![endif]-->
            <!--[if (mso)|(IE)]><td align="center" width="640" style="background-color:#fff;width:640px; border-top: 0px solid transparent; border-left: 0px solid transparent; border-bottom: 0px solid transparent; border-right: 0px solid transparent;" valign="top"><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 0px; padding-left: 0px; padding-top:0px; padding-bottom:0px;"><![endif]-->
            <div class="col num12" style="min-width: 320px; max-width: 640px; display: table-cell; vertical-align: top; width: 640px;">
            <div style="width:100% !important;">
            <!--[if (!mso)&(!IE)]><!-->
            <div style="border-top:0px solid transparent; border-left:0px solid transparent; border-bottom:0px solid transparent; border-right:0px solid transparent; padding-top:0px; padding-bottom:0px; padding-right: 0px; padding-left: 0px;">
            <!--<![endif]-->
            <!--[if mso]><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 40px; padding-left: 40px; padding-top: 10px; padding-bottom: 10px; font-family: Tahoma, sans-serif"><![endif]-->
            <div style="color:#555555;font-family:Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif;line-height:1.2;padding-top:10px;padding-right:40px;padding-bottom:10px;padding-left:40px;">
            <div style="line-height: 1.2; font-size: 12px; color: #555555; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; mso-line-height-alt: 14px;">
            <p style="font-size: 30px; line-height: 1.2; text-align: center; word-break: break-word; mso-line-height-alt: 36px; margin: 0;"><span style="font-size: 30px; color: #2b303a;"><strong>Almost there!</strong></span></p>
            </div>
            </div>
            <!--[if mso]></td></tr></table><![endif]-->
            <!--[if mso]><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 40px; padding-left: 40px; padding-top: 10px; padding-bottom: 10px; font-family: Tahoma, sans-serif"><![endif]-->
            <div style="color:#555555;font-family:Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif;line-height:1.5;padding-top:10px;padding-right:40px;padding-bottom:10px;padding-left:40px;">
            <div style="line-height: 1.5; font-size: 12px; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; color: #555555; mso-line-height-alt: 18px;">
            <p style="font-size: 15px; line-height: 1.5; word-break: break-word; text-align: left; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; mso-line-height-alt: 23px; margin: 0;"><span style="color: #808389; font-size: 15px;">Hi ${userName},</span></p>
            <p style="font-size: 14px; line-height: 1.5; word-break: break-word; text-align: justify; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; mso-line-height-alt: 21px; margin: 0;"> </p>
            <p style="font-size: 15px; line-height: 1.5; word-break: break-word; text-align: justify; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; mso-line-height-alt: 23px; margin: 0;"><span style="color: #808389; font-size: 15px;">Thanks for creating your E-Bank account. To continue, please verify your email address by clicking the button below.</span></p>
            </div>
            </div>
            <!--[if mso]></td></tr></table><![endif]-->
            <div align="center" class="button-container" style="padding-top:15px;padding-right:10px;padding-bottom:0px;padding-left:10px;">
            <!--[if mso]><table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; border-collapse: collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;"><tr><td style="padding-top: 15px; padding-right: 10px; padding-bottom: 0px; padding-left: 10px" align="center"><v:roundrect xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="urn:schemas-microsoft-com:office:word" href="" style="height:46.5pt; width:157.5pt; v-text-anchor:middle;" arcsize="17%" stroke="false" fillcolor="#800000"><w:anchorlock/><v:textbox inset="0,0,0,0"><center style="color:#ffffff; font-family:Tahoma, sans-serif; font-size:16px"><![endif]-->

            <!-- <form method="POST" action='${link}'>
            <button type="submit" class="btn btn-primary" style="text-decoration:none;display:inline-block;color:#ffffff;background-color:darkslategray;border-radius:10px;-webkit-border-radius:10px;-moz-border-radius:10px;width:auto; width:auto;;border-top:1px solid #800000;border-right:1px solid #800000;border-bottom:1px solid #800000;border-left:1px solid #800000;padding-top:15px;padding-bottom:15px;font-family:Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif;text-align:center;mso-border-alt:none;word-break:keep-all;"><span style="padding-left:30px;padding-right:30px;font-size:16px;display:inline-block;"><span style="font-size: 16px; margin: 0; line-height: 2; word-break: break-word; mso-line-height-alt: 32px;"><strong>Verify Email</strong></span></span></button>
            </form> -->
            <a href='${link}' class="btn btn-primary" style="text-decoration:none;display:inline-block;color:#ffffff;background-color:#800000;border-radius:10px;-webkit-border-radius:10px;-moz-border-radius:10px;width:auto; width:auto;;border-top:1px solid #800000;border-right:1px solid #800000;border-bottom:1px solid #800000;border-left:1px solid #800000;padding-top:15px;padding-bottom:15px;font-family:Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif;text-align:center;mso-border-alt:none;word-break:keep-all;"><span style="padding-left:30px;padding-right:30px;font-size:16px;display:inline-block;"><span style="font-size: 16px; margin: 0; line-height: 2; word-break: break-word; mso-line-height-alt: 32px;"><strong>Verify Email</strong></span></span></a>

            <!--[if mso]></center></v:textbox></v:roundrect></td></tr></table><![endif]-->
            </div>
            <table border="0" cellpadding="0" cellspacing="0" class="divider" role="presentation" style="table-layout: fixed; vertical-align: top; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;" valign="top" width="100%">
            <tbody>
            <tr style="vertical-align: top;" valign="top">
            <td class="divider_inner" style="word-break: break-word; vertical-align: top; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; padding-top: 60px; padding-right: 0px; padding-bottom: 12px; padding-left: 0px;" valign="top">
            <table align="center" border="0" cellpadding="0" cellspacing="0" class="divider_content" role="presentation" style="table-layout: fixed; vertical-align: top; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-top: 0px solid #BBBBBB; width: 100%;" valign="top" width="100%">
            <tbody>
            <tr style="vertical-align: top;" valign="top">
            <span style="color: #95979c; font-size: 12px; font-family:Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; margin-left: 3rem;"> If you're having problems activating verification code, click <a href='${link}'>here.</span>
            <td style="word-break: break-word; vertical-align: top; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;" valign="top"><span></span></td>
            </tr>
            </tbody>
            </table>
            </td>
            </tr>
            </tbody>
            </table>
            <!--[if (!mso)&(!IE)]><!-->
            </div>
            <!--<![endif]-->
            </div>
            </div>
            <!--[if (mso)|(IE)]></td></tr></table><![endif]-->
            <!--[if (mso)|(IE)]></td></tr></table></td></tr></table><![endif]-->
            </div>
            </div>
            </div>
            <div style="background-color:transparent;">
            <div class="block-grid" style="Margin: 0 auto; min-width: 320px; max-width: 640px; overflow-wrap: break-word; word-wrap: break-word; word-break: break-word; background-color: #2b303a;">
            <div style="border-collapse: collapse;display: table;width: 100%;background-color:#2b303a;">
            <!--[if (mso)|(IE)]><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:transparent;"><tr><td align="center"><table cellpadding="0" cellspacing="0" border="0" style="width:640px"><tr class="layout-full-width" style="background-color:#2b303a"><![endif]-->
            <!--[if (mso)|(IE)]><td align="center" width="640" style="background-color:#2b303a;width:640px; border-top: 0px solid transparent; border-left: 0px solid transparent; border-bottom: 0px solid transparent; border-right: 0px solid transparent;" valign="top"><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 0px; padding-left: 0px; padding-top:5px; padding-bottom:5px;"><![endif]-->
            <div class="col num12" style="min-width: 320px; max-width: 640px; display: table-cell; vertical-align: top; width: 640px;">
            <div style="width:100% !important;">
            <!--[if (!mso)&(!IE)]><!-->
            <div style="border-top:0px solid transparent; border-left:0px solid transparent; border-bottom:0px solid transparent; border-right:0px solid transparent; padding-top:5px; padding-bottom:5px; padding-right: 0px; padding-left: 0px;">
            <!--<![endif]-->
            <!--[if mso]><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 40px; padding-left: 40px; padding-top: 15px; padding-bottom: 10px; font-family: Tahoma, sans-serif"><![endif]-->
            <div style="color:#555555;font-family:Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif;line-height:1.5;padding-top:15px;padding-right:40px;padding-bottom:10px;padding-left:40px;">
            <div style="line-height: 1.5; font-size: 12px; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; color: #555555; mso-line-height-alt: 18px;">
            <p style="font-size: 12px; line-height: 1.5; word-break: break-word; text-align: left; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; mso-line-height-alt: 18px; margin: 0;"><span style="color: #95979c; font-size: 12px;">This email is for demonstration purpose only.</span></p>
            <p style="font-size: 12px; line-height: 1.5; word-break: break-word; text-align: left; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; mso-line-height-alt: 18px; margin: 0;"><span style="color: #95979c; font-size: 12px;">This message was intended for ${userEmail} </span></p>
            <p style="font-size: 12px; line-height: 1.5; word-break: break-word; text-align: left; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; mso-line-height-alt: 18px; margin: 0;"><span style="color: #95979c; font-size: 12px;">If this was not you, ignore this email.</span></p>
            <p style="font-size: 12px; line-height: 1.5; word-break: break-word; text-align: left; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; mso-line-height-alt: 18px; margin: 0;"><span style="color: #95979c; font-size: 12px;">E-Bank Team</span></p>
            </div>
            </div>
            <!--[if mso]></td></tr></table><![endif]-->
            <!--[if (!mso)&(!IE)]><!-->
            </div>
            <!--<![endif]-->
            </div>
            </div>
            <!--[if (mso)|(IE)]></td></tr></table><![endif]-->
            <!--[if (mso)|(IE)]></td></tr></table></td></tr></table><![endif]-->
            </div>
            </div>
            </div>
            <div style="background-color:transparent;">
            <div class="block-grid" style="Margin: 0 auto; min-width: 320px; max-width: 640px; overflow-wrap: break-word; word-wrap: break-word; word-break: break-word; background-color: #2b303a;">
            <div style="border-collapse: collapse;display: table;width: 100%;background-color:#2b303a;">
            <!--[if (mso)|(IE)]><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:transparent;"><tr><td align="center"><table cellpadding="0" cellspacing="0" border="0" style="width:640px"><tr class="layout-full-width" style="background-color:#2b303a"><![endif]-->
            <!--[if (mso)|(IE)]><td align="center" width="640" style="background-color:#2b303a;width:640px; border-top: 0px solid transparent; border-left: 0px solid transparent; border-bottom: 0px solid transparent; border-right: 0px solid transparent;" valign="top"><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 0px; padding-left: 0px; padding-top:0px; padding-bottom:0px;"><![endif]-->
            <div class="col num12" style="min-width: 320px; max-width: 640px; display: table-cell; vertical-align: top; width: 640px;">
            <div style="width:100% !important;">
            <!--[if (!mso)&(!IE)]><!-->
            <div style="border-top:0px solid transparent; border-left:0px solid transparent; border-bottom:0px solid transparent; border-right:0px solid transparent; padding-top:0px; padding-bottom:0px; padding-right: 0px; padding-left: 0px;">
            <!--<![endif]-->
            <table border="0" cellpadding="0" cellspacing="0" class="divider" role="presentation" style="table-layout: fixed; vertical-align: top; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;" valign="top" width="100%">
            <tbody>
            <tr style="vertical-align: top;" valign="top">
            <td class="divider_inner" style="word-break: break-word; vertical-align: top; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;" valign="top">
            <table align="center" border="0" cellpadding="0" cellspacing="0" class="divider_content" role="presentation" style="table-layout: fixed; vertical-align: top; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-top: 4px solid #F8F8F9; width: 100%;" valign="top" width="100%">
            <tbody>
            <tr style="vertical-align: top;" valign="top">
            <td style="word-break: break-word; vertical-align: top; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;" valign="top"><span></span></td>
            </tr>
            </tbody>
            </table>
            </td>
            </tr>
            </tbody>
            </table>
            <table border="0" cellpadding="0" cellspacing="0" class="divider" role="presentation" style="table-layout: fixed; vertical-align: top; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;" valign="top" width="100%">
            <tbody>
            <tr style="vertical-align: top;" valign="top">
            <td class="divider_inner" style="word-break: break-word; vertical-align: top; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; padding-top: 25px; padding-right: 40px; padding-bottom: 10px; padding-left: 40px;" valign="top">
            <table align="center" border="0" cellpadding="0" cellspacing="0" class="divider_content" role="presentation" style="table-layout: fixed; vertical-align: top; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-top: 1px solid #555961; width: 100%;" valign="top" width="100%">
            <tbody>
            <tr style="vertical-align: top;" valign="top">
            <td style="word-break: break-word; vertical-align: top; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;" valign="top"><span></span></td>
            </tr>
            </tbody>
            </table>
            </td>
            </tr>
            </tbody>
            </table>
            <!--[if mso]><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 40px; padding-left: 40px; padding-top: 20px; padding-bottom: 30px; font-family: Tahoma, sans-serif"><![endif]-->
            <div style="color:#555555;font-family:Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif;line-height:1.2;padding-top:20px;padding-right:40px;padding-bottom:30px;padding-left:40px;">
            <div style="line-height: 1.2; font-size: 12px; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; color: #555555; mso-line-height-alt: 14px;">
            <p style="font-size: 12px; line-height: 1.2; word-break: break-word; text-align: left; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; mso-line-height-alt: 14px; margin: 0;"><span style="color: #95979c; font-size: 12px;">E-Bank © 2020</span></p>
            </div>
            </div>
            <!--[if mso]></td></tr></table><![endif]-->
            <!--[if (!mso)&(!IE)]><!-->
            </div>
            <!--<![endif]-->
            </div>
            </div>
            <!--[if (mso)|(IE)]></td></tr></table><![endif]-->
            <!--[if (mso)|(IE)]></td></tr></table></td></tr></table><![endif]-->
            </div>
            </div>
            </div>
            <!--[if (mso)|(IE)]></td></tr></table><![endif]-->
            </td>
            </tr>
            </tbody>
            </table>
            <!--[if (IE)]></div><![endif]-->
            </body>
            </html>`,
            };

            transporter.sendMail(mailOptions, (err) => {
                if (err) {
                    console.log(err);
                }
            });
        }

    });
};
const sendPasswordResetMail = function(userEmail, userRawToken) {
    getResetToken(userEmail).then(result => {
        let token = userRawToken;
        let currentPassResetCode = result.passwordResetCode;
        let userID = result.userID;
        let userName = result.name;
        if (currentPassResetCode != null) {
            const baseurl = backendUrl + 'api/user';
            const repourl = backendUrl + 'repository/images/'
            const link = `${baseurl}/reset/?code=${token}&id=${userID}`;
            const mailOptions = {
                from: '"E-Bank" <test1aplikacija@gmail.com>',
                to: 'bblog@gmx.com',
                subject: 'E-Bank Password Reset',
                html: `<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional //EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

          <html xmlns="http://www.w3.org/1999/xhtml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:v="urn:schemas-microsoft-com:vml">
          <head>
          <!--[if gte mso 9]><xml><o:OfficeDocumentSettings><o:AllowPNG/><o:PixelsPerInch>96</o:PixelsPerInch></o:OfficeDocumentSettings></xml><![endif]-->
          <meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
          <meta content="width=device-width" name="viewport"/>
          <!--[if !mso]><!-->
          <meta content="IE=edge" http-equiv="X-UA-Compatible"/>
          <!--<![endif]-->
          <title></title>
          <!--[if !mso]><!-->
          <!--<![endif]-->
          <style type="text/css">
              body {
                margin: 0;
                padding: 0;
              }

              table,
              td,
              tr {
                vertical-align: top;
                border-collapse: collapse;
              }

              * {
                line-height: inherit;
              }

              a[x-apple-data-detectors=true] {
                color: inherit !important;
                text-decoration: none !important;
              }
            </style>
          <style id="media-query" type="text/css">
              @media (max-width: 660px) {

                .block-grid,
                .col {
                  min-width: 320px !important;
                  max-width: 100% !important;
                  display: block !important;
                }

                .block-grid {
                  width: 100% !important;
                }

                .col {
                  width: 100% !important;
                }

                .col>div {
                  margin: 0 auto;
                }

                img.fullwidth,
                img.fullwidthOnMobile {
                  max-width: 100% !important;
                }

                .no-stack .col {
                  min-width: 0 !important;
                  display: table-cell !important;
                }

                .no-stack.two-up .col {
                  width: 50% !important;
                }

                .no-stack .col.num4 {
                  width: 33% !important;
                }

                .no-stack .col.num8 {
                  width: 66% !important;
                }

                .no-stack .col.num4 {
                  width: 33% !important;
                }

                .no-stack .col.num3 {
                  width: 25% !important;
                }

                .no-stack .col.num6 {
                  width: 50% !important;
                }

                .no-stack .col.num9 {
                  width: 75% !important;
                }

                .video-block {
                  max-width: none !important;
                }

                .mobile_hide {
                  min-height: 0px;
                  max-height: 0px;
                  max-width: 0px;
                  display: none;
                  overflow: hidden;
                  font-size: 0px;
                }

                .desktop_hide {
                  display: block !important;
                  max-height: none !important;
                }
              }
            </style>
          </head>
          <body class="clean-body" style="margin: 0; padding: 0; -webkit-text-size-adjust: 100%; background-color: #f8f8f9;">
          <!--[if IE]><div class="ie-browser"><![endif]-->
          <table bgcolor="#f8f8f9" cellpadding="0" cellspacing="0" class="nl-container" role="presentation" style="table-layout: fixed; vertical-align: top; min-width: 320px; Margin: 0 auto; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #f8f8f9; width: 100%;" valign="top" width="100%">
          <tbody>
          <tr style="vertical-align: top;" valign="top">
          <td style="word-break: break-word; vertical-align: top;" valign="top">
          <!--[if (mso)|(IE)]><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td align="center" style="background-color:#f8f8f9"><![endif]-->
          <div class="block-grid" style="Margin: 0 auto; min-width: 320px; max-width: 640px; overflow-wrap: break-word; word-wrap: break-word; word-break: break-word; background-color: #1aa19c;">
          <div style="border-collapse: collapse;display: table;width: 100%;background-color:#1aa19c;">
          <!--[if (mso)|(IE)]><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#1aa19c;"><tr><td align="center"><table cellpadding="0" cellspacing="0" border="0" style="width:640px"><tr class="layout-full-width" style="background-color:#1aa19c"><![endif]-->
          <!--[if (mso)|(IE)]><td align="center" width="640" style="background-color:#1aa19c;width:640px; border-top: 0px solid transparent; border-left: 0px solid transparent; border-bottom: 0px solid transparent; border-right: 0px solid transparent;" valign="top"><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 0px; padding-left: 0px; padding-top:0px; padding-bottom:0px;"><![endif]-->
          <div class="col num12" style="min-width: 320px; max-width: 640px; display: table-cell; vertical-align: top; width: 640px;">
          <div style="width:100% !important;">
          <!--[if (!mso)&(!IE)]><!-->
          <div style="border-top:0px solid transparent; border-left:0px solid transparent; border-bottom:0px solid transparent; border-right:0px solid transparent; padding-top:0px; padding-bottom:0px; padding-right: 0px; padding-left: 0px;">
          <!--<![endif]-->
          <table border="0" cellpadding="0" cellspacing="0" class="divider" role="presentation" style="table-layout: fixed; vertical-align: top; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;" valign="top" width="100%">
          <tbody>
          <tr style="vertical-align: top;" valign="top">
          <td class="divider_inner" style="word-break: break-word; vertical-align: top; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;" valign="top">
          </td>
          </tr>
          </tbody>
          </table>
          <!--[if (!mso)&(!IE)]><!-->
          </div>
          <!--<![endif]-->
          </div>
          </div>
          <!--[if (mso)|(IE)]></td></tr></table><![endif]-->
          <!--[if (mso)|(IE)]></td></tr></table></td></tr></table><![endif]-->
          </div>
          </div>
          </div>
          <div style="background-color:transparent;">
          <div class="block-grid" style="Margin: 0 auto; min-width: 320px; max-width: 640px; overflow-wrap: break-word; word-wrap: break-word; word-break: break-word; background-color: #800000;">
          <div style="border-collapse: collapse;display: table;width: 100%;background-color:#800000;">
          <!--[if (mso)|(IE)]><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#fff;"><tr><td align="center"><table cellpadding="0" cellspacing="0" border="0" style="width:640px"><tr class="layout-full-width" style="background-color:#800000"><![endif]-->
          <!--[if (mso)|(IE)]><td align="center" width="640" style="background-color:#800000;width:640px; border-top: 0px solid transparent; border-left: 0px solid transparent; border-bottom: 0px solid transparent; border-right: 0px solid transparent;" valign="top"><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 0px; padding-left: 0px; padding-top:0px; padding-bottom:0px;"><![endif]-->
          <div class="col num12" style="min-width: 320px; max-width: 640px; display: table-cell; vertical-align: top; width: 640px;">
          <div style="width:100% !important;">
          <!--[if (!mso)&(!IE)]><!-->
          <div style="border-top:0px solid transparent; border-left:0px solid transparent; border-bottom:0px solid transparent; border-right:0px solid transparent; padding-top:0px; padding-bottom:0px; padding-right: 0px; padding-left: 0px;">
          <!--<![endif]-->
          <div align="center" class="img-container center fixedwidth" style="padding-right: 0px;padding-left: 0px;">
          <!--[if mso]><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr style="line-height:0px"><td style="padding-right: 0px;padding-left: 0px;" align="center"><![endif]--><img align="center" alt="E-Bank" border="0" class="center fixedwidth" src="${repourl}logo2.PNG" style="text-decoration: none; -ms-interpolation-mode: bicubic; height: auto; border: 0; width: 100%; max-width: 224px; display: block;" title="Alternate text" width="224"/>
          <!--[if mso]></td></tr></table><![endif]-->
          </div>
          <!--[if (!mso)&(!IE)]><!-->
          </div>
          <!--<![endif]-->
          </div>
          </div>
          <!--[if (mso)|(IE)]></td></tr></table><![endif]-->
          <!--[if (mso)|(IE)]></td></tr></table></td></tr></table><![endif]-->
          </div>
          </div>
          </div>
          <div style="background-color:transparent;">
          <div class="block-grid" style="Margin: 0 auto; min-width: 320px; max-width: 640px; overflow-wrap: break-word; word-wrap: break-word; word-break: break-word; background-color: #ffffff;">
          <div style="border-collapse: collapse;display: table;width: 100%;background-color:transparent;">
          <!--[if (mso)|(IE)]><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:transparent;"><tr><td align="center"><table cellpadding="0" cellspacing="0" border="0" style="width:640px"><tr class="layout-full-width" style="background-color:#ffffff"><![endif]-->
          <!--[if (mso)|(IE)]><td align="center" width="640" style="background-color:#ffffff;width:640px; border-top: 0px solid transparent; border-left: 0px solid transparent; border-bottom: 0px solid transparent; border-right: 0px solid transparent;" valign="top"><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 0px; padding-left: 0px; padding-top:5px; padding-bottom:5px;"><![endif]-->
          <div class="col num12" style="min-width: 320px; max-width: 640px; display: table-cell; vertical-align: top; width: 640px;">
          <div style="width:100% !important;">
          <!--[if (!mso)&(!IE)]><!-->
          <div style="border-top:0px solid transparent; border-left:0px solid transparent; border-bottom:0px solid transparent; border-right:0px solid transparent; padding-top:5px; padding-bottom:5px; padding-right: 0px; padding-left: 0px;">
          <!--<![endif]-->
          <table border="0" cellpadding="0" cellspacing="0" class="divider" role="presentation" style="table-layout: fixed; vertical-align: top; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;" valign="top" width="100%">
          <tbody>
          <tr style="vertical-align: top;" valign="top">
          <td class="divider_inner" style="word-break: break-word; vertical-align: top; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; padding-top: 20px; padding-right: 20px; padding-bottom: 20px; padding-left: 20px;" valign="top">
          <table align="center" border="0" cellpadding="0" cellspacing="0" class="divider_content" role="presentation" style="table-layout: fixed; vertical-align: top; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-top: 0px solid #BBBBBB; width: 100%;" valign="top" width="100%">
          <tbody>
          <tr style="vertical-align: top;" valign="top">
          </tr>
          </tbody>
          </table>
          </td>
          </tr>
          </tbody>
          </table>
          <!--[if (!mso)&(!IE)]><!-->
          </div>
          <!--<![endif]-->
          </div>
          </div>
          <!--[if (mso)|(IE)]></td></tr></table><![endif]-->
          <!--[if (mso)|(IE)]></td></tr></table></td></tr></table><![endif]-->
          </div>
          </div>
          </div>
          <div style="background-color:transparent;">
          <div class="block-grid" style="Margin: 0 auto; min-width: 320px; max-width: 640px; overflow-wrap: break-word; word-wrap: break-word; word-break: break-word; background-color: #fff;">
          <div style="border-collapse: collapse;display: table;width: 100%;background-color:#fff;">
          <!--[if (mso)|(IE)]><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:transparent;"><tr><td align="center"><table cellpadding="0" cellspacing="0" border="0" style="width:640px"><tr class="layout-full-width" style="background-color:#fff"><![endif]-->
          <!--[if (mso)|(IE)]><td align="center" width="640" style="background-color:#fff;width:640px; border-top: 0px solid transparent; border-left: 0px solid transparent; border-bottom: 0px solid transparent; border-right: 0px solid transparent;" valign="top"><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 0px; padding-left: 0px; padding-top:0px; padding-bottom:0px;"><![endif]-->
          <div class="col num12" style="min-width: 320px; max-width: 640px; display: table-cell; vertical-align: top; width: 640px;">
          <div style="width:100% !important;">
          <!--[if (!mso)&(!IE)]><!-->
          <div style="border-top:0px solid transparent; border-left:0px solid transparent; border-bottom:0px solid transparent; border-right:0px solid transparent; padding-top:0px; padding-bottom:0px; padding-right: 0px; padding-left: 0px;">
          <!--<![endif]-->
          <!--[if mso]><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 40px; padding-left: 40px; padding-top: 10px; padding-bottom: 10px; font-family: Tahoma, sans-serif"><![endif]-->
          <div style="color:#555555;font-family:Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif;line-height:1.2;padding-top:10px;padding-right:40px;padding-bottom:10px;padding-left:40px;">
          <div style="line-height: 1.2; font-size: 12px; color: #555555; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; mso-line-height-alt: 14px;">
          <p style="font-size: 30px; line-height: 1.2; text-align: center; word-break: break-word; mso-line-height-alt: 36px; margin: 0;"><span style="font-size: 30px; color: #2b303a;"><strong>Password reset</strong></span></p>
          </div>
          </div>
          <!--[if mso]></td></tr></table><![endif]-->
          <!--[if mso]><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 40px; padding-left: 40px; padding-top: 10px; padding-bottom: 10px; font-family: Tahoma, sans-serif"><![endif]-->
          <div style="color:#555555;font-family:Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif;line-height:1.5;padding-top:10px;padding-right:40px;padding-bottom:10px;padding-left:40px;">
          <div style="line-height: 1.5; font-size: 12px; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; color: #555555; mso-line-height-alt: 18px;">
          <p style="font-size: 15px; line-height: 1.5; word-break: break-word; text-align: left; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; mso-line-height-alt: 23px; margin: 0;"><span style="color: #808389; font-size: 15px;">Hi ${userName},</span></p>
          <p style="font-size: 14px; line-height: 1.5; word-break: break-word; text-align: justify; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; mso-line-height-alt: 21px; margin: 0;"> </p>
          <p style="font-size: 15px; line-height: 1.5; word-break: break-word; text-align: justify; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; mso-line-height-alt: 23px; margin: 0;"><span style="color: #808389; font-size: 15px;">You told us you forgot your password. If you really did, click here to get a temporary password to log in. Password will be sent to your mobile phone:</span></p>
          </div>
          </div>
          <!--[if mso]></td></tr></table><![endif]-->
          <div align="center" class="button-container" style="padding-top:15px;padding-right:10px;padding-bottom:0px;padding-left:10px;">
          <!--[if mso]><table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; border-collapse: collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;"><tr><td style="padding-top: 15px; padding-right: 10px; padding-bottom: 0px; padding-left: 10px" align="center"><v:roundrect xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="urn:schemas-microsoft-com:office:word" href="" style="height:46.5pt; width:157.5pt; v-text-anchor:middle;" arcsize="17%" stroke="false" fillcolor="#800000"><w:anchorlock/><v:textbox inset="0,0,0,0"><center style="color:#ffffff; font-family:Tahoma, sans-serif; font-size:16px"><![endif]-->

          <!-- <form method="POST" action='${link}'>
          <button type="submit" class="btn btn-primary" style="text-decoration:none;display:inline-block;color:#ffffff;background-color:darkslategray;border-radius:10px;-webkit-border-radius:10px;-moz-border-radius:10px;width:auto; width:auto;;border-top:1px solid #800000;border-right:1px solid #800000;border-bottom:1px solid #800000;border-left:1px solid #800000;padding-top:15px;padding-bottom:15px;font-family:Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif;text-align:center;mso-border-alt:none;word-break:keep-all;"><span style="padding-left:30px;padding-right:30px;font-size:16px;display:inline-block;"><span style="font-size: 16px; margin: 0; line-height: 2; word-break: break-word; mso-line-height-alt: 32px;"><strong>Choose a new password</strong></span></span></button>
          </form> -->
          <a href='${link}' class="btn btn-primary" style="text-decoration:none;display:inline-block;color:#ffffff;background-color:#800000;border-radius:10px;-webkit-border-radius:10px;-moz-border-radius:10px;width:auto; width:auto;;border-top:1px solid #800000;border-right:1px solid #800000;border-bottom:1px solid #800000;border-left:1px solid #800000;padding-top:15px;padding-bottom:15px;font-family:Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif;text-align:center;mso-border-alt:none;word-break:keep-all;"><span style="padding-left:30px;padding-right:30px;font-size:16px;display:inline-block;"><span style="font-size: 16px; margin: 0; line-height: 2; word-break: break-word; mso-line-height-alt: 32px;"><strong>Get a temporary password</strong></span></span></a>

          <!--[if mso]></center></v:textbox></v:roundrect></td></tr></table><![endif]-->
          </div>
          <table border="0" cellpadding="0" cellspacing="0" class="divider" role="presentation" style="table-layout: fixed; vertical-align: top; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;" valign="top" width="100%">
          <tbody>
          <tr style="vertical-align: top;" valign="top">
          <td class="divider_inner" style="word-break: break-word; vertical-align: top; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; padding-top: 60px; padding-right: 0px; padding-bottom: 12px; padding-left: 0px;" valign="top">
          <table align="center" border="0" cellpadding="0" cellspacing="0" class="divider_content" role="presentation" style="table-layout: fixed; vertical-align: top; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-top: 0px solid #BBBBBB; width: 100%;" valign="top" width="100%">
          <tbody>
          <tr style="vertical-align: top;" valign="top">
          <span style="color: #95979c; font-size: 12px; font-family:Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; margin-left: 3rem;"> If you're having problems activating password reset, please click <a href='${link}'>here.</span>
          <td style="word-break: break-word; vertical-align: top; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;" valign="top"><span></span></td>
          </tr>
          </tbody>
          </table>
          </td>
          </tr>
          </tbody>
          </table>
          <!--[if (!mso)&(!IE)]><!-->
          </div>
          <!--<![endif]-->
          </div>
          </div>
          <!--[if (mso)|(IE)]></td></tr></table><![endif]-->
          <!--[if (mso)|(IE)]></td></tr></table></td></tr></table><![endif]-->
          </div>
          </div>
          </div>
          <div style="background-color:transparent;">
          <div class="block-grid" style="Margin: 0 auto; min-width: 320px; max-width: 640px; overflow-wrap: break-word; word-wrap: break-word; word-break: break-word; background-color: #2b303a;">
          <div style="border-collapse: collapse;display: table;width: 100%;background-color:#2b303a;">
          <!--[if (mso)|(IE)]><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:transparent;"><tr><td align="center"><table cellpadding="0" cellspacing="0" border="0" style="width:640px"><tr class="layout-full-width" style="background-color:#2b303a"><![endif]-->
          <!--[if (mso)|(IE)]><td align="center" width="640" style="background-color:#2b303a;width:640px; border-top: 0px solid transparent; border-left: 0px solid transparent; border-bottom: 0px solid transparent; border-right: 0px solid transparent;" valign="top"><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 0px; padding-left: 0px; padding-top:5px; padding-bottom:5px;"><![endif]-->
          <div class="col num12" style="min-width: 320px; max-width: 640px; display: table-cell; vertical-align: top; width: 640px;">
          <div style="width:100% !important;">
          <!--[if (!mso)&(!IE)]><!-->
          <div style="border-top:0px solid transparent; border-left:0px solid transparent; border-bottom:0px solid transparent; border-right:0px solid transparent; padding-top:5px; padding-bottom:5px; padding-right: 0px; padding-left: 0px;">
          <!--<![endif]-->
          <!--[if mso]><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 40px; padding-left: 40px; padding-top: 15px; padding-bottom: 10px; font-family: Tahoma, sans-serif"><![endif]-->
          <div style="color:#555555;font-family:Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif;line-height:1.5;padding-top:15px;padding-right:40px;padding-bottom:10px;padding-left:40px;">
          <div style="line-height: 1.5; font-size: 12px; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; color: #555555; mso-line-height-alt: 18px;">
          <p style="font-size: 12px; line-height: 1.5; word-break: break-word; text-align: left; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; mso-line-height-alt: 18px; margin: 0;"><span style="color: #95979c; font-size: 12px;">This email is for demonstration purpose only.</span></p>
          <p style="font-size: 12px; line-height: 1.5; word-break: break-word; text-align: left; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; mso-line-height-alt: 18px; margin: 0;"><span style="color: #95979c; font-size: 12px;">This message was intended for ${userEmail} </span></p>
          <p style="font-size: 12px; line-height: 1.5; word-break: break-word; text-align: left; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; mso-line-height-alt: 18px; margin: 0;"><span style="color: #95979c; font-size: 12px;">If this was not you, ignore this email.</span></p>
          <p style="font-size: 12px; line-height: 1.5; word-break: break-word; text-align: left; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; mso-line-height-alt: 18px; margin: 0;"><span style="color: #95979c; font-size: 12px;">E-Bank Team</span></p>
          </div>
          </div>
          <!--[if mso]></td></tr></table><![endif]-->
          <!--[if (!mso)&(!IE)]><!-->
          </div>
          <!--<![endif]-->
          </div>
          </div>
          <!--[if (mso)|(IE)]></td></tr></table><![endif]-->
          <!--[if (mso)|(IE)]></td></tr></table></td></tr></table><![endif]-->
          </div>
          </div>
          </div>
          <div style="background-color:transparent;">
          <div class="block-grid" style="Margin: 0 auto; min-width: 320px; max-width: 640px; overflow-wrap: break-word; word-wrap: break-word; word-break: break-word; background-color: #2b303a;">
          <div style="border-collapse: collapse;display: table;width: 100%;background-color:#2b303a;">
          <!--[if (mso)|(IE)]><table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:transparent;"><tr><td align="center"><table cellpadding="0" cellspacing="0" border="0" style="width:640px"><tr class="layout-full-width" style="background-color:#2b303a"><![endif]-->
          <!--[if (mso)|(IE)]><td align="center" width="640" style="background-color:#2b303a;width:640px; border-top: 0px solid transparent; border-left: 0px solid transparent; border-bottom: 0px solid transparent; border-right: 0px solid transparent;" valign="top"><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 0px; padding-left: 0px; padding-top:0px; padding-bottom:0px;"><![endif]-->
          <div class="col num12" style="min-width: 320px; max-width: 640px; display: table-cell; vertical-align: top; width: 640px;">
          <div style="width:100% !important;">
          <!--[if (!mso)&(!IE)]><!-->
          <div style="border-top:0px solid transparent; border-left:0px solid transparent; border-bottom:0px solid transparent; border-right:0px solid transparent; padding-top:0px; padding-bottom:0px; padding-right: 0px; padding-left: 0px;">
          <!--<![endif]-->
          <table border="0" cellpadding="0" cellspacing="0" class="divider" role="presentation" style="table-layout: fixed; vertical-align: top; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;" valign="top" width="100%">
          <tbody>
          <tr style="vertical-align: top;" valign="top">
          <td class="divider_inner" style="word-break: break-word; vertical-align: top; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;" valign="top">
          <table align="center" border="0" cellpadding="0" cellspacing="0" class="divider_content" role="presentation" style="table-layout: fixed; vertical-align: top; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-top: 4px solid #F8F8F9; width: 100%;" valign="top" width="100%">
          <tbody>
          <tr style="vertical-align: top;" valign="top">
          <td style="word-break: break-word; vertical-align: top; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;" valign="top"><span></span></td>
          </tr>
          </tbody>
          </table>
          </td>
          </tr>
          </tbody>
          </table>
          <table border="0" cellpadding="0" cellspacing="0" class="divider" role="presentation" style="table-layout: fixed; vertical-align: top; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;" valign="top" width="100%">
          <tbody>
          <tr style="vertical-align: top;" valign="top">
          <td class="divider_inner" style="word-break: break-word; vertical-align: top; min-width: 100%; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; padding-top: 25px; padding-right: 40px; padding-bottom: 10px; padding-left: 40px;" valign="top">
          <table align="center" border="0" cellpadding="0" cellspacing="0" class="divider_content" role="presentation" style="table-layout: fixed; vertical-align: top; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-top: 1px solid #555961; width: 100%;" valign="top" width="100%">
          <tbody>
          <tr style="vertical-align: top;" valign="top">
          <td style="word-break: break-word; vertical-align: top; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;" valign="top"><span></span></td>
          </tr>
          </tbody>
          </table>
          </td>
          </tr>
          </tbody>
          </table>
          <!--[if mso]><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td style="padding-right: 40px; padding-left: 40px; padding-top: 20px; padding-bottom: 30px; font-family: Tahoma, sans-serif"><![endif]-->
          <div style="color:#555555;font-family:Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif;line-height:1.2;padding-top:20px;padding-right:40px;padding-bottom:30px;padding-left:40px;">
          <div style="line-height: 1.2; font-size: 12px; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; color: #555555; mso-line-height-alt: 14px;">
          <p style="font-size: 12px; line-height: 1.2; word-break: break-word; text-align: left; font-family: Montserrat, Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif; mso-line-height-alt: 14px; margin: 0;"><span style="color: #95979c; font-size: 12px;">E-Bank © 2020</span></p>
          </div>
          </div>
          <!--[if mso]></td></tr></table><![endif]-->
          <!--[if (!mso)&(!IE)]><!-->
          </div>
          <!--<![endif]-->
          </div>
          </div>
          <!--[if (mso)|(IE)]></td></tr></table><![endif]-->
          <!--[if (mso)|(IE)]></td></tr></table></td></tr></table><![endif]-->
          </div>
          </div>
          </div>
          <!--[if (mso)|(IE)]></td></tr></table><![endif]-->
          </td>
          </tr>
          </tbody>
          </table>
          <!--[if (IE)]></div><![endif]-->
          </body>
          </html>`,
            };

            transporter.sendMail(mailOptions, (err) => {
                if (err) {
                    console.log(err);
                }
            });
        }

    });
};
var sendSms = function(userID, tempPass) {
    return new Promise(function(resolve, reject) {
        let queryNode = `CALL get_user_phone_number_id(?)`;
        Mysqldb.query(queryNode, [userID], (err, results, fields) => {
            let res = results;
            if (err) {
                reject(err.message);
            }
            if (res[0].length == 0) {
                resolve(0);
            } else {
                sendSmsApi(res[0][0].number, tempPass).then(res => {
                    if (res == 0)
                        resolve(0);
                    else
                        resolve(1);
                });
            }
        });
    });
    // napravi post zahtev
};
var sendSmsApi = function(number, pass) {
    console.log("New SMS code for", number, "is: ", pass);
    return new Promise(function(resolve, reject) {
        var options = {
            'method': 'POST',
            //'url': apiSmsUrl + 'send?username=twmd1454&password=6LNT1B9G&dlr-method=POST&dlr-url=https://4ba60af1.ngrok.io/receive&dlr=yes&dlr-level=3&from=EBNK&content=Your temporary password is ' + pass + '. This password expires in 2 minutes. \n\nEBNK Team &to=' + number,
            'url': apiSmsUrl + 'send?username=fipb9989&password=y6Z9fFnT&dlr-method=POST&dlr-url=https://4ba60af1.ngrok.io/receive&dlr=yes&dlr-level=3&from=EBNK&content=Your temporary password is ' + pass + '. This password expires in 2 minutes. \n\nEBNK Team &to=' + number,
            'headers': {},
            formData: {}
        };
        request(options, function(error, response) {
            if (error)
                throw new Error(error);
            console.log(response.body);
        });
        resolve(1);
    });
}
var generateToken = function() {
    return new Promise(function(resolve, reject) {
        crypto.randomBytes(16, (err, buf) => {
            const token = buf.toString('hex');
            if (err) {
                reject(err);
            } else
                resolve(token);
        });
    });
};
var generateTokenNumber = function() {
    return new Promise(function(resolve, reject) {
        crypto.randomBytes(2, (err, buf) => {
            const token = buf.toString('hex');
            if (err) {
                reject(err);
            } else
                resolve(token);
        });
    });
};
var getVerifToken = function(userEmail) {
    return new Promise(function(resolve, reject) {
        let queryNode = `CALL get_user_verification_code('${userEmail}')`;
        Mysqldb.query(queryNode, [userEmail], (err, results, fields) => {
            let res = results;
            if (err) {
                reject(err.message);
            }
            resolve(res[0]);
        });
    });
};
var getResetToken = function(userEmail) {
    return new Promise(function(resolve, reject) {
        let queryNode = `CALL get_user_reset_password_code('${userEmail}')`;
        Mysqldb.query(queryNode, [userEmail], (err, results, fields) => {
            let res = results;
            if (err) {
                reject(err.message);
            }
            resolve(res[0][0]);
        });
    });
};
var resetUserPassword = function(rawToken, userID) {
    return new Promise(function(resolve, reject) {
        let queryNode = `CALL get_user_password_reset_code_id('${userID}')`;
        Mysqldb.query(queryNode, [userID], (err, results, fields) => {
            let res = results;
            if (err) {
                reject(console.log(err.message));
            }
            if (res[0].length == 0)
                return resolve(0);
            else if (res[0][0].expired == 'expired')
                return resolve(3);
            bcrypt.compare(rawToken, res[0][0].passwordResetCode).catch(err => {
                return resolve(2);
            }).then(isSame => {
                if (!isSame) {
                    return resolve(0);
                } else {
                    return resolve(1);
                }
            });
        });
    });
};
var verifyUser = function(rawToken, userID) {
    return new Promise(function(resolve, reject) {
        let queryNode = `CALL get_user_verification_code_id('${userID}')`;
        Mysqldb.query(queryNode, [userID], (err, results, fields) => {
            let res = results;
            if (err) {
                reject(console.log(err.message));
            }
            bcrypt.compare(rawToken, res[0][0].verificationCode).catch(err => {
                resolve(2);
            }).then(isSame => {
                if (!isSame) {
                    resolve(0);
                } else {
                    let queryNode = `SELECT set_verify_user('${userID}') AS res`;
                    Mysqldb.query(queryNode, [userID], (err, results, fields) => {
                        let res = results;
                        if (err) {
                            reject(console.log(err.message));
                        }
                        if (res[0].res == 1) {
                            resolve(1);
                        } else if (res[0].res == 0) {
                            resolve(2);
                        }
                    });
                }
            });
        });
    });
};
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
};
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
};
var userFindByEmail = function(userEmail) {
    return new Promise(function(resolve, reject) {
        userCheckVerification(userEmail).then(result => {
            if (result.length > 0) {
                if (result[0].isVerified == 0)
                    resolve({ status: "notVerified" });
            }
        })
        let queryNode = `CALL find_user_by_email('${userEmail}')`
        Mysqldb.query(queryNode, [userEmail], (err, results, fields) => {
            if (err) {
                reject(console.log(err.message));
            }
            if (results[0].length == 0) {
                resolve(results[0]);
            }
            resolve(results[0]);
        });
    });
};
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
};
var transactionCreateUserAccountCard = function(user) {
    return new Promise(function(resolve, reject) {
        let queryNode = `CALL initialize_user(
          '${user.email}',
          '${user.password}',
          '${user.name}',
          '${user.surname}',
          '${user.number}',
          '${user.address}',
          '${user.hnumber}',
          '${user.token}'
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
};
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
};
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
};
module.exports = router;
