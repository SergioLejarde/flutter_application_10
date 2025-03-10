const express = require("express");
const authenticateToken = require("../middleware/authMiddleware");
const { createArticle, getArticles } = require("../controllers/articleController");

const router = express.Router();

// Ruta para obtener artículos (PROTEGIDA)
router.get("/", authenticateToken, getArticles);

// Ruta para agregar artículos (PROTEGIDA)
router.post("/", authenticateToken, createArticle);

module.exports = router;
