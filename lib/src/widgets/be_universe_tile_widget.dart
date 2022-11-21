import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UniverseTileWidget extends StatelessWidget {
  const UniverseTileWidget(
      {Key? key,
      required this.text,
      required this.path,
      required this.onPressed})
      : super(key: key);
  final String text;
  final String path;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              stops: [0.1, 1],
              end: Alignment.centerRight,
              begin: Alignment.centerLeft,
              colors: [
                Color(0xFF3A2E51),
                Color(0xff56528E),
                // Color(0xff56528E),
              ]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Image.asset(path, width: 40, height: 40),
            ),
            Text(
              text,
              style: GoogleFonts.poppins(
                  fontSize: 18, color: Colors.white, letterSpacing: 1),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              width: 80,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                    stops: [0.2, 1],
                    end: Alignment.centerRight,
                    begin: Alignment.centerLeft,
                    colors: [
                      Color(0xffD2876F),
                      Color(0xFF4F2A98),
                    ]),
              ),
              child: const Icon(
                Icons.keyboard_double_arrow_right,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
