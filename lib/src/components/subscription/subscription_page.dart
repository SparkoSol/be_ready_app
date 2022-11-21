import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/components/subscription/subscription_offers_page.dart';
import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body: BackgroundImageWidget(
          child: SingleChildScrollView(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Image.asset(AppAssets.temple, width: 100, height: 100),
            ),
            const SizedBox(
              height: 45,
            ),
            Text(
              'Exclusive Content',
              style: GoogleFonts.oswald(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Access exclusive content here',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.white60,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF6272E4),
                        Color(0xFFF09793),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white30),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                  shape: BoxShape.rectangle,
                  border:
                      Border.all(color: const Color(0xFF444A88), width: 0.5),
                ),
                child: Column(
                  children: [
                    Text(
                      '7 days free, then \$59.99/year',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'only  \$0.16/day',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 25),
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFD2876F),
                      Color(0xFF523072),
                    ],
                  ),
                ),
                child: TextButton(
                  child: Text(
                    'Try Free & Subscribe',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            GestureDetector(
              onTap: () =>
                  AppNavigation.to(context, const SubscriptionOffersPage()),
              child: Text(
                'View other plans',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white54,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
