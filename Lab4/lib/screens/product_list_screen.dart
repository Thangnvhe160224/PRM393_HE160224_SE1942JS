import 'package:flutter/material.dart';
import '../dao/product_dao.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  final ValueChanged<Product> onProductTap;

  const ProductListScreen({
    super.key,
    required this.onProductTap,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductDAO productDAO = ProductDAO();
  late List<Product> products;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    products = productDAO.getAllProduct();
  }

  void _search(String value) {
    setState(() {
      products = productDAO.findProductByName(value);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  int _getColumnCount(BuildContext context, double width) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // Requirement:
    // width <= 500, portrait  -> 1 column
    // width <= 500, landscape -> 2 columns
    // width >= 500, portrait  -> 2 columns
    // width >= 500, landscape -> 3 columns

    if (width < 500) {
      return isLandscape ? 2 : 1;
    }

    return isLandscape ? 3 : 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),

      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Products',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final columns = _getColumnCount(context, width);

            return Column(
              children: [
                // Search
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    14,
                    16,
                    10,
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: _search,
                    decoration: InputDecoration(
                      hintText: 'Search products...',

                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),

                      suffixIcon:
                      searchController.text.isNotEmpty
                          ? IconButton(
                        onPressed: () {
                          searchController.clear();
                          _search('');
                        },
                        icon: const Icon(Icons.clear),
                      )
                          : null,

                      filled: true,
                      fillColor: Colors.white,

                      contentPadding:
                      const EdgeInsets.symmetric(
                        vertical: 0,
                      ),

                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                // Product Grid
                Expanded(
                  child: products.isEmpty
                      ? const Center(
                    child: Text(
                      'No products found',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                      : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      4,
                      16,
                      20,
                    ),

                    itemCount: products.length,

                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,

                      // Each column adapts to parent width
                      childAspectRatio:
                      columns == 1 ? 3.6 : 1.45,
                    ),

                    itemBuilder: (context, index) {
                      final product = products[index];

                      return ProductCard(
                        product: product,

                        onTap: () {
                          // Send selected product
                          // to MainScreen
                          widget.onProductTap(product);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}