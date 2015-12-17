var models = require('../models');
var passport = require('passport');
var BasicStrategy = require('passport-http').BasicStrategy;

var User_auth = models.sequelize.models.User_auth;
var User = models.sequelize.models.User;

passport.use(new BasicStrategy(
    function(username, apiKey, callback) {
        User.findOne({
            where: {
                username: username.toLowerCase()
            }
        }).then(function (user) {

            // No user found with that username
            if (!user) { return callback(null, false); }

            // Make sure the apiKey is correct
            User_auth.findById(username.toLowerCase()).then(function (user_auth) {

                // apiKey matches
                if (user_auth.dataValues.apiKey == apiKey) {
                    return callback(null, user)
                } 

                // apiKey did not match
                else { return callback(null, false); }
            });
        })
    }
));

module.exports.authenticate = passport.authenticate('basic', { session : false });