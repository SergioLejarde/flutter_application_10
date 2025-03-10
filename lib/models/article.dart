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
}
