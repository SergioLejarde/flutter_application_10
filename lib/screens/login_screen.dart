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
      // ignore: avoid_print
      print("🔎 Estado actual de SharedPreferences después del login:");
      prefs.getKeys().forEach((key) {
        // ignore: avoid_print
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
      appBar: AppBar(title: const Text("Iniciar Sesión")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Correo"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Contraseña"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: login,
                    child: const Text("Ingresar"),
                  ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(errorMessage, style: const TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}
