import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/article.dart';

class DbHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'favorites.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY,
            title TEXT,
            description TEXT,
            image_url TEXT
          )
        ''');
      },
    );
  }

  // 🛠 Añadir artículo a favoritos
  Future<void> addFavorite(Article article) async {
    final db = await database;
    await db.insert(
      "favorites",
      article.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // ignore: avoid_print
    print("✅ Favorito guardado en SQLite: ${article.title} (${article.id})");
  }

  // ❌ Eliminar artículo de favoritos
  Future<void> removeFavorite(int articleId) async {
    final db = await database;
    await db.delete("favorites", where: "id = ?", whereArgs: [articleId]);
    // ignore: avoid_print
    print("❌ Favorito eliminado de SQLite: ID $articleId");
  }

  // 🔄 Obtener todos los favoritos
  Future<List<Article>> getFavoriteArticles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("favorites");

    // ignore: avoid_print
    print("🗂 Favoritos guardados en SQLite: $maps"); // Debugging info

    return List.generate(maps.length, (i) {
      return Article(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        imageUrl: maps[i]['image_url'],
      );
    });
  }
}
