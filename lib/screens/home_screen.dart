import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../theme.dart';
import '../widgets/cart_button.dart';
import '../widgets/product_card.dart';
import 'catalog_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.products, required this.cart, super.key});

  final List<Product> products;
  final Cart cart;

  void _openCatalog(BuildContext context) {
    Navigator.pushNamed(context, CatalogScreen.route, arguments: products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 33,
              height: 33,
              decoration: BoxDecoration(
                color: forest,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.terrain_rounded, size: 19, color: lime),
            ),
            const SizedBox(width: 9),
            const Text('Patika', style: TextStyle(fontWeight: FontWeight.w800)),
          ],
        ),
        actions: [
          CartButton(cart: cart),
          const SizedBox(width: 11),
        ],
      ),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
              sliver: SliverToBoxAdapter(
                child: _CatalogBanner(onExplore: () => _openCatalog(context)),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 19, 12, 7),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Öne çıkanlar',
                        style: TextStyle(
                          fontFamily: 'Instrument Serif',
                          fontSize: 34,
                          color: forest,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _openCatalog(context),
                      child: const Text('Tüm ürünler'),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 26),
              sliver: SliverGrid.builder(
                gridDelegate: productGridLayout,
                itemCount: products.take(2).length,
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

class _CatalogBanner extends StatelessWidget {
  const _CatalogBanner({required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/hero.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
              excludeFromSemantics: true,
            ),
          ),
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x02131910), Color(0xDD152318)],
                  stops: [0.12, 1],
                ),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 328),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 86, width: double.infinity),
                  const Text(
                    'Kamp ve yürüyüş',
                    style: TextStyle(
                      color: lime,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Doğaya çık.',
                    style: TextStyle(
                      fontFamily: 'Instrument Serif',
                      color: Colors.white,
                      fontSize: 63,
                      height: 0.96,
                    ),
                  ),
                  const SizedBox(height: 17),
                  FilledButton.icon(
                    onPressed: onExplore,
                    style: FilledButton.styleFrom(
                      backgroundColor: lime,
                      foregroundColor: forest,
                    ),
                    icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                    label: const Text('Kataloğu keşfet'),
                    iconAlignment: IconAlignment.end,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
