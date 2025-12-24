import 'package:flutter/material.dart';
import '../data/question_data.dart';
import '../models/test_category_model.dart';
import 'quiz_screen.dart';

/// Dashboard (Ana Ekran)
/// Tüm psikolojik testlerin listelendiği ana sayfa
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = QuestionData.getAllCategories();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Psikolojik Testler'),
      ),
      body: Column(
        children: [
          // KRİTİK UYARI BANNER - SRS Gereksinimi
          _buildWarningBanner(),

          // Test Listesi
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return _TestCard(category: categories[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Kritik uyarı banner widget'ı
  /// "Bu testler klinik tanı koymaz, yalnızca farkındalık amaçlıdır."
  Widget _buildWarningBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD), // Açık mavi arka plan
        border: Border(
          bottom: BorderSide(
            color: Colors.blue.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.blue.shade700,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Bu testler klinik tanı koymaz, yalnızca farkındalık amaçlıdır.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue.shade900,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Test Kartı Widget'ı
/// Her bir psikolojik testi temsil eden kart
class _TestCard extends StatelessWidget {
  final TestCategory category;

  const _TestCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // Quiz ekranına yönlendir
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizScreen(category: category),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // İkon
              _buildIcon(),

              const SizedBox(width: 16),

              // İçerik
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Başlık
                    Text(
                      category.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Açıklama
                    Text(
                      category.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 12),

                    // Süre ve Soru Sayısı
                    _buildMetadata(),
                  ],
                ),
              ),

              // Sağ ok ikonu
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Test ikonunu oluşturur
  Widget _buildIcon() {
    IconData iconData;
    Color backgroundColor;

    // Test tipine göre ikon ve renk seçimi
    switch (category.iconName) {
      case 'mood':
        iconData = Icons.sentiment_satisfied_alt;
        backgroundColor = const Color(0xFFE3F2FD); // Açık mavi
        break;
      case 'anxiety':
        iconData = Icons.psychology;
        backgroundColor = const Color(0xFFE8F5E9); // Açık yeşil
        break;
      case 'stress':
        iconData = Icons.self_improvement;
        backgroundColor = const Color(0xFFFFF3E0); // Açık turuncu
        break;
      case 'sleep':
        iconData = Icons.bedtime;
        backgroundColor = const Color(0xFFF3E5F5); // Açık mor
        break;
      default:
        iconData = Icons.article;
        backgroundColor = const Color(0xFFE0E0E0); // Gri
    }

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        iconData,
        size: 28,
        color: Colors.blue.shade700,
      ),
    );
  }

  /// Süre ve soru sayısı metadata'sını oluşturur
  Widget _buildMetadata() {
    return Row(
      children: [
        // Süre
        Icon(
          Icons.access_time,
          size: 16,
          color: Colors.grey.shade500,
        ),
        const SizedBox(width: 4),
        Text(
          category.duration,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(width: 16),

        // Soru Sayısı
        Icon(
          Icons.description_outlined,
          size: 16,
          color: Colors.grey.shade500,
        ),
        const SizedBox(width: 4),
        Text(
          '${category.questionCount} soru',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
