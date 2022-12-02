import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/components/goals/explore.dart';
import 'package:be_ready_app/src/components/journey/journey_detail_page.dart';
import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({Key? key}) : super(key: key);

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
              left: 30,
              right: 30,
            ),  physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: GoalsPageTitle(text: 'Articles'),
                ),
                for (int i = 0; i < 20; i++)
                  GestureDetector(
                    onTap: () {
                      AppNavigation.to(context, const ExplorePage());
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xff2E2340),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                child: Image.asset(AppAssets.user),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'HR Ujjol',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xffF0D781),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            lorem,
                            maxLines: 3,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
    Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            left: 55,
            right: 55,
            top: MediaQuery.of(context).padding.top + 56,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 159),
                  child: GoalsPageTitle(text: 'Articles'),
                ),
                for (int i = 0; i < 20; i++)
                  GestureDetector(
                    onTap: () {
                      AppNavigation.to(context, const ExplorePage());
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 31),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xff2E2340),
                      ),
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
                                  color: const Color(0xffF0D781),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            lorem,
                            maxLines: 3,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
