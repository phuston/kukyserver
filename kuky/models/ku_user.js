"use strict";

var Ku = require("./kus");
var User = require("./users");

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
        type: DataTypes.INTEGER, 
        allowNull: false, 
        defaultValue: false}
  });

  return K_user;
};