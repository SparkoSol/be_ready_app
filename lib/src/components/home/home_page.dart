import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/base/theme.dart';
import 'package:be_universe/src/components/auth/otp_page.dart';
import 'package:be_universe/src/components/home/drawer_widget.dart';
import 'package:be_universe/src/components/home/home_view.dart';
import 'package:be_universe/src/services/auth_api.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Map<String, Widget>> _pages;
  int _selectedPageIndex = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _selectPage(int index) {
    _selectedPageIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      {'page': const HomeView()},
      {'page': const Text('Second View')},
    ];
    getProfileData();
  }

  Future<void> getProfileData() async {
    try {
      var accessToken = AppData.accessToken;
      final profile = await AuthenticationService().getProfile(accessToken);

      /// Check Verification
      await AppData().saveUser(profile);
      if (!mounted) return;
      if (profile.loginVia == 'Email' && profile.isVerified != true) {
        AppNavigation.to(context, const OtpPage(isTimer: false));
      }
      setState(() {});
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    print(AppData.accessToken);
    print(AppData().readLastUser().userid);
    return Scaffold(
      key: _scaffoldKey,
      // drawer: SizedBox(
      //   width: 346,
      //   child: AppDrawer(parentScaffoldKey: _scaffoldKey),
      // ),
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: const HomeView(),
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.only(top: 24),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(40),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       _getBottomBarItem(
      //         onTap: () => _selectPage(0),
      //         icon: AppAssets.homeIcon,
      //         color: _selectedPageIndex == 0 ? null : Colors.grey,
      //         showContainer: _selectedPageIndex == 0,
      //       ),
      //       _getBottomBarItem(
      //         onTap: () => _selectPage(1),
      //         icon: AppAssets.chatIcon,
      //         color: _selectedPageIndex == 1 ? null : Colors.grey,
      //         showContainer: _selectedPageIndex == 1,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget _getBottomBarItem({
    required Function() onTap,
    required String icon,
    Color? color,
    required bool showContainer,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icon,
            height: 23,
            width: 23,
            color: color,
          ),
          const SizedBox(height: 23),
          if (showContainer)
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(100, 50),
                  topLeft: Radius.elliptical(100, 50),
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
                gradient: LinearGradient(
                  colors: AppColors.buttonGradient,
                ),
              ),
              height: 9,
              width: 28,
            )
          else
            const SizedBox(height: 9),
        ],
      ),
    );
  }
}
