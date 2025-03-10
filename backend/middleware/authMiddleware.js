const jwt = require("jsonwebtoken");

const authenticateToken = (req, res, next) => {
  const token = req.header("Authorization");

  if (!token) {
    return res.status(401).json({ error: "❌ Acceso denegado. No hay token." });
  }

  try {
    const verified = jwt.verify(token.replace("Bearer ", ""), process.env.JWT_SECRET);
    req.user = verified;
    next(); // Continuar con la siguiente función
  } catch (error) {
    res.status(403).json({ error: "❌ Token inválido." });
  }
};

module.exports = authenticateToken;
