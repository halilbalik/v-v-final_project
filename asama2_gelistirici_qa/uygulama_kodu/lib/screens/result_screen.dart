import 'package:flutter/material.dart';
import '../models/test_category_model.dart';

/// Sonuç Ekranı
/// Test tamamlandıktan sonra sonuçların gösterildiği ekran
class ResultScreen extends StatelessWidget {
  final TestCategory category;
  final int totalScore;

  const ResultScreen({
    super.key,
    required this.category,
    required this.totalScore,
  });

  /// Maksimum puan (soru sayısı × 5)
  int get maxScore => category.questionCount * 5;

  /// Ortalama puan (0.0 - 5.0 arası)
  double get averageScore => totalScore / category.questionCount;

  /// Yüzde değeri (0-100 arası)
  double get percentage => (totalScore / maxScore) * 100;

  /// Puan seviyesini belirler
  ScoreLevel get scoreLevel {
    if (totalScore <= 15) {
      return ScoreLevel.low;
    } else if (totalScore <= 30) {
      return ScoreLevel.medium;
    } else {
      return ScoreLevel.high;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Geri tuşuna basıldığında ana sayfaya dön
        Navigator.of(context).popUntil((route) => route.isFirst);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Test Sonuçları'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 24),

                    // Başarı İkonu ve Mesaj
                    _buildSuccessHeader(),

                    const SizedBox(height: 32),

                    // Puan Kartı
                    _buildScoreCard(),

                    const SizedBox(height: 24),

                    // Seviye Göstergesi
                    _buildLevelIndicator(),

                    const SizedBox(height: 24),

                    // Detaylı Sonuçlar
                    _buildDetailedResults(),

                    const SizedBox(height: 24),

                    // Öneri Metni
                    _buildRecommendation(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Profesyonel Tanı Uyarısı
            _buildWarningBanner(),

            // Ana Sayfaya Dön Butonu
            _buildHomeButton(context),
          ],
        ),
      ),
    );
  }

  /// Başarı başlığı
  Widget _buildSuccessHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: scoreLevel.color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle,
            size: 50,
            color: scoreLevel.color,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Testi Tamamladınız!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            category.title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  /// Puan kartı (büyük gösterim)
  Widget _buildScoreCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scoreLevel.color,
            scoreLevel.color.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: scoreLevel.color.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Toplam Puanınız',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$totalScore',
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12, left: 4),
                child: Text(
                  '/ $maxScore',
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '${percentage.toStringAsFixed(0)}%',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Seviye göstergesi
  Widget _buildLevelIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scoreLevel.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: scoreLevel.color.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            scoreLevel.emoji,
            style: const TextStyle(fontSize: 40),
          ),
          const SizedBox(height: 12),
          Text(
            scoreLevel.title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: scoreLevel.color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            scoreLevel.subtitle,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Detaylı sonuçlar
  Widget _buildDetailedResults() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Detaylı Analiz',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildResultRow(
            icon: Icons.quiz,
            label: 'Toplam Soru',
            value: '${category.questionCount}',
          ),
          const Divider(height: 24),
          _buildResultRow(
            icon: Icons.star,
            label: 'Ortalama Puan',
            value: averageScore.toStringAsFixed(2),
          ),
          const Divider(height: 24),
          _buildResultRow(
            icon: Icons.access_time,
            label: 'Tahmini Süre',
            value: category.duration,
          ),
        ],
      ),
    );
  }

  /// Detaylı sonuç satırı
  Widget _buildResultRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 20,
            color: const Color(0xFF2196F3),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  /// Öneri metni
  Widget _buildRecommendation() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.blue.shade100,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: Colors.blue.shade700,
                size: 24,
              ),
              const SizedBox(width: 12),
              const Text(
                'Öneriler',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            scoreLevel.recommendation,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade800,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  /// Profesyonel tanı uyarısı
  Widget _buildWarningBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        border: Border(
          top: BorderSide(
            color: Colors.orange.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange.shade700,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Bu sonuçlar profesyonel tanı değildir. Uzman desteği için bir psikolog veya psikiyatriste danışmanız önerilir.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.orange.shade900,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Ana sayfaya dön butonu
  Widget _buildHomeButton(BuildContext context) {
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
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2196F3),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home, size: 20),
                SizedBox(width: 8),
                Text(
                  'Ana Sayfaya Dön',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Puan seviyesi enum ve özellikleri
enum ScoreLevel {
  low,
  medium,
  high;

  /// Seviye başlığı
  String get title {
    switch (this) {
      case ScoreLevel.low:
        return 'Düşük Seviye / Normal';
      case ScoreLevel.medium:
        return 'Orta Seviye';
      case ScoreLevel.high:
        return 'Yüksek Seviye';
    }
  }

  /// Alt başlık
  String get subtitle {
    switch (this) {
      case ScoreLevel.low:
        return 'Sonuçlarınız normal aralıkta';
      case ScoreLevel.medium:
        return 'Dikkat edilmesi gereken noktalar var';
      case ScoreLevel.high:
        return 'Profesyonel destek önerilir';
    }
  }

  /// Emoji
  String get emoji {
    switch (this) {
      case ScoreLevel.low:
        return '😊';
      case ScoreLevel.medium:
        return '😐';
      case ScoreLevel.high:
        return '😟';
    }
  }

  /// Renk
  Color get color {
    switch (this) {
      case ScoreLevel.low:
        return const Color(0xFF4CAF50); // Yeşil
      case ScoreLevel.medium:
        return const Color(0xFFFF9800); // Turuncu
      case ScoreLevel.high:
        return const Color(0xFFF44336); // Kırmızı
    }
  }

  /// Öneri metni
  String get recommendation {
    switch (this) {
      case ScoreLevel.low:
        return 'Sonuçlarınız sağlıklı bir duruma işaret ediyor. Mevcut iyi alışkanlıklarınızı sürdürmeniz önerilir. Düzenli egzersiz, kaliteli uyku ve dengeli beslenme ruh sağlığınızı desteklemeye devam edecektir.';
      case ScoreLevel.medium:
        return 'Bazı alanlarda zorluklar yaşayabilirsiniz. Stres yönetimi teknikleri, meditasyon veya yoga gibi aktiviteler faydalı olabilir. Durumunuz devam ederse bir uzmana danışmanız yararlı olacaktır.';
      case ScoreLevel.high:
        return 'Sonuçlarınız dikkat gerektirebilir. Bir ruh sağlığı uzmanı ile görüşmeniz önerilir. Profesyonel destek almanın hiçbir zaman geç olmadığını unutmayın. Uzman yardımı ile bu süreci daha kolay yönetebilirsiniz.';
    }
  }
}
