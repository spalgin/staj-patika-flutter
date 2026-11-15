import 'package:flutter/material.dart';

import '../models/product.dart';
import '../screens/product_screen.dart';
import '../theme.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: Material(
        color: paper,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: line),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            ProductScreen.route,
            arguments: product,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Ink.image(
                  image: AssetImage(product.image),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(11, 9, 11, 11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.category,
                      style: const TextStyle(color: quiet, fontSize: 12),
                    ),
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: forest,
                        fontSize: 15,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      formatPrice(product.price),
                      style: const TextStyle(
                        fontSize: 14,
                        color: forest,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const productGridLayout = SliverGridDelegateWithMaxCrossAxisExtent(
  maxCrossAxisExtent: 250,
  crossAxisSpacing: 12,
  mainAxisSpacing: 14,
  mainAxisExtent: 222,
);
