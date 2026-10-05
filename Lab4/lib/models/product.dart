class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final double discountPercen;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discountPercen,
    required this.image,
  });

  double get salePrice => price * (1 - discountPercen / 100);
}
