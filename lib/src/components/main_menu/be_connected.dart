import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/goals/explore.dart';
import 'package:be_universe/src/components/journey/journey_detail_page.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe/src/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BeConnected extends StatefulWidget {
  const BeConnected({Key? key}) : super(key: key);

  @override
  State<BeConnected> createState() => _BeConnectedState();
}

class _BeConnectedState extends State<BeConnected> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 56,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
                left: 52,
                right: 52,
                bottom: 20,
            ),            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GoalsPageTitle(text: 'Be Connected '),
                const GoalsPageDescription(text: 'Aware. Acknowledge. Accept.'),
                const SizedBox(
                  height: 30,
                ),
                for (int i = 0; i < 100; i++)
                  GestureDetector(
                      onTap: () {
                        AppNavigation.to(context, const ExplorePage());
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xff2E2340)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  child: Image.asset(AppAssets.user),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'HR Ujjol',
                                  style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xffF0D781)),
                                ),
                                const Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xff241B32),
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Like',
                                        style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              lorem,
                              maxLines: 3,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
