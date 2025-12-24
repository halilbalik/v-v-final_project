/// Soru modeli
/// Likert ölçeği için 1-5 arası değer kullanır
/// 1: Hiç Katılmıyorum
/// 2: Az Katılıyorum
/// 3: Kısmen Katılıyorum
/// 4: Çoğunlukla Katılıyorum
/// 5: Tamamen Katılıyorum
class Question {
  final String id;
  final String text;
  int? answer; // Kullanıcının seçtiği cevap (1-5 arası)

  Question({
    required this.id,
    required this.text,
    this.answer,
  });

  /// JSON'dan Question nesnesi oluşturur
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as String,
      text: json['text'] as String,
      answer: json['answer'] as int?,
    );
  }

  /// Question nesnesini JSON'a dönüştürür
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'answer': answer,
    };
  }

  /// Sorunun cevaplanıp cevaplanmadığını kontrol eder
  bool get isAnswered => answer != null;

  /// Cevabı sıfırlar
  void clearAnswer() {
    answer = null;
  }

  /// Question nesnesinin bir kopyasını oluşturur
  Question copyWith({
    String? id,
    String? text,
    int? answer,
  }) {
    return Question(
      id: id ?? this.id,
      text: text ?? this.text,
      answer: answer ?? this.answer,
    );
  }
}
