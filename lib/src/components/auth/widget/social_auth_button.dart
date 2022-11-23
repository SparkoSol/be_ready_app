import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    Key? key,
    required this.onTap,
    required this.platformImage,
    required this.platformName,
  }) : super(key: key);

  final String platformImage;
  final String platformName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(15, 0),
              blurRadius: 30,
              spreadRadius: 0,
              color: const Color(0xffd3d4d2).withOpacity(0.25),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.5),
            minimumSize: const Size.fromHeight(66),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(platformImage),
              const SizedBox(width: 22),
              Text(
                'Login with $platformName',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
