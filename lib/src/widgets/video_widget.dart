import 'package:be_ready_app/src/base/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 51),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(AppAssets.journeyHome),
          )),
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
                  ]),
            ),
            child: Image.asset(
              AppAssets.videoIcon,
            ),
          ),
          SizedBox(
            height: 43,
          ),
          Container(
            padding: EdgeInsets.all(
              21,
            ),
            margin: const EdgeInsets.only(bottom: 1),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(35),
                  bottomLeft: Radius.circular(35)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Share with a Friend',
                  style: GoogleFonts.poppins(fontSize: 11, color: Colors.white),
                ), // Container(
                Spacer(), //   width: 1,
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       begin: Alignment.bottomCenter,
                //       end: Alignment.topCenter,
                //       stops: const [0.5, 1],
                //       colors: [
                //         Colors.white.withOpacity(0.1),
                //         Colors.white,
                //       ],
                //     ),
                //   ),
                // ),
                Text(
                  'Like',
                  style: GoogleFonts.poppins(fontSize: 11, color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
