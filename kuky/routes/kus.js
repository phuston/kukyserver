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

// TODO: Unfavoriting kus.

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
            response['kus'] = kus;
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
            kus.sort(function (a, b) {
                return a.getKarma() - b.getKarma();
            })
            response['kus'] = kus
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
    "User_id": 1,
    "Ku_id": 15
} 
*/
router.post('/favorite', function (req, res, next) {
    var whereClause = {
            userId: req.body.User_id,
            kuId: req.body.Ku_id,
            relationship: 1
        }
    Ku_user.findOrCreate({
        where: whereClause
    }).spread(function (ku_user, created) {
        if (!created) {
            Ku_user.destroy({
                where: whereClause
            }).then(function () {
                res.status(200).json({"Status": "Ku successfully unfavorited"});
            })
        } else {
            res.status(200).json({"Status": "Ku successfully favorited"})
        }
    }).catch(function (error) {
        res.status(500).send(error);
    });
});

/* POST an upvote to an existing ku*/
router.post('/:id/upvote', function (req, res, next) {
    Ku.findById(req.params.id).then(function (ku) {
        ku.increment('upvotes');
        ku.increment('karma');
        res.send("Confirmed");
    });
});

/* POST a downvote to an existing ku */
router.post('/:id/downvote', function (req, res, next) {
    Ku.findById(req.params.id).then(function (ku) {
        ku.increment('downvotes');
        ku.decrement('karma');
        res.send("Confirmed.");
    });
});

module.exports = router;