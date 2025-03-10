const { DataTypes } = require("sequelize");
const sequelize = require("../models/index");

const Article = sequelize.define("Article", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  title: {
    type: DataTypes.STRING,
    allowNull: false
  },
  description: {
    type: DataTypes.TEXT,
    allowNull: false
  },
  image_url: {
    type: DataTypes.STRING,
    allowNull: true
  }
}, {
  tableName: "articles",
  timestamps: false
});

module.exports = Article;
