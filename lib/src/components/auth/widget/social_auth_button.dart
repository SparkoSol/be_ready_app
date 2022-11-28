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
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromRGBO(255, 255, 255, 0.05),
        boxShadow: const [
          BoxShadow(
            offset: Offset(15, 0),
            blurRadius: 30,
            spreadRadius: 0,
            color: Color.fromRGBO(211, 212, 226, 0.25),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // backgroundColor: const Color.fromRGBO(255, 255, 255, 0.05),
          // backgroundColor: Colors.white.withOpacity(0.5),
          backgroundColor: Colors.transparent,
          minimumSize: const Size.fromHeight(66),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              platformImage,
              height: 33,
              width: 33,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 22),
            Text(
              'Login with $platformName',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
