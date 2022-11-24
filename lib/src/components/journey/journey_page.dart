import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/components/home/be_universe_view.dart';
import 'package:be_ready_app/src/components/journey/journey_detail_page.dart';
import 'package:be_ready_app/src/utils/app_utils.dart';
import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JourneyHomePage extends StatefulWidget {
  const JourneyHomePage({
    Key? key,
    required this.therapy,
  }) : super(key: key);

  final TherapyType therapy;

  @override
  State<JourneyHomePage> createState() => _JourneyHomePageState();
}

class _JourneyHomePageState extends State<JourneyHomePage> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final devicePadding = media.padding;
    double height = media.size.height - devicePadding.bottom;
    // double height =
    //     media.size.height - devicePadding.top - devicePadding.bottom;

    double topContainerHeight = (height * 39) / 100;

    final positionScale = ((height * 61) / 100) / 6;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: media.size.width,
            // margin: EdgeInsets.only(top: devicePadding.top),
            height: topContainerHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.journeyHome),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: media.viewPadding.top),
                SizedBox(height: media.viewPadding.top + devicePadding.top),
                Text(
                  AppUtils.getTherapy(therapy: widget.therapy),
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
                const Spacer(),
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
                _buildContainer(
                  colorStart: const Color(0xff43355C),
                  colorEnd: const Color(0xff57538E),
                  top: 0,
                  text: 'Actions vs outcomes',
                  height: positionScale,
                ),
                _buildContainer(
                  height: positionScale,
                  colorStart: const Color(0xff7390D5),
                  colorEnd: const Color(0xffDFE0A0),
                  top: positionScale,
                  text: 'Formal/Spoken/Written',
                ),
                _buildContainer(
                  colorStart: const Color(0xffF0D780),
                  colorEnd: const Color(0xffDA8C6E),
                  height: positionScale,
                  top: positionScale * 2,
                  text: 'Never Assumed',
                ),
                _buildContainer(
                  colorStart: const Color(0xffD58874),
                  colorEnd: const Color(0xff523071),
                  height: positionScale,
                  top: positionScale * 3,
                  text: 'Voluntary (never coerced)',
                ),
                _buildContainer(
                  colorStart: const Color(0xff43355C),
                  colorEnd: const Color(0xff57538E),
                  top: positionScale * 4,
                  height: positionScale,
                  text: "Mutual (“our” agreement)",
                ),
                _buildContainer(
                  colorStart: const Color(0xff2E2340),
                  colorEnd: const Color(0xff2E2340),
                  height: positionScale,
                  top: positionScale * 5,
                  text: 'Renegotiable',
                ),
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
      child: GestureDetector(
        child: Container(
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
              color: Colors.white.withOpacity(0.5),
              // color: const Color(0xffA29CB1),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        onTap: () {
          AppNavigation.to(
            context,
            JourneyDetailPage(pageTitle: text),
          );
        },
      ),
    );
  }
}
