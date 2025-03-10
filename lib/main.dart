import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/articles_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isTokenValid = await checkTokenValidity();

  runApp(MyApp(initialRoute: isTokenValid ? "/home" : "/login"));
}

Future<bool> checkTokenValidity() async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString("token");
  final String? expiryDateStr = prefs.getString("token_expiry");

  debugPrint("🔑 Token guardado en SharedPreferences: $token");
  debugPrint("📅 Fecha de expiración: $expiryDateStr");

  if (token == null || expiryDateStr == null) return false;

  final expiryDate = DateTime.parse(expiryDateStr);
  return expiryDate.isAfter(DateTime.now()); // ✅ Verifica si el token sigue siendo válido
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Browntastic App',
      initialRoute: initialRoute,
      routes: {
        "/login": (context) => const LoginScreen(),
        "/home": (context) => const HomeScreen(),
        "/articles": (context) => const ArticlesScreen(),
      },
    );
  }
}
