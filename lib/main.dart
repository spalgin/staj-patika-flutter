import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/cart.dart';
import 'models/product.dart';
import 'screens/catalog_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_screen.dart';
import 'theme.dart';

void main() {
  runApp(const PatikaApp());
}

class PatikaApp extends StatefulWidget {
  const PatikaApp({super.key});

  @override
  State<PatikaApp> createState() => _PatikaAppState();
}

class _PatikaAppState extends State<PatikaApp> {
  final _cart = Cart();
  late Future<List<Product>> _products = loadProducts();

  @override
  void dispose() {
    _cart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patika',
      debugShowCheckedModeBanner: false,
      theme: patikaTheme,
      onGenerateRoute: (settings) {
        final screen = switch (settings.name) {
          CatalogScreen.route => CatalogScreen(
            products: settings.arguments! as List<Product>,
            cart: _cart,
          ),
          ProductScreen.route => ProductScreen(
            product: settings.arguments! as Product,
            cart: _cart,
          ),
          _ => null,
        };
        if (screen == null) return null;
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => screen,
        );
      },
      home: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Katalog yüklenemedi.'),
                    TextButton(
                      onPressed: () =>
                          setState(() => _products = loadProducts()),
                      child: const Text('Tekrar dene'),
                    ),
                  ],
                ),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return HomeScreen(products: snapshot.data!, cart: _cart);
        },
      ),
    );
  }
}

Future<List<Product>> loadProducts() async {
  final source = await rootBundle.loadString('assets/products.json');
  return Product.decodeList(source);
}
