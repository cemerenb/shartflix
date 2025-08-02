import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color.fromARGB(255, 9, 9, 9);
  static const Color secondaryColor = Color.fromARGB(255, 89, 73, 230);
  static const Color accentColor = Color.fromARGB(255, 229, 9, 20);
  static const Color darkBackgroundColor = Color.fromARGB(255, 9, 9, 9);
  static const Color lightBackgroundColor = Color.fromARGB(255, 225, 225, 225);
  static const Color darkBorderColor = Color.fromARGB(50, 255, 255, 255);
  static const Color lightBorderColor = Color.fromARGB(50, 0, 0, 0);
  static const Color darkSurfaceColor = Color.fromARGB(255, 31, 31, 31);
  static const Color lightSurfaceColor = Color.fromARGB(220, 255, 255, 255);
  static const Color darkTextColor = Color(0xFFFFFFFF);
  static const Color lightTextColor = Color.fromARGB(255, 0, 0, 0);
  static const Color darkTransparent = Color.fromARGB(93, 149, 149, 149);
  static const Color lightTransparent = Color.fromARGB(105, 192, 192, 192);
  static const Color darkSubtitleColor = Color(0xFFB0B0B0);
  static const Color lightSubtitleColor = Color.fromARGB(255, 100, 100, 100);
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'EuclidCircularA',

      textTheme: darkTextTheme,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: accentColor,
        surface: darkSurfaceColor,
        onPrimary: darkTextColor,
        onSecondary: darkTextColor,
        onSurface: darkTextColor,
        outline: darkBorderColor,
      ),
      scaffoldBackgroundColor: darkBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: darkTextColor,
        elevation: 0,
        centerTitle: true,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          backgroundColor: darkSurfaceColor,
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          iconSize: 24,
        ),
      ),
      iconTheme: IconThemeData(color: darkTextColor),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: darkTextColor,

          textStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: darkTextColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: darkTextColor,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurfaceColor,
        iconColor: darkSubtitleColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color.fromARGB(49, 19, 147, 252),
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        hintStyle: const TextStyle(color: darkSubtitleColor),
        labelStyle: const TextStyle(color: darkSubtitleColor),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: primaryColor,
        selectedItemColor: accentColor,
        unselectedItemColor: darkSubtitleColor,
        type: BottomNavigationBarType.fixed,
      ),
      cardTheme: CardThemeData(
        color: darkSurfaceColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'EuclidCircularA',
      textTheme: lightTextTheme,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        surface: lightSurfaceColor,
        onPrimary: lightTextColor,
        onSecondary: lightTextColor,
        onSurface: lightTextColor,
        outline: lightBorderColor,
      ),
      scaffoldBackgroundColor: lightBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: lightSurfaceColor,
        foregroundColor: lightTextColor,
        elevation: 1,
        centerTitle: true,
      ),
      iconTheme: IconThemeData(color: lightTextColor),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          backgroundColor: lightSurfaceColor,
          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
          iconSize: 24,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: lightTextColor,

          textStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: darkTextColor,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: lightTextColor),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightSurfaceColor,
        iconColor: lightSubtitleColor,

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: lightBorderColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        hintStyle: const TextStyle(color: lightSubtitleColor),
        labelStyle: const TextStyle(color: lightSubtitleColor),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lightSurfaceColor,
        selectedItemColor: accentColor,
        unselectedItemColor: lightSubtitleColor,
        type: BottomNavigationBarType.fixed,
      ),
      cardTheme: CardThemeData(
        color: lightSurfaceColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static TextTheme get lightTextTheme => const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: lightTextColor,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: lightTextColor,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: lightTextColor,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: lightTextColor,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: lightSubtitleColor,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: lightTextColor),
    bodyMedium: TextStyle(fontSize: 14, color: lightTextColor),
    bodySmall: TextStyle(fontSize: 12, color: lightTextColor),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: lightTextColor,
    ),
  );

  static TextTheme get darkTextTheme => const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: darkTextColor,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: darkTextColor,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: darkTextColor,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: darkTextColor,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: darkSubtitleColor,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: darkTextColor),
    bodyMedium: TextStyle(fontSize: 14, color: darkTextColor),
    bodySmall: TextStyle(fontSize: 12, color: darkTextColor),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: darkTextColor,
    ),
  );
}
