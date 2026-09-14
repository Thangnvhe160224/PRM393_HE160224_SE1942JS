class Product {
  final String id;
  final String name;
  final double price;
  final String? image;
  final String? description;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.image,
    this.description,
  });

  Product copyProduct({
    String? id,
    String? name,
    double? price,
    String? image,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }
}