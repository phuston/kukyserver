var express = require('express');
var router = express.Router();
var models  = require('../models');
var app = express();

var User = models.sequelize.models.User;
var Ku = models.sequelize.models.Ku;
var Ku_user = models.sequelize.models.Ku_user;

var responseLimit = 50;

/* GET all posts in new order */
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

router.post('/new/composed', function (req, res, next) {
    var returnObject = {}
    
    models.sequelize.transaction(function (t) {
        return Ku.create({
            content: req.body.Ku,
            lat: req.body.Lat,
            lon: req.body.Lon
        }, {transaction: t}).then(function (ku) {
            returnObject.ku = ku.dataValues;
            console.log(req.body.User_id);
            console.log(ku.dataValues.id);
            return Ku_user.create({
                user_id: req.body.User_id,
                ku_id: ku.dataValues.id
            }, {transaction: t});
        });
    }).then(function (result) {
        res.send(returnObject);
    }).catch(function (error) {
        console.log(error);
    })
})

router.post('/new/favorited', function (req, res, next) {
    Ku_user.create({
        user_id: req.body.User_id,
        ku_id: req.body.Ku_id,
        is_favorite: true
    }).then(function (result) {
        res.send("Ku favorited");
    }).catch(function (error) {
        console.log(error);
    })
})

router.post('/upvote', function (req, res, next) {
    Ku.findById(req.body.Ku_id).then(function (ku) {
        ku.increment('upvotes');
        res.send("Confirmed");
    })
})

router.post('/downvote', function (req, res, next) {
    Ku.findById(req.body.Ku_id).then(function (ku) {
        ku.increment('downvotes');
        res.send("Confirmed");
    })
})

module.exports = router;