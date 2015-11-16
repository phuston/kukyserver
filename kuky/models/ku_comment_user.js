"use strict";

var Comment = require("./comments");
var Ku = require("./kus");
var User = require("./users");

module.exports = function(sequelize, DataTypes) {
  var Kcu = sequelize.define("Ku_comment_user", {
    user_id: {
        type: DataTypes.INTEGER, 
        allowNull: false, 
        references: {model: User, key: 'id'}, 
        validate: {isInt: true}},
    comment_id: {
        type: DataTypes.INTEGER, 
        allowNull: false, 
        primaryKey: true, 
        references: {model: Comment, key: 'id'}, 
        validate: {isInt: true}},
    ku_id: {
        type: DataTypes.INTEGER, 
        allowNull: false, 
        references: {model: Ku, key: 'id'}, 
        validate: {isInt: true}}
  });

  return Kcu;
};