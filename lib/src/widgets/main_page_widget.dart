import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget({
    Key? key,
    required this.path,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String path;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(clipBehavior: Clip.none, children: [
        Positioned(
          top: 16,
          left: 18,
          right: 18,
          child: Container(
            height: 155,
            width: 131,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(27),
              gradient: LinearGradient(
                end: Alignment.bottomRight,
                begin: Alignment.centerLeft,
                colors: [
                  const Color(0xFF916DDD).withOpacity(0.12),
                  const Color(0xFF512E73).withOpacity(0.12),
                  // Colors.yellow,
                  // Colors.pink,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          right: 8,
          child: Container(
            height: 155,
            width: 131,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(27),
              gradient: LinearGradient(
                end: Alignment.bottomRight,
                begin: Alignment.centerLeft,
                colors: [
                  const Color(0xFF916DDD).withOpacity(0.4),
                  const Color(0xFF512E73).withOpacity(0.4),
                ],
              ),
            ),
          ),
        ),
        Container(
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
              ],
            ),
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
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white,
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
