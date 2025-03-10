const express = require("express");
const cors = require("cors");
require("dotenv").config();

const app = express();
const port = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

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
