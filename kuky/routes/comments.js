var express = require('express');
var router = express.Router();
var models  = require('../models');
var apiAuth = require('./apiAuth');

var User = models.sequelize.models.User;
var Ku = models.sequelize.models.Ku;
var Ku_user = models.sequelize.models.Ku_user;
var Ku_comment_user = models.sequelize.models.Ku_comment_user;
var Comment = models.sequelize.models.Comment;

/* GET all comments for a given Ku id */
router.get('/:id/:userId', apiAuth.authenticate, function (req, res, next) {
	var all_comments = [];
    var comment_ids = [];
    var relationship = {};

	Ku_comment_user.findAll({
		where: {
            kuId: req.params.id,
            userId: req.params.userId
        } 
	}).then(function(Ku_comment_users){
		Ku_comment_users.forEach(function (elem, i, arr) {
			comment_ids.push(elem.dataValues.commentId);
            var key = elem.dataValues.commentId;
            var value = elem.dataValues.relationship;
            if (relationship.hasOwnProperty(key)) {
                relationship[key].push(value);
            } else {
                relationship[key] = [value];
            }
		});
        console.log(relationship);
		Comment.findAll({
			where: {id: {$in: comment_ids}}
		}).then(function (comments){
			comments.forEach(function (elem, i, arr) {
                var comment = elem.getData();
                comment.isOp = relationship[comment.id].indexOf(1) > -1 || false;
                comment.upvoted = relationship[comment.id].indexOf(2) > -1 || false;
                comment.downvoted = relationship[comment.id].indexOf(3) > -1 || false;
                console.log(comment);
				all_comments.push(comment);
			});
			res.json(all_comments);
		});
	});
});


/* 
POST new comment for a given Ku id. Body looks like:
{
    "comment": "This ku is okay",
    "kuId": "12",
    "userId": "6"
} 
*/
router.post('/compose', apiAuth.authenticate, function (req, res, next) {
    var auth = req.get("authorization").split(' ')[1];
    var auth_user = new Buffer(auth, 'base64').toString().split(':')[0];

    User.findById(req.body.userId).then(function (user) {
        if (user.dataValues.username == auth_user) {
        	var returnObject = {};
            var isOp;
            var USER_ID = req.body.userId;
            var KU_ID = req.body.kuId;

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
                        content:req.body.comment
                    }, {transaction: t}).then(function (comment) {
                        returnObject.comment = comment.dataValues;
                        console.log(returnObject);
                        return Ku_comment_user.create({
                            kuId: KU_ID,
                            commentId: comment.dataValues.id,
                            userId: USER_ID,
                            relationship: isOp
                        }, {transaction: t});
                    });
                }).then(function (result) {
                    User.findById(result.dataValues.userId).then(function (user) {
                        user.update({score: user.dataValues.score+5})
                    });
                    res.json(returnObject);
                }).catch(function (error) {
                    res.status(500).send(error);
                })
            }).catch(function (error) {
                res.status(500).send(error);
            });
        } else {
            res.status(401).send('Unauthorized');
        }
    });
})

/* POST an upvote to an existing comment. Body looks like:
{
    "userId": 5,
    "commentId": 7,
    "kuId": 3
}
 */
router.post('/upvote', apiAuth.authenticate, function (req, res, next) {
    var auth = req.get("authorization").split(' ')[1];
    var auth_user = new Buffer(auth, 'base64').toString().split(':')[0];
    var added;

    User.findById(req.body.userId).then(function (user) {
        if (user.dataValues.username == auth_user) {
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
                        User.findById(req.body.userId).then(function (user) {
                            user.update({score: user.dataValues.score-3});
                        });
                        Comment.findById(req.body.commentId).then(function (comment) {
                            comment.decrement('upvotes')
                            res.status(200).json({"Status": comment.dataValues.upvotes - 1 - comment.dataValues.downvotes})
                        });
                    })
                } else {
                    User.findById(req.body.userId).then(function (user) {
                        user.update({score: user.dataValues.score+3});
                    });
                    Comment.findById(req.body.commentId).then(function (comment) {
                        comment.increment('upvotes').then(function (comment) {
                                res.status(200).json({"Status": comment.dataValues.upvotes + 1 - comment.dataValues.downvotes})
                            });
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

/* POST a downvote to an existing comment. Body looks like:
{
    "userId": 5,
    "commentId": 7,
    "kuId": 3
}
 */
router.post('/downvote', apiAuth.authenticate, function (req, res, next) {
    var auth = req.get("authorization").split(' ')[1];
    var auth_user = new Buffer(auth, 'base64').toString().split(':')[0];

    User.findOne({where: {id: req.body.userId}}).then(function (user) {
        if (user.dataValues.username == auth_user) {
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
                        User.findById(req.body.userId).then(function (user) {
                            user.update({score: user.dataValues.score-3})
                        });
                        Comment.findById(req.body.commentId).then(function (comment) {
                            comment.decrement('downvotes');
                            res.status(200).json({"Status": comment.dataValues.upvotes - comment.dataValues.downvotes + 1})
                        });
                    })
                } else {
                    User.findById(req.body.userId).then(function (user) {
                            user.update({score: user.dataValues.score-3})
                        });
                    Comment.findById(req.body.commentId).then(function (comment) {
                        comment.increment('downvotes');
                        res.status(200).json({"Status": comment.dataValues.upvotes - comment.dataValues.downvotes - 1})
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

module.exports = router;