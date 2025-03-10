import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/article_service.dart';
import '../models/article.dart';
import '../providers/favorites_provider.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  late Future<List<Article>> articlesFuture;

  @override
  void initState() {
    super.initState();
    articlesFuture = ArticleService.fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Artículos")),
      body: FutureBuilder<List<Article>>(
        future: articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay artículos disponibles"));
          } else {
            return Consumer<FavoritesProvider>(
              builder: (context, favoritesProvider, child) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final article = snapshot.data![index];
                    final isFavorite = favoritesProvider.isFavorite(article);

                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: Image.network(
                          article.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.broken_image, size: 50),
                        ),
                        title: Text(article.title),
                        subtitle: Text(article.description),
                        trailing: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            print("🛠 Favorito tocado: ${article.title}");
                            favoritesProvider.toggleFavorite(article);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
