import 'package:be_ready_app/src/base/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResourceWidget extends StatelessWidget {
  const ResourceWidget({
    Key? key,
    required this.quantity,
    required this.text,
  }) : super(key: key);
  final String text;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
            stops: [0.1, 0.7],
            end: Alignment.bottomRight,
            begin: Alignment.centerLeft,
            colors: [
              Color(0xFFD2876F),
              Color(0xFF523072),
              // Color(0xff56528E),
            ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Image.asset(AppAssets.resourcesIcon, width: 50, height: 50),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                quantity.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 1,
            width: 160,
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
        ],
      ),
    );
  }
}
