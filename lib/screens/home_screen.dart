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
    await AuthService.logout();
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pantalla Principal"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("🔑 TOKEN GUARDADO:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(token, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: Colors.blueGrey)),
            const SizedBox(height: 20),
            const Text("📅 EXPIRACIÓN:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(expiryDate, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: Colors.red)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/articles");
              },
              child: const Text("Ver Artículos"),
            ),
          ],
        ),
      ),
    );
  }
}
