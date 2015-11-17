var express = require('express');
var router = express.Router();
var models  = require('../models');

/* GET all posts in new order */
router.get('/all/recent', function(req, res, next) {
	models.sequelize.models.Ku.findAll({
		where: {
			createdAt: {
				$lt: new Date(),
				$gt: new Date(new Date() - 24*60*60*1000)
			}
		}
	}).then(function (kus){
		kus.forEach(function (index, element, array){
			console.log(element.dataValues.id + ": " + element.dataValues.content);
		})
	});
	res.json('hello')
});

module.exports = router;