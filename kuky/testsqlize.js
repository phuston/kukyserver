"use strict";

var Sequelize = require("sequelize");

var sequelize = new Sequelize(process.env.database, 'root', process.env.password, {
    host: 'localhost',
    dialect: 'mysql',
    
    pool: {
        max: 5,
        min: 0,
        idle: 10000
    },
});

var uuid = require('node-uuid');

console.log(uuid());

