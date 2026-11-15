import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../theme.dart';

class CartButton extends StatelessWidget {
  const CartButton({required this.cart, super.key});

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: cart,
      builder: (context, _) => IconButton(
        tooltip: 'Sepet, ${cart.count} ürün',
        onPressed: () => showModalBottomSheet<void>(
          context: context,
          showDragHandle: true,
          useSafeArea: true,
          builder: (context) => _CartSheet(cart: cart),
        ),
        icon: Badge(
          isLabelVisible: cart.count > 0,
          backgroundColor: lime,
          textColor: forest,
          label: ExcludeSemantics(child: Text('${cart.count}')),
          child: const Icon(Icons.shopping_bag_outlined),
        ),
      ),
    );
  }
}

class _CartSheet extends StatelessWidget {
  const _CartSheet({required this.cart});

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListenableBuilder(
        listenable: cart,
        builder: (context, _) => Padding(
          padding: const EdgeInsets.fromLTRB(22, 0, 22, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Sepet', style: headline),
              const SizedBox(height: 14),
              if (cart.count == 0)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text('Sepetiniz boş.'),
                )
              else ...[
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (final item in cart.items)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(item.product.name),
                          subtitle: Text(
                            '${item.quantity} adet · ${formatPrice(item.product.price * item.quantity)}',
                          ),
                          trailing: IconButton(
                            tooltip: '${item.product.name} adedini azalt',
                            onPressed: () => cart.removeOne(item.product),
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                        ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Toplam ${formatPrice(cart.totalPrice)}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
