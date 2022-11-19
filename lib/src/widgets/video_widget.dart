import 'package:be_ready_app/src/base/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 220,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(path),
          )),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
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
                  ]),
            ),
            child: Image.asset(
              AppAssets.videoIcon,
            ),
          ),
          Container(
            width: 60,
            height: 60,
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
                  ]),
            ),
            child: Image.asset(
              AppAssets.videoIcon,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              //padding: EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 1),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Share with a Friend',
                    style:
                        GoogleFonts.poppins(fontSize: 11, color: Colors.white),
                  ),
                  Container(
                    height: 60,
                    width: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: const [0.5, 1],
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'Like',
                    style:
                        GoogleFonts.poppins(fontSize: 11, color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
