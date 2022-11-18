import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget(
      {Key? key,
      required this.path,
      required this.text,
      required this.onPressed})
      : super(key: key);
  final String path;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
            stops: [0.5, 1],
            end: Alignment.bottomRight,
            begin: Alignment.centerLeft,
            colors: [
              Color(0xff6f55a0),
              Color(0xFF4F2A98),
            ]),
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            spreadRadius: 1,
            offset: const Offset(0, 7),
            color: const Color(0xFF481ba0).withOpacity(0.7),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Image.asset(path, width: 70, height: 70),
          ),
          Container(
            height: 1,
            width: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  stops: const [0.5, 1],
                  colors: [Colors.white.withOpacity(0.1), Colors.white]),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            text,
            style: GoogleFonts.poppins(
                fontSize: 13, color: Colors.white, letterSpacing: 1),
          ),
        ],
      ),
    );
  }
}
