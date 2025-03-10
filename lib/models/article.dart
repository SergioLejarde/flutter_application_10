class Article {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  // 🔄 Convertir un JSON en un objeto `Article`
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
    );
  }

  // 🔄 Convertir el objeto `Article` a un Map (necesario para SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  // 🔄 Crear un objeto `Article` desde un Map (para leer desde SQLite)
  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }
}
