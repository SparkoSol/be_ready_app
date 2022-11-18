import 'package:be_ready_app/src/base/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JourneyHomePage extends StatefulWidget {
  const JourneyHomePage({Key? key}) : super(key: key);

  @override
  State<JourneyHomePage> createState() => _JourneyHomePageState();
}

class _JourneyHomePageState extends State<JourneyHomePage> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final devicePadding = media.padding;
    double height =
        media.size.height - devicePadding.top - devicePadding.bottom;

    double topContainerHeight = (height * 39) / 100;
    final positionScale = ((height * 61) / 100) / 6;

    return
        // Scaffold(
        //   backgroundColor: Colors.black,
        //   body: SizedBox(
        //     child: SingleChildScrollView(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         children: [
        //           SizedBox(
        //             // decoration: const BoxDecoration(
        //             //     ),
        //             height: 890,
        //             width: double.infinity,
        //             child: Stack(
        //               clipBehavior: Clip.none,
        //               fit: StackFit.loose, // fit: StackFit.expand,
        //               children: [
        //                 Image.asset(AppAssets.journeyHome),
        //                 Padding(
        //                   padding: const EdgeInsets.only(
        //                       left: 25, right: 25, bottom: 25, top: 45),
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Row(
        //                         children: [
        //                           Icon(
        //                             Icons.arrow_back,
        //                             color: Colors.white,
        //                           ),
        //                           Spacer(),
        //                           Icon(
        //                             Icons.notifications_none,
        //                             color: Colors.white,
        //                           ),
        //                           SizedBox(
        //                             width: 5,
        //                           ),
        //                           CircleAvatar(
        //                             radius: 15,
        //                             backgroundColor: Colors.yellow,
        //                           )
        //                         ],
        //                       ),
        //                       SizedBox(
        //                         height: 20,
        //                       ),
        //                       const Text(
        //                         'Mind',
        //                         style: TextStyle(
        //                             color: Colors.white,
        //                             fontWeight: FontWeight.w400,
        //                             fontSize: 33),
        //                       ),
        //                       const Text(
        //                         'Framing the journey',
        //                         style: TextStyle(
        //                             color: Colors.white,
        //                             fontWeight: FontWeight.w500,
        //                             fontSize: 18),
        //                       ),
        //                       const SizedBox(
        //                         height: 85,
        //                       ),
        //                       Align(
        //                         alignment: Alignment.topRight,
        //                         child: Image.asset(AppAssets.playButton),
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //                 Positioned(
        //                     top: MediaQuery.of(context).size.height -
        //                         (MediaQuery.of(context).size.height -
        //                             350), // bottom: -675,
        //                     child: SizedBox(
        //                       child: Stack(
        //                         // fit: StackFit.loose,
        //                         // clipBehavior: Clip.none,
        //                         children: [
        //                           Container(
        //                             height: 1545,
        //                             decoration: const BoxDecoration(
        //                               gradient: LinearGradient(colors: [
        //                                 Color(0xff43355C),
        //                                 Color(0xff57538E),
        //                               ]),
        //                               borderRadius: BorderRadius.only(
        //                                 topRight: Radius.circular(100),
        //                               ),
        //                             ),
        //                             width: MediaQuery.of(context).size.width,
        //                             padding:
        //                                 const EdgeInsets.only(top: 35, left: 35),
        //                             child: const Text(
        //                               'Actions vs outcomes',
        //                               style: TextStyle(
        //                                   color: Color(0xffA29CB1),
        //                                   fontWeight: FontWeight.w400),
        //                             ),
        //                           ),
        //                           _buildContainer(
        //                               colorStart: const Color(0xff7390D5),
        //                               colorEnd: const Color(0xffDFE0A0),
        //                               top: 90,
        //                               text: 'Formal/Spoken/Written'),
        //                           _buildContainer(
        //                               colorStart: const Color(0xffF0D780),
        //                               colorEnd: const Color(0xffDA8C6E),
        //                               top: 180,
        //                               text: 'Never Assumed'),
        //                           _buildContainer(
        //                               colorStart: const Color(0xffD58874),
        //                               colorEnd: const Color(0xff523071),
        //                               top: 270,
        //                               text: 'Formal/Spoken/Written'),
        //                           _buildContainer(
        //                               colorStart: const Color(0xff43355C),
        //                               colorEnd: const Color(0xff57538E),
        //                               top: 360,
        //                               text: 'Formal/Spoken/Written'),
        //                           _buildContainer(
        //                               colorStart: const Color(0xff2E2340),
        //                               colorEnd: const Color(0xff2E2340),
        //                               top: 450,
        //                               text: 'Formal/Spoken/Written'),
        //                         ],
        //                       ),
        //                     ))
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ));
        Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: media.size.width,
            margin: EdgeInsets.only(top: devicePadding.top),
            height: topContainerHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppAssets.journeyHome), fit: BoxFit.cover),
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    Spacer(),
                    Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.yellow,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                 Text(
                  'Mind',
                  style: GoogleFonts.oswald(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 33),
                ),
               Text(
                  'Framing the journey',
                  style: GoogleFonts.oswald(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(AppAssets.playButton),
                )
              ],
            ),
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xff43355C),
                      Color(0xff57538E),
                    ]),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(100),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: positionScale * 2,
                  padding:
                      EdgeInsets.only(left: 35, top: (positionScale - 17) / 2),
                  child: const Text(
                    'Actions vs outcomes',
                    style: TextStyle(
                        color: Color(0xffA29CB1), fontWeight: FontWeight.w400),
                  ),
                ),
                _buildContainer(
                    height: positionScale,
                    colorStart: const Color(0xff7390D5),
                    colorEnd: const Color(0xffDFE0A0),
                    top: positionScale,
                    text: 'Formal/Spoken/Written'),
                _buildContainer(
                    colorStart: const Color(0xffF0D780),
                    colorEnd: const Color(0xffDA8C6E),
                    height: positionScale,
                    top: positionScale * 2,
                    text: 'Never Assumed'),
                _buildContainer(
                    colorStart: const Color(0xffD58874),
                    colorEnd: const Color(0xff523071),
                    height: positionScale,
                    top: positionScale * 3,
                    text: 'Voluntary (never coerced)'),
                _buildContainer(
                    colorStart: const Color(0xff43355C),
                    colorEnd: const Color(0xff57538E),
                    top: positionScale * 4,
                    height: positionScale,
                    text: "Mutual (“our” agreement)"),
                _buildContainer(
                    colorStart: const Color(0xff2E2340),
                    colorEnd: const Color(0xff2E2340),
                    height: positionScale,
                    top: positionScale * 5,
                    text: 'Renegotiable'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContainer({
    required Color colorStart,
    required Color colorEnd,
    required double top,
    required String text,
    required double height,
  }) {
    return Positioned(
      top: top,
      child: Container(
        // height: MediaQuery.of(context).size.height,
        height: height * 10,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 35, top: (height - 17) / 2),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [colorStart, colorEnd]),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(100),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
              color: Color(0xffA29CB1), fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
