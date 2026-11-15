import 'dart:convert';

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.description,
    required this.features,
  });

  final String id;
  final String name;
  final String category;
  final int price;
  final String image;
  final String description;
  final List<String> features;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      price: json['price'] as int,
      image: json['image'] as String,
      description: json['description'] as String,
      features: List<String>.unmodifiable(json['features'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category': category,
    'price': price,
    'image': image,
    'description': description,
    'features': features,
  };

  static List<Product> decodeList(String source) {
    final products = jsonDecode(source) as List<dynamic>;
    return List.unmodifiable(
      products.map((entry) => Product.fromJson(entry as Map<String, dynamic>)),
    );
  }
}

String formatPrice(int price) {
  final formatted = price.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => '.',
  );
  return '$formatted ₺';
}
