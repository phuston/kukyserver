"use strict";

module.exports = function(sequelize, DataTypes) {
  var User = sequelize.define("User", {
    username: {
        type: DataTypes.STRING, 
        allowNull: false}, 
    score: {
        type: DataTypes.INTEGER, 
        allowNull: false, 
        defaultValue: 0, 
        validate: {isInt: true}}
    // password: DataTypes.INTEGER,
    // api_key: ?
  });

  return User;
};