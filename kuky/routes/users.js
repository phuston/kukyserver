var express = require('express');
var router = express.Router();
var models = require('../models');

var User = models.sequelize.models.User;
var Ku_user = models.sequelize.models.Ku_user;
var Ku = models.sequelize.models.Ku;

var responseLimit = 10;

/* GET users listing. */
router.get('/:id', function(req, res, next) {
    var returnedUser = {
        basicInfo: {},
        favoriteHaikus: {}
    }
    
    User.findById(req.params.id)
        .then(function (user) {
            returnedUser.basicInfo = user.dataValues;
            Ku_user.findAll({
                where: {
                    user_id: req.params.id,
                    is_favorite: true
                },
                limit: responseLimit
            }).then(function (kus) {
                var ids = [];
                kus.forEach(function (elem, i, arr) {
                    ids.push(elem.dataValues.ku_id);
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
