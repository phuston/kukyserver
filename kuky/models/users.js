"use strict";

/*
Model for connecting user info to database through Sequelize
*/
module.exports = function(sequelize, DataTypes) {
  var User = sequelize.define("User", {
    username: {
        type: DataTypes.STRING, 
        allowNull: false}, 
    score: {
        type: DataTypes.INTEGER, 
        allowNull: false, 
        defaultValue: 100, 
        validate: {isInt: true}},
    radiusLimit: {
        type: DataTypes.FLOAT,
        allowNull: true,
        defaultValue: 60,
        validate: {
            max: 100,
            min: 20
        }
    }
  });

  return User;
};