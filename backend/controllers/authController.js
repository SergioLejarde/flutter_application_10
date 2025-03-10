const User = require("../models/user");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");

exports.register = async (req, res) => {
  try {
    console.log("📢 Registro de usuario iniciado...");

    const { name, email, password } = req.body;
    if (!name || !email || !password) {
      return res.status(400).json({ error: "Todos los campos son obligatorios" });
    }

    // Encriptar la contraseña
    const hashedPassword = await bcrypt.hash(password, 10);

    // Crear usuario en la base de datos
    const newUser = await User.create({ name, email, password: hashedPassword });

    res.status(201).json({ message: "✅ Usuario registrado", user: newUser });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.login = async (req, res) => {
  try {
    console.log("📢 Intento de inicio de sesión...");

    const { email, password } = req.body;
    const user = await User.findOne({ where: { email } });
    if (!user) return res.status(400).json({ error: "Usuario no encontrado" });

    const validPassword = await bcrypt.compare(password, user.password);
    if (!validPassword) return res.status(401).json({ error: "Contraseña incorrecta" });

    const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET, { expiresIn: "7d" });
    res.json({ token, user });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
