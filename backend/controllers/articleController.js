const Article = require("../models/article");

// Obtener todos los artículos
exports.getArticles = async (req, res) => {
  try {
    const articles = await Article.findAll();
    res.json(articles);
  } catch (error) {
    res.status(500).json({ error: "Error al obtener los artículos" });
  }
};

// Crear un artículo
exports.createArticle = async (req, res) => {
  try {
    const { title, description, image_url } = req.body;

    if (!title || !description) {
      return res.status(400).json({ error: "El título y la descripción son obligatorios." });
    }

    const newArticle = await Article.create({ title, description, image_url });
    res.status(201).json({ message: "✅ Artículo agregado", article: newArticle });
  } catch (error) {
    res.status(500).json({ error: "Error al crear el artículo" });
  }
};
