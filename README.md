# 🧠 Psikolojik Test Uygulaması

Flutter ile geliştirilmiş mobil psikolojik test uygulaması. Bu uygulama, kullanıcıların ruh sağlığı konusunda farkındalık kazanmalarını sağlamak amacıyla tasarlanmıştır.

## ⚠️ Önemli Uyarı

**Bu uygulama profesyonel tıbbi tanı koymaz, yalnızca farkındalık amaçlıdır.**
Herhangi bir ruh sağlığı sorunu yaşıyorsanız, lütfen bir uzman psikolog veya psikiyatristle görüşün.

---

## 📱 Özellikler

### 4 Ana Test Kategorisi

1. **😊 Duygudurum Değerlendirme Testi**
   - 10 soru, 3-5 dakika
   - Ruh hali ve motivasyon değerlendirmesi

2. **🧠 Anksiyete Seviye Testi**
   - 12 soru, 4-5 dakika
   - Kaygı ve stres belirtileri ölçümü

3. **🧘 Stres Yönetimi Değerlendirmesi**
   - 8 soru, 2-4 dakika
   - Başa çıkma stratejileri analizi

4. **😴 Uyku Kalitesi Anketi**
   - 10 soru, 3-5 dakika
   - Uyku düzeni ve kalite değerlendirmesi

### Temel Özellikler

- ✅ **Likert Ölçeği (1-5):** Hiç Katılmıyorum → Tamamen Katılıyorum
- ✅ **İlerleme Takibi:** Gerçek zamanlı soru sayacı ve progress bar
- ✅ **Puan Hesaplama:** Otomatik seviye belirleme
- ✅ **Detaylı Sonuçlar:** Renk kodlu seviye gösterimi ve öneriler
- ✅ **Modern UI:** Minimalist, mavi-beyaz tema
- ✅ **Kullanıcı Dostu:** Sezgisel navigasyon ve validasyon

---

## 🎨 Ekran Görüntüleri

### Dashboard Ekranı
- 4 test kategorisi kartları
- Kritik uyarı banner'ı
- Test bilgileri (süre, soru sayısı)

### Quiz Ekranı
- İlerleme çubuğu ve sayaç
- 5 seçenekli cevap sistemi
- Emoji destekli seçenekler

### Sonuç Ekranı
- Toplam puan gösterimi
- Seviye belirleme (Düşük/Orta/Yüksek)
- Kişiselleştirilmiş öneriler
- Profesyonel destek uyarısı

---

## 🏗️ Proje Yapısı

```
lib/
├── main.dart                      # Ana uygulama giriş noktası
├── models/                        # Veri modelleri
│   ├── question_model.dart        # Soru modeli
│   └── test_category_model.dart   # Test kategorisi modeli
├── data/                          # Statik veri
│   └── question_data.dart         # Test ve soru verileri
└── screens/                       # UI ekranları
    ├── dashboard_screen.dart      # Ana sayfa
    ├── quiz_screen.dart           # Test ekranı
    └── result_screen.dart         # Sonuç ekranı

test/
├── unit_test.dart                 # Unit testler (30 test)
└── widget_test.dart               # Widget testler (2 test)
```

---

## 🚀 Kurulum ve Çalıştırma

### Gereksinimler
- Flutter SDK 3.0+
- Dart 3.0+
- Android Studio / VS Code
- iOS için: Xcode 14+

### Kurulum Adımları

1. **Projeyi Klonlayın**
```bash
git clone <repo-url>
cd asama2_gelistirici_qa
```

2. **Bağımlılıkları Yükleyin**
```bash
flutter pub get
```

3. **Uygulamayı Çalıştırın**
```bash
flutter run
```

### Test Çalıştırma

**Tüm Testler:**
```bash
flutter test
```

**Coverage Raporu:**
```bash
flutter test --coverage
```

**Sadece Unit Testler:**
```bash
flutter test test/unit_test.dart
```

---

## 🧪 Test Kapsamı

### Test İstatistikleri
- **Toplam Test:** 32 test
- **Başarı Oranı:** 100%
- **Unit Test:** 30 test
- **Widget Test:** 2 test

### Test Kategorileri
1. ✅ Puan Hesaplama Testleri (4 test)
2. ✅ Seviye Belirleme Testleri (6 test)
3. ✅ Soru Sayısı ve Veri Yükleme (8 test)
4. ✅ Question Model Testleri (4 test)
5. ✅ TestCategory Model Testleri (5 test)
6. ✅ Edge Case Testleri (3 test)
7. ✅ Widget Testleri (2 test)


---

## 📊 Puan Sistemi

### Likert Ölçeği (1-5)
- **1 Puan:** Hiç Katılmıyorum 😔
- **2 Puan:** Az Katılıyorum 🙁
- **3 Puan:** Kısmen Katılıyorum 😐
- **4 Puan:** Çoğunlukla Katılıyorum 🙂
- **5 Puan:** Tamamen Katılıyorum 😊

### Seviye Belirleme
- **0-15 Puan:** 🟢 Düşük Seviye / Normal
- **16-30 Puan:** 🟠 Orta Seviye
- **31-50 Puan:** 🔴 Yüksek Seviye

---

## 🎯 SRS Gereksinimleri

### Fonksiyonel Gereksinimler
- ✅ 4 farklı psikolojik test kategorisi
- ✅ Likert ölçeği ile soru-cevap sistemi
- ✅ Otomatik puan hesaplama
- ✅ Seviye bazlı sonuç gösterimi
- ✅ Kritik uyarı mesajları

### Fonksiyonel Olmayan Gereksinimler
- ✅ Minimalist mavi-beyaz tasarım
- ✅ Mobilde okunabilir font boyutu (14pt+)
- ✅ Sezgisel kullanıcı arayüzü
- ✅ Responsive tasarım
- ✅ Performans optimizasyonu

### Yazılım Doğrulama ve Geçerleme (V&V)
- ✅ Kapsamlı unit test paketi
- ✅ Widget test coverage
- ✅ Kritik iş mantığı testleri
- ✅ Edge case senaryoları

---

## 🛠️ Teknolojiler

### Framework & Dil
- **Flutter** 3.0+
- **Dart** 3.0+

### State Management
- **StatefulWidget** (Local state)
- **setState** pattern

### Test Framework
- **flutter_test** package
- AAA (Arrange-Act-Assert) pattern

### UI Components
- Material Design 3
- Custom widgets
- Responsive layouts

---

## 📝 Veri Yapısı

### Question Model
```dart
class Question {
  String id;
  String text;
  int? answer;  // 1-5 arası Likert değeri
}
```

### TestCategory Model
```dart
class TestCategory {
  String id;
  String title;
  String description;
  String duration;
  int questionCount;
  List<Question> questions;
}
```

---

## 🎨 Tasarım Sistemi

### Renk Paleti
- **Primary:** #2196F3 (Mavi)
- **Background:** #FFFFFF (Beyaz)
- **Success:** #4CAF50 (Yeşil)
- **Warning:** #FF9800 (Turuncu)
- **Error:** #F44336 (Kırmızı)

### Typography
- **Başlık:** 18-24px, Bold
- **Body:** 14-16px, Regular
- **Küçük:** 13px, Medium

### Spacing
- **Padding:** 16-24px
- **Margin:** 20px
- **Border Radius:** 12-20px

---

## 🤝 Katkıda Bulunma

Bu proje Yazılım Doğrulama ve Geçerleme (V&V) dersi için geliştirilmiştir.

---

## 📄 Lisans

Bu proje eğitim amaçlı geliştirilmiştir.


---

## 🎓 Proje Hakkında

**Proje Türü:** Yazılım Doğrulama ve Geçerleme (V&V) Projesi \n,
**Geliştirme Süresi:** Aralık 2025 \n,
**Platform:** Flutter (iOS/Android)
**Test Kapsamı:** 32 test senaryosu
**Geliştirenler:** Eftalya Beril Şahin - Halil İbrahim Balık
