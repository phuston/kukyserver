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
		where: {kuId: req.params.id} 
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

/* 
POST new comment for a given Ku id. Body looks like:
{
    "Content": "This ku is okay",
    "Ku_id": "12",
    "User_id": "6"
} 
*/
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
            isOp = ku_user.length > 0 ? 1 : 0;
        }, {transaction: t});
    }).then(function (result) {
        models.sequelize.transaction(function (t) {
            return Comment.create({
                content:req.body.Content
            }, {transaction: t}).then(function (comment) {
                returnObject.comment = comment.dataValues;
                console.log(isOp);
                return Ku_comment_user.create({
                    kuId: KU_ID,
                    commentId: comment.dataValues.id,
                    userId: USER_ID,
                    relationship: isOp
                }, {transaction: t});
            });
        }).then(function (result) {
            res.json(returnObject);
        }).catch(function (error) {
            res.status(500).send(error);
        })
    }).catch(function (error) {
        res.status(500).send(error);
    })
})

/* POST an upvote to an existing comment. Body looks like:
{
    "userId": 5,
    "commentId": 7,
    "kuId": 3
}
 */
router.post('/upvote', function (req, res, next) {
    var whereClause = {
        userId: req.body.userId,
        commentId: req.body.commentId,
        kuId: req.body.kuId,
        relationship: 2
    }
    
    Ku_comment_user.findOrCreate({
        where: whereClause
    }).spread(function (ku_user, created) {
        if (!created) {
            Ku_comment_user.destroy({
                where: whereClause
            }).then(function () {
                Comment.findById(req.body.commentId).then(function (comment) {
                    comment.decrement('upvotes')
                    res.status(200).json({"Status": comment.dataValues.upvotes - 1 - comment.dataValues.downvotes})
                });
            })
        } else {
            Comment.findById(req.body.commentId).then(function (comment) {
                comment.increment('upvotes').then(function (comment) {
                        res.status(200).json({"Status": comment.dataValues.upvotes + 1 - comment.dataValues.downvotes})
                    });
            });
        }
    }).catch(function (error) {
        res.status(500).send(error);
    });
});

/* POST a downvote to an existing comment. Body looks like:
{
    "userId": 5,
    "commentId": 7,
    "kuId": 3
}
 */
router.post('/downvote', function (req, res, next) {
    var whereClause = {
        userId: req.body.userId,
        commentId: req.body.commentId,
        kuId: req.body.kuId,
        relationship: 3
    }
    
    Ku_comment_user.findOrCreate({
        where: whereClause
    }).spread(function (ku_user, created) {
        if (!created) {
            Ku_comment_user.destroy({
                where: whereClause
            }).then(function () {
                Comment.findById(req.body.commentId).then(function (comment) {
                    comment.decrement('downvotes');
                    res.status(200).json({"Status": comment.dataValues.upvotes - comment.dataValues.downvotes + 1})
                });
            })
        } else {
            Comment.findById(req.body.commentId).then(function (comment) {
                comment.increment('downvotes');
                res.status(200).json({"Status": comment.dataValues.upvotes - comment.dataValues.downvotes - 1})
            });
        }
    }).catch(function (error) {
        res.status(500).send(error);
    });
});

/*
GET boolean check to see if user has already upvoted/downvoted a ku
*/
router.get('/:kuId/:commentId/:userId/:vote', function (req, res, next) {
    var relationship = req.params.vote == 'upvote' ? 2 : 3;
    Ku_comment_user.findOne({
        where: {
            userId: req.params.userId,
            kuId: req.params.kuId,
            commentId: req.params.commentId,
            relationship: relationship
        }
    }).then(function (ku_comment_user) {
        var hasVote = ku_comment_user !== null;
        res.json({"status": hasVote});
    })
}) 

module.exports = router;