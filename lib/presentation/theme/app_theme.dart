import 'package:flutter/material.dart';

class AppTheme {
  static const Color goldAccent = Color(0xFFFFD700);
  static const Color premiumBlack = Color(0xFF0D0D0D);
  static const Color lightGold = Color(0xFFFFF8E1);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: goldAccent,
    colorScheme: ColorScheme.fromSeed(seedColor: goldAccent),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: premiumBlack),
      titleTextStyle: TextStyle(
        color: premiumBlack,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: goldAccent,
    colorScheme: ColorScheme.fromSeed(
      seedColor: goldAccent,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: premiumBlack,
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      backgroundColor: premiumBlack,
      elevation: 0,
      iconTheme: IconThemeData(color: goldAccent),
      titleTextStyle: TextStyle(
        color: goldAccent,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );
}
