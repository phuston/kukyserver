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

var Comments = sequelize.define("Comments", {
    ID: Sequelize.INTEGER,
    Content: Sequelize.STRING,
    Upvotes: Sequelize.INTEGER,
    Downvotes: Sequelize.INTEGER
}, {
    classMethods: {
        getAll: function() {
            return 'smth';
        }
    },
    instanceMethods: {
        getData: function() {
            return this.Content;
        }
    }
})

function ShowAll() {
    sequelize.query("select * from `Comments`", {type: sequelize.QueryTypes.SELECT})
    .then(function(rows) {
        rows.forEach(function(element, index, array) {
            console.log(element.ID + ": " + element.Content);
        })
    })  
}


Comments.findById(1).then(function(comment) {
    console.log(comment.getData());
})

