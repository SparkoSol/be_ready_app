import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/modals/dialogs/error_dialog.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/journey/be_universe_view.dart';
import 'package:be_universe/src/components/journey/journey_detail_page.dart';
import 'package:be_universe/src/utils/app_utils.dart';
import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusables/reusables.dart';

class JourneyHomePage extends StatefulWidget {
  const JourneyHomePage({Key? key, required this.therapy, required this.data})
      : super(key: key);

  final TherapyType therapy;
  final List<JourneyResponse> data;

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

    final positionScale = ((height * 61) / 100) / widget.data.length;
    var startColor = const [
      Color(0xff43355C),
      Color(0xff7390D5),
      Color(0xffF0D780),
      Color(0xffD58874),
      Color(0xff43355C),
      Color(0xff2E2340)
    ];
    var endColor = const [
      Color(0xffDFE0A0),
      Color(0xffDA8C6E),
      Color(0xffDA8C6E),
      Color(0xff523071),
      Color(0xff57538E),
      Color(0xff2E2340)
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarWidget(),
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
                GestureDetector(
                  onTap: () {
                    AppNavigation.to(
                      context,
                      JourneyDetailPage(
                          data: widget.data.first, isMainRoute: true, track: 1),
                    );
                    // var urls = <String>[];
                    // var titles = <String>[];
                    // for (var u in widget.data) {
                    //   urls.add(u.audioName);
                    //   titles.add(u.title);
                    // }
                    // AudioPlayerWidget(
                    //   url: urls,
                    //   title: titles,
                    // ).show(context);
                    // AudioPlayerWidget(
                    //   url: urls,
                    //   title: 'Playing Multiple',
                    // ).show(context);
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(AppAssets.playButton),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                for (var t = 0; t < widget.data.length; t++) ...[
                  _buildContainer(
                      colorStart: startColor[t],
                      colorEnd: endColor[t],
                      top: positionScale * t,
                      text: widget.data[t].title,
                      height: positionScale,
                      journeyResponse: widget.data[t],
                      index: t + 1)
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContainer(
      {required Color colorStart,
      required Color colorEnd,
      required double top,
      required String text,
      required double height,
      required JourneyResponse journeyResponse,
      required int index}) {
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
        onTap: () => getJourneys(widget.therapy, index, widget.data),
      ),
    );
  }

  Future<void> getJourneys(
      TherapyType tType, int index, List<JourneyResponse> data) async {
    debugPrint(tType.name);
    String type = '';
    switch (tType) {
      case TherapyType.mind:
        type = 'Mind';
        break;
      case TherapyType.body:
        type = 'Body';
        break;
      case TherapyType.spirit:
        type = 'Spirit';
        break;
    }
    try {
      data = await Awaiter.process(
          future: JourneyApi()
              .getPaginatedJourneys(type, 0.toString(), 6.toString()),
          context: context,
          arguments: 'loading...');
      if (!mounted) return;
      setState(() {});
      AppNavigation.to(
        context,
        JourneyDetailPage(
            data: data[index - 1], isMainRoute: false, track: index),
      );
    } catch (e) {
      ErrorDialog(error: DioException.withDioError(e)).show(context);
    }
  }
}
