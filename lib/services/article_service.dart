import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../models/article.dart';

class ArticleService {
  // 🔍 Obtener la lista de artículos desde la API
  static Future<List<Article>> fetchArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");

    if (token == null) {
      throw Exception("No hay token de autenticación");
    }

    final response = await http.get(
      Uri.parse("${Config.apiUrl}/api/articles"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Article.fromJson(item)).toList();
    } else {
      throw Exception("Error al obtener artículos");
    }
  }
}
