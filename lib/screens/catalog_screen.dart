import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../theme.dart';
import '../widgets/cart_button.dart';
import '../widgets/product_card.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({required this.products, required this.cart, super.key});

  static const route = '/catalog';

  final List<Product> products;
  final Cart cart;

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String? _category;

  @override
  Widget build(BuildContext context) {
    final products = widget.products
        .where((product) => _category == null || product.category == _category)
        .toList();
    final categories = [
      null,
      ...widget.products.map((item) => item.category).toSet(),
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          CartButton(cart: widget.cart),
          const SizedBox(width: 11),
        ],
      ),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 14),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Katalog', style: headline),
                    const SizedBox(height: 13),
                    Wrap(
                      spacing: 7,
                      children: [
                        for (final category in categories)
                          ChoiceChip(
                            label: Text(category ?? 'Tümü'),
                            selected: category == _category,
                            selectedColor: lime,
                            side: BorderSide(
                              color: category == _category ? lime : line,
                            ),
                            showCheckmark: false,
                            onSelected: (_) =>
                                setState(() => _category = category),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${products.length} ürün',
                      style: const TextStyle(color: quiet),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              sliver: SliverGrid.builder(
                gridDelegate: productGridLayout,
                itemCount: products.length,
                itemBuilder: (_, index) =>
                    ProductCard(product: products[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
