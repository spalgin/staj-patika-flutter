import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog/main.dart';

void main() {
  testWidgets('katalog filtresi, rota argümanı ve sepet durumu', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(411, 914);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const PatikaApp());
    await tester.pumpAndSettle();
    expect(find.text('Patika'), findsOneWidget);
    expect(find.text('Doruk Sırt Çantası'), findsOneWidget);

    await tester.tap(find.text('Kataloğu keşfet'));
    await tester.pumpAndSettle();
    expect(find.text('Katalog'), findsOneWidget);
    expect(find.text('4 ürün'), findsOneWidget);
    await tester.tap(find.widgetWithText(ChoiceChip, 'Kamp'));
    await tester.pumpAndSettle();
    expect(find.text('2 ürün'), findsOneWidget);
    expect(find.text('Doruk Sırt Çantası'), findsNothing);
    await tester.tap(find.text('Ova Çadır'));
    await tester.pumpAndSettle();
    expect(find.text('İki kişilik'), findsOneWidget);

    await tester.tap(find.text('Sepete ekle'));
    await tester.pumpAndSettle();
    expect(find.text('Sepete ekle (1)'), findsOneWidget);
    await tester.tap(find.byTooltip('Sepet, 1 ürün'));
    await tester.pumpAndSettle();
    expect(find.text('Toplam 3.290 ₺'), findsOneWidget);
    await tester.tap(find.byTooltip('Ova Çadır adedini azalt'));
    await tester.pumpAndSettle();
    expect(find.text('Sepetiniz boş.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
