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
            imageUrl TEXT
          )
        ''');
      },
    );
  }

  // 🛠 Añadir artículo a favoritos
  Future<void> addFavorite(Article article) async {
    final db = await database;
    await db.insert("favorites", article.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // ❌ Eliminar artículo de favoritos
  Future<void> removeFavorite(int id) async {
    final db = await database;
    await db.delete("favorites", where: "id = ?", whereArgs: [id]);
  }

  // 🔄 Obtener todos los favoritos
  Future<List<Article>> getFavoriteArticles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("favorites");

    return List.generate(maps.length, (i) {
      return Article(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        imageUrl: maps[i]['imageUrl'],
      );
    });
  }
}
