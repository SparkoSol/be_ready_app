import 'dart:ui';

import 'package:be_ready_app/src/base/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 51),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppAssets.videoBg),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 63,
            height: 63,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                stops: [0.1, 0.8],
                end: Alignment.bottomRight,
                begin: Alignment.centerLeft,
                colors: [
                  Color(0xFFF0D781),
                  Color(0xFFDA8B6D),
                  // Color(0xff56528E),
                ],
              ),
            ),
            child: Image.asset(AppAssets.videoIcon),
          ),
          const SizedBox(height: 43),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(21),
                    margin: const EdgeInsets.only(bottom: 1),
                    decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(0.4),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(210, 135, 111, 1),
                          Color.fromRGBO(82, 48, 114, 1),
                        ],
                      ),
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          'Share with a Friend',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        'Like',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ]),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
