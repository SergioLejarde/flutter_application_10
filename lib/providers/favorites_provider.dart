import 'package:flutter/material.dart';
import '../models/article.dart';
import '../database/db_helper.dart';

class FavoritesProvider with ChangeNotifier {
  List<Article> _favoriteArticles = [];
  final DbHelper dbHelper = DbHelper();

  List<Article> get favoriteArticles => _favoriteArticles;

  // 🔄 Cargar favoritos desde SQLite
  Future<void> loadFavorites() async {
    _favoriteArticles = await dbHelper.getFavoriteArticles();
    // ignore: avoid_print
    print("📂 Favoritos cargados al iniciar: $_favoriteArticles");
    notifyListeners();
  }

  // ❤️ Verificar si un artículo es favorito
  bool isFavorite(Article article) {
    return _favoriteArticles.any((fav) => fav.id == article.id);
  }

  // 🔄 Alternar entre agregar y eliminar favoritos
  Future<void> toggleFavorite(Article article) async {
    if (isFavorite(article)) {
      _favoriteArticles.removeWhere((fav) => fav.id == article.id);
      await dbHelper.removeFavorite(article.id);
      // ignore: avoid_print
      print("❌ Eliminado de favoritos: ${article.title}");
    } else {
      _favoriteArticles.add(article);
      await dbHelper.addFavorite(article);
      // ignore: avoid_print
      print("✅ Añadido a favoritos: ${article.title}");
    }
    notifyListeners();
  }
}
