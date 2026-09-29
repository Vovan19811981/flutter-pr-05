class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final String category;

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
    );
  }

  @override
  bool operator ==(Object other) => other is Product && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
