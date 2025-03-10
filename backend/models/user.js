const { DataTypes } = require("sequelize");
const sequelize = require("../models/index"); // Importar instancia de Sequelize

const User = sequelize.define("User", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false
  },
  email: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false
  },
  token_expiry: {
    type: DataTypes.DATE,
    allowNull: true // ✅ Debe permitir valores NULL
  }
}, {
 
  tableName: "users",
  timestamps: false
});

module.exports = User;
