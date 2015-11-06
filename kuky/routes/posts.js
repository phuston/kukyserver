var express = require('express');
var router = express.Router();

/* GET all posts */
router.get('/all/top', function(req, res, next) {
    // TODO: Get all the posts, order them in 'best' order
    res.send("Under development");
});

router.get('/all/new', function(req, res, next) {
    // TODO: Get all the posts, order them in the correct order.
    res.send("Under development");  
});

router.post('/new', function(req, res, next) {
    res.send(req.body);
});

module.exports = router;