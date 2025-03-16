// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String token = "Cargando...";
  String expiryDate = "Cargando...";

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("token") ?? "No hay token guardado";
      expiryDate = prefs.getString("token_expiry") ?? "No hay fecha de expiración";
    });

    print("🔑 Token en HomeScreen: $token");
    print("📅 Fecha de expiración en HomeScreen: $expiryDate");
  }

  Future<void> logout(BuildContext context) async {
    bool confirmLogout = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cerrar sesión"),
        content: const Text("¿Estás seguro de que quieres cerrar sesión?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Salir", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmLogout) {
      await AuthService.logout();
      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Fondo claro
      appBar: AppBar(
        title: const Text(
          "Browntastic Home",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple, // Color del encabezado
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔥 Imagen de bienvenida
              Image.asset(
                "assets/logo.png", // 🛠 Asegúrate de colocar la imagen en assets
                height: 100,
              ),
              const SizedBox(height: 20),
              // 📦 Caja con información del token
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        "🔑 TOKEN GUARDADO:",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        token,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
                      ),
                      const Divider(),
                      const Text(
                        "📅 EXPIRACIÓN:",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        expiryDate,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // 🎯 Botón de navegación
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/articles");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Ver Artículos",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
