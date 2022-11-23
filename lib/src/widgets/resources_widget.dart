import 'package:be_ready_app/src/base/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResourceWidget extends StatelessWidget {
  const ResourceWidget({
    Key? key,
    required this.quantity,
    required this.text,
    required this.isDifferentFromNormal,
  }) : super(key: key);
  final String text;
  final int quantity;
  final bool isDifferentFromNormal;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            const Color(0xFFD2876F).withOpacity(1),
            const Color(0xFF523072).withOpacity(1),
          ],
        ),
      ),
      padding: EdgeInsets.only(
        top: 40,
        bottom: isDifferentFromNormal ? 0 : 40,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Image.asset(AppAssets.resourcesIcon, width: 50, height: 50),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 23),
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
            padding: const EdgeInsets.only(left: 15, bottom: 25),
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
          if (isDifferentFromNormal) ...[
            Container(
              height: 41,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(22),
                  bottomLeft: Radius.circular(22),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.04),
                    Colors.white.withOpacity(0.2),
                  ],
                ),
              ),
            ),
          ] else ...[
            Container(
              height: 1,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: const [0.3, 1],
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
