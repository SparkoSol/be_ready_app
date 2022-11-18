import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeelingWidget extends StatelessWidget {
  const FeelingWidget(
      {Key? key,
      required this.text,
      required this.path,
      required this.onPressed,
      required this.duration})
      : super(key: key);
  final String text;
  final String path;
  final String duration;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              stops: [0.1, 0.8],
              end: Alignment.bottomRight,
              begin: Alignment.centerLeft,
              colors: [
                Color(0xFFD7886C),
                Color(0xff513071),
                // Color(0xff56528E),
              ]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Image.asset(path, width: 50, height: 50),
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: GoogleFonts.poppins(
                      fontSize: 13, color: Colors.white, letterSpacing: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.watch_later,
                      color: Colors.white,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      duration,
                      style: GoogleFonts.poppins(
                          fontSize: 10, color: Colors.white, letterSpacing: 1),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
