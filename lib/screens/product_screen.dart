import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../theme.dart';
import '../widgets/cart_button.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({required this.product, required this.cart, super.key});

  static const route = '/product';

  final Product product;
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CartButton(cart: cart),
          const SizedBox(width: 11),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(
              aspectRatio: 1.26,
              child: Image.asset(
                product.image,
                fit: BoxFit.cover,
                semanticLabel: product.name,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            product.category,
            style: const TextStyle(
              color: moss,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(product.name, style: headline),
          const SizedBox(height: 11),
          Text(
            product.description,
            style: const TextStyle(fontSize: 15, color: quiet, height: 1.45),
          ),
          const SizedBox(height: 14),
          for (final feature in product.features)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  const Icon(Icons.check_rounded, color: moss, size: 17),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feature,
                      style: const TextStyle(fontSize: 14, color: forest),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          color: paper,
          border: Border(top: BorderSide(color: line)),
        ),
        child: SafeArea(
          top: false,
          minimum: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  formatPrice(product.price),
                  style: const TextStyle(
                    fontSize: 22,
                    color: forest,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 2,
                child: ListenableBuilder(
                  listenable: cart,
                  builder: (context, _) {
                    final quantity = cart.quantityOf(product);
                    return FilledButton.icon(
                      onPressed: () => cart.add(product),
                      icon: const Icon(Icons.add_rounded, size: 20),
                      label: Text(
                        quantity > 0
                            ? 'Sepete ekle ($quantity)'
                            : 'Sepete ekle',
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
