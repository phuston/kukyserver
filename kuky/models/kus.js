"use strict";

module.exports = function(sequelize, DataTypes) {
  var Ku = sequelize.define("Ku", {
    content: {
        type: DataTypes.STRING, 
        allowNull: false},
    upvotes: {
        type: DataTypes.INTEGER, 
        allowNull: false, 
        defaultValue: 0, 
        validate: {isInt: true}},
    downvotes: {
        type: DataTypes.INTEGER, 
        allowNull: false, 
        defaultValue: 0, 
        validate: {isInt: true}},
    lat: {
        type: DataTypes.FLOAT, 
        allowNull: false, 
        validate: {max: 90, min: -90, isFloat: true}},
    lon: {
        type: DataTypes.FLOAT, 
        allowNull: false, 
        validate: {max: 180, min: -180, isFloat: true}}
  });

  return Ku;
};