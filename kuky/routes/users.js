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
router.post('/login/:userid/:apikey', function (req, res, next) {
    User_auth.findById(req.params.userid).then(function (user) {
        if (user.dataValues.apiKey == req.params.apikey) {
            res.redirect('/users/' + req.params.userid);
        } else {
            res.send("User incorrect.");
        }
    });
})

/* POST a new user. Body looks like:
{
    "username": [],
    "password": []
}
 */
router.post('/register', function (req, res, next) {
    var hash = crypto
        .createHash("sha256")
        .update(req.body.password)
        .digest('hex');
    
    models.sequelize.transaction(function (t) {
        return User.create({
            username: req.body.username,
        }, {transaction: t}).then(function (user) {
            return User_auth.create({
                userId: user.dataValues.id,
                apiKey: uuid(),
                hashedPassword: hash
            }, {transaction: t});
        });
    }).then(function (result) {
        res.send("User created");
    }).catch(function (error) {
        console.log(error);
    })
})

/* GET a user's profile. */
router.get('/:id', function (req, res, next) {
    var returnedUser = {
        basicInfo: {},
        favoriteHaikus: {}
    }

    User.findById(req.params.id).then(function (user) {
        returnedUser.basicInfo = user.dataValues;
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
