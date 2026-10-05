import 'package:flutter/material.dart';

import 'models/product.dart';
import 'screens/product_list_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(const ProductApp());
}

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Products',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  Product? selectedProduct;

  void openProductDetail(Product product) {
    setState(() {
      selectedProduct = product;
      currentIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen;

    if (currentIndex == 0) {
      currentScreen = ProductListScreen(
        onProductTap: openProductDetail,
      );
    } else if (currentIndex == 1) {
      currentScreen = selectedProduct == null
          ? ProductListScreen(
        onProductTap: openProductDetail,
      )
          : ProductDetailScreen(
        product: selectedProduct!,
      );
    } else {
      currentScreen = const CartScreen();
    }

    return Scaffold(
      body: currentScreen,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        type: BottomNavigationBarType.fixed,

        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black54,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            activeIcon: Icon(Icons.inventory_2),
            label: 'Product Detail',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}