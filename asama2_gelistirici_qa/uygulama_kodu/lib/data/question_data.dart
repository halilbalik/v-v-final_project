import '../models/question_model.dart';
import '../models/test_category_model.dart';

/// Statik test verileri
/// SRS dokümanında belirtilen 4 temel psikolojik testi içerir
class QuestionData {
  /// Tüm test kategorilerinin listesini döndürür
  static List<TestCategory> getAllCategories() {
    return [
      _getDuyguDurumTesti(),
      _getAnksiyeteTesti(),
      _getStresYonetimiTesti(),
      _getUykuKalitesiTesti(),
    ];
  }

  /// ID'ye göre test kategorisini döndürür
  static TestCategory? getCategoryById(String id) {
    try {
      return getAllCategories().firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Duygudurum Değerlendirme Testi (10 soru, 3-5 dk)
  static TestCategory _getDuyguDurumTesti() {
    return TestCategory(
      id: 'mood_test',
      title: 'Duygudurum Değerlendirme Testi',
      description: 'Son haftalardaki duygu durumunuzu değerlendirin.',
      duration: '3-5 dakika',
      questionCount: 10,
      iconName: 'mood',
      questions: [
        Question(
          id: 'mood_q1',
          text: 'Son iki haftada kendimi sık sık üzgün veya umutsuz hissettim.',
        ),
        Question(
          id: 'mood_q2',
          text: 'Eskiden keyif aldığım aktivitelere olan ilgimi kaybettim.',
        ),
        Question(
          id: 'mood_q3',
          text: 'Kendimi enerjik ve motivasyonlu hissediyorum.',
        ),
        Question(
          id: 'mood_q4',
          text: 'Gün içinde duygusal olarak dengesiz hissediyorum.',
        ),
        Question(
          id: 'mood_q5',
          text: 'Kendimi değersiz veya suçlu hissediyorum.',
        ),
        Question(
          id: 'mood_q6',
          text: 'Geleceğe dair umutlu ve pozitif bakıyorum.',
        ),
        Question(
          id: 'mood_q7',
          text: 'Sosyal ilişkilerimden zevk alıyorum ve insanlarla vakit geçirmek istiyorum.',
        ),
        Question(
          id: 'mood_q8',
          text: 'Kendimi yalnız ve izole olmuş hissediyorum.',
        ),
        Question(
          id: 'mood_q9',
          text: 'Konsantre olmakta ve kararlar almakta zorlanıyorum.',
        ),
        Question(
          id: 'mood_q10',
          text: 'Hayatımdan genel olarak memnunum ve mutlu hissediyorum.',
        ),
      ],
    );
  }

  /// Anksiyete Seviye Testi (12 soru, 4-5 dk)
  static TestCategory _getAnksiyeteTesti() {
    return TestCategory(
      id: 'anxiety_test',
      title: 'Anksiyete Seviye Testi',
      description: 'Kaygı seviyenizi ve kısa süre içinde nasıl hissettiğinizi değerlendirin.',
      duration: '4-5 dakika',
      questionCount: 12,
      iconName: 'anxiety',
      questions: [
        Question(
          id: 'anxiety_q1',
          text: 'Aşırı endişelendiğimi ve kaygılandığımı hissediyorum.',
        ),
        Question(
          id: 'anxiety_q2',
          text: 'Kendimi gergin ve huzursuz hissediyorum.',
        ),
        Question(
          id: 'anxiety_q3',
          text: 'Kalp çarpıntısı, terleme veya titreme gibi fiziksel belirtiler yaşıyorum.',
        ),
        Question(
          id: 'anxiety_q4',
          text: 'Gelecekte kötü bir şeyler olacağından sürekli endişeleniyorum.',
        ),
        Question(
          id: 'anxiety_q5',
          text: 'Rahatlamakta ve gevşemekte zorlanıyorum.',
        ),
        Question(
          id: 'anxiety_q6',
          text: 'Günlük işlerimi yaparken aşırı endişeli hissediyorum.',
        ),
        Question(
          id: 'anxiety_q7',
          text: 'Sosyal ortamlarda kendimi rahatsız ve kaygılı hissediyorum.',
        ),
        Question(
          id: 'anxiety_q8',
          text: 'Uyumakta zorlanıyorum çünkü aklım sürekli endişelerle dolu.',
        ),
        Question(
          id: 'anxiety_q9',
          text: 'Küçük sorunlar karşısında bile aşırı tepki veriyorum.',
        ),
        Question(
          id: 'anxiety_q10',
          text: 'Nefes almakta zorlanma veya nefes darlığı yaşıyorum.',
        ),
        Question(
          id: 'anxiety_q11',
          text: 'Kontrolümü kaybedeceğim veya çıldıracağım korkusu yaşıyorum.',
        ),
        Question(
          id: 'anxiety_q12',
          text: 'Belirli durumlar veya yerlerden kaçınma ihtiyacı hissediyorum.',
        ),
      ],
    );
  }

  /// Stres Yönetimi Değerlendirmesi (8 soru, 2-4 dk)
  static TestCategory _getStresYonetimiTesti() {
    return TestCategory(
      id: 'stress_test',
      title: 'Stres Yönetimi Değerlendirmesi',
      description: 'Strese başa çıkma becerinizi ve yaşam baskı düzeyinizi değerlendirin.',
      duration: '2-4 dakika',
      questionCount: 8,
      iconName: 'stress',
      questions: [
        Question(
          id: 'stress_q1',
          text: 'Kendimi bunalmış ve stresli hissediyorum.',
        ),
        Question(
          id: 'stress_q2',
          text: 'Sorumluluklarımın üstesinden gelemeyeceğimi düşünüyorum.',
        ),
        Question(
          id: 'stress_q3',
          text: 'Stresin fiziksel belirtilerini yaşıyorum (baş ağrısı, mide sorunları vb.).',
        ),
        Question(
          id: 'stress_q4',
          text: 'Zor durumlarla başa çıkma konusunda kendime güveniyorum.',
        ),
        Question(
          id: 'stress_q5',
          text: 'İşten veya okuldan sonra rahatlamakta zorlanıyorum.',
        ),
        Question(
          id: 'stress_q6',
          text: 'Stresli durumlarda etkili başa çıkma stratejilerim var.',
        ),
        Question(
          id: 'stress_q7',
          text: 'Kolaylıkla sinirlenip öfkeleniyorum.',
        ),
        Question(
          id: 'stress_q8',
          text: 'Yaşamımda dengeli bir iş-özel hayat dengesi kurabiliyor muyum.',
        ),
      ],
    );
  }

  /// Uyku Kalitesi Anketi (10 soru, 3-5 dk)
  static TestCategory _getUykuKalitesiTesti() {
    return TestCategory(
      id: 'sleep_test',
      title: 'Uyku Kalitesi Anketi',
      description: 'Uyku düzeninizi ve kalitesini değerlendirin.',
      duration: '3-5 dakika',
      questionCount: 10,
      iconName: 'sleep',
      questions: [
        Question(
          id: 'sleep_q1',
          text: 'Gece uykuya dalmakta zorlanıyorum.',
        ),
        Question(
          id: 'sleep_q2',
          text: 'Gece boyunca sık sık uyanıyorum.',
        ),
        Question(
          id: 'sleep_q3',
          text: 'Sabahları dinlenmiş ve zinde uyanıyorum.',
        ),
        Question(
          id: 'sleep_q4',
          text: 'Uyku saatlerim düzensiz ve değişken.',
        ),
        Question(
          id: 'sleep_q5',
          text: 'Yeterli uyku alabiliyorum (7-8 saat).',
        ),
        Question(
          id: 'sleep_q6',
          text: 'Gün içinde aşırı yorgunluk ve uyku hali yaşıyorum.',
        ),
        Question(
          id: 'sleep_q7',
          text: 'Kabuslar veya rahatsız edici rüyalar görüyorum.',
        ),
        Question(
          id: 'sleep_q8',
          text: 'Uyumadan önce rahatlamak için düzenli rutinlerim var.',
        ),
        Question(
          id: 'sleep_q9',
          text: 'Uyku kalitemin yaşam kalitemi olumsuz etkilediğini düşünüyorum.',
        ),
        Question(
          id: 'sleep_q10',
          text: 'Yatak odamın uyku için uygun ve konforlu olduğunu düşünüyorum.',
        ),
      ],
    );
  }
}
