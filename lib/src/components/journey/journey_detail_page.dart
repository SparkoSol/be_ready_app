import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../base/assets.dart';
import '../subscription/subscription_page.dart';

class JourneyDetailPage extends StatefulWidget {
  const JourneyDetailPage({Key? key, required this.data}) : super(key: key);
  final JourneyResponse data;
  @override
  State<JourneyDetailPage> createState() => _JourneyDetailPageState();
}

class _JourneyDetailPageState extends State<JourneyDetailPage> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBarWidget(),
        body: BackgroundImageWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                      top: media.viewPadding.top + 56),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.title,
                        style: GoogleFonts.oswald(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      Html(
                        style: {
                          "*": Style(color: Colors.white),
                          "li": Style(
                            color: Colors.white,
                          ),
                          // "ul li::before": Style(
                          //   color: Colors.red,
                          //   fontWeight: FontWeight.bold,
                          //   display: Display.INLINE_BLOCK,
                          //   width: 1,
                          //   margin: const EdgeInsets.only(left: 1),
                          // ),
                        },
                        data: widget.data.description,
                      ),
                      // Text(
                      //   lorem + lorem + lorem,
                      //   style: GoogleFonts.poppins(
                      //     fontWeight: FontWeight.w300,
                      //     color: Colors.white.withOpacity(0.6),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              _buildContainer()
            ],
          ),
        ));
  }

  Widget _buildContainer() {
    return GestureDetector(
      onTap: () {
        AppNavigation.to(context, const SubscriptionPage());
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xffF0D780), Color(0xffDA8C6E)]),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(70),
            ),
          ),
          child: Row(
            children: [
              Text(
                'Track 987324...',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 17),
              ),
              const Spacer(),
              Image.asset(AppAssets.playYellowButton)
            ],
          )),
    );
  }
}

String lorem =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
