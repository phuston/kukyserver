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
        validate: {isInt: true},
        increment: function() {
            this.setDataValue('upvotes', this.getDataValues('upvotes')+1);
        },
        decrement: function() {
            this.setDataValue('upvotes', this.getDataValues('upvotes')-1);
        }},
    downvotes: {
        type: DataTypes.INTEGER, 
        allowNull: false, 
        defaultValue: 0, 
        validate: {isInt: true},
        increment: function() {
            this.setDataValue('upvotes', this.getDataValues('upvotes')+1);
        },
        decrement: function() {
            this.setDataValue('upvotes', this.getDataValues('upvotes')-1);
        }},
  }, {
      instanceMethods: {
          getData: function() {
              return {
                  "id": this.id,
                  "content": this.content,
                  "karma": this.upvotes - this.downvotes
              }
          },
          getKarma: function() {
              return this.upvotes - this.downvotes;
          }
      }
  });

  return Comment;
};