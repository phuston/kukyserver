"use strict";

module.exports = function(sequelize, DataTypes) {
  var Comment = sequelize.define("Comment", {
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
        validate: {isInt: true}}
  });

  return Comment;
};