var express = require('express');
var router = express.Router();

/* GET all posts */
router.get('/all', function(req, res, next) {
	var post1 = {
		"_id":1000,
		"kukontent":["Haikus are easy","They take almost no effort", "Refrigerator"],
		"username":"Patrick"
	};
	var post2 = {
		"_id":1001,
		"kukontent":["Haikus are stupid","They take a lot of effort", "Byron S Wasti"],
		"username":"Patrick"
	};
	res.json(post1)
});

module.exports = router;