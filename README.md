# Patika · Flutter Mini Katalog

**Fevzi Emre Karahan** · Program katılımcısı

Patika, kamp ve yürüyüş ekipmanlarından oluşan küçük bir mobil katalog. Ana sayfadan ürün listesine geçilebilir, ürünler kategoriye göre süzülebilir ve ürün detayından sepete eklenebilir. Sepet adedi ve toplam tutar uygulama çalıştığı sürece bellekte tutulur. Ürün verisi ve görseller uygulamaya dahildir.

## Çalıştırma

Flutter **3.41.4**, Dart **3.11.1** ve Android SDK kullanıldı. Android Studio Device Manager ile bir emülatör başlatın veya USB hata ayıklaması açık bir Android cihaz bağlayın.

```sh
flutter pub get
flutter devices
flutter run -d <cihaz-kimligi>
```

`flutter analyze` ile statik analiz, `flutter test` ile kategori, ürün detayı ve sepet akışı kontrol edilebilir. Uygulamanın üçüncü taraf çalışma zamanı bağımlılığı yoktur.

## Proje yapısı

- `lib/models/` ürün modeli, JSON dönüşümü ve sepet durumu
- `lib/screens/` ana sayfa, katalog ve ürün detayı
- `lib/widgets/` ortak ürün kartı ve sepet düğmesi
- `assets/products.json` ve `assets/images/` çevrimdışı katalog verisi

Ana sayfa ve katalog ürünü `Navigator.pushNamed` ile açar. Seçilen ürün, rota argümanı olarak detay ekranına geçer. Sepet güncellemelerini `ChangeNotifier` ve `ListenableBuilder` ekrana yansıtır. Ödeme işlemi, kullanıcı hesabı ve uzak API kullanılmaz.
