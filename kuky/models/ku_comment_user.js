"use strict";

var Comment = require("./comments");
var Ku = require("./kus");
var User = require("./users");

/*
Model for connecting ku-comment-user relationship info to database through Sequelize
*/
module.exports = function(sequelize, DataTypes) {
  var Kcu = sequelize.define("Ku_comment_user", {
    userId: {
        type: DataTypes.INTEGER, 
        allowNull: false, 
        references: {model: User, key: 'id'}, 
        validate: {isInt: true}},
    commentId: {
        type: DataTypes.INTEGER, 
        allowNull: false, 
        primaryKey: true, 
        references: {model: Comment, key: 'id'}, 
        validate: {isInt: true}},
    kuId: {
        type: DataTypes.INTEGER, 
        allowNull: false, 
        references: {model: Ku, key: 'id'}, 
        validate: {isInt: true}},
    relationship: {
        type: DataTypes.INTEGER,
        allowNull: false,
        validate: {isIn: [[0, 1, 2, 3]]}
    }
  });

  return Kcu;
};