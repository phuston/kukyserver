"use strict";

var Ku = require("./kus");
var User = require("./users");

module.exports = function(sequelize, DataTypes) {
  var K_user = sequelize.define("Ku_user", {
    user_id: {
        type: DataTypes.INTEGER, 
        allowNull: false, 
        references: {model: User, key: 'id'}, 
        validate: {isInt: true}},
    ku_id: {
        type: DataTypes.INTEGER, 
        allowNull: false, 
        references: {model: Ku, key: 'id'}, 
        validate: {isInt: true}, 
        primaryKey: true},
    is_favorite: {
        type: DataTypes.BOOLEAN, 
        allowNull: false, 
        validate: {isIn: [0, 1]}, 
        defaultValue: 0}
  });

  return K_user;
};