var express = require('express');
var router = express.Router();
var models  = require('../models');

var User = models.sequelize.models.User;
var Ku = models.sequelize.models.Ku;
var Ku_user = models.sequelize.models.Ku_user;

var responseLimit = 50;

/* 
GET all kus in new order
 */
router.get('/all/recent', function (req, res, next) {
	Ku.findAll({
		where: {
			createdAt: {
				$lt: new Date(),
				$gt: new Date(new Date() - 7*24*60*60*1000)
			}
		},
        limit: responseLimit
	}).then(function (kus) {
		kus.sort(function (a, b) {
            return a.dataValues.createdAt - b.dataValues.createdAt;
        })
        res.json(kus)
	});
});

/* 
GET all kus in order of hotness
 */
router.get('/all/hot', function(req, res, next) {
	Ku.findAll({
        limit: responseLimit
    }).then(function (kus) {
		kus.sort(function (a, b) {
            var karmaA = a.dataValues.upVotes - a.dataValues.downVotes;
            var karmaB = b.dataValues.upVotes - b.dataValues.downVotes;
            return karmaA - karmaB;
        })
        res.json(kus)
	});
});

/* 
POST a new ku. Body looks like:
{
    "User_id": "1",
    "Ku": "This is a real test;I am not kidding, no sir; This test is for real",
    "Lat": "29",
    "Lon": "28"
}
 */
router.post('/new/composed', function (req, res, next) {
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
    "User_id": "1",
    "Ku_id": "15"
} 
*/
router.post('/new/favorited', function (req, res, next) {
    Ku_user.create({
        userId: req.body.User_id,
        kuId: req.body.Ku_id,
        relationship: 1
    }).then(function (result) {
        res.send("Confirmed");
    }).catch(function (error) {
        res.status(500).send(error);
    });
});

/* POST an upvote to an existing ku */
router.post('/:id/upvote', function (req, res, next) {
    Ku.findById(req.params.id).then(function (ku) {
        ku.increment('upvotes');
        res.send("Confirmed");
    });
});

/* POST a downvote to an existing ku */
router.post('/:id/downvote', function (req, res, next) {
    Ku.findById(req.params.id).then(function (ku) {
        ku.increment('downvotes');
        res.send("Confirmed.");
    });
});

module.exports = router;