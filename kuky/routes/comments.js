var express = require('express');
var router = express.Router();
var models  = require('../models');

var User = models.sequelize.models.User;
var Ku = models.sequelize.models.Ku;
var Ku_user = models.sequelize.models.Ku_user;
var Ku_comment_user = models.sequelize.models.Ku_comment_user;
var Comment = models.sequelize.models.Comment;

/* GET all comments for a given Ku id */
router.get('/:id', function (req, res, next) {
	var all_comments = [];

	Ku_comment_user.findAll(
	{
		where: {
			kuId: req.params.id
		} 
	}).then(function(Ku_comment_users){
		var comment_ids = [];
		Ku_comment_users.forEach(function (elem, i, arr) {
			comment_ids.push(elem.dataValues.commentId);
		});
		Comment.findAll({
			where: {
				id: {
					$in: comment_ids
				}
			}
		}).then(function (comments){
			comments.forEach(function (elem, i, arr) {
				all_comments.push(elem.dataValues)
			});
			res.json(all_comments);
		});
	});
});

/* POST new comment for a given Ku id */
router.post('/new', function (req, res, next) {
	var returnObject = {};
    var isOp;
    var USER_ID = Number(req.body.User_id);
    var KU_ID = Number(req.body.Ku_id);

    models.sequelize.transaction(function (t) {
        return Ku_user.findAll({
            where: {
                userId: USER_ID,
                kuId: KU_ID,
                relationship: 0
            }
        }).then(function (ku_user) {
            isOp = ku_user.length > 0;
        }, {transaction: t});
    }).then(function (result) {
        console.log(isOp);
        models.sequelize.transaction(function (t) {
            return Comment.create({
                content:req.body.Content
            }, {transaction: t}).then(function (comment) {
                returnObject.comment = comment.dataValues;
                console.log("RETURNOBJECT:\n" + JSON.stringify(returnObject));
                return Ku_comment_user.create({
                    kuId: KU_ID,
                    commentId: comment.dataValues.id,
                    userId: USER_ID,
                    isOp: isOp
            }, {transaction: t});
        }).then(function (result) {
            res.json(returnObject);
        }).catch(function (error) {
            console.log(error);
        });
        }).catch(function (error) {
            console.log(error);
        })
    })
})

/* POST an upvote to an existing comment */
router.post('/:id/upvote', function (req, res, next) {
	Comment.findById(req.params.id).then(function (comment) {
		comment.increment('upvotes');
		res.send("Confirmed");
	});
});

/* POST a downvote to an existing comment */
router.post('/:id/downvote', function (req, res, next) {
	Comment.findById(req.params.id).then(function (comment) {
		comment.increment('downvotes');
		res.send("Confirmed");
	});
});

module.exports = router;