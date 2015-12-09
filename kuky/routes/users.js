var express = require('express');
var router = express.Router();
var models = require('../models');
var crypto = require('crypto');
var uuid = require('node-uuid');

var User = models.sequelize.models.User;
var Ku_user = models.sequelize.models.Ku_user;
var Ku = models.sequelize.models.Ku;
var User_auth = models.sequelize.models.User_auth;

var responseLimit = 10;

/* POST log in */
router.post('/login', function (req, res, next) {
    var userId;
    var uname = req.body.username.toLowerCase();
    var hash = crypto
        .createHash("sha256")
        .update(req.body.password)
        .digest('hex');
    User_auth.findById(uname).then(function (user) {
        userId = user.dataValues.userId;
        console.log(userId);
        if (user.dataValues.hashedPassword == hash) {
            var newApi = uuid();
            User_auth.update(
                {apiKey: newApi},
                {where: {username: uname}}
            );
            res.json({newKey: newApi, userId: userId, error: null});
        } else {
            res.status(200).json({newKey: null, userId: null, error: "User not found."});
        }
    });
})

/* POST a new user. Body looks like:
 */
router.post('/register', function (req, res, next) {
    var hash = crypto
        .createHash("sha256")
        .update(req.body.password)
        .digest('hex');
    var apiKey = uuid();
    var userId;
    
    models.sequelize.transaction(function (t) {
        return User.create({
            username: req.body.username.toLowerCase(),
        }, {transaction: t}).then(function (user) {
            userId = user.dataValues.id;
            return User_auth.create({
                userId: user.dataValues.id,
                username: user.dataValues.username,
                apiKey: apiKey,
                hashedPassword: hash
            }, {transaction: t});
        });
    }).then(function (result) {
        res.json({newKey: apiKey, userId: userId, error: null});
    }).catch(function (error) {
        res.status(200).json({newKey: null, userId: null, error: error.name});
    })
})

/* GET a user's profile. */
router.get('/:username', function (req, res, next) {
    var returnedUser = {
        basicInfo: {},
        composedKus: {},
        favoritedKus: {}
    }

    User.findOne({
        where: {
            username: req.params.username.toLowerCase()
        }
    }).then(function (user) {
        returnedUser.basicInfo = user.dataValues;
        // First find all favorited haikus
        Ku_user.findAll({
            where: {
                userId: user.dataValues.id,
            },
            limit: responseLimit
        }).then(function (ku_users) {
            var ids = [];
            var relationship = {};
            ku_users.forEach(function (elem, i, arr) {
                ids.push(elem.dataValues.kuId);
                relationship[elem.dataValues.kuId] = elem.dataValues.relationship;
            })
            Ku.findAll({
                where: {
                    id: {
                        $in: ids
                    }
                }
            }).then(function (kus) {
                kus.forEach(function (elem, i, array) {
                    if (relationship[elem.dataValues.id] == 1) {
                        returnedUser.favoritedKus[i] = elem.getData();
                    } else {
                        returnedUser.composedKus[i] = elem.getData();
                    }
                })
                res.json(returnedUser);
            })
        })
    })
});

module.exports = router;
