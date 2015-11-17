var express = require('express');
var router = express.Router();
var models  = require('../models');

var Ku = models.sequelize.models.Ku;
var Ku_user = models.sequelize.models.Ku_user;

/* GET all posts in new order */
router.get('/all/recent', function(req, res, next) {
	Ku.findAll({
		where: {
			createdAt: {
				$lt: new Date(),
				$gt: new Date(new Date() - 7*24*60*60*1000)
			}
		}
	}).then(function(kus) {
		kus.sort(function(a, b) {
            return a.dataValues.createdAt - b.dataValues.createdAt;
        })
        res.json(kus)
	});
});

router.get('/all/recent', function(req, res, next) {
	Ku.findAll().then(function(kus) {
		kus.sort(function(a, b) {
            return a.dataValues.createdAt - b.dataValues.createdAt;
        })
        res.json(kus)
	});
});

module.exports = router;