import 'package:flutter/material.dart';

class AppTheme {
  // Cores da Cafetaria
  static const Color espresso = Color(0xFF3C2A21);
  static const Color latteBackground = Color(0xFFFDFBF7);
  static const Color latteCard = Color(0xFFF5EBE1);
  static const Color darkRoastBackground = Color(0xFF120E0C);
  static const Color darkRoastCard = Color(0xFF1E1714);
  static const Color warmAmber = Color(0xFFE5890A);

  // ☕ Tema Claro
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: espresso,
      scaffoldBackgroundColor: latteBackground,
      colorScheme: const ColorScheme.light(
        primary: espresso,
        secondary: warmAmber,
        surface: latteCard,
        onPrimary: Colors.white,
        onSurface: espresso,
      ),
      // ✅ CORRIGIDO: CardThemeData no lugar de CardTheme
      cardTheme: CardThemeData(
        color: latteCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: latteBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: espresso),
        titleTextStyle: TextStyle(
          color: espresso,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: espresso,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // ☕ Tema Escuro
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: warmAmber,
      scaffoldBackgroundColor: darkRoastBackground,
      colorScheme: const ColorScheme.dark(
        primary: warmAmber,
        secondary: Color(0xFFD5CEA3),
        surface: darkRoastCard,
        onPrimary: Colors.black,
        onSurface: Color(0xFFECE0D1),
      ),
      // ✅ CORRIGIDO: CardThemeData no lugar de CardTheme
      cardTheme: CardThemeData(
        color: darkRoastCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkRoastBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFFECE0D1)),
        titleTextStyle: TextStyle(
          color: Color(0xFFECE0D1),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: warmAmber,
          foregroundColor: Colors.black,
          elevation: 2,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}