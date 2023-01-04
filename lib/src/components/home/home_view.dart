import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/modals/app_snackbar.dart';
import 'package:be_universe/src/base/modals/dialogs/error_dialog.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/base/theme.dart';
import 'package:be_universe/src/components/home/drawer_widget.dart';
import 'package:be_universe/src/components/journey/be_universe_view.dart';
import 'package:be_universe/src/components/main_menu/daily_check_in_page.dart';
import 'package:be_universe/src/components/main_menu/events/events.dart';
import 'package:be_universe/src/components/main_menu/resources/articles_page.dart';
import 'package:be_universe/src/components/main_menu/resources/resource_page.dart';
import 'package:be_universe/src/components/subscription/offers/subscription_offers_page.dart';
import 'package:be_universe/src/services/daily_check_in_service.dart';
import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe/src/widgets/gradient_progress_indicator.dart';
import 'package:be_universe/src/widgets/main_page_widget.dart';
import 'package:be_universe/src/widgets/premium/premium_controller.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusables/reusables.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => getJourneyPro());
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    getJourneyPro();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double average = 0;
  int duration = 2;
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final padding = mediaQuery.padding;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarWidget(
        parentScaffoldKey: _scaffoldKey,
        hasDrawer: true,
        afterSetting: () {
          setState(() {});
        },
      ),
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
            SliverToBoxAdapter(
              child: Text(
                'Welcome, ${AppData().readLastUser().name}',
                style: const TextStyle(fontSize: 33, color: Colors.white),
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
            if (average > 0)
              SliverToBoxAdapter(
                child: AppCourseButtonWidget(
                  title: 'Continue Coursework',
                  onTap: () {
                    if (PremiumController.instance.isPremiumUser) {
                      AppNavigation.to(
                        context,
                        const BeUniverseView(),
                      );
                    } else {
                      $showSnackBar(
                          context, 'You need to purchase exclusive context');
                      AppNavigation.to(
                        context,
                        SubscriptionOffersPage(),
                      );
                    }
                  },
                  isShadowed: true,
                ),
              ),
            SliverGrid(
              delegate: SliverChildListDelegate([
                MainMenuWidget(
                  onPressed: dailyCheckInRequest,
                  text: 'Daily Check-In',
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
                    AppNavigation.to(context, const EventsPage());
                  },
                  text: 'Events',
                  path: AppAssets.calenderIcon,
                ),
                MainMenuWidget(
                  onPressed: () {
                    AppNavigation.to(
                      context,
                      const ArticlesPage(isBeConnected: true),
                    );
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
                onTap: () async {
                  if (PremiumController.instance.isPremiumUser) {
                    await AppNavigation.to(
                      context,
                      const BeUniverseView(),
                    );
                  } else {
                    $showSnackBar(
                        context, 'You need to purchase exclusive context');
                    await AppNavigation.to(context, SubscriptionOffersPage());
                  }
                  getJourneyPro();
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
                        value: average,
                        radius: 62,
                        duration: duration,
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

  Future<void> getJourneyPro() async {
    try {
      final response = await JourneyApi().getJourneyProgress(
        AppData().readLastUser().userid,
      );
      average = (response.mind + response.body + response.spirit) / 3;
      duration = 1;
    } catch (_) {}
    setState(() {});
  }

  Future<void> dailyCheckInRequest() async {
    try {
      final result = await Awaiter.process(
        future: DailyCheckInService().getDailyCheckIn(),
        context: context,
        arguments: '',
      );
      if (!mounted) return;
      if (result) {
        AppNavigation.to(context, const DailyCheckInPage());
      } else {
        $showSnackBar(context, 'Already Checked In');
      }
    } catch (e) {
      ErrorDialog(
        error: DioException.withDioError(e),
      ).show(context);
    }
  }
}
