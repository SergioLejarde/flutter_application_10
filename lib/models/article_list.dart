import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../providers/favorites_provider.dart';

class ArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Artículos'),
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          return ListView.builder(
            itemCount: 10, // Suponiendo que tienes una lista de 10 artículos
            itemBuilder: (context, index) {
              final article = Article(
                id: index,
                title: 'Artículo $index',
                description: 'Descripción del artículo $index',
                imageUrl: 'https://via.placeholder.com/150',
              );

              // Verificar si el artículo es favorito
              bool isFavorite = favoritesProvider.isFavorite(article);

              return ListTile(
                leading: Image.network(article.imageUrl),
                title: Text(article.title),
                subtitle: Text(article.description),
                trailing: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    // Al hacer clic en el corazón, agregar o eliminar el artículo de favoritos
                    favoritesProvider.toggleFavorite(article);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
