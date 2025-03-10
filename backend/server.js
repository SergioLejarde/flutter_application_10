const express = require("express");
const cors = require("cors");
const path = require("path");
require("dotenv").config();

const app = express();
const port = process.env.PORT || 5000;

app.use(cors({
  origin: "*",
  methods: "GET,POST,PUT,DELETE",
  allowedHeaders: "Content-Type,Authorization"
}));

app.use(express.json());

// Servir imágenes desde la carpeta "public/images"
app.use("/images", express.static(path.join(__dirname, "public/images")));

console.log("✅ Cargando rutas de autenticación y artículos...");

const authRoutes = require("./routes/authRoutes");
const articleRoutes = require("./routes/articleRoutes");

app.use("/api/auth", authRoutes);
app.use("/api/articles", articleRoutes);

app.get("/", (req, res) => {
  res.send("✅ El servidor está funcionando correctamente.");
});

app.use((req, res) => {
  console.log(`❌ Ruta no encontrada: ${req.method} ${req.url}`);
  res.status(404).json({ error: "❌ Ruta no encontrada" });
});

app.listen(port, () => {
  console.log(`🚀 Servidor corriendo en http://localhost:${port}`);
});
