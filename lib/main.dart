import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/articles_screen.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await debugSharedPreferences(); // 🔥 Ver SharedPreferences al iniciar
  bool isTokenValid = await checkTokenValidity();
  runApp(MyApp(initialRoute: isTokenValid ? "/home" : "/login"));
}

// 🔥 PRUEBA: Ver todo el contenido de SharedPreferences al iniciar
Future<void> debugSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  print("🔎 Contenido actual de SharedPreferences al iniciar:");
  prefs.getKeys().forEach((key) {
    print("$key: ${prefs.get(key)}");
  });
}

// 🔍 Verificar si el token es válido antes de decidir la pantalla inicial
Future<bool> checkTokenValidity() async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString("token");
  final String? expiryDateStr = prefs.getString("token_expiry");

  print("🔍 Verificando `SharedPreferences` al iniciar la app...");
  print("🔑 Token al iniciar: $token");
  print("📅 Fecha de expiración al iniciar: $expiryDateStr");

  if (token == null || expiryDateStr == null) {
    print("❌ No hay token guardado o la fecha de expiración no está disponible.");
    return false;
  }

  final expiryDate = DateTime.parse(expiryDateStr);
  if (expiryDate.isBefore(DateTime.now())) {
    print("❌ Token expirado, se requiere login nuevamente.");
    return false;
  }

  print("✅ Token válido, redirigiendo a /home...");
  return true;
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
        "/articles": (context) => const ArticlesScreen(), // 🔥 Agregamos la ruta de artículos
      },
    );
  }
}
