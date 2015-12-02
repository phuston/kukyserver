"use strict";

module.exports = function(sequelize, DataTypes) {
    var User_auth = sequelize.define("User_auth", {
        userId: {
            type: DataTypes.INTEGER,
            allowNull: false},
        username: {
            type: DataTypes.STRING,
            allowNull: false,
            primaryKey: true},
        apiKey: {
            type: DataTypes.STRING,
            allowNull: false},
        hashedPassword: {
            type: DataTypes.STRING,
            allowNull: false}
    });
    
    return User_auth;
};