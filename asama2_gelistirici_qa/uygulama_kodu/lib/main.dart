import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const PsikolojikTestApp());
}

/// Ana uygulama widget'ı
/// Tema ve navigasyon yapılandırmasını içerir
class PsikolojikTestApp extends StatelessWidget {
  const PsikolojikTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Psikolojik Testler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Primary renk: Mavi tonları (SRS gereksinimi)
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196F3),
        scaffoldBackgroundColor: Colors.white,

        // AppBar teması
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2196F3),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),

        // Card teması
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),

        // Text teması - Minimum 14pt font boyutu (SRS gereksinimi)
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),

        // Icon teması
        iconTheme: const IconThemeData(
          color: Color(0xFF2196F3),
          size: 24,
        ),

        // Material 3 kullan
        useMaterial3: true,

        // Genel renk şeması
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
          primary: const Color(0xFF2196F3),
          secondary: const Color(0xFF64B5F6),
          background: Colors.white,
          surface: Colors.white,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}
