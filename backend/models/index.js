const { Sequelize } = require("sequelize");
const config = require("../config/config.js").development;

const sequelize = new Sequelize(
  config.database,
  config.username,
  config.password,
  {
    host: config.host,
    dialect: config.dialect,
    port: config.port,
    logging: false
  }
);

// Asegurar sincronización de tablas
sequelize.sync({ force: false })
  .then(() => console.log("✅ Todas las tablas están sincronizadas"))
  .catch(err => console.error("❌ Error al sincronizar Sequelize:", err));

module.exports = sequelize;
