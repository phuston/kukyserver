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
    console.log(req.body);
    var uname = req.body.username.toLowerCase();
    var hash = crypto
        .createHash("sha256")
        .update(req.body.password)
        .digest('hex');
    User_auth.findById(uname).then(function (user) {
        if (user.dataValues.hashedPassword == hash) {
            var newApi = uuid();
            User_auth.update(
                {apiKey: newApi},
                {where: {username: uname}}
            );
            res.json({newKey: newApi});
        } else {
            res.status(404).send("User not found.");
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
    
    models.sequelize.transaction(function (t) {
        return User.create({
            username: req.body.username.toLowerCase(),
        }, {transaction: t}).then(function (user) {
            return User_auth.create({
                userId: user.dataValues.id,
                username: user.dataValues.username,
                apiKey: uuid(),
                hashedPassword: hash
            }, {transaction: t});
        });
    }).then(function (result) {
        //console.log(result);
        res.redirect('/users/' + result.dataValues.userId);
    }).catch(function (error) {
        res.status(500).json({"name": error.name});
    })
})

/* GET a user's profile. */
router.get('/:username', function (req, res, next) {
    var returnedUser = {
        basicInfo: {},
        favoriteHaikus: {}
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
                userId: req.params.id,
                relationship: 1
            },
            limit: responseLimit
        }).then(function (kus) {
            var ids = [];
            kus.forEach(function (elem, i, arr) {
                ids.push(elem.dataValues.kuId);
            })
            Ku.findAll({
                where: {
                    id: {
                        $in: ids
                    }
                }
            }).then(function (kus) {
                kus.forEach(function (elem, i, array) {
                    returnedUser.favoriteHaikus[i] = elem.getDataForUser();
                })
                res.json(returnedUser);
            })
        })
    })
});

module.exports = router;
