// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = "";
  bool isLoading = false;

  Future<void> login() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    bool success = await AuthService.login(emailController.text, passwordController.text);

    if (success) {
      final prefs = await SharedPreferences.getInstance();
      print("🔎 Estado actual de SharedPreferences después del login:");
      prefs.getKeys().forEach((key) {
        print("$key: ${prefs.get(key)}");
      });

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      setState(() {
        errorMessage = "Error al iniciar sesión. Verifica tus credenciales.";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Fondo gris claro
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo.png", height: 120), // 🖼️ Logo de la app
              const SizedBox(height: 20),
              const Text(
                "Bienvenido a Browntastic",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Correo Electrónico",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    prefixIcon: const Icon(Icons.email, color: Colors.purple),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    prefixIcon: const Icon(Icons.lock, color: Colors.purple),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Ingresar", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(errorMessage, style: const TextStyle(color: Colors.red)),
                ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Acción de "Olvidé mi contraseña"
                },
                child: const Text("¿Olvidaste tu contraseña?", style: TextStyle(color: Colors.purple)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
