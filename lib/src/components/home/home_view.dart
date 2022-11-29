import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/base/theme.dart';
import 'package:be_ready_app/src/components/home/be_universe_view.dart';
import 'package:be_ready_app/src/components/home/drawer_widget.dart';
import 'package:be_ready_app/src/components/main_menu/be_connected.dart';
import 'package:be_ready_app/src/components/main_menu/daily_check_in_page.dart';
import 'package:be_ready_app/src/components/main_menu/events/controller.dart';
import 'package:be_ready_app/src/components/main_menu/events/events.dart';
import 'package:be_ready_app/src/components/main_menu/resources/resource_page.dart';
import 'package:be_ready_app/src/services/auth_api.dart';
import 'package:be_ready_app/src/widgets/app_button_widget.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/gradient_progress_indicator.dart';
import 'package:be_ready_app/src/widgets/main_page_widget.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => getProfileData());
    super.initState();
  }

  String name = '';

  Future<void> getProfileData() async {
    var accessToken = await Api.getAccessToken();
    print('access token $accessToken');
    final profile = await AuthenticationService().getProfile(accessToken);
    Api.saveProfileData(profile.userid, profile.username);
    name = profile.username;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final padding = mediaQuery.padding;
    return Scaffold(
      key: _scaffoldKey,
      drawer: SizedBox(
        width: mediaQuery.size.width - (mediaQuery.size.width * 0.19),
        child: AppDrawer(parentScaffoldKey: _scaffoldKey),
      ),
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      // appBar: AppBarWidget(
      //   hasDrawer: false,
      //   parentScaffoldKey: _scaffoldKey,
      // ),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: padding.top + 56,
            bottom: padding.bottom,
          ),
          child: CustomScrollView(slivers: [
            // SliverPadding(
            //   padding: const EdgeInsets.only(top: 12),
            SliverPadding(
              padding: const EdgeInsets.only(top: 33),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Welcome, $name',
                  style: const TextStyle(fontSize: 33, color: Colors.white),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 2, bottom: 28),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'We’re glad you’re here.',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: AppCourseButtonWidget(
                title: 'Continue Coursework',
                onTap: () {},
                isShadowed: true,
              ),
            ),
            SliverGrid(
              delegate: SliverChildListDelegate([
                MainMenuWidget(
                  onPressed: () {
                    AppNavigation.to(context, const DailyCheckInPage());
                  },
                  text: 'Daily check-In',
                  path: AppAssets.graphIcon,
                ),
                MainMenuWidget(
                  onPressed: () {
                    AppNavigation.to(context, const ResourcePage());
                  },
                  text: 'Resources',
                  path: AppAssets.graphIcon,
                ),
                MainMenuWidget(
                  onPressed: () {
                    AppNavigation.to(
                        context,
                        EventsPage(
                          eventsController: EventsController(),
                        ));
                  },
                  text: 'Events',
                  path: AppAssets.calenderIcon,
                ),
                MainMenuWidget(
                  onPressed: () {
                    AppNavigation.to(context, const BeConnected());
                  },
                  text: 'Be Connected',
                  path: AppAssets.userIcon,
                ),
              ]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 36,
                crossAxisSpacing: 21,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 45)),
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {
                  AppNavigation.to(
                    context,
                    const BeUniverseView(),
                  );
                },
                child: Center(
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
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
