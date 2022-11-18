import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        textTheme: GoogleFonts.oswaldTextTheme(),
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      );
}

class AppColors {
  static const primaryColor = Color(0xFF17682E);
}
