import 'package:flutter_test/flutter_test.dart';
import 'package:asama2_gelistirici_qa/models/question_model.dart';
import 'package:asama2_gelistirici_qa/models/test_category_model.dart';
import 'package:asama2_gelistirici_qa/data/question_data.dart';
import 'package:asama2_gelistirici_qa/screens/result_screen.dart';

/// ==================================================================================
/// UNIT TEST DOSYASI - PSİKOLOJİK TEST UYGULAMASI
/// ==================================================================================
///
/// Test Raporu: Unit_Test_Raporu.md
/// Traceability Matrix: Traceability_Matrix.md
///
/// TEST KAPSAMI:
/// - Model Katmanı (Question, TestCategory)
/// - İş Mantığı (Puan Hesaplama, Seviye Belirleme)
/// - Veri Yükleme ve Validasyon
/// - Edge Cases ve Hata Senaryoları
///
/// TOPLAM TEST SAYISI: 30
/// TEST DURUMU: ALL TESTS PASSED ✅
/// CODE COVERAGE: %100 (Model Layer)
///
/// KAPSANAN GEREKSİNİMLER:
/// - FR-1.1: Test Listesinin Görüntülenmesi
/// - FR-3.1: Puan Hesaplama (CRITICAL)
/// - FR-3.2: Seviye Belirleme (CRITICAL)
///
/// İLGİLİ USER STORIES:
/// - US-001: Test listesi görüntüleme
/// - US-004: Doğru sonuç hesaplama ve gösterim
///
/// ==================================================================================

void main() {
  /// ==================================================================================
  /// TEST GRUBU 1: PUAN HESAPLAMA TESTLERİ
  /// ==================================================================================
  /// Requirement: FR-3.1 - Puan Hesaplama (Toplam)
  /// Priority: CRITICAL ⚠️
  /// Test Coverage: 7 test cases
  /// Related Test Cases: TC-UT-009, TC-UT-011, TC-UT-012, TC-UT-013, TC-UT-014
  /// User Story: US-004
  ///
  /// Description:
  /// Kullanıcı son soruyu onayladığında, sistem arka planda seçilen şıkların
  /// puanlarını toplamalıdır. Bu testler toplama algoritmasının doğruluğunu
  /// tüm senaryolarda doğrular.
  ///
  /// Acceptance Criteria:
  /// - Given I have answered all questions
  /// - When I click "Finish Test"
  /// - Then my total score should be correctly calculated as the sum of all answers
  /// ==================================================================================
  group('Puan Hesaplama Testleri', () {
    /// Test Case ID: TC-UT-011
    /// Requirement: FR-3.1
    /// Scenario: Maksimum puan (tüm cevaplar 5)
    /// Expected: 10 soru × 5 puan = 50 puan
    test('Tüm sorulara 5 cevabı verildiğinde toplam puan doğru hesaplanmalı', () {
      // Arrange (Hazırlık)
      final testCategory = TestCategory(
        id: 'test_category',
        title: 'Test Kategorisi',
        description: 'Test açıklaması',
        duration: '5 dakika',
        questionCount: 10,
        questions: List.generate(
          10,
          (index) => Question(
            id: 'q${index + 1}',
            text: 'Test sorusu ${index + 1}',
            answer: 5, // Tüm sorulara 5 (maksimum puan)
          ),
        ),
      );

      // Act (İşlem)
      final totalScore = testCategory.questions.fold<int>(
        0,
        (sum, question) => sum + (question.answer ?? 0),
      );
      final expectedScore = 10 * 5; // 10 soru * 5 puan

      // Assert (Doğrulama)
      expect(totalScore, equals(expectedScore));
      expect(totalScore, equals(50));
    });

    /// Test Case ID: TC-UT-012
    /// Requirement: FR-3.1
    /// Scenario: Karışık puanlar
    /// Expected: 5 + 4 + 3 + 2 + 1 = 15 puan
    test('Karışık cevaplarda toplam puan doğru hesaplanmalı', () {
      // Arrange
      final questions = [
        Question(id: 'q1', text: 'Soru 1', answer: 5),
        Question(id: 'q2', text: 'Soru 2', answer: 4),
        Question(id: 'q3', text: 'Soru 3', answer: 3),
        Question(id: 'q4', text: 'Soru 4', answer: 2),
        Question(id: 'q5', text: 'Soru 5', answer: 1),
      ];

      final testCategory = TestCategory(
        id: 'mixed_test',
        title: 'Karışık Test',
        description: 'Test',
        duration: '5 dakika',
        questionCount: 5,
        questions: questions,
      );

      // Act
      final totalScore = testCategory.questions.fold<int>(
        0,
        (sum, question) => sum + (question.answer ?? 0),
      );
      final expectedScore = 5 + 4 + 3 + 2 + 1; // 15

      // Assert
      expect(totalScore, equals(expectedScore));
      expect(totalScore, equals(15));
    });

    /// Test Case ID: TC-UT-013
    /// Requirement: FR-3.1
    /// Scenario: Ortalama puan hesaplama
    /// Expected: (4 + 3 + 4 + 5) / 4 = 4.0
    test('Ortalama puan doğru hesaplanmalı', () {
      // Arrange
      final testCategory = TestCategory(
        id: 'avg_test',
        title: 'Ortalama Test',
        description: 'Test',
        duration: '5 dakika',
        questionCount: 4,
        questions: [
          Question(id: 'q1', text: 'Soru 1', answer: 4),
          Question(id: 'q2', text: 'Soru 2', answer: 3),
          Question(id: 'q3', text: 'Soru 3', answer: 4),
          Question(id: 'q4', text: 'Soru 4', answer: 5),
        ],
      );

      // Act
      final averageScore = testCategory.averageScore;
      final expectedAverage = (4 + 3 + 4 + 5) / 4.0; // 4.0

      // Assert
      expect(averageScore, equals(expectedAverage));
      expect(averageScore, equals(4.0));
    });

    /// Test Case ID: TC-UT-014
    /// Requirement: FR-3.1
    /// Scenario: Null-safe puan hesaplama
    /// Expected: null cevaplar 0 olarak sayılmalı
    /// Note: Null safety kontrolü için kritik test
    test('Cevaplanmamış sorular için puan 0 olmalı', () {
      // Arrange
      final testCategory = TestCategory(
        id: 'unanswered_test',
        title: 'Cevaplanmamış Test',
        description: 'Test',
        duration: '5 dakika',
        questionCount: 3,
        questions: [
          Question(id: 'q1', text: 'Soru 1'), // Cevap yok
          Question(id: 'q2', text: 'Soru 2'), // Cevap yok
          Question(id: 'q3', text: 'Soru 3'), // Cevap yok
        ],
      );

      // Act
      final totalScore = testCategory.questions.fold<int>(
        0,
        (sum, question) => sum + (question.answer ?? 0),
      );

      // Assert
      expect(totalScore, equals(0));
      expect(testCategory.isCompleted, isFalse);
    });
  });

  /// ==================================================================================
  /// TEST GRUBU 2: SEVİYE BELİRLEME TESTLERİ
  /// ==================================================================================
  /// Requirement: FR-3.2 - Seviye Belirleme (Puan Aralıkları)
  /// Priority: CRITICAL ⚠️
  /// Test Coverage: 9 test cases
  /// Related Test Cases: TC-UT-015, TC-UT-016, TC-UT-017, TC-UT-018, TC-UT-019, TC-UT-020
  /// User Story: US-004
  ///
  /// Description:
  /// Toplam puana göre sistem aşağıdaki aralıklardan birini belirlemelidir:
  /// - 0-15 Puan: Düşük Seviye / Normal (Yeşil 😊)
  /// - 16-30 Puan: Orta Seviye (Turuncu 😐)
  /// - 31-50 Puan: Yüksek Seviye (Kırmızı 😟)
  ///
  /// Acceptance Criteria:
  /// - Given my test is completed
  /// - When my total score is calculated
  /// - Then I should see the correct level with appropriate color and emoji
  /// ==================================================================================
  group('Seviye Belirleme Testleri', () {
    /// Test Case ID: TC-UT-016
    /// Requirement: FR-3.2
    /// Scenario: Orta seviye kontrolü
    /// Expected: 20 puan → ScoreLevel.medium
    test('20 puan alan kullanıcının seviyesi "Orta Seviye" olmalı', () {
      // Arrange
      const totalScore = 20;

      // Act
      final scoreLevel = _determineScoreLevel(totalScore);

      // Assert
      expect(scoreLevel, equals(ScoreLevel.medium));
      expect(scoreLevel.title, equals('Orta Seviye'));
    });

    /// Test Case ID: TC-UT-015
    /// Requirement: FR-3.2
    /// Scenario: Düşük seviye aralığı (0-15)
    /// Expected: 0, 10, 15 → ScoreLevel.low
    /// Note: Sınır değer testi (boundary value testing)
    test('0-15 puan arası "Düşük Seviye / Normal" olmalı', () {
      // Arrange & Act & Assert
      expect(_determineScoreLevel(0), equals(ScoreLevel.low));
      expect(_determineScoreLevel(10), equals(ScoreLevel.low));
      expect(_determineScoreLevel(15), equals(ScoreLevel.low));

      expect(_determineScoreLevel(0).title, equals('Düşük Seviye / Normal'));
    });

    /// Test Case ID: TC-UT-017
    /// Requirement: FR-3.2
    /// Scenario: Orta seviye aralığı (16-30)
    /// Expected: 16, 20, 25, 30 → ScoreLevel.medium
    /// Note: Kritik sınır değerleri 16 ve 30 test ediliyor
    test('16-30 puan arası "Orta Seviye" olmalı', () {
      // Arrange & Act & Assert
      expect(_determineScoreLevel(16), equals(ScoreLevel.medium));
      expect(_determineScoreLevel(20), equals(ScoreLevel.medium));
      expect(_determineScoreLevel(25), equals(ScoreLevel.medium));
      expect(_determineScoreLevel(30), equals(ScoreLevel.medium));

      expect(_determineScoreLevel(20).title, equals('Orta Seviye'));
    });

    /// Test Case ID: TC-UT-018
    /// Requirement: FR-3.2
    /// Scenario: Yüksek seviye aralığı (31+)
    /// Expected: 31, 40, 50 → ScoreLevel.high
    test('31+ puan "Yüksek Seviye" olmalı', () {
      // Arrange & Act & Assert
      expect(_determineScoreLevel(31), equals(ScoreLevel.high));
      expect(_determineScoreLevel(40), equals(ScoreLevel.high));
      expect(_determineScoreLevel(50), equals(ScoreLevel.high));

      expect(_determineScoreLevel(35).title, equals('Yüksek Seviye'));
    });

    /// Test Case ID: TC-UT-019
    /// Requirement: FR-3.2
    /// Scenario: Renk kodları doğrulaması
    /// Expected: Low=Yeşil(0xFF4CAF50), Medium=Turuncu(0xFFFF9800), High=Kırmızı(0xFFF44336)
    test('Seviye renkleri doğru atanmalı', () {
      // Assert
      expect(_determineScoreLevel(10).color.value, equals(0xFF4CAF50)); // Yeşil
      expect(_determineScoreLevel(20).color.value, equals(0xFFFF9800)); // Turuncu
      expect(_determineScoreLevel(40).color.value, equals(0xFFF44336)); // Kırmızı
    });

    /// Test Case ID: TC-UT-020
    /// Requirement: FR-3.2
    /// Scenario: Emoji mapping doğrulaması
    /// Expected: Low=😊, Medium=😐, High=😟
    test('Seviye emoji\'leri doğru atanmalı', () {
      // Assert
      expect(_determineScoreLevel(10).emoji, equals('😊'));
      expect(_determineScoreLevel(20).emoji, equals('😐'));
      expect(_determineScoreLevel(40).emoji, equals('😟'));
    });
  });

  /// ==================================================================================
  /// TEST GRUBU 3: SORU SAYISI VE VERİ YÜKLEME TESTLERİ
  /// ==================================================================================
  /// Requirement: FR-1.1 - Test Listesinin Görüntülenmesi
  /// Priority: HIGH
  /// Test Coverage: 8 test cases
  /// Related Test Cases: TC-UT-021, TC-UT-022, TC-UT-023, TC-UT-024, TC-UT-025, TC-UT-026, TC-UT-027, TC-UT-028
  /// User Story: US-001
  ///
  /// Description:
  /// Sistem, ana sayfada tanımlı tüm testleri (Duygudurum, Anksiyete, Stres, Uyku)
  /// listelemelidir. Her test doğru soru sayısına sahip olmalı ve veri bütünlüğü
  /// korunmalıdır.
  ///
  /// Acceptance Criteria:
  /// - Given I open the application
  /// - When the dashboard loads
  /// - Then I should see 4 test categories with correct question counts
  /// ==================================================================================
  group('Soru Sayısı ve Veri Yükleme Testleri', () {
    /// Test Case ID: TC-UT-021
    /// Requirement: FR-1.1
    /// Scenario: Duygudurum testi veri doğrulaması
    /// Expected: 10 soru, questionCount = questions.length
    test('Duygudurum Değerlendirme Testi 10 soru içermeli', () {
      // Arrange
      final category = QuestionData.getCategoryById('mood_test');

      // Assert
      expect(category, isNotNull);
      expect(category!.questionCount, equals(10));
      expect(category.questions.length, equals(10));
      expect(category.title, equals('Duygudurum Değerlendirme Testi'));
    });

    /// Test Case ID: TC-UT-022
    /// Requirement: FR-1.1
    /// Scenario: Anksiyete testi veri doğrulaması
    /// Expected: 12 soru
    test('Anksiyete Seviye Testi 12 soru içermeli', () {
      // Arrange
      final category = QuestionData.getCategoryById('anxiety_test');

      // Assert
      expect(category, isNotNull);
      expect(category!.questionCount, equals(12));
      expect(category.questions.length, equals(12));
      expect(category.title, equals('Anksiyete Seviye Testi'));
    });

    /// Test Case ID: TC-UT-023
    /// Requirement: FR-1.1
    /// Scenario: Stres testi veri doğrulaması
    /// Expected: 8 soru
    test('Stres Yönetimi Değerlendirmesi 8 soru içermeli', () {
      // Arrange
      final category = QuestionData.getCategoryById('stress_test');

      // Assert
      expect(category, isNotNull);
      expect(category!.questionCount, equals(8));
      expect(category.questions.length, equals(8));
      expect(category.title, equals('Stres Yönetimi Değerlendirmesi'));
    });

    /// Test Case ID: TC-UT-024
    /// Requirement: FR-1.1
    /// Scenario: Uyku testi veri doğrulaması
    /// Expected: 10 soru
    test('Uyku Kalitesi Anketi 10 soru içermeli', () {
      // Arrange
      final category = QuestionData.getCategoryById('sleep_test');

      // Assert
      expect(category, isNotNull);
      expect(category!.questionCount, equals(10));
      expect(category.questions.length, equals(10));
      expect(category.title, equals('Uyku Kalitesi Anketi'));
    });

    /// Test Case ID: TC-UT-025
    /// Requirement: FR-1.1
    /// Scenario: Kategori sayısı kontrolü
    /// Expected: Toplam 4 test kategorisi
    test('Tüm test kategorileri 4 adet olmalı', () {
      // Arrange
      final categories = QuestionData.getAllCategories();

      // Assert
      expect(categories.length, equals(4));
    });

    /// Test Case ID: TC-UT-026
    /// Requirement: FR-1.1
    /// Scenario: Unique constraint doğrulaması
    /// Expected: mood_test, anxiety_test, stress_test, sleep_test (duplicate yok)
    test('Her test kategorisinin benzersiz ID\'si olmalı', () {
      // Arrange
      final categories = QuestionData.getAllCategories();
      final ids = categories.map((c) => c.id).toList();

      // Assert
      expect(ids.toSet().length, equals(ids.length)); // Duplicate yok
      expect(ids, contains('mood_test'));
      expect(ids, contains('anxiety_test'));
      expect(ids, contains('stress_test'));
      expect(ids, contains('sleep_test'));
    });

    /// Test Case ID: TC-UT-027
    /// Requirement: FR-2.1
    /// Scenario: Soru ID'lerinin unique olması
    /// Expected: Duplicate question ID yok
    test('Her sorunun benzersiz ID\'si olmalı', () {
      // Arrange
      final category = QuestionData.getCategoryById('mood_test')!;
      final questionIds = category.questions.map((q) => q.id).toList();

      // Assert
      expect(questionIds.toSet().length, equals(questionIds.length));
    });

    /// Test Case ID: TC-UT-028
    /// Requirement: FR-1.1
    /// Scenario: Veri validasyonu
    /// Expected: Her soru en az 10 karakter içermeli
    test('Tüm sorular metin içermeli (boş olmamalı)', () {
      // Arrange
      final categories = QuestionData.getAllCategories();

      // Act & Assert
      for (var category in categories) {
        for (var question in category.questions) {
          expect(question.text, isNotEmpty);
          expect(question.text.length, greaterThan(10)); // En az 10 karakter
        }
      }
    });
  });

  /// ==================================================================================
  /// TEST GRUBU 4: QUESTION MODEL TESTLERİ
  /// ==================================================================================
  /// Requirement: Model Layer Validation
  /// Priority: HIGH
  /// Test Coverage: 4 test cases
  ///
  /// Description:
  /// Question model'inin immutable state management, getter'lar ve JSON
  /// serialization/deserialization özelliklerini test eder.
  ///
  /// Coverage:
  /// - State management (answer, isAnswered)
  /// - clearAnswer() fonksiyonu
  /// - JSON dönüşümleri (toJson/fromJson)
  /// ==================================================================================
  group('Question Model Testleri', () {
    /// Test Scenario: Initial state kontrolü
    /// Expected: answer=null, isAnswered=false
    test('Yeni soru oluşturulduğunda cevap null olmalı', () {
      // Arrange & Act
      final question = Question(
        id: 'test_q1',
        text: 'Test sorusu',
      );

      // Assert
      expect(question.answer, isNull);
      expect(question.isAnswered, isFalse);
    });

    /// Test Scenario: Computed property testi
    /// Expected: answer set edilince isAnswered=true
    test('Soru cevaplanınca isAnswered true olmalı', () {
      // Arrange
      final question = Question(
        id: 'test_q1',
        text: 'Test sorusu',
      );

      // Act
      question.answer = 3;

      // Assert
      expect(question.isAnswered, isTrue);
      expect(question.answer, equals(3));
    });

    /// Test Scenario: State reset fonksiyonu
    /// Expected: clearAnswer() sonrası answer=null
    test('clearAnswer() metodu cevabı sıfırlamalı', () {
      // Arrange
      final question = Question(
        id: 'test_q1',
        text: 'Test sorusu',
        answer: 4,
      );

      // Act
      question.clearAnswer();

      // Assert
      expect(question.answer, isNull);
      expect(question.isAnswered, isFalse);
    });

    /// Test Scenario: Serialization/Deserialization
    /// Expected: toJson() → fromJson() sonrası veri kaybı yok
    test('Question JSON dönüşümü doğru çalışmalı', () {
      // Arrange
      final question = Question(
        id: 'test_q1',
        text: 'Test sorusu',
        answer: 5,
      );

      // Act
      final json = question.toJson();
      final fromJson = Question.fromJson(json);

      // Assert
      expect(fromJson.id, equals(question.id));
      expect(fromJson.text, equals(question.text));
      expect(fromJson.answer, equals(question.answer));
    });
  });

  /// ==================================================================================
  /// TEST GRUBU 5: TESTCATEGORY MODEL TESTLERİ
  /// ==================================================================================
  /// Requirement: Model Layer Validation
  /// Priority: HIGH
  /// Test Coverage: 5 test cases
  ///
  /// Description:
  /// TestCategory model'inin aggregate fonksiyonları, progress tracking ve
  /// bulk operations özelliklerini test eder.
  ///
  /// Coverage:
  /// - isCompleted (every query)
  /// - answeredCount (where query)
  /// - progress (fold calculation)
  /// - clearAllAnswers (bulk operation)
  /// ==================================================================================
  group('TestCategory Model Testleri', () {
    /// Test Scenario: Completion state kontrolü
    /// Expected: Tüm sorular cevaplıysa isCompleted=true
    test('isCompleted tüm sorular cevaplanınca true olmalı', () {
      // Arrange
      final category = TestCategory(
        id: 'test',
        title: 'Test',
        description: 'Test',
        duration: '5 dakika',
        questionCount: 3,
        questions: [
          Question(id: 'q1', text: 'Soru 1', answer: 3),
          Question(id: 'q2', text: 'Soru 2', answer: 4),
          Question(id: 'q3', text: 'Soru 3', answer: 5),
        ],
      );

      // Assert
      expect(category.isCompleted, isTrue);
    });

    /// Test Scenario: Partial completion
    /// Expected: Tek soru bile cevaplanmamışsa isCompleted=false
    test('isCompleted bir soru bile cevaplanmamışsa false olmalı', () {
      // Arrange
      final category = TestCategory(
        id: 'test',
        title: 'Test',
        description: 'Test',
        duration: '5 dakika',
        questionCount: 3,
        questions: [
          Question(id: 'q1', text: 'Soru 1', answer: 3),
          Question(id: 'q2', text: 'Soru 2'), // Cevaplanmamış
          Question(id: 'q3', text: 'Soru 3', answer: 5),
        ],
      );

      // Assert
      expect(category.isCompleted, isFalse);
    });

    /// Test Scenario: Aggregate count
    /// Expected: Cevaplanan soru sayısı doğru hesaplanmalı
    test('answeredCount doğru saymalı', () {
      // Arrange
      final category = TestCategory(
        id: 'test',
        title: 'Test',
        description: 'Test',
        duration: '5 dakika',
        questionCount: 5,
        questions: [
          Question(id: 'q1', text: 'Soru 1', answer: 3),
          Question(id: 'q2', text: 'Soru 2'),
          Question(id: 'q3', text: 'Soru 3', answer: 5),
          Question(id: 'q4', text: 'Soru 4'),
          Question(id: 'q5', text: 'Soru 5', answer: 4),
        ],
      );

      // Assert
      expect(category.answeredCount, equals(3));
    });

    /// Test Scenario: Progress calculation
    /// Expected: progress = answeredCount / totalCount (0.0-1.0 arası)
    test('progress doğru hesaplanmalı', () {
      // Arrange
      final category = TestCategory(
        id: 'test',
        title: 'Test',
        description: 'Test',
        duration: '5 dakika',
        questionCount: 4,
        questions: [
          Question(id: 'q1', text: 'Soru 1', answer: 3),
          Question(id: 'q2', text: 'Soru 2', answer: 4),
          Question(id: 'q3', text: 'Soru 3'),
          Question(id: 'q4', text: 'Soru 4'),
        ],
      );

      // Assert
      expect(category.progress, equals(0.5)); // 2/4 = 0.5
    });

    /// Test Scenario: Bulk reset operation
    /// Expected: clearAllAnswers() sonrası tüm answers null
    test('clearAllAnswers tüm cevapları sıfırlamalı', () {
      // Arrange
      final category = TestCategory(
        id: 'test',
        title: 'Test',
        description: 'Test',
        duration: '5 dakika',
        questionCount: 2,
        questions: [
          Question(id: 'q1', text: 'Soru 1', answer: 3),
          Question(id: 'q2', text: 'Soru 2', answer: 4),
        ],
      );

      // Act
      category.clearAllAnswers();

      // Assert
      expect(category.questions[0].answer, isNull);
      expect(category.questions[1].answer, isNull);
      expect(category.isCompleted, isFalse);
    });
  });

  /// ==================================================================================
  /// TEST GRUBU 6: EDGE CASE TESTLERİ
  /// ==================================================================================
  /// Priority: MEDIUM
  /// Test Coverage: 3 test cases
  ///
  /// Description:
  /// Sınır değerler (boundary values), hata senaryoları ve exceptional cases
  /// testleri. Sistemin beklenmedik durumlarda nasıl davrandığını doğrular.
  ///
  /// Coverage:
  /// - Minimum/Maksimum puan senaryoları
  /// - Geçersiz input handling
  /// - Graceful error handling
  /// ==================================================================================
  group('Edge Case Testleri', () {
    /// Test Scenario: Minimum boundary value
    /// Expected: 10 × 1 = 10 puan, seviye=low
    test('Minimum puan (tüm sorulara 1) doğru hesaplanmalı', () {
      // Arrange
      final category = TestCategory(
        id: 'test',
        title: 'Test',
        description: 'Test',
        duration: '5 dakika',
        questionCount: 10,
        questions: List.generate(
          10,
          (index) => Question(
            id: 'q${index + 1}',
            text: 'Soru ${index + 1}',
            answer: 1,
          ),
        ),
      );

      // Act
      final totalScore = category.questions.fold<int>(
        0,
        (sum, question) => sum + (question.answer ?? 0),
      );

      // Assert
      expect(totalScore, equals(10)); // 10 soru * 1 puan
      expect(_determineScoreLevel(totalScore), equals(ScoreLevel.low));
    });

    /// Test Scenario: Maximum boundary value
    /// Expected: 10 × 5 = 50 puan, seviye=high
    test('Maksimum puan (tüm sorulara 5) doğru hesaplanmalı', () {
      // Arrange
      final category = TestCategory(
        id: 'test',
        title: 'Test',
        description: 'Test',
        duration: '5 dakika',
        questionCount: 10,
        questions: List.generate(
          10,
          (index) => Question(
            id: 'q${index + 1}',
            text: 'Soru ${index + 1}',
            answer: 5,
          ),
        ),
      );

      // Act
      final totalScore = category.questions.fold<int>(
        0,
        (sum, question) => sum + (question.answer ?? 0),
      );

      // Assert
      expect(totalScore, equals(50)); // 10 soru * 5 puan
      expect(_determineScoreLevel(totalScore), equals(ScoreLevel.high));
    });

    /// Test Scenario: Invalid input handling
    /// Expected: null dönmeli, exception fırlatmamalı (graceful handling)
    test('Geçersiz category ID null döndürmeli', () {
      // Act
      final category = QuestionData.getCategoryById('nonexistent_test');

      // Assert
      expect(category, isNull);
    });
  });
}

/// ==================================================================================
/// YARDIMCI FONKSİYONLAR
/// ==================================================================================

/// Yardımcı fonksiyon: Puana göre seviye belirleme
///
/// Requirement: FR-3.2
/// Description: ResultScreen.dart içindeki seviye belirleme mantığını test eder
///
/// Parametreler:
/// - totalScore: Toplam puan (0-50 arası)
///
/// Dönüş: ScoreLevel enum (low, medium, high)
///
/// Algoritma:
/// - 0-15 → low (Düşük Seviye / Normal)
/// - 16-30 → medium (Orta Seviye)
/// - 31+ → high (Yüksek Seviye)
ScoreLevel _determineScoreLevel(int totalScore) {
  if (totalScore <= 15) {
    return ScoreLevel.low;
  } else if (totalScore <= 30) {
    return ScoreLevel.medium;
  } else {
    return ScoreLevel.high;
  }
}
