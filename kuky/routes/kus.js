var express = require('express');
var router = express.Router();
var models  = require('../models');
var sequelize = require('sequelize');
var apiAuth = require('./apiAuth');

var User = models.sequelize.models.User;
var Ku = models.sequelize.models.Ku;
var Ku_user = models.sequelize.models.Ku_user;
var Ku_comment_user = models.sequelize.models.Ku_comment_user;
var Comment = models.sequelize.models.Comment;

var responseLimit = 50;
var dateLimitRecent = 50;
var dateLimitHot = 50;
var karmaThreshold = 3;


/*
GET single ku by id
*/
router.get('/:id', apiAuth.authenticate, function (req, res, next) { // TODO:FIX THIS
    var response = {
        ku: {},
        comments: []
    };
    var commentIds = [];
    Ku.findById(req.params.id).then(function (ku) {
        response.ku = ku.getData();
        Ku_comment_user.findAll({
            where: {kuId: response.ku.id}
        }).then(function (ku_comment_users) {
            ku_comment_users.forEach(function (elem, i, arr) {
                commentIds.push(elem.dataValues.commentId);
            });
            Comment.findAll({
                where: {id: {$in: commentIds}}
            }).then(function (comments) {
                comments.forEach(function (elem, i, arr) {
                    response['comments'].push(elem.getData());
                })
                res.json(response);
            });
        });
    });
});

/* 
GET all kus in new order
 */
router.get('/all/:sort', apiAuth.authenticate, function (req, res, next) {
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
                returnKus.splice(0, 0, elem.getData());
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
    "userId": 1,
    "ku": "This is a real test;I am not kidding, no sir; This test is for real",
    "lat": 29,
    "lon": 28
}
 */
router.post('/compose', apiAuth.authenticate, function (req, res, next) {
    var auth = req.get("authorization").split(' ')[1];
    var auth_user = new Buffer(auth, 'base64').toString().split(':')[0];

    User.findOne({where: {id: req.body.userId}}).then(function (user) {
        if (user.dataValues.username == auth_user) {
            var returnObject = {};
            models.sequelize.transaction(function (t) {
                return Ku.create({
                    content: req.body.ku,
                    lat: req.body.lat,
                    lon: req.body.lon
                }, {transaction: t}).then(function (ku) {
                    returnObject.ku = ku.dataValues;
                    return Ku_user.create({
                        userId: req.body.userId,
                        kuId: ku.dataValues.id,
                        relationship: 0
                    }, {transaction: t});
                });
            }).then(function (result) {
                res.json(returnObject);
            }).catch(function (error) {
                res.status(500).send(error);
            });
        } else {
            res.status(401).send('Unauthorized');
        }
    });
});

/* 
POST a newly favorited ku. Body looks like:
{
    "userId": 1,
    "kuId": 15
} 
*/
router.post('/favorite', apiAuth.authenticate, function (req, res, next) {
    var auth = req.get("authorization").split(' ')[1];
    var auth_user = new Buffer(auth, 'base64').toString().split(':')[0];

    User.findOne({where: {id: req.body.userId}}).then(function (user) {
        if (user.dataValues.username == auth_user) {
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
        } else {
            res.status(401).send('Unauthorized');
        }
    });
});

/* 
POST an upvote to a ku. Body looks like:
{
    "userId": 1,
    "kuId": 15
} 
*/
router.post('/upvote', apiAuth.authenticate, function (req, res, next) {
    var auth = req.get("authorization").split(' ')[1];
    var auth_user = new Buffer(auth, 'base64').toString().split(':')[0];

    User.findOne({where: {id: req.body.userId}}).then(function (user) {
        if (user.dataValues.username == auth_user) {
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
                            res.status(200).json({"Status": ku.dataValues.karma-1});
                        });
                    })
                } else {
                    Ku.findById(req.body.kuId).then(function (ku) {
                        ku.increment("upvotes");
                        ku.increment("karma");
                        res.status(200).json({"Status": ku.dataValues.karma+1})
                    });
                }
            }).catch(function (error) {
                res.status(500).send(error);
            });
        } else {
            res.status(401).send('Unauthorized');
        }
    });
});

/* 
POST a downvote to a ku. Body looks like:
{
    "userId": 1,
    "kuId": 15
} 
*/
router.post('/downvote', apiAuth.authenticate, function (req, res, next) {
    var auth = req.get("authorization").split(' ')[1];
    var auth_user = new Buffer(auth, 'base64').toString().split(':')[0];

    User.findOne({where: {id: req.body.userId}}).then(function (user) {
        if (user.dataValues.username == auth_user) {
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
                            res.status(200).json({"Status": ku.dataValues.karma+1});
                        })
                    })
                } else {
                    Ku.findById(req.body.kuId).then(function (ku) {
                        ku.increment("downvotes");
                        ku.decrement("karma");
                        res.status(200).json({"Status": ku.dataValues.karma-1})
                    })
                }
            }).catch(function (error) {
                res.status(500).send(error);
            });
        } else {
            res.status(401).send('Unauthorized');
        }
    });
});

/*
GET boolean check to see if user has already upvoted/downvoted a ku
*/
router.get('/:id/:userId/:vote', apiAuth.authenticate, function (req, res, next) {
    var auth = req.get("authorization").split(' ')[1];
    var auth_user = new Buffer(auth, 'base64').toString().split(':')[0];

    User.findOne({where: {id: req.params.userId}}).then(function (user) {
        if (user.dataValues.username == auth_user) {
            var relationship = req.params.vote == 'upvote' ? 2 : 3;
            Ku_user.findOne({
                where: {
                    userId: req.params.userId,
                    kuId: req.params.id,
                    relationship: relationship
                }
            }).then(function (ku_user) {
                var hasVote = ku_user !== null;
                res.json({"status": hasVote});
            });
        } else {
            res.status(401).send('Unauthorized');
        }
    });
});

module.exports = router;