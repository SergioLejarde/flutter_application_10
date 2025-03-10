import 'package:flutter/material.dart';
import '../models/article.dart';
import '../database/db_helper.dart';

class FavoritesProvider with ChangeNotifier {
  List<Article> _favoriteArticles = [];
  final DbHelper dbHelper = DbHelper();

  List<Article> get favoriteArticles => _favoriteArticles;

  Future<void> loadFavorites() async {
    _favoriteArticles = await dbHelper.getFavoriteArticles();
    //print("📂 Favoritos en la base de datos: $_favoriteArticles");
    notifyListeners();
  }

  bool isFavorite(Article article) {
    return _favoriteArticles.any((fav) => fav.id == article.id);
  }

  void toggleFavorite(Article article) async {
    if (isFavorite(article)) {
      _favoriteArticles.removeWhere((fav) => fav.id == article.id);
      await dbHelper.removeFavorite(article.id);
      //print("❌ Eliminado de favoritos: ${article.title}");
    } else {
      _favoriteArticles.add(article);
      await dbHelper.addFavorite(article);
      //print("✅ Añadido a favoritos: ${article.title}");
    }
    notifyListeners();
  }
}
