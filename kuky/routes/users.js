var express = require('express');
var router = express.Router();
var models = require('../models');
var crypto = require('crypto');

var User = models.sequelize.models.User;
var Ku_user = models.sequelize.models.Ku_user;
var Ku = models.sequelize.models.Ku;

var responseLimit = 10;

// router.post('/register', function (req, res, next) {
//     var hash = crypto
//         .createHash("sha256")
//         .update(req.body.password)
//         .digest('hex');
    
// })

/* GET a user's profile. */
router.get('/:id', function (req, res, next) {
    var returnedUser = {
        basicInfo: {},
        favoriteHaikus: {}
    }

    User.findById(req.params.id)
        .then(function (user) {
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
