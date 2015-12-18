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
            this.setDataValue('downvotes', this.getDataValues('downvotes')+1);
        },
        decrement: function() {
            this.setDataValue('downvotes', this.getDataValues('downvotes')-1);
        }},
    karma: {
        type: DataTypes.INTEGER,
        allowNull: false,
        defaultValue: 0,
        validate: {isInt: true},
        increment: function() {
            this.setDataValue('karma', this.getDataValues('karma')+1);
        },
        decrement: function() {
            this.setDataValue('karma', this.getDataValues('karma')-1);
        }},
    lat: {
        type: DataTypes.FLOAT, 
        allowNull: false, 
        validate: {max: 90, min: -90, isFloat: true}},
    lon: {
        type: DataTypes.FLOAT, 
        allowNull: false, 
        validate: {max: 180, min: -180, isFloat: true}}
  }, {
      instanceMethods: {
          getData: function() {
              return {
                  "id": this.id,
                  "content": this.content,
                  "karma": this.karma,
                  "lat": this.lat,
                  "lon": this.lon,
                  "created": this.createdAt
              }
          },
          getKarma: function() {
              return this.upvotes - this.downvotes
          }
      }
  }, {
      paranoid: true
  });

  return Ku;
};