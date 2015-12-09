var express = require('express');
var router = express.Router();
var models  = require('../models');
var sequelize = require('sequelize');

var User = models.sequelize.models.User;
var Ku = models.sequelize.models.Ku;
var Ku_user = models.sequelize.models.Ku_user;

var responseLimit = 50;
var dateLimitRecent = 50;
var dateLimitHot = 50;
var karmaThreshold = 3;


/*
GET single ku by id
*/
router.get('/:id', function (req, res, next) {
    Ku.findById(req.params.id).then(function (ku) {
        res.status(200).json({"kus": [ku.getData()]})
    })
})

/* 
GET all kus in new order
 */
router.get('/all/:sort', function (req, res, next) {
    var response = {};
    if (req.params.sort == 'recent') {
        Ku.findAll({
            where: {
                createdAt: {
                    $lt: new Date(),
                    $gt: new Date(new Date() - dateLimitRecent*24*60*60*1000)
                }
            },
            limit: responseLimit,
            order: 'createdAt'
        }).then(function (kus) {
            var returnKus = [];
            kus.forEach(function (elem, i, arr) {
                returnKus.push(elem.getData());
            })
            response['kus'] = returnKus;
            res.json(response);
        });
    } else if (req.params.sort == 'hot') {
        Ku.findAll({
            where: {
                createdAt: {
                    $lt: new Date(),
                    $gt: new Date(new Date() - dateLimitHot*24*60*60*1000)
                },
                karma: {
                    $gt: karmaThreshold
                }
            },
            limit: responseLimit
        }).then(function (kus) {
            var returnKus = [];
            kus.forEach(function (elem, i, arr) {
                returnKus.push(elem.getData());
            })
            returnKus.sort(function (a, b) {
                return a.getKarma() - b.getKarma();
            })
            response['kus'] = returnKus;
            res.json(response)
        });
    }
});

/* 
POST a new ku. Body looks like:
{
    "User_id": 1,
    "Ku": "This is a real test;I am not kidding, no sir; This test is for real",
    "Lat": 29,
    "Lon": 28
}
 */
router.post('/compose', function (req, res, next) {
    var returnObject = {}
    models.sequelize.transaction(function (t) {
        return Ku.create({
            content: req.body.Ku,
            lat: req.body.Lat,
            lon: req.body.Lon
        }, {transaction: t}).then(function (ku) {
            returnObject.ku = ku.dataValues;
            return Ku_user.create({
                userId: req.body.User_id,
                kuId: ku.dataValues.id,
                relationship: 0
            }, {transaction: t});
        });
    }).then(function (result) {
        res.json(returnObject);
    }).catch(function (error) {
        res.status(500).send(error);
    });
});

/* 
POST a newly favorited ku. Body looks like:
{
    "userId": 1,
    "kuId": 15
} 
*/
router.post('/favorite', function (req, res, next) {
    var whereClause = {
            userId: req.body.userId,
            kuId: req.body.kuId,
            relationship: 1
        }
    Ku_user.findOrCreate({
        where: whereClause
    }).spread(function (ku_user, created) {
        if (!created) {
            Ku_user.destroy({
                where: whereClause
            }).then(function () {
                res.status(200).json({"Status": "Ku favorite removed"});
            })
        } else {
            res.status(200).json({"Status": "Ku favorite added"})
        }
    }).catch(function (error) {
        res.status(500).send(error);
    });
});

/* 
POST an upvote to a ku. Body looks like:
{
    "userId": 1,
    "kuId": 15
} 
*/
router.post('/upvote', function (req, res, next) {
    var whereClause = {
            userId: req.body.userId,
            kuId: req.body.kuId,
            relationship: 2
        }
    Ku_user.findOrCreate({
        where: whereClause
    }).spread(function (ku_user, created) {
        if (!created) {
            Ku_user.destroy({
                where: whereClause
            }).then(function () {
                Ku.findById(req.body.kuId).then(function (ku) {
                    ku.decrement("upvotes");
                    ku.decrement("karma");
                    res.status(200).json({"Status": "Ku upvote removed"});
                })
            })
        } else {
            Ku.findById(req.body.kuId).then(function (ku) {
                ku.increment("upvotes");
                ku.increment("karma");
                res.status(200).json({"Status": "Ku upvote added"})
            })
        }
    }).catch(function (error) {
        res.status(500).send(error);
    });
});

/* 
POST an downvote to a ku. Body looks like:
{
    "userId": 1,
    "kuId": 15
} 
*/
router.post('/downvote', function (req, res, next) {
    var whereClause = {
            userId: req.body.userId,
            kuId: req.body.kuId,
            relationship: 3
        }
    Ku_user.findOrCreate({
        where: whereClause
    }).spread(function (ku_user, created) {
        if (!created) {
            Ku_user.destroy({
                where: whereClause
            }).then(function () {
                Ku.findById(req.body.kuId).then(function (ku) {
                    ku.decrement("downvotes");
                    ku.increment("karma");
                    res.status(200).json({"Status": "Ku downvote removed"});
                })
            })
        } else {
            Ku.findById(req.body.kuId).then(function (ku) {
                ku.increment("downvotes");
                ku.decrement("karma");
                res.status(200).json({"Status": "Ku downvote added"})
            })
        }
    }).catch(function (error) {
        res.status(500).send(error);
    });
});

module.exports = router;