import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/article_service.dart';
import '../models/article.dart';
import '../providers/favorites_provider.dart';
import '../providers/view_provider.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  ArticlesScreenState createState() => ArticlesScreenState();
}

class ArticlesScreenState extends State<ArticlesScreen> {
  late Future<List<Article>> articlesFuture;

  @override
  void initState() {
    super.initState();
    articlesFuture = ArticleService.fetchArticles();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavoritesProvider>(context, listen: false).loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewProvider = Provider.of<ViewProvider>(context);
    final isGridView = viewProvider.isGridView;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Artículos"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              viewProvider.toggleView();
            },
          ),
        ],
      ),
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
                return isGridView
                    ? GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final article = snapshot.data![index];
                          final isFavorite = favoritesProvider.isFavorite(article);

                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Image.network(
                                  article.imageUrl,
                                  width: double.infinity,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image, size: 50),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(article.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 5),
                                      Text(article.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : Colors.grey,
                                  ),
                                  onPressed: () {
                                    favoritesProvider.toggleFavorite(article);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : ListView.builder(
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
                                    const Icon(Icons.broken_image, size: 50),
                              ),
                              title: Text(article.title),
                              subtitle: Text(article.description),
                              trailing: IconButton(
                                icon: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.grey,
                                ),
                                onPressed: () {
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
