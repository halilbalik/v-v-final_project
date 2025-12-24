// Widget Test - Psikolojik Test Uygulaması
// UI bileşenlerinin doğru çalıştığını test eder
//
// Test Coverage: Widget Testing
// Related Requirements: FR-1.1, NFR-6
// Test Cases: TC-ST-001, TC-ST-020, TC-ST-021, TC-ST-022, TC-ST-018

import 'package:flutter_test/flutter_test.dart';
import 'package:asama2_gelistirici_qa/main.dart';

void main() {
  // Test Group: Dashboard UI Tests
  // Requirements: FR-1.1 - Test Listesinin Görüntülenmesi
  //               NFR-6 - Tıbbi Tanı Uyarısı
  // User Story: US-001, US-008

  /// Test Case ID: TC-ST-001
  /// Requirement: FR-1.1 - Test Listesinin Görüntülenmesi
  /// Description: Ana sayfada tanımlı tüm testlerin listelenmesi
  /// Priority: HIGH
  /// Related Test Cases: TC-ST-020 (Dashboard Yükleme)
  testWidgets('Dashboard ekranı yüklenmeli', (WidgetTester tester) async {
    // Uygulamayı başlat
    await tester.pumpWidget(const PsikolojikTestApp());

    // AppBar başlığını kontrol et
    expect(find.text('Psikolojik Testler'), findsOneWidget);

    // Test Case ID: TC-ST-018
    // Requirement: NFR-6 - Tıbbi Tanı Uyarısı
    // Uyarı banner'ını kontrol et
    // CRITICAL: Her sonuç ekranında ve ana sayfada uyarı bulunmalıdır
    expect(
      find.text('Bu testler klinik tanı koymaz, yalnızca farkındalık amaçlıdır.'),
      findsOneWidget,
    );
  });

  /// Test Case IDs: TC-ST-001, TC-ST-021, TC-ST-022
  /// Requirement: FR-1.1 - Test Listesinin Görüntülenmesi
  /// Description: Tüm test kategorilerinin (Duygudurum, Anksiyete, Stres, Uyku) görüntülenmesi
  /// Acceptance Criteria:
  ///   - Given I open the application
  ///   - When the dashboard loads
  ///   - Then I should see 4 test categories with titles
  /// Priority: HIGH
  /// Related Requirements: FR-1.1
  /// User Story: US-001
  testWidgets('4 test kartı görüntülenmeli', (WidgetTester tester) async {
    // Uygulamayı başlat
    await tester.pumpWidget(const PsikolojikTestApp());
    await tester.pumpAndSettle();

    // Test başlıklarını kontrol et
    // TC-ST-021: Duygudurum testi görüntüleniyor mu?
    expect(find.text('Duygudurum Değerlendirme Testi'), findsOneWidget);

    // TC-ST-021: Anksiyete testi görüntüleniyor mu?
    expect(find.text('Anksiyete Seviye Testi'), findsOneWidget);

    // TC-ST-021: Stres testi görüntüleniyor mu?
    expect(find.text('Stres Yönetimi Değerlendirmesi'), findsOneWidget);

    // TC-ST-022: Uyku testi görüntüleniyor mu?
    expect(find.text('Uyku Kalitesi Anketi'), findsOneWidget);
  });
}
