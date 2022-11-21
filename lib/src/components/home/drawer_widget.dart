import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/components/home/drawer_actions/contact_us_page.dart';
import 'package:be_ready_app/src/components/home/drawer_actions/faq_page.dart';
import 'package:be_ready_app/src/components/home/drawer_actions/settings/setting_page.dart';
import 'package:be_ready_app/src/components/home/drawer_actions/terms_and_conditions_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Container(
      padding: const EdgeInsets.only(right: 2),
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
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        backgroundColor: const Color(0xFF0B002A),
        child: Padding(
          padding: EdgeInsets.only(top: padding.top + 10),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            ListTile(
              onTap: () {
                AppNavigation.to(context, const SettingPage());
              },
              leading: const CircleAvatar(
                backgroundImage: AssetImage(
                  AppAssets.user,
                ),
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
              trailing: const Icon(Icons.close, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
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
              padding: const EdgeInsets.symmetric(vertical: 32),
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
          ]),
        ),
      ),
    );
  }

  Widget _getDrawerTile({
    required String title,
    required String icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
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
