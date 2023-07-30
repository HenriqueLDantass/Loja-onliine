class ProdutosModel {
  final String title;
  final String description;
  final double price;
  final double rating;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  ProdutosModel({
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory ProdutosModel.fromMap(Map<String, dynamic> map) {
    return ProdutosModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      rating: (map['rating'] ?? 0).toDouble(),
      brand: map['brand'] ?? '',
      category: map['category'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      images: List<String>.from(map['images'] ?? []),
    );
  }
}
