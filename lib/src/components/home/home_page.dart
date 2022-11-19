import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/base/theme.dart';
import 'package:be_ready_app/src/components/home/drawer_widget.dart';
import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/app_button_widget.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/gradient_progress_indicator.dart';
import 'package:be_ready_app/src/widgets/main_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      drawer: const AppDrawer(),
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            top: padding.top + 56,
            bottom: padding.bottom,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(53, 40, 53, 0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome, Laurie',
                  style: TextStyle(fontSize: 33, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 28),
                  child: Text(
                    'We’re glad you’re here.',
                    style: GoogleFonts.poppins(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                AppCourseButtonWidget(
                  title: 'Continue Coursework',
                  onTap: () {},
                  isShadowed: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 37, bottom: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MainMenuWidget(
                        onPressed: () {},
                        text: 'Daily check-In',
                        path: AppAssets.graphIcon,
                      ),
                      MainMenuWidget(
                        onPressed: () {},
                        text: 'Resources',
                        path: AppAssets.graphIcon,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MainMenuWidget(
                      onPressed: () {},
                      text: 'Events',
                      path: AppAssets.calenderIcon,
                    ),
                    MainMenuWidget(
                      onPressed: () {},
                      text: 'Be Connected',
                      path: AppAssets.userIcon,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFFF0D781).withOpacity(0.25),
                          const Color(0xFFF0D781).withOpacity(0),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(18),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0D781).withOpacity(0.20),
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFFF0D781),
                            const Color(0xFFF0D781).withOpacity(0),
                          ],
                        ),
                      ),
                      child: GradientProgressIndicator(
                        value: 50,
                        radius: 62,
                        duration: 2,
                        strokeWidth: 6,
                        gradientStops: const [0.1, 1.0],
                        gradientColors: const [
                          Color(0xFFE0DFA3),
                          Color(0xFF7391D4),
                        ],
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 26,
                            horizontal: 18,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: AppColors.buttonGradient,
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 7),
                                blurRadius: 9,
                                spreadRadius: 0,
                                color: Colors.black.withOpacity(0.25),
                              ),
                            ],
                          ),
                          child: const Text(
                            'YOUR\nJOURNEY',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ),
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
