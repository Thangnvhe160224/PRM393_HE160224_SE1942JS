import '../models/product.dart';

class ProductDAO {
  final List<Product> _products = [
    Product(
      id: 1,
      name: 'iPhone 15',
      description:
          'Experience the latest technology with the new iPhone 15. Stunning design and powerful performance.',
      price: 1099,
      discountPercen: 9,
      image: 'assets/iphone15.jpg',
    ),
    Product(
      id: 2,
      name: 'Samsung S24',
      description:
          'Samsung Galaxy S24 with a beautiful display, powerful performance and a modern design.',
      price: 999,
      discountPercen: 10,
      image: 'assets/samsung_s24.jpg',
    ),
    Product(
      id: 3,
      name: 'MacBook Air',
      description:
          'MacBook Air is thin, light and powerful, suitable for study, work and everyday use.',
      price: 1299,
      discountPercen: 7,
      image: 'assets/macbook_air.jpg',
    ),
  ];

  List<Product> getAllProduct() {
    return List.unmodifiable(_products);
  }

  List<Product> findProductByName(String name) {
    final keyword = name.trim().toLowerCase();

    if (keyword.isEmpty) {
      return getAllProduct();
    }

    return _products
        .where((product) => product.name.toLowerCase().contains(keyword))
        .toList();
  }
}
