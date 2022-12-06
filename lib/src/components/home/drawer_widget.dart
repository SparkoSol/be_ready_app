import 'dart:ui';

import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/modals/dialogs/confirmation_dialog.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/auth/sign_in_page.dart';
import 'package:be_universe/src/components/home/drawer_actions/contact_us_page.dart';
import 'package:be_universe/src/components/home/drawer_actions/faq_page.dart';
import 'package:be_universe/src/components/home/drawer_actions/settings/setting_page.dart';
import 'package:be_universe/src/components/home/drawer_actions/terms_and_conditions_page.dart';
import 'package:be_universe/src/services/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusables/reusables.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({
    Key? key,
    required this.parentScaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> parentScaffoldKey;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final _buttonTitleTextStyle = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Container(
      padding: const EdgeInsets.only(right: 3),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF7391D4),
            Color(0xFFE0DFA3),
          ],
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          backgroundColor: const Color(0xFF0B002A),
          child: Padding(
            padding: EdgeInsets.only(top: padding.top + 20, bottom: 37),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              ListTile(
                contentPadding: const EdgeInsets.only(left: 46),
                leading: const CircleAvatar(
                  backgroundImage: AssetImage(AppAssets.user),
                ),
                title: Text(
                  'Erlan Sadewa',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  '+91-9800000012',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    splashRadius: 0.1,
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed:
                        widget.parentScaffoldKey.currentState?.closeDrawer,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 64),
                child: _getDrawerTile(
                  title: 'Share with a friend',
                  icon: AppAssets.shareIcon,
                  onTap: () {},
                ),
              ),
              _getDrawerTile(
                title: 'FAQs',
                icon: AppAssets.faqIcon,
                onTap: () {
                  AppNavigation.to(context, const FAQPage());
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 64),
                child: _getDrawerTile(
                  title: 'Terms and Conditions',
                  icon: AppAssets.termsAndCondIcon,
                  onTap: () {
                    AppNavigation.to(context, const TermsAndConditionsPage());
                  },
                ),
              ),
              _getDrawerTile(
                title: 'Contact Us',
                icon: AppAssets.contactUsIcon,
                onTap: () {
                  AppNavigation.to(context, const ContactUsPage());
                },
              ),
              const Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                  onPressed: () {
                    AppNavigation.to(context, const SettingPage());
                  },
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Image.asset(AppAssets.settingsIcon, height: 18, width: 18),
                    const SizedBox(width: 13),
                    Text(
                      'Settings',
                      style: _buttonTitleTextStyle,
                    ),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  height: 33,
                  width: 1,
                  color: Colors.white,
                ),
                TextButton(
                  onPressed: () async {
                    var result = await ConfirmationDialog(
                            text: 'Are you sure you want to Logout?')
                        .show(context);
                    if (result) {
                      _signOut();
                    } else {
                      return;
                    }
                  },
                  child: Text(
                    'Logout',
                    style: _buttonTitleTextStyle,
                  ),
                ),
              ]),
            ]),
          ),
        ),
      ),
    );
  }

  void _signOut() async {
    try {
      await Awaiter.process(
        future: AuthenticationService().signOut(),
        context: context,
        arguments: 'Signing out...',
      );
      if (mounted) {
        AppNavigation.navigateRemoveUntil(
          context,
          const SignInPage(),
        );
      }
    } catch (_) {}
  }

  Widget _getDrawerTile({
    required String title,
    required String icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 46),
      dense: true,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      onTap: onTap,
      leading: Image.asset(icon, width: 21, height: 18),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
