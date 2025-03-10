const express = require("express");
const { register, login } = require("../controllers/authController");

const router = express.Router();

console.log("✅ authRoutes.js cargado correctamente.");

// Usar el controlador real en lugar de la prueba
router.post("/register", register);
router.post("/login", login);

module.exports = router;
