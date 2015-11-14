"use strict";

module.exports = function(sequelize, DataTypes) {
  var User = sequelize.define("Users", {
    username: DataTypes.STRING
  });

  return User;
};