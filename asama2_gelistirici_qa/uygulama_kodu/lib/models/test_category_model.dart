import 'question_model.dart';

/// Test Kategorisi modeli
/// Psikolojik testlerin kategorilerini temsil eder
class TestCategory {
  final String id;
  final String title;
  final String description;
  final String duration; // Örn: "3-5 dakika"
  final int questionCount;
  final List<Question> questions;
  final String? iconName; // İkon adı (opsiyonel)

  TestCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.questionCount,
    required this.questions,
    this.iconName,
  });

  /// JSON'dan TestCategory nesnesi oluşturur
  factory TestCategory.fromJson(Map<String, dynamic> json) {
    return TestCategory(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      duration: json['duration'] as String,
      questionCount: json['questionCount'] as int,
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q as Map<String, dynamic>))
          .toList(),
      iconName: json['iconName'] as String?,
    );
  }

  /// TestCategory nesnesini JSON'a dönüştürür
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'duration': duration,
      'questionCount': questionCount,
      'questions': questions.map((q) => q.toJson()).toList(),
      'iconName': iconName,
    };
  }

  /// Tüm soruların cevaplanıp cevaplanmadığını kontrol eder
  bool get isCompleted => questions.every((q) => q.isAnswered);

  /// Cevaplanmış soru sayısını döndürür
  int get answeredCount => questions.where((q) => q.isAnswered).length;

  /// İlerleme yüzdesini hesaplar (0.0 - 1.0 arası)
  double get progress =>
      questionCount > 0 ? answeredCount / questionCount : 0.0;

  /// Testin ortalama puanını hesaplar
  double get averageScore {
    final answeredQuestions = questions.where((q) => q.isAnswered).toList();
    if (answeredQuestions.isEmpty) return 0.0;

    final totalScore = answeredQuestions.fold<int>(
      0,
      (sum, q) => sum + (q.answer ?? 0),
    );

    return totalScore / answeredQuestions.length;
  }

  /// Tüm cevapları sıfırlar
  void clearAllAnswers() {
    for (var question in questions) {
      question.clearAnswer();
    }
  }

  /// TestCategory nesnesinin bir kopyasını oluşturur
  TestCategory copyWith({
    String? id,
    String? title,
    String? description,
    String? duration,
    int? questionCount,
    List<Question>? questions,
    String? iconName,
  }) {
    return TestCategory(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      questionCount: questionCount ?? this.questionCount,
      questions: questions ?? this.questions,
      iconName: iconName ?? this.iconName,
    );
  }
}
