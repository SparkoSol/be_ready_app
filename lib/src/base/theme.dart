import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      );
}

class AppColors {
  static const primaryColor = Color(0xFF17682E);
}
