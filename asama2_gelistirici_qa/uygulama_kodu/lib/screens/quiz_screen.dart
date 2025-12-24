import 'package:flutter/material.dart';
import '../models/test_category_model.dart';
import '../models/question_model.dart';
import 'result_screen.dart';

/// Quiz Ekranı
/// Psikolojik test sorularının gösterildiği ve cevaplanması ekranı
class QuizScreen extends StatefulWidget {
  final TestCategory category;

  const QuizScreen({
    super.key,
    required this.category,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswer; // Şu anki seçili cevap (1-5 arası)

  /// Şu anki soru
  Question get _currentQuestion =>
      widget.category.questions[_currentQuestionIndex];

  /// Son soru mu kontrolü
  bool get _isLastQuestion =>
      _currentQuestionIndex == widget.category.questions.length - 1;

  /// İlerleme yüzdesi (0.0 - 1.0)
  double get _progress =>
      (_currentQuestionIndex + 1) / widget.category.questions.length;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _showExitDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.category.title),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => _showExitDialog(context),
          ),
        ),
        body: Column(
          children: [
            // İlerleme Bölümü
            _buildProgressSection(),

            // Soru ve Cevap Bölümü
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Soru Metni
                    _buildQuestionText(),

                    const SizedBox(height: 32),

                    // Cevap Seçenekleri (Likert Ölçeği)
                    _buildAnswerOptions(),
                  ],
                ),
              ),
            ),

            // İleri/Bitir Butonu
            _buildNavigationButton(),
          ],
        ),
      ),
    );
  }

  /// İlerleme çubuğu ve sayaç bölümü
  Widget _buildProgressSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          // Soru Sayacı
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Soru ${_currentQuestionIndex + 1}/${widget.category.questions.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2196F3),
                ),
              ),
              Text(
                '%${(_progress * 100).toInt()}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // İlerleme Çubuğu
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF2196F3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Soru metni widget'ı
  Widget _buildQuestionText() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F9FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.shade100,
          width: 1,
        ),
      ),
      child: Text(
        _currentQuestion.text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// Cevap seçenekleri (Likert Ölçeği 1-5)
  Widget _buildAnswerOptions() {
    final options = [
      {
        'value': 1,
        'label': 'Hiç Katılmıyorum',
        'emoji': '😔',
      },
      {
        'value': 2,
        'label': 'Az Katılıyorum',
        'emoji': '🙁',
      },
      {
        'value': 3,
        'label': 'Kısmen Katılıyorum',
        'emoji': '😐',
      },
      {
        'value': 4,
        'label': 'Çoğunlukla Katılıyorum',
        'emoji': '🙂',
      },
      {
        'value': 5,
        'label': 'Tamamen Katılıyorum',
        'emoji': '😊',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cevabınızı seçin:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        ...options.map((option) => _buildAnswerOption(
              value: option['value'] as int,
              label: option['label'] as String,
              emoji: option['emoji'] as String,
            )),
      ],
    );
  }

  /// Tek bir cevap seçeneği
  Widget _buildAnswerOption({
    required int value,
    required String label,
    required String emoji,
  }) {
    final isSelected = _selectedAnswer == value;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedAnswer = value;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE3F2FD) : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  isSelected ? const Color(0xFF2196F3) : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              // Radio Button
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF2196F3)
                        : Colors.grey.shade400,
                    width: 2,
                  ),
                  color:
                      isSelected ? const Color(0xFF2196F3) : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.circle,
                        size: 12,
                        color: Colors.white,
                      )
                    : null,
              ),

              const SizedBox(width: 12),

              // Emoji
              Text(
                emoji,
                style: const TextStyle(fontSize: 20),
              ),

              const SizedBox(width: 12),

              // Label
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.black87 : Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// İleri/Bitir navigasyon butonu
  Widget _buildNavigationButton() {
    final isAnswerSelected = _selectedAnswer != null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(0, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: isAnswerSelected ? _handleNext : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2196F3),
              disabledBackgroundColor: Colors.grey.shade300,
              foregroundColor: Colors.white,
              disabledForegroundColor: Colors.grey.shade500,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isLastQuestion ? 'Testi Bitir' : 'İleri',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  _isLastQuestion ? Icons.check : Icons.arrow_forward,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// İleri butonuna basıldığında çalışır
  void _handleNext() {
    if (_selectedAnswer == null) {
      // Validasyon - Uyarı göster
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen bir cevap seçin'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Cevabı kaydet
    _currentQuestion.answer = _selectedAnswer;

    if (_isLastQuestion) {
      // Son soru - Testi bitir ve sonuç ekranına git
      _finishQuiz();
    } else {
      // Sonraki soruya geç
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer =
            widget.category.questions[_currentQuestionIndex].answer;
      });
    }
  }

  /// Testi bitirir ve sonuç ekranına yönlendirir
  void _finishQuiz() {
    // Puan hesapla
    final totalScore = widget.category.questions.fold<int>(
      0,
      (sum, question) => sum + (question.answer ?? 0),
    );

    // Sonuç ekranına yönlendir
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          category: widget.category,
          totalScore: totalScore,
        ),
      ),
    );
  }

  /// Çıkış onay dialogu
  Future<bool> _showExitDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Testi Bırakmak İstediğinize Emin misiniz?'),
        content: const Text(
          'İlerlemeniz kaydedilmeyecek ve tüm cevaplarınız silinecektir.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Çık'),
          ),
        ],
      ),
    );

    return result ?? false;
  }
}
