import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';

class AuthService {
  // 🔑 Iniciar sesión y guardar token + fecha de expiración
  static Future<bool> login(String email, String password) async {
    final url = Uri.parse("${Config.apiUrl}/api/auth/login");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await saveToken(data["token"], DateTime.now().add(const Duration(days: 7)).toIso8601String());

      print("✅ Token guardado en SharedPreferences correctamente.");
      return true;
    } else {
      return false;
    }
  }

  // 🔥 Nueva función para guardar el token y asegurar persistencia
  static Future<void> saveToken(String token, String expiry) async {
    final prefs = await SharedPreferences.getInstance();
    
    prefs.setString("token", token);
    prefs.setString("token_expiry", expiry);

    // 🔥 Método alternativo para asegurar persistencia
    await prefs.reload();
    await prefs.commit();

    print("✅ Token guardado con `setStringSync()`: ${prefs.getString("token")}");
    print("📅 Fecha de expiración guardada: ${prefs.getString("token_expiry")}");
  }

  // 🔄 Verifica si hay un token válido
  static Future<bool> isTokenValid() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final expiryDateStr = prefs.getString("token_expiry");

    if (token == null || expiryDateStr == null) return false;

    final expiryDate = DateTime.parse(expiryDateStr);
    return expiryDate.isAfter(DateTime.now());
  }

  // 🚪 Cerrar sesión (elimina token)
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // 🔥 Limpia todo al cerrar sesión
  }
}
