"use strict";

var Ku = require("./kus");
var User = require("./users");

/*
Model for connecting ku-user relationship info to database through Sequelize
*/
module.exports = function(sequelize, DataTypes) {
  var K_user = sequelize.define("Ku_user", {
    userId: {
        type: DataTypes.INTEGER, 
        allowNull: false, 
        references: {model: User, key: 'id'}, 
        validate: {isInt: true}},
    kuId: {
        type: DataTypes.INTEGER, 
        allowNull: false, 
        references: {model: Ku, key: 'id'}, 
        validate: {isInt: true}, 
        primaryKey: true},
    relationship: {
        // 0: composed, 1: favorited, 2: upvoted, 3: downvoted
        type: DataTypes.INTEGER, 
        allowNull: false, 
        defaultValue: false,
        validate: {isIn: [[0, 1, 2, 3]]}}
  });

  return K_user;
};