import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RedText extends StatelessWidget {
  final String text;

  const RedText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 15,
        color: const Color(0xFFD3896F),
        letterSpacing: 1,
      ),
    );
  }
}
